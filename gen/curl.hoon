::  Fetch contents at url
::
::::  /hoon/curl/gen
  ::
/?    310
/-  gene
=>  [gene g=dsl:gene]
:-  %get  |=  {^ {a/tape $~} $~}
^-  (request (cask httr))
%+  at.g  (scan a auri:urlp)
|=  hit/httr
(so.g %httr hit)
