if exists("b:did_indent")
	finish
endif

let b:did_indent = 1

let s:cpo_save = &cpoptions
set cpoptions&vim

setlocal indentexpr=GetLieIndent()
setlocal indentkeys+=0=then,0=do,0=else,0=elif,0=fi,0=od,),0=;;,0=;&
setlocal indentkeys-=:,0#
setlocal nosmartindent

let s:cpo_save = &cpo
set cpo&vim

function! GetLieIndent()
	let l:prevlnum = prevnonblank(v:lnum - 1)
	if l:prevlnum == 0
		return 0
	endif

	let line = getline(v:lnum)
	let prevl = getline(l:prevlnum)

	let ind = indent(l:prevlnum)

	if prevl =~ '^\s*\<\%\(if\|then\|do\|else\|while\|for\)\>' || prevl =~ '{$'
		if prevl !~ '\<\%\(fi\|od\)\>\s*\%\(#.*\)\=;$'
			let ind += shiftwidth()
		endif
	endif

	if line =~ '^\s*\<\%\(then\|do\|else\|fi\|od\)\>' || line =~ '^\s*}'
		let ind -= shiftwidth()
	endif

	return ind
endfunction

let &cpoptions = s:cpo_save
unlet s:cpo_save
