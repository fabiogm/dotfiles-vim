" Vim syntax file
" Language: Clojure	
" Last Change:	2014 Feb 7
" Maintainer: Fabio Gabriel <fmagalhaes@gmail.com>
" 
" Based on Scheme syntax file originally by Dirk van Deun <dirk@igwe.vub.ac.be>

" This script incorrectly recognizes some junk input as numerals:
" parsing the complete system of Scheme numerals using the pattern
" language is practically impossible: I did a lax approximation.

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
"syn match	clojureError	![^ \t()\[\]";]*!
"syn match	clojureError	")"

" Hash maps
" FIXME: Not working properly. Sometimes an end of hash-map will be taken as
" an error. Don't know why.
syn region clojureHash matchgroup=Delimiter start="{" matchgroup=Delimiter end="}" contains=TOP

" Quoted and backquoted stuff
syn region clojureQuoted matchgroup=Delimiter start="['`]" end=![ \t()\[\]";]!me=e-1 contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc

syn region clojureQuoted matchgroup=Delimiter start="['`](" matchgroup=Delimiter end=")" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc
syn region clojureQuoted matchgroup=Delimiter start="['`]#(" matchgroup=Delimiter end=")" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc

syn region clojureStrucRestricted matchgroup=Delimiter start="(" matchgroup=Delimiter end=")" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc
syn region clojureStrucRestricted matchgroup=Delimiter start="#(" matchgroup=Delimiter end=")" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc

" Popular Scheme extension:
" using [] as well as ()
"syn region clojureStrucRestricted matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc
"syn region clojureStrucRestricted matchgroup=Delimiter start="#\[" matchgroup=Delimiter end="\]" contains=ALLBUT,clojureStruc,clojureSyntax,clojureFunc

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

if version < 600
  set iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
else
  setlocal iskeyword=33,35-39,42-58,60-90,94,95,97-122,126,_
endif

syn keyword clojureConstant nil

syn keyword clojureBoolean false true

syn keyword clojureMacro ->

syn keyword clojureSyntax fn defn defn- definline identity constantly memfn comp
syn keyword clojureSyntax complement partial juxt memoize fnil every-pred some-fn

syn keyword clojureSyntax def defmacro defmethod defmulti defonce defrecord
syn keyword clojureSyntax declare intern binding find-var var type

syn keyword clojureSyntax definterface

syn keyword clojureNamespace ns

syn keyword clojureSyntax do let letfn quote var loop recur throw try monitor-enter monitor-exit

syn keyword clojureSyntax doseq dorun doall

syn keyword clojureSyntax seq vals keys rseq subseq rsubseq
syn keyword clojureSyntax lazy-seq repeatedly iterate
syn keyword clojureSyntax repeat range

syn keyword clojureSyntax cons first second last rest next ffirst nfirst fnext nnext nth nthnext
syn keyword clojureSyntax rand-nth when-first max-key min-key

syn keyword clojureSyntax and or if cond case 

syn keyword clojureSyntax defprotocol defrecord deftype defmulti defmethod

syn keyword clojureSyntax hash-map merge

syn keyword clojureSyntax count empty not-empty into conj walk prewalk prewalk-demo prewalk-replace
syn keyword clojureSyntax postwalk postwalk-demo postwalk-replace
syn keyword clojureSyntax distinct? empty? every? not-every? some not-any?
syn keyword clojureSyntax sequential? associative? sorted? counted? reversible?

syn keyword clojureSyntax coll? list? vector? set? map? seq? symbol?

syn keyword clojureSyntax and or xor not flip set shift-right shift-left and-not clear test 

syn keyword clojureFunc = < > <= >=
syn keyword clojureFunc zero? pos? neg? odd? even? max min + * - / quot rem mod inc dec max min 

syn keyword clojureFunc str format get subs compare join escape split split-lines repace replace-first reverse
syn keyword clojureFunc re-find re-seq re-matches re-pattern re-matcher re-groups
syn keyword clojureFunc re-quote-replacement 

syn keyword clojureFunc vector vec vector-of vector?
syn keyword clojureFunc apply map reduce for-each into

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

" Clojure multiline comment
syn region clojureComment start="(comment" end=")"

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

  HiLink clojureMacro			Statement
  HiLink clojureNamespace		Statement
  HiLink clojureSyntax			Statement
  HiLink clojureFunc			Function

  HiLink clojureString			String
  HiLink clojureCharacter		Character
  HiLink clojureNumber			Number
  HiLink clojureBoolean			Boolean

  HiLink clojureDelimiter		Delimiter
  HiLink clojureConstant		Constant

  HiLink clojureComment			Comment
  HiLink clojureMultilineComment	Comment
  HiLink clojureError			Error

  HiLink clojureExtSyntax		Type
  HiLink clojureExtFunc			PreProc
  delcommand HiLink
endif

let b:current_syntax = "clojure"
