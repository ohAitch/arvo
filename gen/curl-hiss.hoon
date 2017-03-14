::  Make HTTP request(get only)
::
::::  /hoon/curl-hiss/gen
  ::
/?    310
/-  gene
=>  [gene g=dsl:gene]
:-  %get  |=  {^ {a/hiss $~} usr/iden}
^-  (request (cask httr))
?.  ?=($get p.q.a)
  ~|  %only-get-requests-supported-in-generators  :: XX enforced?
  !!
:-  *tang
:^  %|  `usr  `hiss`a
|=(hit/httr (so.g %httr hit))
