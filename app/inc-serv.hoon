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
++  a-diff
  $%  {$atom @u}
      {$backlog-atoms (list @u)}
  ==
++  move
  $:  bone
  $%  {$diff a-diff}
      {$quit $~}
  ==  ==
--
::
=|  mow/(list move)
|_  {bowl dat/(map session {num/@u log/(list @u)})}
:: ++  prep  _~&(%wiped abet)
++  abet  [(flop mow) .(mow ~)]
++  pull  |=(path ~&(serv+pull+[+<] abet))
++  peer-inc
  |=  a/path  ^+  abet
  ~|  pax=a
  =^  ses  a  ?~(a !! [(decode-id i.a) t.a])
  =/  num  (raid a /[%ud])
  ~&  serv+peer+a
  (peer:(se ses) num)
::
++  poke-noun  |=(a/* ?+(a !! $wipe abet(dat ~)))
++  poke-inc-cmd
  |=  {ses/session cmd/?($bump $drop $make)}  ^+  abet
  ?-  cmd
    $make  ?<((~(has by dat) ses) abet(dat (~(put by dat) ses [0 ~])))
    $bump  bump:(se ses)
    $drop  drop:(se ses)
  ==
::
++  se
  |=  ses/session
  =+  `{num/@ log/(list @u)}`(~(got by dat) ses)
  |%
  ++  this  .
  ++  abet  ^abet(dat (~(put by dat) ses num log))
  ++  emit  |=(a/move this(mow [a mow]))
  ::
  ++  peer
    |=  num/@u  ^+  abet
    =/  new  (slag num (flop log))
    ?~  new  abet
    abet:(emit ost %diff %backlog-atoms new)
  ::
  ++  bump
    =<  abet
    ~&  serv+[%bump ses num=num log=log]
    =.  num  +(num)
    =.  log  [num log]
    ~&  broadcasting+(prey /inc/(encode-id ses) +<-.se)
    %+  roll  (prey /inc/(encode-id ses) +<-.se)
    |:  [[ost=*bone *^] this]
    (emit ost %diff %atom num)
  ::
  ++  drop
    =<  abet
    ~&  serv+[%drop ses num=num log=log]
    ~&  dropping+(prey /inc/(encode-id ses) +<-.se)
    %+  roll  (prey /inc/(encode-id ses) +<-.se)
    |:  [[ost=*bone *^] this]
    (emit ost %quit ~)
  --
--
