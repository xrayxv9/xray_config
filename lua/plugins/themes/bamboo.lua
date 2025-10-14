return {
	"ribru17/bamboo.nvim",
	name = "bamboo",
	priotity = 1000,
	config = function ()
		require("bamboo").setup{
			style = 'vulgaris',
		}
	end
}
