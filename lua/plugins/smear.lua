return{
	"sphamba/smear-cursor.nvim",

	config = function ()
		require("smear_cursor").setup({
			swiftness = 0.8,
			trailing_swiftness = 0.5,
		})
	end
}
