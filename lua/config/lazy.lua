local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ";"

require("lazy").setup({
  {
  'projekt0n/github-nvim-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('github-theme').setup({
      -- ...
    })

    vim.cmd('colorscheme github_dark_default')
  end,
	},
    {
		'rcarriga/nvim-notify'
        },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
            vim.keymap.set("n", "<Space><Space>", ":NvimTreeFocus<CR>", { silent = true, noremap = true })
            vim.keymap.set("n", "<Space>q", ":NvimTreeClose<CR>", { silent = true, noremap = true })
            vim.keymap.set("n", "<Space>s", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
        end,
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    {"nathanaelkane/vim-indent-guides"},
    {
	'akinsho/bufferline.nvim',
	version = "*", 
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                numbers = "ordinal",
                diagnostics = "nvim_lsp",
                offsets = {
                    filetype = "NvimTree",
                    text = "File Explorer",
                },
            },
        })

        -- 키 매핑
        vim.keymap.set("n", "<Leader>n", ":bnext<CR>", { silent = true })
        vim.keymap.set("n", "<Leader>p", ":bprev<CR>", { silent = true })
        vim.keymap.set("n", "<Leader>q", ":bp | bd #<CR>", { silent = true })

        for i = 1, 10 do
            local key = i % 10  -- 0 for 10th buffer
            vim.keymap.set("n", "<leader>" .. key, function()
                bufferline.go_to_buffer(i, true)
            end)
        end
    end
    },
    
    {"williamboman/mason.nvim"},
    {"williamboman/mason-lspconfig.nvim"},
    {"neovim/nvim-lspconfig"},


})
