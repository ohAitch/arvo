::  Get occurnces in file, with line numbers
::  
::::  /hoon/cat/gen
  ::
/?    310
/+    numbered
!:
::::
  ::
|%
++  contains
  |=  a/tape
  =+  b=(lent a)
  |=  c/tape  ^-  ?
  ?|  =(a (scag b c))
      ?~(c | $(c t.c))
  ==
--
!:
::::
  ::
:-  %say
|=  {^ {txt/cord arg/(list path)} $~}
=-  tang+(flop `tang`(zing -))
%+  turn  arg
|=  pax/path
^-  tang
=+  ark=.^(arch %cy pax)
?~  fil.ark  ~
%+  turn
  %+  skim  (numbered (lore .^(@t %cx pax)))
  |=({@u a/cord} %.((trip a) ~+((contains (trip txt)))))
|=  {a/@u b/cord}  ^-  tank
rose+[": " `~]^~[>a< leaf+(trip b)]
