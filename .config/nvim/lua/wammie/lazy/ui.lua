return {
  {
    "folke/noice.nvim",
    opts_extend = { "routes" },
    opts = {
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = {
            skip = true,
          },
        },

        {
          filter = {
            cond = function()
              return not vim.g.focused
            end,
          },
          view = "notify_send",
          opts = {
            stop = false,
          },
        },
      },

      commands = {
        all = {
          view = "split",
          opts = {
            enter = true,
            format = "details",
          },
          filter = {},
        },
      },

      presets = {
        lsp_doc_border = true,
      },
    },

    init = function()
      vim.g.focused = true

      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          vim.g.focused = true
        end,
      })

      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          vim.g.focused = false
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },

  {
    "snacks.nvim",
    opts = {
      scroll = { enabled = false },
      dashboard = {
        preset = {
          header = [[
                                                            .-.␍
                                                           /  ;␍
.-                                                        /   |␍
| `.                        _                           .'    |␍
;   \                    ,-" ``'.                      /      ;␍
;    `.                ,'        '.                   /      '␍
 |     \              /            \                 /       |␍
 ;      `.           |              \               /        '␍
  |       \         ;                \             /        |␍
  ;        `.       |  .-._           ;          .'        .'␍
   |         `.    ;  /    `.         ;         /          |␍
   ;           `.  | |O,_O   |         |       /           ;␍
    |            `.| '/ `\   /         ;     .'            '␍
    ;             .'/`    `-L,--.       '   /             ;␍
     \            ,'         ____`.      \.'              ;␍
      \          /            |  f \    /`               ;␍
       ;       .'             /   \                      '␍
        \     /             .'   _| |                   /␍
         \   (            .'|| /` ; |                  '␍
          `.  `-..____.-'`  '/|  / ,'                .'␍
            `.       |     /L__.'_/                 /␍
              `.|    |     `"--'` |              _.'␍
                |    ;            ;          _,-'␍
                |   .              \            `.␍
               ;    |               \
]],
        },
        sections = {
          { section = "header" },
          {
            pane = 2,
            section = "terminal",
            cmd = "colorscript -e square",
            height = 5,
            padding = 1,
          },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          {
            pane = 2,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
    },
    keys = {},
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>",   "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    dependencies = { "craftzdog/solarized-osaka.nvim" },
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
}
