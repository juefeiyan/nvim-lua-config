return {
	"scalameta/nvim-metals",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		local metals_config = require("metals").bare_config()

		metals_config.settings = {
			showImplicitArguments = true,
			excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
		}

		-- Example if you are using cmp how to make sure the correct capabilities for snippets are set
		metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Debug settings if you're using nvim-dap
		local dap = require("dap")

		dap.configurations.scala = {
			{
				type = "scala",
				request = "launch",
				name = "RunOrTest",
				metals = {
					runType = "runOrTestFile",
					--args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
					args = {},
					jvmOptions = { "--add-exports", "java.base/sun.nio.ch=ALL-UNNAMED" },
				},
			},
			{
				type = "scala",
				request = "launch",
				name = "Test Target",
				metals = {
					runType = "testTarget",
					args = {},
					jvmOptions = { "--add-exports", "java.base/sun.nio.ch=ALL-UNNAMED" },
				},
			},
		}

		metals_config.on_attach = function(_, bufnr)
			require("config.lsp-keymap").loadKeyMap(bufnr)
			require("metals").setup_dap()
		end
		-- Autocmd that will actually be in charging of starting the whole thing
		local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			-- NOTE: You may or may not want java included here. You will need it if you
			-- want basic Java support but it may also conflict if you are using
			-- something like nvim-jdtls which also works on a java filetype autocmd.
			pattern = { "scala", "sbt", "java" },
			callback = function()
				require("metals").initialize_or_attach(metals_config)
			end,
			group = nvim_metals_group,
		})
	end,
}
