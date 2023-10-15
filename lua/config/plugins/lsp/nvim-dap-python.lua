return {
	"mfussenegger/nvim-dap-python",
	ft = { "python" },
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	config = function(_, opts)
		local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
		require("dap-python").setup(path)
		local mode_nv = { "n", "v" }
		local nmappings = {
			{
				from = "<leader>dr",
				to = function()
					require("dap-python").test_method()
				end,
				mode = mode_nv,
			},
		}
		for _, mapping in ipairs(nmappings) do
			vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
		end
	end,
}
