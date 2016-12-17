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
--
::
::::
  ::
~&  >>  %init
(pass (do-task %init ~sipnum (my giv+['pittyp' 'Pittyp'] ~)))
~&  >>  %fungi
?>  =(~ %.(our ~(del by shy:(burb our))))
(pass (do-task %mint ~binzod (my fungi+(my a+1 ~) ~)))
?>  =((my fungi+(my a+1 ~) ~) %.(~binzod ~(get ju shy:(burb our))))
(fail (do-task %burn ~binzod (my fungi+(my a+2 ~) ~)))
(fail (do-task %burn ~binzod (my fungi+(my b+1 ~) ~)))
::
(pass (do-task %move ~binzod ~marzod (my fungi+(my a+1 ~) ~)))
(fail (do-task %move ~binzod ~marzod (my fungi+(my a+1 ~) ~)))
?>  =(~ %.(~binzod ~(get ju shy:(burb our))))
?>  =((my fungi+(my a+1 ~) ~) %.(~marzod ~(get ju shy:(burb our))))
~&  >>  %done
::
::::
  ::
[lex mow=mow err=errs]
