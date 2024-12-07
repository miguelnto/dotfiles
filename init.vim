" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/local/share/nvim/plugged')
" THEMES
Plug 'ribru17/bamboo.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'bettervim/yugen.nvim'
Plug 'widatama/vim-phoenix'
Plug 'n1ghtmare/noirblaze-vim'
Plug 'aktersnurra/no-clown-fiesta.nvim'
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
" PLENARY
Plug 'nvim-lua/plenary.nvim'
" LANGUAGE SUPPORT
Plug 'dart-lang/dart-vim-plugin'
Plug 'evanleck/vim-svelte'
Plug 'zah/nim.vim'
Plug 'konimarti/c3.vim'
" TELESCOPE
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-tree/nvim-web-devicons' 
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
" BARS
Plug 'romgrk/barbar.nvim'
" TOGGLE TERMINAL
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
" MASON
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
"" :MasonUpdateAll command
Plug 'RubixDev/mason-update-all'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" LUA-LINE
Plug 'nvim-lualine/lualine.nvim'
call plug#end()

lua <<EOF
  local cmp = require'cmp'
  cmp.setup({
  -- Installed sources:
    sources = {
      { name = 'path' },                              -- file paths
      { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
      { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
      { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
      { name = 'buffer', keyword_length = 2 },        -- source current buffer
      { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
      { name = 'calc'},                               -- source for math calculation
    },
    mapping = {
      ['<Up>'] = cmp.mapping.select_prev_item(),
      ['<Down>'] = cmp.mapping.select_next_item(),
      ['<CR>'] = cmp.mapping.confirm({select = true}),
    },
    window = {
      documentation = cmp.config.window.bordered()
    },
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

  -- Setup lspconfig
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Setup toggleterm
  require("toggleterm").setup()

  require("mason").setup()
  -- Setup lsp for some languages
  require("mason-lspconfig").setup {
    ensure_installed = { "rust_analyzer", "pyright", "clangd", "nim_langserver", "svelte" }
  } 
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
  require("lspconfig").svelte.setup {
    capabilities = capabilities
  }
  -- :MasonUpdateAll command
  require('mason-update-all').setup()
  -- Telescope file browser
  require("telescope").load_extension "file_browser"
  vim.keymap.set("n", "fb", ":Telescope file_browser<CR>")
  -- Setup lualine
  require('lualine').setup()
EOF

set number
set hidden
" Use the system clipboard. Requires xclip.
set clipboard+=unnamedplus

" Available colorschemes
colorscheme bamboo
" colorscheme tokyonight-night
" colorscheme yugen
" colorscheme noirblaze
" colorscheme no-clown-fiesta
" colorscheme gruvbox-baby

" Barbar commands
nnoremap <silent> <C-p> <Cmd>BufferPick<CR>
nnoremap <silent> <C-x> <Cmd>BufferWipeout<CR>
nnoremap <silent> <C-h> <Cmd>BufferPrevious<CR>
nnoremap <silent> <C-l> <Cmd>BufferNext<CR>
nnoremap <silent> <A-x> <Cmd>BufferPickDelete<CR>

" Compile document, be it groff, latex, markdown, etc.
map <leader>c :w! \| !compiler "%:p"<CR>

" Open corresponding pdf/html/sent preview
map <leader>p :!opout "%:p"<CR>

" Toggle the terminal window.
nnoremap <silent><c-t> <Cmd>exe "ToggleTerm"<CR>
tnoremap <silent><c-t> <Cmd>exe "ToggleTerm"<CR>

" Telescope commands
nnoremap <silent>ff <cmd>Telescope find_files<cr>
nnoremap <silent>fg <cmd>Telescope live_grep<cr>
nnoremap <silent>bf <cmd>Telescope buffers<cr>
nnoremap <silent>fh <cmd>Telescope help_tags<cr>
nnoremap <silent>td <cmd>Telescope lsp_definitions<cr>
