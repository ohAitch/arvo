::
::::  /hoon/jael/test/lib
  ::
//  /===/sys/vane/jael
::
::::
  ::
((. *vase) ~2016.12.15..23.02.18..f874 `@e`'totally-eny' _~)
::
::::
  ::
!.
|_  {mow/(list move) err/(list tang)}
++  do-task
  |=  a/task:able:^jael.zuse
  =/  try
    (mule |.(~|(task+a (call [/test-jael]~ %noun %soft a))))
  ?.  ?=($& -.try)
    +>.$(err [p.try err])
  =^  mow-new  $.call  p.try
  +>.$(mow (welp mow mow-new))
::
++  errs
  %-  flop  ^-  wall
  %-  zing  ^-  (list wall)
  %+  turn  err
  |=  a/tang
  %-  zing  ^-  (list wall)
  :-  ~[""]
  %+  turn  a
  |=(b/tank (wash 0^160 b))
++  pass  |=(next/_. ?>(=(err err.next) next))
++  fail  |=(next/_. ?<(=(err err.next) next))
::
++  burb  ~(burb of [now eny] lex)
++  check-fungi
  |=  {src/ship dst/ship}  ^-  (map term @ud)
  =+  %.(%fungi ~(expose up (lawn:(burb src) dst)))
  ?~  -  ~
  ?>(?=($fungi -.u) p.u)
--
::
::::
  ::
~&  >>  %init
(pass (do-task %init ~sipnum (my giv+['pittyp' 'Pittyp'] ~)))
~&  >>  %subscribe
(pass (do-task %veil our))
?>  ?=({{* $pass ^} {* $give $veil ^} $~} mow)
=/  vel/channel  p.p.q.i.t.mow
=/  cer/cert  q:(need ~(instant we `will`pub.vel))
?>  =((my giv+['pittyp' 'Pittyp'] ~) nym.doc.dat.cer)
..pass(mow ~)
::
(pass (do-task %vest ~))
:: ?>  ?=({{* $give $vest ^} $~} mow)
:: =/  ves/tally  p.q.i.mow
:: ?>  ?=({$& $~ *} ves)
:: =/  cer/cert  (need ~(current we (~(got by pub.q.p.ves) our))) 
:: ?>  =((my giv+['pittyp' 'Pittyp'] ~) nym.cer)
:: ..pass(mow ~)
::
(pass (do-task %vein ~))
(pass (do-task %vine ~))
~&  >>  %fungi
?>  =((check-fungi our ~binzod) ~)
(pass (do-task %mint ~binzod (my fungi+(my a+1 ~) ~)))
?>  =((check-fungi our ~binzod) (my a+1 ~))
(fail (do-task %burn ~binzod (my fungi+(my a+2 ~) ~)))
(fail (do-task %burn ~binzod (my fungi+(my b+1 ~) ~)))
::
(pass (do-task %move ~binzod ~marzod (my fungi+(my a+1 ~) ~)))
(fail (do-task %move ~binzod ~marzod (my fungi+(my a+1 ~) ~)))
?>  =((check-fungi our ~binzod) ~)
?>  =((check-fungi our ~marzod) (my a+1 ~))
(pass (do-task %mint ~marzod (my fungi+(my a+2 ~) ~)))
?>  =((check-fungi our ~marzod) (my a+3 ~))
(pass (do-task %burn ~marzod (my fungi+(my a+3 ~) ~)))
?>  =((check-fungi our ~marzod) ~)
~&  >>  %done
::
::::
  ::
[lex mow=mow err=(lent err)]
