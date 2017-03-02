::  Styx helpers
::
::::
  ::
=,  ^dill
|%
++  make                                            ::  stub from styx
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
++  styd                                            ::  stye from styl
  |=  {a/styl b/stye}  ^+  b                        ::  with inheritance
  :+  ?~  p.a  p.b
      ?~  u.p.a  ~
      (~(put in p.b) u.p.a)
   (fall p.q.a p.q.b)
   (fall q.q.a q.q.b)
::
++  lent-stye
  |=  a/stub  ^-  @
  (roll (lnts-stye a) add)
::
++  lent-char
  |=  a/stub  ^-  @
  (roll (lnts-char a) add)
::
++  lnts-stye                                       ::  stub pair head lengths
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
++  lnts-char                                       ::  stub pair tail lengths
  |=  a/stub  ^-  (list @)
  %+  turn  a
  |=  a/(pair stye (list @c))
  (lent q.a)
::
++  brek                                            ::  index + incl-len of
  |=  {a/@ b/(list @)}                              ::  stub pair w/ idx a
  =|  {c/@ i/@}
  |-  ^-  (unit (pair @ @))
  ?~  b  ~
  =.  c  (add c i.b)
  ?:  (gte c a)
    `[i c]
  $(i +(i), b t.b)
::
++  slag                                            ::  slag stub, keep stye
  |=  {a/@ b/stub}
  ^-  stub
  =+  c=(lnts-char b)
  =+  i=(brek a c)
  ?~  i  b
  =+  r=(^slag +(p.u.i) b)
  ?:  =(a q.u.i)
    r
  =+  n=(snag p.u.i b)
  :_  r  :-  p.n
  (^slag (sub (snag p.u.i c) (sub q.u.i a)) q.n)
::
++  scag                                            ::  scag stub, keep stye
  |=  {a/@ b/stub}
  ^-  stub
  =+  c=(lnts-char b)
  =+  i=(brek a c)
  ?~  i  b
  ?:  =(a q.u.i)
    (^scag +(p.u.i) b)
  %+  welp
    (^scag p.u.i b)
  =+  n=(snag p.u.i b)
  :_  ~  :-  p.n
  (^scag (sub (snag p.u.i c) (sub q.u.i a)) q.n)
--
