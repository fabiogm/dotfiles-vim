" Vim syntax file
" Language: Clojure	
" Last Change:	2014 Feb 5
" Maintainer: Fabio Gabriel <fmagalhaes@gmail.com>
" 
" Based on Scheme syntax file originally by Dirk van Deun <dirk@igwe.vub.ac.be>

" This script incorrectly recognizes some junk input as numerals:
" parsing the complete system of Scheme numerals using the pattern
" language is practically impossible: I did a lax approximation.
 
" MzScheme extensions can be activated with setting is_mzscheme variable

" Suggestions and bug reports are solicited by the author.

" Initializing:

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

" Fascist highlighting: everything that doesn't fit the rules is an error...

syn match	clojureError	![^ \t()\[\]";]*!
syn match	clojureError	")"

" Quoted and backquoted stuff

syn region clojureQuoted matchgroup=Delimiter start="['`]" end=![ \t()\[\]";]!me=e-1 contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc

syn region clojureQuoted matchgroup=Delimiter start="['`](" matchgroup=Delimiter end=")" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc
syn region clojureQuoted matchgroup=Delimiter start="['`]#(" matchgroup=Delimiter end=")" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc

syn region clojureStrucRestricted matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc
syn region clojureStrucRestricted matchgroup=Delimiter start="#(" matchgroup=Delimiter end=")" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc

" Popular Scheme extension:
" using [] as well as ()
syn region clojureStrucRestricted matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc
syn region clojureStrucRestricted matchgroup=Delimiter start="#\[" matchgroup=Delimiter end="\]" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc

syn region clojureUnquote matchgroup=Delimiter start="," end=![ \t\[\]()";]!me=e-1 contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc
syn region clojureUnquote matchgroup=Delimiter start=",@" end=![ \t\[\]()";]!me=e-1 contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc

syn region clojureUnquote matchgroup=Delimiter start=",(" end=")" contains=ALL
syn region clojureUnquote matchgroup=Delimiter start=",@(" end=")" contains=ALL

syn region clojureUnquote matchgroup=Delimiter start=",#(" end=")" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc
syn region clojureUnquote matchgroup=Delimiter start=",@#(" end=")" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc

syn region clojureUnquote matchgroup=Delimiter start=",\[" end="\]" contains=ALL
syn region clojureUnquote matchgroup=Delimiter start=",@\[" end="\]" contains=ALL

syn region clojureUnquote matchgroup=Delimiter start=",#\[" end="\]" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc
syn region clojureUnquote matchgroup=Delimiter start=",@#\[" end="\]" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc

" R5RS Scheme Functions and Syntax:

if version < 600
  set iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
else
  setlocal iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
endif

syn keyword clojureSyntax fn defn defn- definline identity constantly memfn comp
syn keyword clojureSyntax complement partial juxt memoize fnil every-pred some-fn

syn keyword clojureSyntax def defmacro defmethod defmulti defonce defrecord
syn keyword clojureSyntax declare intern binding find-var var

syn keyword clojureSyntax and or if cond case define let let* letrec
syn keyword clojureSyntax begin do delay set! else =>
syn keyword clojureSyntax quote quasiquote unquote unquote-splicing
syn keyword clojureSyntax define-syntax let-syntax letrec-syntax syntax-rules
" R6RS
syn keyword clojureSyntax define-record-type fields protocol

syn keyword clojureFunc not boolean? eq? eqv? equal? pair? cons car cdr set-car!
syn keyword clojureFunc set-cdr! caar cadr cdar cddr caaar caadr cadar caddr
syn keyword clojureFunc cdaar cdadr cddar cdddr caaaar caaadr caadar caaddr
syn keyword clojureFunc cadaar cadadr caddar cadddr cdaaar cdaadr cdadar cdaddr
syn keyword clojureFunc cddaar cddadr cdddar cddddr null? list? list length
syn keyword clojureFunc append reverse list-ref memq memv member assq assv assoc
syn keyword clojureFunc symbol? symbol->string string->symbol number? complex?
syn keyword clojureFunc real? rational? integer? exact? inexact? = < > <= >=
syn keyword clojureFunc zero? positive? negative? odd? even? max min + * - / abs
syn keyword clojureFunc quotient remainder modulo gcd lcm numerator denominator
syn keyword clojureFunc floor ceiling truncate round rationalize exp log sin cos
syn keyword clojureFunc tan asin acos atan sqrt expt make-rectangular make-polar
syn keyword clojureFunc real-part imag-part magnitude angle exact->inexact
syn keyword clojureFunc inexact->exact number->string string->number char=?
syn keyword clojureFunc char-ci=? char<? char-ci<? char>? char-ci>? char<=?
syn keyword clojureFunc char-ci<=? char>=? char-ci>=? char-alphabetic? char?
syn keyword clojureFunc char-numeric? char-whitespace? char-upper-case?
syn keyword clojureFunc char-lower-case?
syn keyword clojureFunc char->integer integer->char char-upcase char-downcase
syn keyword clojureFunc string? make-string string string-length string-ref
syn keyword clojureFunc string-set! string=? string-ci=? string<? string-ci<?
syn keyword clojureFunc string>? string-ci>? string<=? string-ci<=? string>=?
syn keyword clojureFunc string-ci>=? substring string-append vector? make-vector
syn keyword clojureFunc vector vector-length vector-ref vector-set! procedure?
syn keyword clojureFunc apply map for-each call-with-current-continuation
syn keyword clojureFunc call-with-input-file call-with-output-file input-port?
syn keyword clojureFunc output-port? current-input-port current-output-port
syn keyword clojureFunc open-input-file open-output-file close-input-port
syn keyword clojureFunc close-output-port eof-object? read read-char peek-char
syn keyword clojureFunc write display newline write-char call/cc
syn keyword clojureFunc list-tail string->list list->string string-copy
syn keyword clojureFunc string-fill! vector->list list->vector vector-fill!
syn keyword clojureFunc force with-input-from-file with-output-to-file
syn keyword clojureFunc char-ready? load transcript-on transcript-off eval
syn keyword clojureFunc dynamic-wind port? values call-with-values
syn keyword clojureFunc scheme-report-environment null-environment
syn keyword clojureFunc interaction-environment
" R6RS
syn keyword clojureFunc make-eq-hashtable make-eqv-hashtable make-hashtable
syn keyword clojureFunc hashtable? hashtable-size hashtable-ref hashtable-set!
syn keyword clojureFunc hashtable-delete! hashtable-contains? hashtable-update!
syn keyword clojureFunc hashtable-copy hashtable-clear! hashtable-keys
syn keyword clojureFunc hashtable-entries hashtable-equivalence-function hashtable-hash-function
syn keyword clojureFunc hashtable-mutable? equal-hash string-hash string-ci-hash symbol-hash 
syn keyword clojureFunc find for-all exists filter partition fold-left fold-right
syn keyword clojureFunc remp remove remv remq memp assp cons*

" ... so that a single + or -, inside a quoted context, would not be
" interpreted as a number (outside such contexts, it's a clojureFunc)

syn match	clojureDelimiter	!\.[ \t\[\]()";]!me=e-1
syn match	clojureDelimiter	!\.$!
" ... and a single dot is not a number but a delimiter

" This keeps all other stuff unhighlighted, except *stuff* and <stuff>:

syn match	clojureOther	,[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*,
syn match	clojureError	,[a-z!$%&*/:<=>?^_~+@#%-][-a-z!$%&*/:<=>?^_~0-9+.@#%]*[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

syn match	clojureOther	"\.\.\."
syn match	clojureError	!\.\.\.[^ \t\[\]()";]\+!
" ... a special identifier

syn match	clojureConstant	,\*[-a-z!$%&*/:<=>?^_~0-9+.@]\+\*[ \t\[\]()";],me=e-1
syn match	clojureConstant	,\*[-a-z!$%&*/:<=>?^_~0-9+.@]\+\*$,
syn match	clojureError	,\*[-a-z!$%&*/:<=>?^_~0-9+.@]*\*[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

syn match	clojureConstant	,<[-a-z!$%&*/:<=>?^_~0-9+.@]*>[ \t\[\]()";],me=e-1
syn match	clojureConstant	,<[-a-z!$%&*/:<=>?^_~0-9+.@]*>$,
syn match	clojureError	,<[-a-z!$%&*/:<=>?^_~0-9+.@]*>[^-a-z!$%&*/:<=>?^_~0-9+.@ \t\[\]()";]\+[^ \t\[\]()";]*,

" Non-quoted lists, and strings:

syn region clojureStruc matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALL
syn region clojureStruc matchgroup=Delimiter start="#(" matchgroup=Delimiter end=")" contains=ALL

syn region clojureStruc matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALL
syn region clojureStruc matchgroup=Delimiter start="#\[" matchgroup=Delimiter end="\]" contains=ALL

" Simple literals:
syn region clojureString start=+\%(\\\)\@<!"+ skip=+\\[\\"]+ end=+"+

" Comments:

syn match	clojureComment	";.*$"


" Writing out the complete description of Scheme numerals without
" using variables is a day's work for a trained secretary...

syn match	clojureOther	![+-][ \t\[\]()";]!me=e-1
syn match	clojureOther	![+-]$!
"
" This is a useful lax approximation:
syn match	clojureNumber	"[-#+.]\=[0-9][-#+/0-9a-f@i.boxesfdl]*"
syn match	clojureError	![-#+0-9.][-#+/0-9a-f@i.boxesfdl]*[^-#+/0-9a-f@i.boxesfdl \t\[\]()";][^ \t\[\]()";]*!

syn match	clojureBoolean	"#[tf]"
syn match	clojureError	!#[tf][^ \t\[\]()";]\+!

syn match	clojureCharacter	"#\\"
syn match	clojureCharacter	"#\\."
syn match       clojureError	!#\\.[^ \t\[\]()";]\+!
syn match	clojureCharacter	"#\\space"
syn match	clojureError	!#\\space[^ \t\[\]()";]\+!
syn match	clojureCharacter	"#\\newline"
syn match	clojureError	!#\\newline[^ \t\[\]()";]\+!

" R6RS
syn match clojureCharacter "#\\x[0-9a-fA-F]\+"


if exists("b:is_mzscheme") || exists("is_mzscheme")
    " MzScheme extensions
    " multiline comment
    syn region	clojureComment start="#|" end="|#"

    " #%xxx are the special MzScheme identifiers
    syn match clojureOther "#%[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    " anything limited by |'s is identifier
    syn match clojureOther "|[^|]\+|"

    syn match	clojureCharacter	"#\\\%(return\|tab\)"

    " Modules require stmt
    syn keyword clojureExtSyntax module require dynamic-require lib prefix all-except prefix-all-except rename
    " modules provide stmt
    syn keyword clojureExtSyntax provide struct all-from all-from-except all-defined all-defined-except
    " Other from MzScheme
    syn keyword clojureExtSyntax with-handlers when unless instantiate define-struct case-lambda syntax-case
    syn keyword clojureExtSyntax free-identifier=? bound-identifier=? module-identifier=? syntax-object->datum
    syn keyword clojureExtSyntax datum->syntax-object
    syn keyword clojureExtSyntax let-values let*-values letrec-values set!-values fluid-let parameterize begin0
    syn keyword clojureExtSyntax error raise opt-lambda define-values unit unit/sig define-signature 
    syn keyword clojureExtSyntax invoke-unit/sig define-values/invoke-unit/sig compound-unit/sig import export
    syn keyword clojureExtSyntax link syntax quasisyntax unsyntax with-syntax

    syn keyword clojureExtFunc format system-type current-extension-compiler current-extension-linker
    syn keyword clojureExtFunc use-standard-linker use-standard-compiler
    syn keyword clojureExtFunc find-executable-path append-object-suffix append-extension-suffix
    syn keyword clojureExtFunc current-library-collection-paths current-extension-compiler-flags make-parameter
    syn keyword clojureExtFunc current-directory build-path normalize-path current-extension-linker-flags
    syn keyword clojureExtFunc file-exists? directory-exists? delete-directory/files delete-directory delete-file
    syn keyword clojureExtFunc system compile-file system-library-subpath getenv putenv current-standard-link-libraries
    syn keyword clojureExtFunc remove* file-size find-files fold-files directory-list shell-execute split-path
    syn keyword clojureExtFunc current-error-port process/ports process printf fprintf open-input-string open-output-string
    syn keyword clojureExtFunc get-output-string
    " exceptions
    syn keyword clojureExtFunc exn exn:application:arity exn:application:continuation exn:application:fprintf:mismatch
    syn keyword clojureExtFunc exn:application:mismatch exn:application:type exn:application:mismatch exn:break exn:i/o:filesystem exn:i/o:port
    syn keyword clojureExtFunc exn:i/o:port:closed exn:i/o:tcp exn:i/o:udp exn:misc exn:misc:application exn:misc:unsupported exn:module exn:read
    syn keyword clojureExtFunc exn:read:non-char exn:special-comment exn:syntax exn:thread exn:user exn:variable exn:application:mismatch
    syn keyword clojureExtFunc exn? exn:application:arity? exn:application:continuation? exn:application:fprintf:mismatch? exn:application:mismatch?
    syn keyword clojureExtFunc exn:application:type? exn:application:mismatch? exn:break? exn:i/o:filesystem? exn:i/o:port? exn:i/o:port:closed?
    syn keyword clojureExtFunc exn:i/o:tcp? exn:i/o:udp? exn:misc? exn:misc:application? exn:misc:unsupported? exn:module? exn:read? exn:read:non-char?
    syn keyword clojureExtFunc exn:special-comment? exn:syntax? exn:thread? exn:user? exn:variable? exn:application:mismatch?
    " Command-line parsing
    syn keyword clojureExtFunc command-line current-command-line-arguments once-any help-labels multi once-each 

    " syntax quoting, unquoting and quasiquotation
    syn region clojureUnquote matchgroup=Delimiter start="#," end=![ \t\[\]()";]!me=e-1 contains=ALL
    syn region clojureUnquote matchgroup=Delimiter start="#,@" end=![ \t\[\]()";]!me=e-1 contains=ALL
    syn region clojureUnquote matchgroup=Delimiter start="#,(" end=")" contains=ALL
    syn region clojureUnquote matchgroup=Delimiter start="#,@(" end=")" contains=ALL
    syn region clojureUnquote matchgroup=Delimiter start="#,\[" end="\]" contains=ALL
    syn region clojureUnquote matchgroup=Delimiter start="#,@\[" end="\]" contains=ALL
    syn region clojureQuoted matchgroup=Delimiter start="#['`]" end=![ \t()\[\]";]!me=e-1 contains=ALL
    syn region clojureQuoted matchgroup=Delimiter start="#['`](" matchgroup=Delimiter end=")" contains=ALL
endif


if exists("b:is_chicken") || exists("is_chicken")
    " multiline comment
    syntax region clojureMultilineComment start=/#|/ end=/|#/ contains=clojureMultilineComment

    syn match clojureOther "##[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    syn match clojureExtSyntax "#:[-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"

    syn keyword clojureExtSyntax unit uses declare hide foreign-declare foreign-parse foreign-parse/spec
    syn keyword clojureExtSyntax foreign-lambda foreign-lambda* define-external define-macro load-library
    syn keyword clojureExtSyntax let-values let*-values letrec-values ->string require-extension
    syn keyword clojureExtSyntax let-optionals let-optionals* define-foreign-variable define-record
    syn keyword clojureExtSyntax pointer tag-pointer tagged-pointer? define-foreign-type
    syn keyword clojureExtSyntax require require-for-syntax cond-expand and-let* receive argc+argv
    syn keyword clojureExtSyntax fixnum? fx= fx> fx< fx>= fx<= fxmin fxmax
    syn keyword clojureExtFunc ##core#inline ##sys#error ##sys#update-errno

    " here-string
    syn region clojureString start=+#<<\s*\z(.*\)+ end=+^\z1$+
 
    if filereadable(expand("<sfile>:p:h")."/cpp.vim")
	unlet! b:current_syntax
	syn include @ChickenC <sfile>:p:h/cpp.vim
	syn region ChickenC matchgroup=clojureOther start=+(\@<=foreign-declare "+ end=+")\@=+ contains=@ChickenC
	syn region ChickenC matchgroup=clojureComment start=+foreign-declare\s*#<<\z(.*\)$+hs=s+15 end=+^\z1$+ contains=@ChickenC
	syn region ChickenC matchgroup=clojureOther start=+(\@<=foreign-parse "+ end=+")\@=+ contains=@ChickenC
	syn region ChickenC matchgroup=clojureComment start=+foreign-parse\s*#<<\z(.*\)$+hs=s+13 end=+^\z1$+ contains=@ChickenC
	syn region ChickenC matchgroup=clojureOther start=+(\@<=foreign-parse/spec "+ end=+")\@=+ contains=@ChickenC
	syn region ChickenC matchgroup=clojureComment start=+foreign-parse/spec\s*#<<\z(.*\)$+hs=s+18 end=+^\z1$+ contains=@ChickenC
	syn region ChickenC matchgroup=clojureComment start=+#>+ end=+<#+ contains=@ChickenC
	syn region ChickenC matchgroup=clojureComment start=+#>?+ end=+<#+ contains=@ChickenC
	syn region ChickenC matchgroup=clojureComment start=+#>!+ end=+<#+ contains=@ChickenC
	syn region ChickenC matchgroup=clojureComment start=+#>\$+ end=+<#+ contains=@ChickenC
	syn region ChickenC matchgroup=clojureComment start=+#>%+ end=+<#+ contains=@ChickenC
    endif

    " suggested by Alex Queiroz
    syn match clojureExtSyntax "#![-a-z!$%&*/:<=>?^_~0-9+.@#%]\+"
    syn region clojureString start=+#<#\s*\z(.*\)+ end=+^\z1$+ 
endif

" Synchronization and the wrapping up...

syn sync match matchPlace grouphere NONE "^[^ \t]"
" ... i.e. synchronize on a line that starts at the left margin

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_scheme_syntax_inits")
  if version < 508
    let did_scheme_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink clojureSyntax		Statement
  HiLink clojureFunc		Function

  HiLink clojureString		String
  HiLink clojureCharacter	Character
  HiLink clojureNumber		Number
  HiLink clojureBoolean		Boolean

  HiLink clojureDelimiter	Delimiter
  HiLink clojureConstant		Constant

  HiLink clojureComment		Comment
  HiLink clojureMultilineComment	Comment
  HiLink clojureError		Error

  HiLink clojureExtSyntax	Type
  HiLink clojureExtFunc		PreProc
  delcommand HiLink
endif

let b:current_syntax = "clojure"
