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
++  pass  !.  |=(next/_. ~|(errs:next(+.err ~) ?>(=(err err.next) next)))
++  fail  !.  |=(next/_. ?<(=(err err.next) next))
::
++  burb  ~(burb of [now eny] lex)
++  check-fungi
  |=  {src/ship dst/ship}  ^-  (map term @ud)
  =+  %.(%fungi ~(expose up (lawn:(burb src) dst)))
  ?~  -  ~
  ?>(?=($fungi -.u) p.u)
::
++  check-move  !.
  |=  a/mold
  ?~  mow  ~|(%no-move !!)
  =/  b  ~|(bad-move+i.mow ((hard a) q.i.mow))
  +>.$(mow t.mow)
++  check-note  |=(a/mold (check-move {$pass path a}))
++  check-gift  |=(a/mold (check-move {$give a}))
::
++  mo  |*({a/* b/*} (my [a b] ~))
::
++  test-cert
  |=  who/@p  ^-  cert
  =*  sign  sign:as:(nol:nu:crub `@`%test-key)
  =/  new  %*(. *cert dad.doc.dat (sein who))
  =/  lyf  1
  new(syg (mo (sein who) [lyf (sign *@ (sham %urbit who lyf dat.new))]))
--
::
::::
  ::
~&  >>  %init
(pass (do-task %init ~sipnum (mo %giv ['pittyp' 'Pittyp'])))
~&  >>  %subscribe
(pass (do-task %veil our))
(check-note {@ $mess ^})
?>  ?=({{* $give $veil ^} $~} mow)
=/  vel/channel  p.p.q.i.mow
=/  cer/cert  q:(need ~(instant we `will`pub.vel))
?>  =((mo %giv ['pittyp' 'Pittyp']) nym.doc.dat.cer)
..pass(mow ~)
::
(pass (do-task %vest ~))
(check-gift {$vest $& $~ ^})
(pass (do-task %vine ~))
?>  ?=($~ mow)
::
~&  >>  %next
(pass (do-task %next ~zod & (mo %giv ['pittyp' 'Pittyp'])))
~|  [lex mow=mow err=(lent err)]
?>  ?=({{* $give $veil ^} $~} mow)
=/  vel/channel  p.p.q.i.mow
?>  =(2 p:(need ~(instant we `will`pub.vel)))
..pass(mow ~)
::
~&  >>  %fungi
?>  =((check-fungi our ~binzod) ~)
(pass (do-task %mint ~binzod (mo %fungi (mo %a 1))))
(check-gift {$vest $| ^})
?>  =((check-fungi our ~binzod) (mo %a 1))
(fail (do-task %burn ~binzod (mo %fungi (mo %a 2))))
(fail (do-task %burn ~binzod (mo %fungi (mo %b 1))))
::
(pass (do-task %move ~binzod ~marzod (mo %fungi (mo %a 1))))
(check-gift {$vest $| ^})
(check-gift {$vest $| ^})
(fail (do-task %move ~binzod ~marzod (mo %fungi (mo %a 1))))
?>  =((check-fungi our ~binzod) ~)
?>  =((check-fungi our ~marzod) (mo %a 1))
(pass (do-task %mint ~marzod (mo %fungi (mo %a 2))))
(check-gift {$vest $| ^})
?>  =((check-fungi our ~marzod) (mo %a 3))
(pass (do-task %burn ~marzod (mo %fungi (mo %a 3))))
(check-gift {$vest $| ^})
?>  =((check-fungi our ~marzod) ~)
?>  ?=($~ mow)
::
~&  >>  %meet
(pass (do-task %meet ~ `farm`~))
(pass (do-task %meet ~ (mo ~nec `will`~)))
(fail (do-task %meet ~ (mo ~nec (mo 1 *cert))))
(fail (do-task %meet ~ (mo ~nec (mo 2 (test-cert ~nec)))))
(pass (do-task %meet ~ (mo ~nec (mo 1 (test-cert ~nec)))))
?>  ?=($~ mow)
~&  >>  %done
::
::::
  ::
[lex mow=mow err=(lent err)]
