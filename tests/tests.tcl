package require Tcl 8.5
package require tcltest 2.0
eval ::tcltest::configure $argv

set src_tree [file join [file dirname [info script]] ..]
source [file join $src_tree src textile.tcl]

namespace eval ::textile::test {
   namespace import ::tcltest::*

   test heading-1 "h1 tag is converted" -body {
      ::textile::convert "h1. This is a heading"
   } -result "<h1>This is a heading</h1>"

   test heading-2 "h2 tag is converted" -body {
      ::textile::convert "h2. This is a heading"
   } -result "<h2>This is a heading</h2>"

   test heading-10 "h10 tag is not converted" -body {
      ::textile::convert "h10. This is a heading"
   } -result "<p>h10. This is a heading</p>"

   test heading-7 "h7 tag is not converted" -body {
      ::textile::convert "h7. This is a heading"
   } -result "<p>h7. This is a heading</p>"

   test paragraph "paragraph tag is applied to non-headings" -body {
      ::textile::convert "This is a paragraph"
   } -result "<p>This is a paragraph</p>"

   test multiline-block-paragraph "paragraph spanning multiple lines" -body {
      ::textile::convert "This is a paragraph\nThis is a continuation"
   } -result "<p>This is a paragraph<br/>This is a continuation</p>"

   test emphasis "emphasis is applied to _ tag" -body {
      ::textile::convert "This is _emphasized_"
   } -result "<p>This is <em>emphasized</em></p>"

   test strong "strong is applied to * tag" -body {
      ::textile::convert "This is *strong*"
   } -result "<p>This is <strong>strong</strong></p>"

   test citation "citation is applied to ?? tag" -body {
      ::textile::convert "This is ??cited??"
   } -result "<p>This is <cite>cited</cite></p>"

   test deleted-text "strikethrough is applied to - tag" -body {
      ::textile::convert "This is -deleted-"
   } -result "<p>This is <del>deleted</del></p>"

   test inserted-text "underline is applied to + tag" -body {
      ::textile::convert "This is +added+"
   } -result "<p>This is <ins>added</ins></p>"

   test superscript "superscript is applied to ^ tag" -body {
      ::textile::convert "This is ^superscript^"
   } -result "<p>This is <sup>superscript</sup></p>"

   test subscript "subscript is applied to ~ tag" -body {
      ::textile::convert "This is ~subscript~"
   } -result "<p>This is <sub>subscript</sub></p>"

   test span "span is applied to % tag" -body {
      ::textile::convert "This is %spanned%"
   } -result "<p>This is <span>spanned</span></p>"

   test emphasis-with-spaces "emphasis is applied to _ tag with spaces" -body {
      ::textile::convert "This is _spaced emphasis_"
   } -result "<p>This is <em>spaced emphasis</em></p>"

   cleanupTests
}

namespace delete ::textile::test
