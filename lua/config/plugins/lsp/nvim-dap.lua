return {
	"mfussenegger/nvim-dap",
	config = function()
		local mode_nv = { "n", "v" }
		local nmappings = {
			{ from = "<leader>db", to = "<cmd> DapToggleBreakpoint <CR>", mode = mode_nv },
			{ from = "<leader>dj", to = "<cmd> DapStepInto <CR>", mode = mode_nv },
			{ from = "<leader>dl", to = "<cmd> DapStepOver <CR>", mode = mode_nv },
			{ from = "<leader>dk", to = "<cmd> DapStepOut <CR>", mode = mode_nv },
			{ from = "<leader>dq", to = "<cmd> DapTerminate <CR>", mode = mode_nv },
			{ from = "<leader>df", to = "<cmd> DapRestartFrame <CR>", mode = mode_nv },
			{ from = "<leader>dc", to = "<cmd> DapContinue <CR>", mode = mode_nv },
			{ from = "<leader>du", to = "<cmd>lua require('dapui').toggle() <CR>", mode = mode_nv },
		}
		for _, mapping in ipairs(nmappings) do
			vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
		end
	end,
}
