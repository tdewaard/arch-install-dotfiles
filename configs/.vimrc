" VIMRC FILE
" @author Tristan de Waard

let vimplug_exists=expand('~/.vim/autoload/plug.vim')
" Install Plugin Manager if it does not exists
if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif


" Plugins managed by VimPlug
call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'yggdroot/indentline'
    Plug 'sirver/ultisnips'
    Plug 'valloric/youcompleteme'
    Plug 'airblade/vim-gitgutter'
    Plug 'scrooloose/nerdtree'
    Plug 'ap/vim-css-color'
    Plug 'raimondi/delimitmate'
    Plug 'connorholyday/vim-snazzy'
    Plug 'morhetz/gruvbox'
    Plug 'dracula/vim', {'as': 'dracula'}
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    Plug 'frazrepo/vim-rainbow'
call plug#end()

"" PLUGIN SETTINGS
    " Colour scheme
    colorscheme dracula
    let g:dracula_colorterm = 0
    
    " colorscheme gruvbox
    " let g:gruvbox_italic = 1
    " let g:gruvbox_contrast_dark = 'hard'
    " let g:gruvbox_contrast_light = 'hard'

    " Change indent markers
    let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    let g:indentLine_color_term = 239

    " Automatically display buffers
    let g:airline#extensions#tabline#enabled = 1
    " Display buffer in format
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    " Use symbols in airline
    let g:airline_powerline_fonts = 1
    " Change airline theme
    let g:airline_theme='dracula'

    " Map Nerd Tree to CTRL-N
    map <C-n> :NERDTreeToggle<CR>
    " Close vim when nerd tree is open 
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " More Nerdtree options
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    let NERDTreeShowLineNumbers=1
    let NERDTreeShowHidden=1
    let NERDTreeMinimalUI = 1

    " Settings for Git-Gutter
    let g:gitgutter_grep=''

    " For UltiSnips
    let g:UltiSnipsExpandTrigger = '<Insert>'
    let g:UltiSnipsJumpForwardTrigger = '<Insert>'
    let g:UltiSnipsJumpBackwardTrigger = '<c-z>'

    " NERD Commenter
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1
    " Add your own custom formats or override the defaults
    let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
    " Enable NERDCommenterToggle to check all selected lines is commented or not 
    let g:NERDToggleCheckAllLines = 1

"" VIM SETTINGS
    " More colours
    " set bg=dark "for gruvbox this switches theme
    let base16colorspace=256
    " Allow sudo saving
    cmap w!! w !sudo tee > /dev/null %
    " Enabling syntax
    syntax enable
    " Disable delay
    set timeoutlen=1000 ttimeoutlen=0
    " Needed
    filetype plugin indent on
    " Show existing tab with 4 spaces width
    set tabstop=4
    " When indenting with '>', use 4 spaces width
    set shiftwidth=4
    " On pressing tab, insert 4 spaces
    set expandtab
    " Line numbers
    set number
    set relativenumber
    " Be smart when using tabs
    set smarttab
    " Use system wide clipboard
    set clipboard=unnamed
    nnoremap <C-y> "+y
    vnoremap <C-y> "+y
    nnoremap <C-p> "+gP
    vnoremap <C-p> "+gP
    " Modes need not be shown, already done in powerline
    set noshowmode
    " Change cursor style
    " Change line style in insert mode
    autocmd InsertEnter,InsertLeave * set cul!
    " Enable mouse scrolling
    set mouse=nicr
    set splitbelow splitright
    set path+=**
    set wildmenu
    set incsearch
    set nobackup
    set noswapfile
    set path+=**
    " Colors
    set t_ut="" " When BG renders incorrectly...
