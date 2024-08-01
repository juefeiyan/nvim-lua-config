-- https://github.com/Nawy/nvim-config-examples/blob/main/lsp-java/ftplugin/java.lua
local java_filetypes = { "java" }

return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				jdtls = {},
			},
			setup = {
				jdtls = function()
					return true -- avoid duplicate servers
				end,
			},
		},
	},
	{
		"mfussenegger/nvim-jdtls", -- configure formatters & linters
		dependencies = { "folke/which-key.nvim" },
		ft = java_filetypes,
		config = function()
			local jdtls_dir = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
			local config_dir = jdtls_dir .. "/config_mac"
			local plugin_dir = jdtls_dir .. "/plugins"

			local root_maker = { "gradlew", ".git" }
			local root_dir = require("jdtls.setup").find_root(root_maker)
			local launcher_file_name = ""
			local launcher_file_prefix = "org.eclipse.equinox.launcher_"
			local pfile = io.popen('ls -a "' .. plugin_dir .. '"')
			for filename in pfile:lines() do
				if filename:sub(1, #launcher_file_prefix) == launcher_file_prefix then
					launcher_file_name = filename
				end
			end
			pfile:close()
			local path_to_jar = plugin_dir .. "/" .. launcher_file_name

			if root_dir == "" then
				return
			end

			local java_debug_dir = vim.fn.stdpath("data") .. "/mason/share/java-debug-adapter/"
			local vs_code_test_dir = vim.fn.stdpath("data") .. "/mason/share/java-test/"
			-- local vs_code_test_dir = "/Users/juefeiyan/Coding/lsp/server/"
			--- local vs_code_test_dir = "/Users/juefeiyan/.local/share/nvim/mason/share/java-test/"

			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
			local home = os.getenv("HOME")
			os.execute("mkdir " .. workspace_dir)
			local on_attach = function(client, bufnr)
				-- require("jdtls.setup").add_commands()
				require("config.lsp-keymap").loadKeyMap(bufnr)
				require("jdtls").setup_dap({ hotcodereplace = "auto" })
			end
			local function attach_jdtls()
				-- Configuration can be augmented and overridden by opts.jdtls
				local bundles = {
					vim.fn.glob(java_debug_dir .. "com.microsoft.java.debug.plugin-*.jar", 1),
				}
				vim.list_extend(bundles, vim.split(vim.fn.glob(vs_code_test_dir .. "*.jar", 1), "\n"))
				local config = {
					on_attach = on_attach,
					cmd = {
						"java",
						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.protocol=true",
						"-Dlog.level=ALL",
						"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
						"-Xmx8g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",
						"-jar",
						path_to_jar,
						"-configuration",
						config_dir,
						"-data",
						workspace_dir,
					},
					root_dir = root_dir,
					settings = {
						java = {
							project = {
								referencedLibraries = {
									"/usr/local/lib/antlr-4.13.1-complete.jar",
								},
							},
						},
					},
					init_options = {
						bundles = bundles,
					},
					-- enable CMP capabilities
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
				}
				require("jdtls").start_or_attach(config)
				local dap = require("dap")
				dap.configurations.java = {
					{
						javaExec = "java",
						request = "launch",
						type = "java",
					},
					--	{
					--		type = "java",
					--		request = "attach",
					--		name = "Debug (Attach) - Remote",
					--		hostName = "127.0.0.1",
					--		port = 5005,
					--	},
				}
				-- Existing server will be reused if the root_dir matches.
				-- not need to require("jdtls.setup").add_commands(), start automatically adds commands
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = attach_jdtls,
			})
		end,
	},
}
