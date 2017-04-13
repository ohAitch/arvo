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
      {$pull wire dock $~}
      {$poke wire dock {$inc-cmd session ?($bump $drop)}}
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
  ?+  a  ~&(clin+%unknown-command abet)
    $read-1  do-peer:(our-se 1)
    $read-2  do-peer:(our-se 2)
    $pull-1  do-pull:(our-se 1)
    $pull-2  do-pull:(our-se 2)
    $write-1  do-bump:(our-se 1)
    $write-2  do-bump:(our-se 2)
  ==
::
++  diff-backlog-atoms
  |=  {wir/wire log/(list @u)}
  =^  ses  wir  [(decode-id -.wir) +.wir]
  (diff-backlog-atoms:(se ses) wir log)
::
++  diff-atom
  |=  {wir/wire res/@u}
  =^  ses  wir  [(decode-id -.wir) +.wir]
  (diff-atom:(se ses) wir res)
::
++  our-se  |=(a/@ud (se a [our dap]))
++  se
  |=  ses/session
  ?>  =(+.ses [our dap])  ::  necessary?
  =/  num  (fall (~(get by saw) ses) 0)
  |%
  ++  this  .
  ++  abet  ^abet(saw (~(put by saw) ses num))
  ++  emit  |=(a/move this(mow [a mow]))
  ::
  ++  server  [our %inc-serv]
  ::
  ++  do-peer
    =/  pax  /(encode-id ses)/(scot %ud num)
    abet:(emit 0 %peer pax server pax)
  ::
  ++  do-pull
    =/  pax  /(encode-id ses)/(scot %ud num)
    abet:(emit 0 %pull pax server ~)
  ::
  ++  do-bump  abet:(emit 0 %poke / server %inc-cmd ses %bump)
  ++  diff-backlog-atoms
    |=  {wir/wire log/(list @u)}
    ~&  clin+[%diff ses +<.$ hav=num]
    =.  num  (add num (lent log))
    abet
  ::
  ++  diff-atom
    |=  {wir/wire @u}
    ~&  clin+[%diff ses +<.$ hav=(~(get by saw) ses)]
    =.  num  +(num)
    abet
  --
:: ++  prep
::   $_
::   :_  .
::   %+  turn  (~(tap by wex))
::   |=  {{ost/bone wir/wire} ? him/ship pax/path}
::   :: XX does wex really not have target app?
::   [ost %pull wir [him %inc-serv] pax]
--


:: {state/@u synced-to/@u}
:: ++  server  [our %inc-serv]
:: ++  poke-connect
::   (peer server /bumps/(encode-id [1 our dap])/)
