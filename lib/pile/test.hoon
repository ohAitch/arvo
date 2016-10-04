/+    pile, pile-list
|%
++  cmd
  $%  {$~ p/tape}
      {$dif p/cmd q/cmd}
      {$int p/cmd q/cmd}
      {$uni p/cmd q/cmd}
  ==
++  test
  |=  {a/@uvI b/@u}
  %+  bind  (shrink (generate a b) do-match)
  results
::
++  results
  |=  a/cmd
  :+  a
    (do-list a)
  ~(tap pi:pile (do-tree a))
::
++  do-match
  |=  a/cmd  ^-  ?
  .=  (do-list a)
  ~(tap pi:pile (do-tree a))
::
++  shrink
  =|  dep/@
  |=  {a/cmd b/$-(cmd ?)}  ^-  (unit cmd)
  ?:  (b a)  ~
  ~&  [`@t`(fil 3 dep ' ') a]
  ?-    -.a
      $~
    ?:  (gth 2 (lent p.a))  `a
    =/  haf  (div (lent p.a) 2)
    =+  $(p.a (scag haf p.a))
    ?^  -  -
    =+  $(p.a (slag haf p.a))
    ?^  -  -
    `a
  ::
      ?($dif $int $uni)
    =.  dep  +(dep)
    =+  $(a p.a)
    ?^  -  -
    =+  $(a q.a)
    ?^  -  -
    =+  ?.  (do-match a)  ~
        $(a [~ ~(tap pi:pile-list (do-list a))])
    ?^  -  -
    =.  p.a  
      =-  (fall - p.a)
      $(a p.a, b |=(pa/cmd (b a(p pa))))
    =.  q.a
      =-  (fall - q.a)
      $(a q.a, b |=(qa/cmd (b a(q qa))))
    `a
  ==
::
++  generate
  |=  {eny/@uvI dyv/@u}  ^-  cmd
  ?~  dyv
    [~ (gen-tape (shas %test eny))]
  =.  dyv  (div dyv +((~(rad og eny) 5)))
  ?+  (end 0 2 eny)  !!
    $0        [%dif $(eny (shas %genr eny)) $(eny (shas %genl eny))]
    $1        [%int $(eny (shas %genr eny)) $(eny (shas %genl eny))]
    ?($2 $3)  [%uni $(eny (shas %genr eny)) $(eny (shas %genl eny))]
  ==
::
++  gen-tape
  =/  all  (gulf 'a' 'z')
  =/  off  &
  |=  b/@uvI  ^-  tape
  ?~  all  ~
  =.  off  ?~((end 0 2 b) !off off)
  ?:  off
    $(all t.all, b (rsh 3 1 b))
  [i.all $(all t.all, b (rsh 3 1 b))]
::
++  do-list
  =*  pi  pi:pile-list
  |=  a/cmd  ~+
  ?-  -.a
    $~  (gas:pi p.a)
    $dif  (~(dif pi $(a p.a)) $(a q.a))
    $int  (~(int pi $(a p.a)) $(a q.a))
    $uni  (~(uni pi $(a p.a)) $(a q.a))
  ==
::
++  do-tree
  =*  pi  pi:pile
  |=  a/cmd  ~+
  ?-  -.a
    $~  (gas:pi p.a)
    $dif  (~(dif pi $(a p.a)) $(a q.a))
    $int  (~(int pi $(a p.a)) $(a q.a))
    $uni  (~(uni pi $(a p.a)) $(a q.a))
  ==
--
::
test
