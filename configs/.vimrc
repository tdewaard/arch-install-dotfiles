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
"{{ The Basics }}
    Plug 'gmarik/Vundle.vim'                           " Vundle
    Plug 'itchyny/lightline.vim'                       " Lightline statusbar
    Plug 'suan/vim-instant-markdown', {'rtp': 'after'} " Markdown Preview
    Plug 'frazrepo/vim-rainbow'
"{{ File management }}
    Plug 'vifm/vifm.vim'                               " Vifm
    Plug 'scrooloose/nerdtree'                         " Nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'     " Highlighting Nerdtree
    Plug 'ryanoasis/vim-devicons'                      " Icons for Nerdtree
"{{ Productivity }}
    Plug 'vimwiki/vimwiki'                             " VimWiki 
    Plug 'jreybert/vimagit'                            " Magit-like plugin for vim
"{{ Tim Pope Plugins }}
    Plug 'tpope/vim-surround'                          " Change surrounding marks
"{{ Syntax Highlighting and Colors }}
    Plug 'PotatoesMaster/i3-vim-syntax'                " i3 config highlighting
    Plug 'kovetskiy/sxhkd-vim'                         " sxhkd highlighting
    Plug 'vim-python/python-syntax'                    " Python highlighting
    Plug 'ap/vim-css-color'                            " Color previews for CSS
"{{ Junegunn Choi Plugins }}
    Plug 'junegunn/goyo.vim'                           " Distraction-free viewing
    Plug 'junegunn/limelight.vim'                      " Hyperfocus on a range
    Plug 'junegunn/vim-emoji'                          " Vim needs emojis!

    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    Plug 'yggdroot/indentline'
    Plug 'sirver/ultisnips'
    Plug 'valloric/youcompleteme'
    Plug 'airblade/vim-gitgutter'
    Plug 'ap/vim-css-color'
    Plug 'raimondi/delimitmate'
    Plug 'dracula/vim', {'as': 'dracula'}
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
call plug#end()

"" PLUGIN SETTINGS
    " Colour scheme
    " colorscheme dracula
    " The lightline.vim theme
    let g:lightline = {
          \ 'colorscheme': 'darcula',
          \ }
    let g:dracula_colorterm = 0
    
    " Change indent markers
    let g:indentLine_char_list = ['|', '¦', '┆', '┊']
    let g:indentLine_color_term = 239

    " Map Nerd Tree to CTRL-N
    map <C-n> :NERDTreeToggle<CR>
    " Close vim when nerd tree is open 
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " More Nerdtree options
    let g:NERDTreeDirArrowExpandable = '►'
    let g:NERDTreeDirArrowCollapsible = '▼'
    let NERDTreeShowLineNumbers=1
    let NERDTreeShowHidden=1
    let NERDTreeMinimalUI = 1
    let g:NERDTreeWinSize=38

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
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Vifm
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    map <Leader>vv :Vifm<CR>
    map <Leader>vs :VsplitVifm<CR>
    map <Leader>sp :SplitVifm<CR>
    map <Leader>dv :DiffVifm<CR>
    map <Leader>tv :TabVifm<CR>
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => VimWiki
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:vimwiki_list = [{'path': '~/vimwiki/',
                          \ 'syntax': 'markdown', 'ext': '.md'}]
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Vim-Instant-Markdown
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:instant_markdown_autostart = 0         " Turns off auto preview
    let g:instant_markdown_browser = "surf"      " Uses surf for preview
    map <Leader>md :InstantMarkdownPreview<CR>   " Previews .md file
    map <Leader>ms :InstantMarkdownStop<CR>      " Kills the preview
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Open terminal inside Vim
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    map <Leader>tt :vnew term://zsh<CR>


"" VIM SETTINGS
    set path+=**					" Searches current directory recursively.
    set wildmenu					" Display all matches when tab complete.
    set incsearch                   " Incremental search
    set hidden                      " Needed to keep multiple buffers open
    set nobackup                    " No auto backups
    set noswapfile                  " No swap
    set t_Co=256                    " Set if term supports 256 colors.
    set number relativenumber       " Display line numbers
    set clipboard=unnamedplus       " Copy/paste between vim and other programs.
    set mouse=nicr
    set mouse=a
    syntax enable
    let g:rehash256 = 1
    " Always show statusline
    set laststatus=2

    " Uncomment to prevent non-normal modes showing in powerline and below powerline.
    set noshowmode


    " More colours
    " set bg=dark "for gruvbox this switches theme
    let base16colorspace=256
    " Allow sudo saving
    cmap w!! w !sudo tee > /dev/null %
    " " Disable delay
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
    nnoremap <C-y> "+y
    vnoremap <C-y> "+y
    nnoremap <C-p> "+gP
    vnoremap <C-p> "+gP
    " Modes need not be shown, already done in powerline
    " set noshowmode
    " Change cursor style
    " Change line style in insert mode
    autocmd InsertEnter,InsertLeave * set cul!
    " Remap ESC to ii
    :imap ii <Esc>
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Splits and Tabbed Files
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    set splitbelow splitright

    " Remap splits navigation to just CTRL + hjkl
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Make adjusing split sizes a bit more friendly
    noremap <silent> <C-Left> :vertical resize +3<CR>
    noremap <silent> <C-Right> :vertical resize -3<CR>
    noremap <silent> <C-Up> :resize +3<CR>
    noremap <silent> <C-Down> :resize -3<CR>

    " Change 2 split windows from vert to horiz or horiz to vert
    map <Leader>th <C-w>t<C-w>H
    map <Leader>tk <C-w>t<C-w>K

    " Removes pipes | that act as seperators on splits
    set fillchars+=vert:\ 
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Other Stuff
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:python_highlight_all = 1

    au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
    au BufEnter *.org            call org#SetOrgFileType()

    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
    "set guifont=SauceCodePro\ Nerd\ Font:h1
    "set guifont=Mononoki\ Nerd\ Font:h15
    set guifont=JetBrains\ Mono:h15
    " Colors
    set t_ut="" " When BG renders incorrectly...
