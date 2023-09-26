return {
	"mfussenegger/nvim-jdtls", -- configure formatters & linters
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local config = {
			cmd = { "/Users/juefeiyan/.config/lsp/javalsp/bin/jdtls" },
			root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
		}
		require("jdtls").start_or_attach(config)
	end,
}
