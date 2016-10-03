:: |%
:: ++  pile  (tree (pair ship ship))
::   |_  pyl/pile
::   ::
::   ++  uni                                               ::  merge two piles
::     |=  lyp/pile
::     ^-  pile
::     !!
::   ::
::   ++  div
::     |=  a/@u  ^-  (unit {pile pile})
::     !!
::   ::  
::   ++  dif
::     |=  pile
::     ^-  (pair pile pile)
::     !!
::   ::
::   ::
::   ++  has
::     |=  ship  ^-  ?
::     !!
::   ::  
::   ++  put
::     |=  a/ship  ^-  pile
::     ?~  pyl  [a a]~    
::   ::
::   ++  del
::     |=  a/ship  ^-  pile
::     ?~  pyl  ~
::   ::
::   ++  gas
::     |=  a/(list ship)
::     ?~  a  pyl
::     $(a t.a, pyl (put i.a))
::   ::
::   ::
::   ++  min
::     ?~  pyl  ~
::     (some p.i.pyl)
::   ::
::   ++  max
::     ?~  pyl  ~
::     %-  some
::     |-  ^-  ship
::     ?~  t.pyl  q.i.pyl
::     $(pyl t.pyl)
::   ::
::   ++  gud
::     ?~  a  &    
::   --

::
|%
++  ship  char  :: XX dread hacks: debugability
++  pile  (list (pair ship ship))
::
++  py  |=(a/(list @) (gas:pi a))
++  pi                                                  ::  sparse ship set
  |_  a/pile
  ::
  ++  uni                                               ::  merge two piles
    |=  b/pile  ^-  pile
    ?~  b  a
    ?~  a  b
    ?:  (lth +(q.i.b) p.i.a)  [i.b $(b t.b)]
    ?:  (lth +(q.i.a) p.i.b)  [i.a $(a t.a)]
    =.  i.a  [(min p.i.a p.i.b) (max q.i.a q.i.b)]
    [i.a $(a t.a, b t.b)]
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
    ?:  (lth +(q.i.b) p.i.a)  $(b t.b)
    ?:  (lth +(q.i.a) p.i.b)  [i.a $(a t.a)]
    %+  welp
      ?.  (lth p.i.a p.i.b)  ~
      [p.i.a (dec p.i.b)]~
    ~&  [i.a i.b (gth +(q.i.b) q.i.a)]
    ?:  (gth +(q.i.b) q.i.a)
      $(a t.a)
    $(b t.b, p.i.a +(q.i.b))
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
