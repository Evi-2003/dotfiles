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
					keys = {
						{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
						{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
						{ icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
						{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
						{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
						{ icon = " ", key = "P", desc = "Octo Pull Requests", action = ":Octo pr list" },
						{ icon = " ", key = "I", desc = "Octo Issues", action = ":Octo issue list" },
						{ icon = " ", key = "S", desc = "Octo Search", action = ":Octo search" },
					},
					header = [[
          *==========================================================*
|                                                    \_/   |
|                                                  --(_)-- |
|   /\                          __     /\       __   / \   |
|  /~'\    /\    /\            (())   //\\     ((()        |
| /    \  /~'\  /~`\          (((()) ///\\\   (())))       |
|/      \/    \/    \    ,.-.---)(--.--)(---'---)(.-'---'''|
|        \           \,'`                              ldb |
*==========================================================*
------------------------------------------------
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
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
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
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				show_buffer_close_icons = false,
				show_close_icon = false,
				separator_style = "thin",
				style_preset = require("bufferline").style_preset.minimal,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			opts.sections.lualine_c[4] = { "filename", path = 3, shorting_target = 0 }
			return opts
		end,
	},

	-- filename
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
			local background = normal.bg and ("#%06x"):format(normal.bg) or "NONE"
			local foreground = normal.fg and ("#%06x"):format(normal.fg) or "NONE"
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = background, guifg = foreground },
						InclineNormalNC = { guibg = background, guifg = foreground },
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
