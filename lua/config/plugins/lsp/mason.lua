return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
    "jayp0521/mason-null-ls.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

    -- import mason-null-ls
		local mason_null_ls = require("mason-null-ls")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"lua_ls",
				"pyright",
				"jdtls",
				"ts_ls",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
			automatic_enable = false, -- not the same as ensure_installed
		})

    mason_null_ls.setup({
			-- list of formatters & linters for mason to install
			ensure_installed = {
				"debugpy",
				"mypy",
				"ruff",
				"black",
				"stylua",
				"java-test",
				"java-debug-adapter",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true,
		})

	end,
}
