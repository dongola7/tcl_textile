package require Tcl 8.5

package provide textile 0.1

namespace eval  ::textile { }

proc ::textile::_apply_phrase_modifiers {line} {
   set line [regsub -- {\_(.+)\_} $line {<em>\1</em>}]
   set line [regsub -- {\*(.+)\*} $line {<strong>\1</strong>}]
   set line [regsub -- {\?\?(.+)\?\?} $line {<cite>\1</cite>}]
   set line [regsub -- {\-(.+)\-} $line {<del>\1</del>}]
   set line [regsub -- {\+(.+)\+} $line {<ins>\1</ins>}]
   set line [regsub -- {\^(.+)\^} $line {<sup>\1</sup>}]
   set line [regsub -- {\~(.+)\~} $line {<sub>\1</sub>}]
   set line [regsub -- {\%(.+)\%} $line {<span>\1</span>}]
   set line [regsub -- {\[([0-9]+)\]} $line {<sup><a href="#fn\1">\1</a></sup>}]
}

proc ::textile::convert {text} {
   set closing_tag ""
   set result ""

   foreach line [split $text \n] {
      if {$closing_tag eq ""} {
         if {[regexp -- {^(h[1-6])\.\s*(.+)} $line -> tag line]} {
            append result "<" $tag ">"
            set closing_tag "</$tag>"
         } elseif {[regexp -- {^bq\.\s*(.+)} $line -> line]} {
            append result "<blockquote><p>"
            set closing_tag "</p></blockquote>"
         } elseif {[regexp -- {fn([0-9]+)\.(.+)} $line -> footnote line]} {
            append result "<p id=\"fn$footnote\"><sup>$footnote</sup>"
            set closing_tag "</p>"
         } else {
            append result "<p>"
            set closing_tag "</p>"
         }
      } elseif {$line eq ""} {
         append result $closing_tag
         set closing_tag ""
         continue
      } else {
         append result "<br/>"
      }

      append result [_apply_phrase_modifiers $line]
   }

   if {$closing_tag ne ""} {
      append result $closing_tag
   }

   return $result
}
