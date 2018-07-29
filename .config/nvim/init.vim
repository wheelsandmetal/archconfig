" vim:fdm=marker

" vim-plug Setting {{{
"" github.com/junegunn/vim-plug
"" To install use :PlugInstall
set nocompatible

call plug#begin()

Plug 'neomake/neomake'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-surround'
Plug 'kana/vim-submode'

"" lsp
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


"" Python
Plug 'tmhedberg/SimpylFold'
 
"" R
Plug 'jalvesaq/Nvim-R'

"" LaTeX
Plug 'lervag/vimtex'

"" Markdown
"function! BuildComposer(info)
"	if a:info.status != 'unchanged' || a:info.force
"		if has('nvim')
"			!cargo build --release
"		else
"			!cargo build --release --no-default-features --features json-rpc
"		endif
"	endif
"endfunction

" Must run `cargo build --release` in plugin directory
"Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }


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
syntax enable
let g:solarized_termcolors=256
set background=dark
"colorscheme solarized
colorscheme NeoSolarized

" Curser and Number setting
set number  " show line numbers
set cursorline

 " Status line settings
set laststatus=2
set statusline=%f " shortend current file path
set statusline+=%m " is current file modified
set statusline+=%= " switch sies
set statusline+=%.30{getcwd()} " current working dir limited to 20char

" }}}
" Tests {{{

" Reduce time out deylay
set timeoutlen=1000 ttimeoutlen=0


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

" grow/shrink
call submode#enter_with('grow/shrink', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('grow/shrink', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('grow/shrink', 'n', '', '-', '<C-w>-')
call submode#map('grow/shrink', 'n', '', '+', '<C-w>+')

" left/right
call submode#enter_with('left/right', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('left/right', 'n', '', '<C-w>>', '<C-w>>')
call submode#map('left/right', 'n', '', '<', '<C-w><')
call submode#map('left/right', 'n', '', '>', '<C-w>>')

"}}}

" Search Settings
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <leader>, :nohl<cr>

" }}}
" Plugin Settings {{{

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

" {{{ ncm2

"" enable ncm2 for all buffer
"autocmd BufEnter * call ncm2#enable_for_buffer()
""
"" " note that must keep noinsert in completeopt, the others is optional
"set completeopt=noinsert,menuone,noselect
""
"" " ### The following vimrc is optional
""
"" " supress the annoying 'match x of y', 'The only match' messages
"set shortmess+=c
""
"" " CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
"inoremap <c-c> <ESC>
""
"" " When the <Enter> key is pressed while the popup menu is visible, it only
"" " hides the menu. Use this mapping to close the menu and also start a new
"" " line.
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
""
"" " Use <TAB> to select the popup menu:
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
""
"" " trigger completion on <backspace> and <c-w>
"imap <backspace> <backspace><Plug>(ncm2_auto_trigger)
"imap <c-w> <c-w><Plug>(ncm2_auto_trigger)
""
"" " wrap existing omnifunc
"" " Note that omnifunc does not run in background and may probably block the
"" " editor. If you don't want to be blocked by omnifunc too often, you could add
"" " 180ms delay before the omni wrapper:
"" "  'on_complete': ['ncm2#on_complete#delay', 180,
"" "               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
"au User Ncm2Plugin call ncm2#register_source({
			"\ 'name' : 'css',
			"\ 'priority': 9, 
			"\ 'subscope_enable': 1,
			"\ 'scope': ['css','scss'],
			"\ 'mark': 'css',
			"\ 'word_pattern': '[\w\-]+',
			"\ 'complete_pattern': ':\s*',
			"\ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
			"\ })
"
"
"" }}}

"" }}}

" Python Settings {{{

" Point neovim at python3 env
let g:python3_host_prog = '/usr/local/bin/python3'



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
aug END

" Run python script
aug runscript
	au!
	au FileType python nnoremap <silent><leader>fs :w!<cr>:!python3 %<cr>
aug END

" }}}

" R Settings {{{


let r_indent_ess_compatible = 1
let r_indent_align_args = 0
" some settings to make R easier to work with
aug RSetting
	au!
	au filetype r setlocal tabstop=2
	au filetype r setlocal softtabstop=2
	au filetype r setlocal shiftwidth=2
	au filetype r setlocal textwidth=79
	au filetype r setlocal expandtab
	au filetype r setlocal autoindent
	au filetype r setlocal fileformat=unix
	au filetype r setlocal colorcolumn=80
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
" }}}
" Java Settings {{{

" Compile code
aug compiling
    au!
    au FileType java nnoremap <F5> :w!<cr>:!javac %<cr>
    au FileType java nnoremap <F6> :! javac %:r<cr>
aug END


" }}}

