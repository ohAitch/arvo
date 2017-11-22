::
::::  /hoon/json/tree/ren
  ::
/?    310
/-    tree-include
/+    tree
/=    gas    /$    fuel:html
/=    dat    /^    tree-include    /tree-include/
/=    kid    /^    (map knot tree-include)
             /_    /tree-include/
=,  eyre
=,  format
=,  mimes:html
::
::::
  ::
|%
++  schema  (dict {term $@(mark schema)})
++  dict    |*(a/_* $^({a (dict a)} a))
++  plist   (list {term $@(mark plist)})
++  query
  $?  {$kids p/(list query)}
      $name
      $path
      $spur
  ::
      $bump
      $beak
      $comt
      $plan
      $head
      $sect
      $snip
      $body
      $meta
      $mime
  ==
::
++  read-quay
  |=  {a/@t b/@t}
  ?.  ((sane %tas) a)  ~
  %-  some
  ?~  b  a
  [a (rash b (more ace sym))]
::
++  schema-to-plist                   :: pad improper list
  |=  a/schema  ^-  plist
  ?@(-.a [(to-item a) ~] [(to-item -.a) $(a +.a)])
::
++  to-item
  |=  b/{term $@(mark schema)}  ^-  {term $@(mark plist)}
  ?@(+.b b [-.b (schema-to-plist +.b)])
::
++  from-type                         ::  XX holding out for noun odors
  |=  a/$%({$t p/cord} {$r p/json} {$j p/json} {$m mime})
  ?-  -.a
    $t  [%s p.a]
    $m  (pairs:enjs mite+[%s (en-mite p.a)] octs+(tape:enjs (en-base64 q.q.a)) ~)
    $r  p.a
    $j  p.a
  ==
++  from-queries
  |=  {bem/beam quy/(list query)}
  =<  (pairs:enjs (turn quy .))
  |=  a/query
  :-  ?@(a a -.a)
  ?-  a
    $name  (from-type %t ?^(s.bem i.s.bem q.bem))
    $beak  (from-type %t (crip (spud (en-beam bem(s /)))))
    $path  (from-type %t (crip (spud (flop s.bem))))
    $spur  (from-type %t (crip (spud s.bem)))
    $bump  (from-type %t bump.dat)
    $plan  (from-type %j plan.dat)
    $comt  (from-type %j comt.dat)
    $head  (from-type %r head.dat)
    $snip  (from-type %r snip.dat)
    $sect  (from-type %j sect.dat)
    $meta  (from-type %j meta.dat)
    $mime  (from-type %m mime.dat)
    $body  (from-type %r body.dat)
    {$kids *}
      ?<  (lien p.a |=(query ?=({$kids *} +<)))  ::  XX recursion?
      =<  o+(~(urn by kid) .)
      |=  {dir/knot dak/tree-include}  ^-  json
      ^^$(quy p.a, s.bem [dir s.bem], dat dak, kid ~)
  ==
--
::
::::
  ::
=,  tree
^-  json
%+  from-queries  bem.gas
=+  default=;;(quay ~[/spur /body /comt /plan /beak /meta kids+'meta head bump'])
=/  seh/,|-((list $@(term {term $})))
  ~|(bad-quay+qix.gas (murn ~(tap by qix.gas) read-quay))
=.  seh  ?^(seh seh (murn default read-quay))
~|(bad-noun+seh ;;((list query) seh))
