local mode_nv = { "n", "v" }
local mode_v = { "v" }
local mode_i = { "i" }
local nmappings = {
	-- Movement
	{ from = "J", to = "5j", mode = mode_nv },
	{ from = "K", to = "5k", mode = mode_nv },
	{ from = "H", to = "^", mode = mode_nv },
	{ from = "L", to = "$", mode = mode_nv },
	{ from = "n", to = "nzz", mode = mode_nv },
	{ from = "N", to = "Nzz", mode = mode_nv },

	-- Split Screen
	{ from = "Sh", to = ":set nosplitright<CR>:vsplit<CR>", mode = mode_nv },
	{ from = "Sl", to = ":set splitright<CR>:vsplit<CR>", mode = mode_nv },
	{ from = "Sk", to = ":set nosplitbelow<CR>:split<CR>", mode = mode_nv },
	{ from = "Sj", to = ":set splitbelow<CR>:split<CR>", mode = mode_nv },

	-- Tab
	{ from = "tk", to = ":tabe<CR>", mode = mode_nv },
	{ from = "th", to = ":-tabnext<CR>", mode = mode_nv },
	{ from = "tl", to = ":+tabnext<CR>", mode = mode_nv },

	-- Change window
	{ from = "<up>", to = ":res +5<CR>", mode = mode_nv },
	{ from = "<down>", to = ":res -5<CR>", mode = mode_nv },
	{ from = "<left>", to = ":vertical resize+5<CR>", mode = mode_nv },
	{ from = "<right>", to = ":vertical resize-5<CR>", mode = mode_nv },
	-- Zoom
	{ from = "<leader>z", to = "<cmd>lua require'config.maximize-panel'.toggle_window()<CR>", mode = mode_nv },
}

for _, mapping in ipairs(nmappings) do
	vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end
