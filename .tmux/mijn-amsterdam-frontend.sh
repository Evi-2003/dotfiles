#!/bin/sh
set -eu

mode=${1:-}
if [ "$mode" = "--start-services" ]; then
	pane_id=$2
	session_id=$(tmux display-message -p -t "$pane_id" '#{session_id}')
	start_path=$(tmux display-message -p -t "$pane_id" '#{pane_current_path}')
else
	session_id=$1
	start_path=$2
fi

project_root=$(git -C "$start_path" rev-parse --show-toplevel 2>/dev/null) || exit 0
remote=$(git -C "$project_root" remote get-url origin 2>/dev/null) || exit 0

case "$remote" in
  git@github.com:Amsterdam/mijn-amsterdam-frontend.git|https://github.com/Amsterdam/mijn-amsterdam-frontend.git|https://github.com/Amsterdam/mijn-amsterdam-frontend)
    ;;
  *)
    exit 0
    ;;
esac

notify_failure() {
  tmux display-message -d 10000 -t "$session_id" "Could not initialize frontend tmux windows: $1" || true
}

if [ "$mode" = "--start-services" ]; then
  if ! tmux new-window -d -t "$session_id" -n start -c "$project_root" "zsh -lic 'nvm use && pnpm start; exec zsh -li'"; then
  	notify_failure "failed to start pnpm start"
  	exit 1
  fi

  if ! tmux new-window -d -t "$session_id" -n mock-server -c "$project_root" "zsh -lic 'nvm use && pnpm mock-server; exec zsh -li'"; then
  	notify_failure "failed to start pnpm mock-server"
  	exit 1
  fi

  if ! tmux new-window -d -t "$session_id" -n bff-api -c "$project_root" "zsh -lic 'nvm use && pnpm bff-api:watch; exec zsh -li'"; then
  	notify_failure "failed to start pnpm bff-api:watch"
  	exit 1
  fi

  exit 0
fi

if ! tmux rename-window -t "$session_id" code; then
  notify_failure "failed to rename the code window"
  exit 1
fi

launcher="$HOME/.tmux/mijn-amsterdam-frontend.sh"
if ! tmux respawn-pane -k -t "$session_id" -c "$project_root" \
  "zsh -lic 'nvm use && pnpm install && \"$launcher\" --start-services \"\$TMUX_PANE\" && nvim; exec zsh -li'"; then
  notify_failure "failed to prepare the code window"
  exit 1
fi
