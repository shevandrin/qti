
<!-- README.md is generated from README.Rmd. Please edit that file -->

# qti

# TODOS

\[x\] 1. check if composites are possible in OPAL, NOT possible \[x\] 2.
make github repo, push

## create rmd for

<https://www.imsglobal.org/question/qtiv2p1/imsqti_implv2p1.html#section10006>
this is for 2.2, we need 2.1

types of tasks (items):

-   singlechoice
-   multiplechoice
-   text entry
-   numbers entry
-   clozes at the end
-   dropdown,
-   associate (!doesnt work in Opal),
-   order,
-   match (directed pair)
-   match (matchMax\>1, table)
-   essay (extended_text in qti)

be creative: clozes in between text, dropdowns in between text -\>
implement some yaml for input

## making gaps

Simply use \<\<\>\> for a gap, example:

Some Text, and now the gap: \<\<extype:num, solution:10, length:3\>\>
Some more text.

## making dropdowns

<!-- badges: start -->
<!-- badges: end -->

The goal of qti is to …

## Installation