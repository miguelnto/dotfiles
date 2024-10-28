
call plug#begin('~/local/share/nvim/plugged')

" # THEMES
Plug 'ellisonleao/gruvbox.nvim'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'folke/tokyonight.nvim'
Plug 'blazkowolf/gruber-darker.nvim'
" # Plenary
Plug 'nvim-lua/plenary.nvim'
" # DISCORD RICH PRESENCE
Plug 'andweeb/presence.nvim'
" # LANGUAGE SUPPORT
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'https://git.sr.ht/~sircmpwn/hare.vim'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'lervag/vimtex'
Plug 'zah/nim.vim'
" # TELESCOPE.NVIM
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-tree/nvim-web-devicons' 
Plug 'lewis6991/gitsigns.nvim'
" # BARS
Plug 'romgrk/barbar.nvim'
" # TOGGLE TERMINAL
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
" # MASON
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" # SIDEBAR
Plug 'sidebar-nvim/sidebar.nvim'

call plug#end()

lua <<EOF
  local cmp = require'cmp'
  local sidebar = require("sidebar-nvim")
  sidebar.setup({
    initial_width = 20,
    open = true,
    sections = { "git", "files", "diagnostics" },
  })
  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- setup toggleterm
  require("toggleterm").setup()

  require("mason").setup()
  require("mason-lspconfig").setup()
  require("lspconfig").rust_analyzer.setup {
    capabilities = capabilities
  }
  require("lspconfig").pyright.setup {
    capabilities = capabilities
  }
  require("lspconfig").clangd.setup {
    capabilities = capabilities
  }
  require("lspconfig").nim_langserver.setup {
    capabilities = capabilities
  }
EOF

set termguicolors
set number
set hidden
set clipboard+=unnamedplus

colorscheme gruvbox
"colorscheme gruber-darker
" colorscheme tokyonight-night
" colorscheme spaceduck

" barbar.nvim
nnoremap <silent> <C-p> <Cmd>BufferPick<CR>
nnoremap <silent> <C-x> <Cmd>BufferPickDelete<CR>
nnoremap <silent> <C-h> <Cmd>BufferPrevious<CR>
nnoremap <silent> <C-l> <Cmd>BufferNext<CR>
nnoremap <silent> <C-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent> <C-0> <Cmd>BufferLast<CR>

" Use zathura as the PDF viewer for vimtex
let g:vimtex_view_method = 'zathura'

" Toggle the terminal window.
nnoremap <silent><c-t> <Cmd>exe "ToggleTerm"<CR>
tnoremap <silent><c-t> <Cmd>exe "ToggleTerm"<CR>

" Find files using Telescope command-line sugar.
nnoremap <silent>ff <cmd>Telescope find_files<cr>
nnoremap <silent>fg <cmd>Telescope live_grep<cr>
nnoremap <silent>fb <cmd>Telescope buffers<cr>
nnoremap <silent>fh <cmd>Telescope help_tags<cr>
nnoremap <silent>td <cmd>Telescope lsp_definitions<cr>

