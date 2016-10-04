|%
++  ship  char  :: XX dread hacks: debugability
++  pile  (list (pair ship ship))
::
++  py  |=(a/(list @) (gas:pi a))
++  pi                                                  ::  sparse ship set
  |_  a/pile
  ++  uni                                               ::  merge two piles
    |=  b/pile  ^-  pile
    ?~  b  a
    ?~  a  b
    ?:  (lth +(q.i.b) p.i.a)  [i.b $(b t.b)]
    ?:  (lth +(q.i.a) p.i.b)  [i.a $(a t.a)]
    =.  p.i.a  (min p.i.a p.i.b)
    ?:  (gth q.i.b q.i.a)
      =.  q.i.a  q.i.b
      $(t.a t.b, b t.a)
    $(b t.b)
  ::
  ++  div
    |=  b/@u  ^-  (unit {pile pile})
    ?~  b  (some [~ a])
    ?~  a  ~
    =/  top  +((sub q.i.a p.i.a))
    ?:  =(b top)
      `[[i.a]~ t.a]
    ?:  (lth b top)
      :+  ~  [p.i.a (add p.i.a (dec b))]~
      a(p.i (add p.i.a b))
    %+  bind  $(a t.a, b (sub b top))
    |=({c/pile d/pile} [[i.a c] d])
  ::  
  ++  dif
::     =;  dif1  |=(b/pile `(pair pile pile)`[(dif1(a b) a) (dif1 b)])
    |=  b/pile  ^-  pile
    ?~  a  a
    ?~  b  a
    ?:  (lth q.i.b p.i.a)  $(b t.b)
    ?:  (lth q.i.a p.i.b)  [i.a $(a t.a)]
    %+  welp
      ?.  (lth p.i.a p.i.b)  ~
      [p.i.a (dec p.i.b)]~
    ?:  (gth +(q.i.b) q.i.a)
      $(a t.a)
    $(b t.b, p.i.a +(q.i.b))
  ::
  ++  int                                               ::  intersection
    |=  b/pile  ^-  pile
    ?~  a  ~
    ?~  b  ~
    ?:  (lth q.i.b p.i.a)  $(b t.b)
    ?:  (lth q.i.a p.i.b)  $(a t.a)
    =/  c  [p=(max p.i.a p.i.b) q=(min q.i.a q.i.b)]
    :-  c
    %_  $
      a  ?.((lth q.c q.i.a) t.a a(p.i q.c))
      b  ?.((lth q.c q.i.b) t.b b(p.i q.c))
    ==
  ::
  ::
  ++  put
    |=  b/ship  ^-  pile
    (uni [b b] ~)
  ::
  ++  gas
    |=  b/(list ship)  ^-  pile
    ?~  b  a
    $(b t.b, a (put i.b))
  ::
  ::
  ++  gud
    ?~  a  &
    ?.  (lte p.i.a q.i.a)  |
    ?~  t.a  &
    &((lth +(q.i.a) p.i.t.a) gud(a t.a))
  --
--
::
{pile}
