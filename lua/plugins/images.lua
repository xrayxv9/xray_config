return {
    'skardyy/neo-img',
    build = ":NeoImg Install",
    config = function()
        require('neo-img').setup()
    end
}
