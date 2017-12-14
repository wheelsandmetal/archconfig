" vim:fdm=marker

" vim-plug Setting {{{
"" github.com/junegunn/vim-plug
"" To install use :PlugInstall

set nocompatible
filetype off

set rtp+=~/.vim/plugged
call plug#begin()

Plug 'neomake/neomake'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'lervag/vimtex'
"Plug 'Raimondi/delimitMate'
"Plug 'mhinz/vim-startify'
"Plugin 'godlygeek/tabular'
Plug 'altercation/vim-colors-solarized'
Plug 'iCyMind/NeoSolarized'

call plug#end()            " required
filetype plugin on
filetype plugin indent on    " required


"" Automatic reloading of .vimrc
aug reload_vimrc
    au!
    au bufwritepost $MYVIMRC :source $MYVIMRC
aug END

"" }}}
" Look and Feel {{{

" Color scheme
syntax on
set background=dark
"" Toggle comments on following lines if colo is weird
"colorscheme solarized
colorscheme NeoSolarized
set tgc

" Showing line numbers and length
set number  " show line numbers
set relativenumber
set tw=79   " width of document (used by gd)
set colorcolumn=80
highlight ColorColumn ctermbg=233

 " Status line settings
set laststatus=2
set statusline=%f " shortend current file path
set statusline+=%m " is current file modified
set statusline+=%= " switch sies
set statusline+=%.20{getcwd()} " current working dir limited to 20char

" }}}
" Tests {{{

set path+=**

" }}}
" Bindings {{{

" Abbreviations {{{


:iabbrev @@ jakob@schmutz.co.uk


" }}}

"" Leader Bindings {{{



"" Rebind <Leader> key
nnoremap <Space> <NOP>
let mapleader = "\<Space>"


"" Quickly open .vimrc
nnoremap <leader>v :e $MYVIMRC<cr>

"" Quick quit command
noremap <Leader>q :q<CR>  " Quit current window
noremap <Leader>Q :wqa!<CR>   " Quit all windows

"" Quick save command
noremap <leader>w :w<cr>

""Quick tab movement
noremap <leader>n :tabprevious<cr>
noremap <leader>m :tabnext<cr>

"" Quick sort
"vnoremap <Leader>s :sort<CR>

" }}}

" Exit normal mode
inoremap jj <esc>

" Navigating with guides
inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
map <Space><Tab> <Esc>/<++><Enter>"_c4l
inoremap ;gui <++>

" Easy Search
nnoremap S :%s//g<Left><Left>

" Map : to ; for easy cmd line tools
nnoremap ; :

" Super easy split management {{{
" Fuction to check if a split exits in a given direction and open one if not
function! SelectorOpenNewSplit(key, cmd)
    let current_window = winnr()
    execute 'wincmd' a:key
    if current_window == winnr()
        execute a:cmd
        execute 'wincmd' a:key
    endif
endfunction

" Call the fuction bound to control movent keys
nnoremap <silent> <c-w>k :call SelectorOpenNewSplit('k', 'leftabove split')<cr>
nnoremap <silent> <c-w>j :call SelectorOpenNewSplit('j', 'leftabove split')<cr>
nnoremap <silent> <c-w>h :call SelectorOpenNewSplit('h', 'leftabove vsplit')<cr>
nnoremap <silent> <c-w>l :call SelectorOpenNewSplit('l', 'leftabove vsplit')<cr>

"}}}

" Bind no highlight, removes highlighting
"nnoremap <C-n> :nohl<CR>

" Easier moving of code blocks
vnoremap < <gv  "" better indentation
vnoremap > >gv  "" better indentation

" }}}
" General Settings {{{

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" }}}
" Plugin Settings {{{

" Nerd Tree {{{


" Open root dictionary
nnoremap <leader>t :NERDTree ~/<cr>
nnoremap <leader>r :NERDTreeFind<cr>


" }}}

" VimTex {{{
let g:vimtex_view_method = 'mupdf'
"let g:vimtex_compiler_latexmk = {
"	\ 'backend' : 'jobs',
"	\ 'background' : 0,
"	\ 'build_dir' : '',
"	\ 'callback' : 1,
"	\ 'continuous' : 1,
"	\ 'executable' : 'latexmk',
"	\ 'options' : [
"	\   '-pdf',
"	\   '-verbose',
"	\   '-file-line-error',
"	\   '-synctex=1',
"	\   '-interaction=nonstopmode',
"	\ ],
"	\}
"let g:vimtex_view_automatic = 1

"" }}}

