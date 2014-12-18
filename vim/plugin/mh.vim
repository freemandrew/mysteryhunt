" mh.vim Mystery Hunt Helper Functions
"
" 2014 Jeff Simpson jeffsimpson@alum.wpi.edu

" Convert Ascii value to corresponding character
function! Ascii2Alpha() range
    :silent s/\%V\(\d\{1,2}\)/\=nr2char(str2nr(submatch(0)))/ge
endfunction

" Convert Ascii value to index, assuming 1=A
function! Ascii2Index() range
    :silent s/\%V\(\d\{1,2}\)/\=str2nr(submatch(1))-64/ge
endfunction

" Convert Uppercase Alpha to Index (A=1, B=2, ...)
function! Alpha2Index() range
    :silent s/\%V\(\u\)/\=char2nr(submatch(1))-64/ge
endfunction

" Convert Uppercase Alpha to Ascii (A=65)
function! Alpha2Ascii() range
    :silent s/\%V\(\u\)/\=char2nr(submatch(1))/g
endfunction

" Convert Index (1-26) to Uppercase Alpha (A=1, B=2, ...)
function! Index2Alpha() range
    :silent s/\%V\(\d\{1,2}\)/\=nr2char(str2nr(submatch(1)+64))/ge
endfunction

" Convert Index (1-26) to Ascii (1->65, ...)
function! Index2Ascii() range
    :silent s/\%V\(\d\{1,2}\)/\=submatch(1)+64/ge
endfunction

" Perform a Caesar Shift of distance 'dist'
function! CaesarShift(dist) range
    let dist = a:dist
    if (dist < 1)
        let dist=26+dist
    endif
    :silent '<,'>s/\%V\u/\=nr2char(char2nr('A') + ((char2nr(submatch(0)) - char2nr('A') + dist) % 26))/ge
    :silent '<,'>s/\%V\l/\=nr2char(char2nr('a') + ((char2nr(submatch(0)) - char2nr('a') + dist) % 26))/ge
    normal! gv
endfunction

" Perform a Caesar Shift of requested distance
function! CaesarShiftAsk() range
    call inputsave()
    let dist = input("Distance: ")
    call CaesarShift(dist)
    call inputrestore()
endfunction

" Add spaces between all characters in the file
function! SpaceText() range
    :silent '<,'>s/\%V\([^\>]\)/\1 /ge
endfunction

" Bind Keys
vmap <silent> <C-Up> :call CaesarShift(1)<CR>
vmap <silent> <C-Down> :call CaesarShift(-1)<CR>
vmap <F3> :call Test()<CR>

" Create Menu
if (has('gui_running'))
    " add perl scripts to menu
    for f in split(glob('~/.vim/perl/*.pl'), '\n')
        execute ('vmenu <silent> &Mystery\ Hunt.Perl.' . fnamemodify(f, ':t:r') . ' !perl ' . f . '<CR>')
    endfor

    vmenu <silent> &Mystery\ Hunt.&Ascii\ To\ Alpha :call Ascii2Alpha()<CR>
    vmenu <silent> &Mystery\ Hunt.&Ascii\ To\ Index :call Ascii2Index()<CR>
    menu &Mystery\ Hunt.-sep1- :

    vmenu <silent> &Mystery\ Hunt.&Alpha\ To\ Ascii :call Alpha2Ascii()<CR>
    vmenu <silent> &Mystery\ Hunt.&Alpha\ To\ Index :call Alpha2Index()<CR>
    menu &Mystery\ Hunt.-sep2- :

    vmenu <silent> &Mystery\ Hunt.&Index\ To\ Ascii :call Index2Ascii()<CR>
    vmenu <silent> &Mystery\ Hunt.&Index\ To\ Alpha :call Index2Alpha()<CR>
    menu &Mystery\ Hunt.-sep3- :

    vmenu <silent> &Mystery\ Hunt.Caesar\ Shift.+1<Tab><C-Up> :call CaesarShift(1)<CR>
    vmenu <silent> &Mystery\ Hunt.Caesar\ Shift.-1<Tab><C-Down> :call CaesarShift(-1)<CR>
    vmenu <silent> &Mystery\ Hunt.Caesar\ Shift.X :call CaesarShiftAsk()<CR>

    menu &Mystery\ Hunt.-sep4- :

    vmenu <silent> &Mystery\ Hunt.Space\ Text :call SpaceText()<CR>

    menu &Mystery\ Hunt.-sep5- :
    amenu <silent> &Mystery\ Hunt.&Reload\ Script :source ~/.vim/plugin/mh.vim<CR>
endif
