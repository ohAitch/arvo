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
++  ses-data
  $:  sus/(unit @u)                   :: seqn of current outbound subscription
      rec/@u                          :: counter of recieved bumps
  ==
--
::
=|  mow/(list move)
|_  {bowl dat/(map session ses-data)}
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
++  diff-backlog-atoms-inc
  |=  {wir/wire dif/(list @u)}
  =^  ses  wir  [(decode-id -.wir) +.wir]
  (diff-backlog-atoms:(se ses) wir dif)
::
++  diff-atom-inc
  |=  {wir/wire dif/@u}
  =^  ses  wir  [(decode-id -.wir) +.wir]
  (diff-atom:(se ses) wir dif)
::
++  our-se  |=(a/@ud (se a [our dap]))
++  se
  |=  ses/session
  ?>  =(+.ses [our dap])  ::  necessary?
  =+  `ses-data`(fall (~(get by dat) ses) *ses-data)
  |%
  ++  this  .
  ++  abet  ^abet(dat (~(put by dat) ses +<.this))
  ++  emit  |=(a/move this(mow [a mow]))
  ::
  ++  server  [our %inc-serv]
  ++  ses-t  (encode-id ses)
  ::
  ++  do-peer
    =~  ?~  sus  this
        (emit 0 %pull /inc/[ses-t]/(scot %ud u.sus) server ~)
    ::
        =/  pax  /inc/[ses-t]/(scot %ud rec)
        =.  sus  `rec
        (emit 0 %peer pax server pax)
    ::
        abet
    ==
  ::
  ++  do-pull
    =<  abet
    ?~  sus  ~&(%no-pull this)
    (emit 0 %pull /[ses-t]/(scot %ud u.sus) server ~)
  ::
  ++  do-bump  abet:(emit 0 %poke / server %inc-cmd ses %bump)
  ++  diff-backlog-atoms
    |=  {wir/wire log/(list @u)}
    ~|  bad-subscription+[sus wir]
    ?>  =(wir /(scot %ud (need sus)))
    =.  rec  (add rec (lent log))
    ~&  clin+[%diff-log ses +<.$ rec=rec]
    abet
  ::
  ++  diff-atom
    |=  {wir/wire @u}
    ~|  bad-subscription+[sus wir]
    ?>  =(wir /(scot %ud (need sus)))
    =.  rec  +(rec)
    ~&  clin+[%diff ses +<.$ rec=rec]
    abet
  --
:: ++  prep  _abet
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
