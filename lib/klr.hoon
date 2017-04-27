::  Styx/stub helpers
::
::::  /hoon/klr/lib
  ::
=,  ^dill
|%
++  tufa                                                ::< strip styl, utf32
  |=  a/stub  ^-  tape
  (zing (turn a |=({stye b/(list @c)} (^tufa b))))
::
++  make                                                ::< styx to stub
  ::> a: styx to flatten into a stub
  ::
  |=  a/styx  ^-  stub
  =|  b/stye
  %+  reel
  |-  ^-  stub
  %-  zing  %+  turn  a
  |=  a/$@(@t (pair styl styx))
  ?@  a  [b (tuba (trip a))]~
  ^$(a q.a, b (styd p.a b))
  ::
  |=  {a/(pair stye (list @c)) b/stub}
  ?~  b  [a ~]
  ?.  =(p.a p.i.b)  [a b]
  [[p.a (weld q.a q.i.b)] t.b]
::
++  styd                                                ::< add stye to styl
  ::> a: new styling
  ::> b: existing set of styles
  ::
  |=  {a/styl b/stye}  ^+  b                            ::< with inheritance
  :+  ?~  p.a  p.b
      ?~  u.p.a  ~
      (~(put in p.b) u.p.a)
    (fall p.q.a p.q.b)
  (fall q.q.a q.q.b)
::
++  lent-stye  |=(a/stub `@`(roll (lnts-stye a) add))   ::< measure
++  lent-char  |=(a/stub `@`(roll (lnts-char a) add))   ::< measure
++  lnts-stye                                           ::< # control chars
  ::> approximate unix byte length of styling escape
  ::> code characters
  ::
  ::REVIEW this seriously looks like it should be
  ::       part of dill %hop handling
  ::
  |=  a/stub  ^-  (list @)
  %+  turn  a
  |=  a/(pair stye (list @c))
  ;:  add                        ::  presumes impl of cvrt:ansi in %dill
      (mul 5 2)                  ::  bg
      (mul 5 2)                  ::  fg
      =+  b=~(wyt in p.p.a)      ::  effect
      ?:(=(0 b) 0 (mul 4 +(b)))
  ==
::
++  lnts-char                                           ::< # regular chars
  ::> measure number of printing characters
  ::>
  ::> a: snippet of colored text
  ::
  |=  a/stub  ^-  (list @)
  %+  turn  a
  |=  a/(pair stye (list @c))
  (lent q.a)
::
++  brek                                              ::<  index and subindex
  ::> determine what section of a {stub} the
  ::> {a}th character lies in, and what index
  ::> inside that section the character is at
  ::>
  ::> a: index being searched for
  ::> b: stub
  ::
  |=  {a/@ b/stub}
  =|  {c/@ i/@}
  |-  ^-  (unit (pair @ @))
  ?~  b  ~
  =.  c  (add c (lent q.i.b))
  ?:  (gte c a)
    `[i c]
  $(i +(i), b t.b)
::
++  slag                                                ::<  slag stub, keep stye
  ::> extract suffix, keeping all styles
  ::>
  ::>  a: number of characters to drop
  ::>  b: colored buffer
  ::
  |=  {a/@ b/stub}
  ^-  stub
  =+  i=(brek a b)
  ?~  i  b
  =+  r=(^slag +(p.u.i) b)
  ?:  =(a q.u.i)
    r
  =+  n=(snag p.u.i b)
  :_  r  :-  p.n
  (^slag (sub (lent q.n) (sub q.u.i a)) q.n)
::
++  scag                                                ::<  scag stub, keep stye
  ::> extract prefix, keeping all styles
  ::>
  ::> a: number of characters to keep
  ::> b: colored buffer
  ::
  |=  {a/@ b/stub}
  ^-  stub
  =+  i=(brek a b)
  ?~  i  b
  ?:  =(a q.u.i)
    (^scag +(p.u.i) b)
  %+  welp
    (^scag p.u.i b)
  =+  n=(snag p.u.i b)
  :_  ~  :-  p.n
  (^scag (sub (lent q.n) (sub q.u.i a)) q.n)
--
