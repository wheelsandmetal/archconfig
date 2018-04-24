" vim:fdm=marker

" vim-plug Setting {{{
"" github.com/junegunn/vim-plug
"" To install use :PlugInstall

set nocompatible
filetype off

call plug#begin()

Plug 'neomake/neomake'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'

"" Python
Plug 'tmhedberg/SimpylFold'

"" LaTeX
Plug 'lervag/vimtex'

"" Markdown
function! BuildComposer(info)
	if a:info.status != 'unchanged' || a:info.force
		if has('nvim')
			!cargo build --release
		else
			!cargo build --release --no-default-features --features json-rpc
		endif
	endif
endfunction

" Must run `cargo build --release` in plugin directory
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

"Plug 'Raimondi/delimitMate'
"Plug 'mhinz/vim-startify'
"Plugin 'godlygeek/tabular'
"" Colours
Plug 'iCyMind/NeoSolarized'

call plug#end()            " required


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

" Curser and Number setting
set number  " show line numbers
set relativenumber
set cursorline

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
" General Settings {{{

" Set shell to powershell
"set shell=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

" Bind exiting the terminal
tnoremap <c-[> <c-\><c-n> 


" Abbreviations {{{

:iabbrev @@ jakob@schmutz.co.uk
:iabbrev @@w jakob.schmutz@apteco.co.uk


" }}}

"" Rebind <Leader> key
nnoremap <Space> <NOP>
let mapleader = "\<Space>"

"" Quickly open .vimrc
nnoremap <leader>v :e $MYVIMRC<cr>

"" File commands
noremap <Leader>q :q<CR>  " Quit current window
noremap <Leader>Q :wqa!<CR>   " Quit all windows
noremap <leader>w :w<cr>

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

" Search Settings
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <leader>, :nohl<cr>

" }}}
" Plugin Settings {{{

" Nerd Tree {{{


" Open root dictionary
"nnoremap <leader>t :NERDTree ~/<cr>
"nnoremap <leader>r :NERDTreeFind<cr>


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

" Point neovim at python3 env
let g:python3_host_prog = 'C:\Python\Lib\site-packages\neovim\'


" some settings to make python easier to work with
aug pythonSetting
	au!
	au filetype python setlocal tabstop=4
	au filetype python setlocal softtabstop=4
	au filetype python setlocal shiftwidth=4
	au filetype python setlocal textwidth=79
	au filetype python setlocal expandtab
	au filetype python setlocal autoindent
	au filetype python setlocal fileformat=unix
	au filetype python setlocal colorcolumn=80
	au filetype python highlight ColorColumn ctermbg=233
aug END

" Run python script
aug runscript
	au!
	au FileType python nnoremap <silent><leader>fs :w!<cr>:!py %<cr>
aug END

" }}}

" Markdown Settings {{{
"
"

aug spell_checkMd
    au!
    au filetype markdown setlocal spell
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

" Navigating with guides
aug nav_bindings
	au!
	au Filetype tex
		\inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
		\vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
		\map <Space><Tab> <Esc>/<++><Enter>"_c4l
		\inoremap ;gui <++>
aug END

"{{{
" Texttypes
autocmd FileType tex inoremap ;em \emph{}<++><Esc>T{i
autocmd FileType tex inoremap ;bf \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap ;it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ;ct \textcite{}<++><Esc>T{i
autocmd FileType tex inoremap ;cp \parencite{}<++><Esc>T{i

"Begintypes
autocmd FileType tex inoremap ;ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;bit \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;li <Enter>\item<Space>
autocmd FileType tex inoremap ;ref \ref{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ;tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
autocmd FileType tex inoremap ;sec \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;up <Esc>/usepackage<Enter>No\usepackage{}<Esc>:noh<cr>i
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

