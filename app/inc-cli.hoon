::  client
|%
++  session  {@u dock}
--
::
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
=,  wired
|%
++  encode-id  |=(a/session `@t`(pack (dray /[%ud]/[%p]/[%tas] a)))
++  decode-id  |=(a/@t `session`(raid (need (pick a)) /[%ud]/[%p]/[%tas]))
--
::
=,  ^gall
|%
++  move
  $:  bone
  $%  {$peer wire dock path}
      {$poke wire dock {$noun {@u dock} *}}
  ==  ==
--
::
=|  mow/(list move)
|_  {bowl saw/(map session @u)}
++  this  .
++  abet  [(flop mow) .(mow ~)]
++  emit  |=(a/move this(mow [a mow]))
::
++  poke-noun
  |=  a/*
  ?+  a  abet
    $read-1  poke-read-1
    $read-2  poke-read-2
::     $pull-1  poke-pull-1
::     $pull-2  poke-pull-2
    $write-1  poke-write-1
    $write-2  poke-write-2
  ==
++  sesh  |=(a/@u [a our dap])
++  as-peer  |=(ses/{@u dock} /(encode-id ses))
++  poke-read-1  (read 1)
++  poke-read-2  (read 2)
++  read
  |=  sid/@u  ^+  abet
  =/  ses  (sesh sid)
  =/  num  (fall (~(get by saw) ses) 0)
  =.  saw  (~(put by saw) ses num)
  =/  pax  /(encode-id ses)/(scot %ud num)
  =<  abet
  (emit 0 %peer pax [our %inc-serv] pax)
::
++  poke-write-1  abet:(emit 0 %poke / [our %inc-serv] %noun (sesh 1) %bump)
++  poke-write-2  abet:(emit 0 %poke / [our %inc-serv] %noun (sesh 2) %bump)
++  diff-atom
  |=  {wir/wire @u}
  =^  ses  wir  [(decode-id -.wir) +.wir]
  ~&  clin+[%diff ses +<.$ hav=(~(get by saw) ses)]
  =.  saw
    %+  ~(put by saw)  ses
    ?.  (~(has by saw) ses)  ~&(%hav-not 1)
    +((~(got by saw) ses))
  abet
++  prep
  $_
  :_  .
  %+  turn  (~(tap by wex))
  |=  {{ost/bone wir/wire} ? him/ship pax/path}
  :: XX does wex really not have target app?
  [ost %pull wir [him %inc-serv] pax]
--


:: {state/@u synced-to/@u}
:: ++  server  [our %inc-serv]
:: ++  poke-connect
::   (peer server /bumps/(encode-id [1 our dap])/)
