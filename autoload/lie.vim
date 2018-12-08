function! lie#LieFile()
	call lie#LieRestart()
	call VimuxRunCommand('read ' . expand('%:p'))
endfunction

function! lie#LieStart()
	VimuxRunCommand('lie')
endfunction

function! lie#LieClean()
  call VimuxSendKeys("^l")
endfunction

function! lie#LieRestart()
	call lie#LieClean()
	call VimuxSendKeys("^c")
	call VimuxSendKeys("^d")
	call VimuxSendKeys("^l")
	call lie#LieStart()
endfunction

function! lie#LieExit()
    call lie#LieSendString('exit')
endfunction

function! lie#LieSendString(str)
	VimuxRunCommand(a:str)
endfunction

function! lie#LieSendBuffer()
    call lie#LieSend("1", "$")
endfunction

" Accepts inputs of either string, list<string>, or line1,line2
function! lie#LieSend(...)
    if a:0 == 0
        let lines = getline(".")
    elseif a:0 == 1
        let ta1 = type(a:1)
        if ta1 == 1
            " strings: break up on newlines
            let lines = split(a:1, "\n")
        elseif ta1 == 3
            " lists: take-as-is
            let lines = a:1
        else
            call LieWarning('vim-Lie-plugin: Argument must be a string or a list.')
            return
        endif
    elseif a:0 == 2
        if type(a:1) <= 1 && type(a:2) <= 1
            " integers/strings
            let lines = getline(a:1, a:2)
            let mode = visualmode(1)
            if mode != '' && line("'<") == a:1
                if mode == "v"
                    let start = col("'<") - 1
                    let end = col("'>") - 1
                    " slice in end before start in case the selection is only one line
                    let lines[-1] = lines[-1][: end]
                    let lines[0] = lines[0][start :]
                elseif mode == "\<c-v>"
                    let start = col("'<")
                    if col("'>") < start
                        let start = col("'>")
                    endif
                    let start = start - 1
                    call map(lines, 'v:val[start :]')
                endif
            endif
        else
            call LieWarning('vim-Lie-plugin: Arguments must be a pair of strings/integers.')
            return
        endif
    else
        call LieWarning('vim-Lie-plugin: Invalid number of arguments.')
    endif

	call VimuxPasteLines(lines)
endfunction
