command! -nargs=0 -complete=shellcmd LieStart :call lie#LieStart()
command! -nargs=0 -complete=shellcmd LieRestart :call lie#LieRestart()
command! -nargs=0 -complete=shellcmd LieExit :call lie#LieExit()
command! -nargs=1 -complete=shellcmd LieSendString :call lie#LieSendString(<args>)
command! -nargs=0 -complete=shellcmd LieSendBuffer :call lie#LieSendBuffer()
command! -nargs=0 -range -complete=shellcmd LieSend :call lie#LieSend(<line1>,<line2>)
command! -nargs=0  LieClean :call lie#LieClean()
command! -nargs=0  LieFile :call lie#LieFile()

function! LieWarning(msg)
    echohl WarningMsg
    echo a:msg
    echohl Normal
endfunction

if !executable('lie')
    call LieWarning("Please install 'lie' to run vim-Lie-plugin")
    sleep 2
    finish
endif
