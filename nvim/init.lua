-- Options
vim.o.swapfile = false
vim.g.netrw_banner = false

vim.o.autoindent = true
vim.o.smartindent = true

vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Tabs
vim.o.expandtab = false
vim.o.smarttab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Keymaps
vim.g.mapleader = ' '
vim.g.localmapleader = '\\'
vim.keymap.set('n', '-', ':Explore<cr>', { silent = true })

vim.keymap.set('n', '<Leader>ls', ':ls<cr>:b ')

vim.keymap.set('n', '<C-j>', ':cnext<cr>')
vim.keymap.set('n', '<C-k>', ':cprevious<cr>')
vim.keymap.set('n', '<Leader>co', ':copen<cr>', { silent = true })
vim.keymap.set('n', '<Leader>cc', ':cclose<cr>', { silent = true })

vim.keymap.set('n', '<C-p>', 'O<Esc>', { silent = true })

vim.keymap.set('n', '<Leader>ke', ':set keymap=""<cr>')
vim.keymap.set('n', '<Leader>kr', ':set keymap=russian-jcukenwin<cr>')

vim.keymap.set('n', '<Leader>le', ':lua vim.diagnostic.open_float()<cr>', { silent = true })
vim.keymap.set('n', '<Leader>lr', ':lua vim.lsp.buf.rename()<cr>')

-- LSP
vim.diagnostic.enable = true
vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = true,
	signs = false,
	underline = true
})

-- Clangd
vim.lsp.config['clangd'] = {
	cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
	filetypes = { 'c', 'cpp' },
	root_markers = { 'compile_commands.json', '.git', { '.build.sh', 'Makefile' } }
}
vim.lsp.enable('clangd')

-- Plugins
vim.cmd('call plug#begin()')
vim.cmd("Plug 'hrsh7th/vim-vsnip'")
vim.cmd("Plug 'hrsh7th/vim-vsnip-integ'")
vim.cmd("Plug 'neovim/nvim-lspconfig'")
vim.cmd("Plug 'hrsh7th/cmp-nvim-lsp'")
vim.cmd("Plug 'hrsh7th/cmp-buffer'")
vim.cmd("Plug 'hrsh7th/cmp-path'")
vim.cmd("Plug 'hrsh7th/cmp-cmdline'")
vim.cmd("Plug 'hrsh7th/nvim-cmp'")
vim.cmd("Plug 'hrsh7th/cmp-vsnip'")
vim.cmd("Plug 'hrsh7th/vim-vsnip'")
vim.cmd("Plug 'ellisonleao/gruvbox.nvim'")
vim.cmd("Plug 'nvim-lua/plenary.nvim'")
vim.cmd("Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }")
vim.cmd('call plug#end()')

-- Telescope keymaps
vim.keymap.set('n', '<Leader>ff', ':Telescope find_files<cr>', { silent = true })
vim.keymap.set('n', '<Leader>fg', ':Telescope live_grep<cr>', { silent = true })
vim.keymap.set('n', '<Leader>fb', ':Telescope buffers<cr>', { silent = true })
vim.keymap.set('n', '<Leader>lf', ':Telescope lsp_references<cr>', { silent = true })

-- Color
vim.cmd.colorscheme('gruvbox')

-- Vsnip
vim.cmd("imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
vim.cmd("smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'")
vim.cmd("imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")
vim.cmd("smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'")

-- vim-cmp
local cmp = require'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
	}, {
		{ name = 'buffer' },
	})
})

cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})
