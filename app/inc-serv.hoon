::  server
|%
++  session  {@u dock}
--
:: XX stolen from old zuse
|%
++  pack                                                ::  light path encoding
  |=  {a/term b/path}  ^-  knot
  %+  rap  3  :-  (wack a)
  (turn b |=(c/knot (cat 3 '_' (wack c))))
::
++  pick                                                ::  light path decoding
  =+  fel=(most cab (sear wick urt:ab))
  |=(a/knot `(unit {p/term q/path})`(rush a fel))
--
::
=,  ^gall
=,  wired ::userlib
=,  pubsub:userlib
|%
++  encode-id  |=(a/session `@t`(pack (dray /[%ud]/[%p]/[%tas] a)))
++  decode-id  |=(a/@t `session`(raid (need (pick a)) /[%ud]/[%p]/[%tas]))
--
::
|%
++  move
  $:  bone
  $%  {$diff $atom @u}
  ==  ==
--
::
=|  mow/(list move)
|_  {bowl dat/(map session {num/@u log/(list @u)})}
++  prep  _~&(%wiped abet)
++  abet  [(flop mow) .(mow ~)]
++  peer
  |=  a/path  ^+  abet
  =^  ses  a  ?~(a !! [(decode-id i.a) t.a])
  =/  num  (raid a /[%ud])
  ~&  serv+peer+a
  peer:(se ses)
++  poke-noun
  |=  {ses/session *}  ^+  abet
  poke:(se ses)
::
++  se
  |=  ses/session
  =+  `{num/@ log/(list @u)}`(fall (~(get by dat) ses) [0 ~])
  |%
  ++  this  .
  ++  abet  ^abet(dat (~(put by dat) ses num log))
  ++  emit  |=(a/move this(mow [a mow]))
  ::
  ++  peer  abet:update
  ++  update  (emit(log [num log]) ost %diff %atom num)
  ++  poke
    =<  abet
    ~&  serv+[%poke ses num=num log=log]
    =.  num  +(num)
    %+  roll  (prey /(encode-id ses) +<-.se)
    |:  [[ost=*bone *^] this]
    update(ost ost)
  --
--



::   log/(list $bump)
:: ++  peer-bumps
::   |=  a/path
::   =^  id  a  ?~(a !! [(parse-id -.a) +.a])
::   =^  num  a  ?~(a [0 a] [(slav %ud i.a) t.a])
::   (give %log (slag num (flop log)))  :: log := multiple events
:: ++  bump
::   |=  a/$bump
::   =.  log  [a log]
::   (give %bump)


