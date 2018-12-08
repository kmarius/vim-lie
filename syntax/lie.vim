if exists('b:current_syntax')
    finish
endif

syntax case match

syntax keyword lieType int vec mat pol grp tex vid
syntax keyword lieKeyword setdefault loc make iapply vapply mapply read write on off savestate restorestate help quit exit
syntax keyword lieConditional if then else fi
syntax keyword lieRepeat while for to downto in row do od break
syntax keyword lieReturn return

syntax match lieNumber /[0-9]*/

syntax match lieCommentLine /#.*/
" syntax region lieComment start='#' end='#'

" syntax match lieIdentifier /\$[[:alnum:]_]\+/
syntax region lieString start=/"/ skip=/\\"/ end=/"/ contains=lieIdentifier
" syntax match lieCharacter /\v\\[abefnrtv *?~%#(){}\[\]<>&;"']|\\[xX][0-9a-f]{1,2}|\\o[0-7]{1,2}|\\u[0-9a-f]{1,4}|\\U[0-9a-f]{1,8}|\\c[a-z]/
" syntax match lieStatement /\v;\s*\zs\k+>/

" syntax region lieLineContinuation matchgroup=lieStatement
"             \ start='\v^\s*\zs\k+>' skip='\\$' end='$'
"             \ contains=lieSpecial,lieIdentifier,lieString,lieCharacter,lieStatement,lieCommandSub,lieComment

highlight default link lieNumber Number
highlight default link lieSetKeywords Keyword
highlight default link lieReturn Keyword
highlight default link lieType Type
highlight default link lieKeyword Keyword
highlight default link lieConditional Conditional
highlight default link lieRepeat Repeat
highlight default link lieLabel Label
highlight default link lieComment Comment
highlight default link lieCommentLine Comment
highlight default link lieSpecial Special
highlight default link lieIdentifier Identifier
highlight default link lieString String
highlight default link lieCharacter Character
highlight default link lieStatement Statement
highlight default link lieCommandSub lieStatement

let b:current_syntax = 'lie'
