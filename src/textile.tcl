package require Tcl 8.5

package provide textile 0.1

namespace eval  ::textile { }

proc ::textile::convert_line {line} {
   if {[regexp -- {^h[1-6]\.} $line]} {
      set line [regsub -- {^h([1-6])\.\s*(.*)} $line {<h\1>\2</h\1>}]
   } else {
      set line "<p>$line</p>"
   }

   set line [regsub -- {\_(.+)\_} $line {<em>\1</em>}]
   set line [regsub -- {\*(.+)\*} $line {<strong>\1</strong>}]
   set line [regsub -- {\?\?(.+)\?\?} $line {<cite>\1</cite>}]
   set line [regsub -- {\-(.+)\-} $line {<del>\1</del>}]
   set line [regsub -- {\+(.+)\+} $line {<ins>\1</ins>}]
   set line [regsub -- {\^(.+)\^} $line {<sup>\1</sup>}]
   set line [regsub -- {\~(.+)\~} $line {<sub>\1</sub>}]
   set line [regsub -- {\%(.+)\%} $line {<span>\1</span>}]
}
