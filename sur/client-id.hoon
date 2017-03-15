::  source identifier
::
::::  /client-id/sur
  ::
:: XX stolen from old zuse
|%
++  pack                                                ::  light path encoding
  |=  {a/term b/path}  ^-  knot
  %+  rap  3  :-  (wack a)
  (turn b |=(c/knot (cat 3 '_' (wack c))))
::
++  pick                                                ::  light path decoding
  =+  fel=(most cab (sear wick urt:ab))
  |=(a/knot `(unit {p/term q/path})`(rush a fel))
--
::
::::
  ::
=,  wired
=<  id
|%
++  id  {@u dock}
++  encode  |=(a/id `@t`(pack (dray /[%ud]/[%p]/[%tas] a)))
++  decode  |=(a/@t `id`(raid (need (pick a)) /[%ud]/[%p]/[%tas]))
--
