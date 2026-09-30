return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- main branch does not support lazy-loading
	build = ":TSUpdate",
	keys = {
		-- incremental selection via Neovim's built-in treesitter `an` / `in` mappings
		{ "<c-space>", "van", desc = "Increment selection", remap = true },
		{ "<c-space>", "an", mode = "x", desc = "Increment selection", remap = true },
		{ "<bs>", "in", mode = "x", desc = "Decrement selection", remap = true },
	},
	config = function()
		local ensure_installed = {
			"bash",
			"c",
			"html",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
			"terraform",
			"hcl",
		}
		require("nvim-treesitter").install(ensure_installed)

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("config_treesitter", { clear = true }),
			callback = function(args)
				-- no-op when there is no parser for this filetype
				if pcall(vim.treesitter.start, args.buf) then
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