" Goyo {{{

"" Toggle Goyo
nnoremap <leader>g :Goyo<cr>

" }}}

"" }}}
" Python Settings {{{

" Run python script
aug runscript
    au!
    au FileType python nnoremap <silent><F5> :w!<cr>:!python3 %<cr>
aug END

" }}}
" Octave Setttings {{{


" .m files are "octave" files
aug detect_octave_files
    au!
    au BufRead,BufNewFile *.m, set filetype=octave
aug END

" F5 will execute the octave script
aug execute_script
    au!
    au filetype octave map <buffer> <f5> gg0pkg load all<esc>Gopause<esc>:w<cr>:!octave -qf %<cr>ddggdd:w<cr>
aug END


" }}}
" LeTeX Settings {{{

" Set filetype
au BufNewFile,BufRead *.tex set filetype=tex

" Spell check in .tex files
aug spell_checkTeX
    au!
    au BufRead,BufNewFile *.tex setlocal spell
aug END

" Compile with latexmk cont feature
" Make sure latexmkrc has
" $pdf_update_method = 2;
" $pdf_previewer = 'mupdf';
aug auto_compile_Tex
	au!
	au Filetype tex noremap <F6> :NeomakeSh latexmk -cd -pdf %<cr>
	au FileType tex noremap <F5> :NeomakeSh mupdf %:r.pdf<cr>
aug END


"{{{
" Texttypes
autocmd FileType tex inoremap ;em \emph{}<++><Esc>T{i
autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ;ct \textcite{}<++><Esc>T{i
autocmd FileType tex inoremap ;cp \parencite{}<++><Esc>T{i

"Begintypes
autocmd FileType tex inoremap ;be \begin{<++>}<Enter>\ex<Space><Enter>\end{<++>}<Esc>kA<Space>
autocmd FileType tex inoremap ;x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;bit \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;li <Enter>\item<Space>
autocmd FileType tex inoremap ;ref \ref{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ;tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
autocmd FileType tex inoremap ;ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
autocmd FileType tex inoremap ;can \cand{}<Tab><++><Esc>T{i
autocmd FileType tex inoremap ;con \const{}<Tab><++><Esc>T{i
autocmd FileType tex inoremap ;v \vio{}<Tab><++><Esc>T{i
autocmd FileType tex inoremap ;a \href{}{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap ;sc \textsc{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ;chap \chapter{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;sec \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;st <Esc>F{i*<Esc>f}i
autocmd FileType tex inoremap ;up <Esc>/usepackage<Enter>o\usepackage{}<Esc>:noh<cr>i
autocmd FileType tex inoremap ;tt \texttt{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ;bt {\blindtext}
autocmd FileType tex inoremap ;nu $\varnothing$
autocmd FileType tex inoremap ;col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
autocmd FileType tex inoremap ;rn (\ref{})<++><Esc>F}i

"".bib
autocmd FileType bib inoremap ;a @article{<Enter><Tab>author<Space>=<Space>"<++>",<Enter><Tab>year<Space>=<Space>"<++>",<Enter><Tab>title<Space>=<Space>"<++>",<Enter><Tab>journal<Space>=<Space>"<++>",<Enter><Tab>volume<Space>=<Space>"<++>",<Enter><Tab>pages<Space>=<Space>"<++>",<Enter><Tab>}<Enter><++><Esc>8kA,<Esc>i
autocmd FileType bib inoremap ;b @book{<Enter><Tab>author<Space>=<Space>"<++>",<Enter><Tab>year<Space>=<Space>"<++>",<Enter><Tab>title<Space>=<Space>"<++>",<Enter><Tab>publisher<Space>=<Space>"<++>",<Enter><Tab>}<Enter><++><Esc>6kA,<Esc>i
autocmd FileType bib inoremap ;c @incollection{<Enter><Tab>author<Space>=<Space>"<++>",<Enter><Tab>title<Space>=<Space>"<++>",<Enter><Tab>booktitle<Space>=<Space>"<++>",<Enter><Tab>editor<Space>=<Space>"<++>",<Enter><Tab>year<Space>=<Space>"<++>",<Enter><Tab>publisher<Space>=<Space>"<++>",<Enter><Tab>}<Enter><++><Esc>8kA,<Esc>i
"}}}

" }}}
" Java Settings {{{

" Compile code
aug compiling
    au!
    au FileType java nnoremap <F5> :w!<cr>:!javac %<cr>
    au FileType java nnoremap <F6> :! javac %:r<cr>
aug END


" }}}

