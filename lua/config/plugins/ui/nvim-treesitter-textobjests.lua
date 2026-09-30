return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	init = function()
		-- disable rtp plugin, as we only need its queries for mini.ai
		require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
	end,
}
