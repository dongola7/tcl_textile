package require Tcl 8.5

package provide textile 0.1

namespace eval  ::textile { }

proc ::textile::convert {text} {
   if {[regexp -- {^h[1-6]\.} $text]} {
      set text [regsub -- {^h([1-6])\.\s*(.*)} $text {<h\1>\2</h\1>}]
   } else {
      set text "<p>$text</p>"
   }

   set text [regsub -- {\n} $text {<br/>}]

   set text [regsub -- {\_(.+)\_} $text {<em>\1</em>}]
   set text [regsub -- {\*(.+)\*} $text {<strong>\1</strong>}]
   set text [regsub -- {\?\?(.+)\?\?} $text {<cite>\1</cite>}]
   set text [regsub -- {\-(.+)\-} $text {<del>\1</del>}]
   set text [regsub -- {\+(.+)\+} $text {<ins>\1</ins>}]
   set text [regsub -- {\^(.+)\^} $text {<sup>\1</sup>}]
   set text [regsub -- {\~(.+)\~} $text {<sub>\1</sub>}]
   set text [regsub -- {\%(.+)\%} $text {<span>\1</span>}]
}
