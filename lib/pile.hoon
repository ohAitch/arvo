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
++  pile  (list (pair ship ship))
::
++  py                                                  ::  sparse ship set
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
    !!
  ::  
  ++  dif
    |=  b/pile  ^-  (pair pile pile)
    !!
  ::
  ::
  ++  has
    |=  b/ship  ^-  ?
    !!
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
