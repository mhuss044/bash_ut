set guifont=Monospace:h10	" wont affect the text size of vim terminal mode(which uses the terminal font)
set nocompatible	" Set compatibility to Vim only.

function! GenerateTagsFile()
	if filereadable("tags")
"		silent	!echo "->Updated tags file"		"makes top of window text dis
		set laststatus=2						"instead statusline
		set statusline=Updated					"this never displays tho bcs laststatus=0
		set statusline+=\ tags
		set laststatus=0
	else
"		silent !echo "->Created tags file"
		set laststatus=2						"show msg in statusline
		set statusline=Created
		set statusline+=\ tags
		set statusline+=\ file
		silent! !ctags -R &	
	endif
endfunction

set tags=./tags;	" tell vim to find the tags file in the same dir as the current file, semicolon indicates to search upwards if tags file not found
" autocmd run GenerateTagsFile upon FileWritePost: write part of a buffer to file event, or BufWritePost: write all of a buffer to file event
" error; had to place *.c, *.cpp, *.h and *.php on separate lines or else get /bin/bash/ looking for missing '"' error
" the above error may stem from adding a comment at the end of the au line
au BufWritePost,FileWritePost *.c,*.cpp,*.h :call GenerateTagsFile()
au BufWritePost,FileWritePost *.php :call GenerateTagsFile()
au BufWritePost,FileWritePost *.py :call GenerateTagsFile()
au BufWritePost,FileWritePost *.java :call GenerateTagsFile()
au BufWritePost,FileWritePost *.js :call GenerateTagsFile()
au BufWritePost,FileWritePost *.ino :call GenerateTagsFile()
au BufWritePost,FileWritePost *.html,*.htm :call GenerateTagsFile()

"au BufWritePost,FileWritePost * :call CtEx()  " upon write any file, call func

" autotag tags file updater; does NOT create it, need above autocmd and func GenerateTagsFile
set runtimepath^=~/.vim/plugin/autotag.vim
" Taglist tag viewer
set runtimepath^=~/.vim/plugin/taglist.vim
" F8 to open taglist and focus on it
nnoremap <silent> <F8> :TlistOpen<CR>
let Tlist_Close_On_Select=1 " auto close the taglist window when a tag or file is selected
let Tlist_Exit_OnlyWindow=1 " auto close vim when only the taglist win is open
let Tlist_Process_File_Always=1	" gen tags for new files even when the taglist window is closed
let Tlist_Enable_Fold_Column=0	" dont display the fold column 

" CTRLP file search plug in:
set runtimepath^=~/.vim/bundle/ctrlp.vim

set number	" display line numbers, aka set nu
syntax on
syntax enable	" enable syntax processing

set tabstop=4	" number of visual spaces per TAB
set softtabstop=4	" number of spaces in tab when editing
" tabs are spaces:
"set expandtab	

set cursorline	" highlight current line
set showmatch	" highlight matching [{()}]
set wildmenu	" visual autocomplete for command menu
set wrap		" long lines are displayed onto multiple lines; in order to move j/k thru these lines, use gk, gj to navigate within a line

"set nowrap		" display long lines as one line, will have to scroll horizontally
set textwidth=0	" the following two lines prevent vim from inserting line breaks when entering new text, aka creating a new line
set wrapmargin=0

set incsearch	" search as characters are entered
set hlsearch	" highlight matches

filetype indent plugin on	" load filetype-specific indent files
set autoindent	" keep the same indent as the line you're currently on.
set foldenable	" enable folding
set foldlevelstart=10	" open most folds by default, 0; all folds closed, 99;all open
" 10 nested fold max:
"set foldnestmax=10	
set foldmethod=indent	" fold on indents

