/+  pile-list
::
|%
++  ship  char  :: XX dread hacks: debugability
++  pile  (tree (pair ship ship))
::
++  py  |=(a/(list @) (gas:pi a))
++  pi                                                  ::  sparse ship set
  |_  a/pile
  ::
  ++  uni                                               ::  merge two piles
    |=  b/pile  ^-  pile
    ?~  b  a
    ?~  a  b
    ?.  (vor p.n.a p.n.b)  $(a b, b a)
    ?:  (lth +(q.n.b) p.n.a)
      $(b r.b, l.a $(a l.a, r.b ~))
    ?:  (lth +(q.n.a) p.n.b)
      $(b l.b, r.a $(a r.a, l.b ~))
    ?:  =(n.a n.b)  [n.a $(a l.a, b l.b) $(a r.a, b r.b)]
    ?:  (lth p.n.a p.n.b)
      ?:  (gth q.n.a q.n.b)
        $(b l.b, a $(b r.b))
      $(b l.b, a $(b r.b, a $(b r.a, r.a ~, q.n.a q.n.b)))
    ?:  (gth q.n.a q.n.b)
      $(a l.a, b $(a r.a, b $(a r.b, r.b ~, q.n.b q.n.a)))
    $(a l.a, b $(a r.a))
  ::
  ++  div
    |=  b/@u  ^-  (unit (pair pile pile))
    =<  ?-(- $& [~ p], $| ~)
    |-  ^-  (each (pair pile pile) @u)
    ?~  b  [%& ~ a]
    ?~  a  [%| 0]
    =/  al  $(a l.a)
    ?-    -.al
        $&  [%& p.p.al a(l q.p.al)]
        $|
      =.  b  (sub b p.al)    
      =/  top  +((sub q.n.a p.n.a))
      ?:  =(b top)
        [%& a(r ~) r.a]
      ?:  (lth b top)
        :+  %&  a(r ~, q.n (add p.n.a (dec b)))
        =.  p.n.a  (add p.n.a b)
        (uni(a r.a) [n.a ~ ~])
      =/  ar  $(a r.a, b (sub b top))
      ?-    -.ar
          $&  [%& a(r p.p.ar) q.p.ar]
          $|  [%| :(add top p.al p.ar)]
      ==
    ==
  ::  
  ++  dif
    |=  b/pile  ^-  pile
    ?~  b  a
    ?~  a  a
    ?:  (gth p.n.a q.n.b)
      $(b r.b, l.a $(a l.a, r.b ~))
    ?:  (lth q.n.a p.n.b)
      $(b l.b, r.a $(a r.a, l.b ~))
    %-  uni(a $(a l.a, r.b ~))
    %-  uni(a $(a r.a, l.b ~))
    ?:  (gte p.n.a p.n.b)
      ?:  (lte q.n.a q.n.b)
        ~
      $(b r.b, a [[+(q.n.b) q.n.a] ~ ~])
    ?:  (lte q.n.a q.n.b)
      $(b l.b, a [[n.a(q (min q.n.a (dec p.n.b)))] ~ ~])
    %-  uni(a $(b r.b, a [[+(q.n.b) q.n.a] ~ ~]))
    $(b l.b, a [[n.a(q (min q.n.a (dec p.n.b)))] ~ ~])
  ::
  ++  int                                               ::  intersection
    |=  b/pile  ^-  pile
    ?~  a  ~
    ?~  b  ~
    ?.  (vor p.n.a p.n.b)  $(a b, b a)
    ?:  (gth p.n.a q.n.b)  
      (uni(a $(b r.b)) $(a l.a, r.b ~))
    ?:  (lth q.n.a p.n.b)  
      (uni(a $(b l.b)) $(a r.a, l.b ~))
    ?:  (gte p.n.a p.n.b)
      ?:  (lte q.n.a q.n.b)
        [n.a $(a l.a, r.b ~) $(a r.a, l.b ~)]
      [n.a(q q.n.b) $(a l.a, r.b ~) $(l.a ~, b r.b)]
    %-  uni(a $(r.a ~, b l.b))
    ?:  (lte q.n.a q.n.b)
      %-  uni(a $(l.b ~, a r.a))
      [n.b(q q.n.a) ~ ~]
    %-  uni(a $(l.a ~, b r.b))
    [n.b ~ ~]
  ::
  ::
  ++  put
    |=  b/ship  ^-  pile
    (uni [b b] ~ ~)
  ::
  ++  gas
    |=  b/(list ship)  ^-  pile
    ?~  b  a
    $(b t.b, a (put i.b))
  ::
  ++  tap
    =|  out/(list (pair ship ship))
    |-  ^+  out
    ?~  a  out
    $(a l.a, out [n.a $(a r.a)])
  ::
  ::
  ++  top  ?~(a ~ (some (fall top(a r.a) q.n.a)))
  ++  bot  ?~(a ~ (some (fall bot(a l.a) p.n.a)))
  ++  gud  ::  XX repeated min/max fetching
    ?~  a  &
    ?.  (lte p.n.a q.n.a)  |
    ?&  =+(top(a l.a) ?~(- & (lth +(u) p.n.a)))
        ?~(l.a & (vor p.n.a p.n.l.a))
        gud(a l.a)
    ::
        =+(bot(a r.a) ?~(- & (gth u +(q.n.a))))
        ?~(l.a & (vor p.n.a p.n.l.a))
        gud(a r.a)
    ==
  --
--
::
{pile}
