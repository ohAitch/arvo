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
|_  {mow/(list move) err/tang}
++  do-task
  |=  a/task:able:^jael.zuse
  =/  may-call  
    (mule |.(~|(task+a (call [/test-jael]~ %noun %soft a))))
  ?.  ?=($& -.may-call)
    +>.$(err (welp p.may-call leaf+"" err))
  =^  mow-new  $.call  p.may-call
  +>.$(mow (welp mow mow-new))
::
++  errs
  %-  flop  ^-  wall
  %-  zing  ^-  (list wall)
  %+  turn  err
  |=(a/tank (wash 0^160 a))
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
[lex mow=mow err=(lent errs)]
