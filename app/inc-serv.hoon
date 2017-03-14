::  server
|%
++  session  {@u dock}
--
::
=,  ^gall
=,  wired ::userlib
=,  pubsub:userlib
|%
++  move
  $:  bone
  $%  {$diff $atom @u}
  ==  ==
--
::
=|  mow/(list move)
|_  {bowl dat/(map session @u)}
++  prep  _~&(%wiped abet)
++  abet  [(flop mow) .(mow ~)]
++  peer
  |=  a/path  ^+  abet
  =/  ses  (raid a /[%ud]/[%p]/[%tas])
  peer:(se ses)
++  poke-noun
  |=  {ses/session *}  ^+  abet
  poke:(se ses)
::
++  se
  |=  ses/session
  =/  num  (fall (~(get by dat) ses) 0)
  |%
  ++  this  .
  ++  abet  ^abet(dat (~(put by dat) ses num))
  ++  emit  |=(a/move this(mow [a mow]))
  ::
  ++  peer  abet:update
  ++  update  (emit ost %diff %atom num)
  ++  poke
    =<  abet
    ~&  [%poke ost ses num=num]
    =.  num  +(num)
    %+  roll  (prey (dray /[%ud]/[%p]/[%tas] ses) +<-.se)
    |:  [[ost=*bone *^] this]
    update(ost ost)
  --
--