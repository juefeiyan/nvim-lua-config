local M = {}

local mode_nv = "n"
local opts = { noremap = true, silent = true }
local nmappings = {
	-- Coding
	{ from = "gd", to = "<cmd>lua vim.lsp.buf.definition()<CR>", mode = mode_nv },
	{ from = "gi", to = "<cmd>lua vim.lsp.buf.implementation()<CR>", mode = mode_nv },
	{ from = "gk", to = "<cmd>lua vim.lsp.buf.signature_help()<CR>", mode = mode_nv },
	{ from = "gD", to = "<cmd>lua vim.lsp.buf.hover()<CR>", mode = mode_nv },
	{ from = "gr", to = "<cmd>Telescope lsp_references<CR>", mode = mode_nv },
	{ from = "ge", to = "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", mode = mode_nv },

	{ from = "[d", to = "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", mode = mode_nv },
	{ from = "]d", to = "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", mode = mode_nv },
	-- Workspace
	{ from = "<leader>wa", to = "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", mode = mode_nv },
	{ from = "<leader>wr", to = "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", mode = mode_nv },
	{
		from = "<leader>wl",
		to = "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
		mode = mode_nv,
	},

	{ from = "<leader>aj", to = "<cmd>lua vim.lsp.buf.code_action()<CR>", mode = mode_nv },
}

function M.loadKeyMap(bufnr)
	for _, mapping in ipairs(nmappings) do
		vim.api.nvim_buf_set_keymap(bufnr, mapping.mode or "n", mapping.from, mapping.to, opts)
	end
end

return M
