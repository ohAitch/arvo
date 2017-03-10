::  
::
::::  /multisole/app
  ::
/+  sole
::
::::  Structures
  ::
|%
++  an-app  {term}
++  command  sole-stuff
++  result  sole-stuff
++  meta
  $%  {$join an-app}
      {$part an-app}
      {$clear $~}
  ==
--
::
::::  Interfaces
  ::
|%
++  a-poke
  $%  {$command command}
  ==
++  a-diff
  $%  {$result result}
      {$info (set an-app)}
  ==
++  card
  $%
::       {$conf wire dock $load ship term}
      {$poke wire dock pear}
      {$diff a-diff}
      {$peer wire dock path}
      {$pull wire dock $~}
  ==
++  nice-card
  $%
::       {$load an-app}
      {$poke app/an-app pok/a-poke}
      {$diff dif/a-diff}
      {$peer app/an-app}
      {$pull app/an-app}
  ==
++  move  (pair bone card)
--
::
::::  App proper
  ::
=|  mow/(list move)
|_  {connections/(set an-app) bowl}
++  peer
  |=  pax/path
  =<  abet  ^+  this
  ?-  pax
    $~  send-meta-info
    {@ $~}  this
    *  !!
  ==
::
++  poke-command
  |=  com/command
  =<  abet  ^+  this
  =/  app  get-app-for-bone-path
  =.  ost
    :: TODO not changing `ost` breaks subscription-command duct parity,
    :: changing `ost` breaks ack handling, a queue could be inserted but this
    :: has problems we've seen in eyre vi-pump-blocked, it's really the
    :: responsibility of gall and/or the sole 1-1 peer/poke mapping pattern.
    ::
    :: XX also this is all moot without working ack defferal
    ost
  (emit %poke / app %command com)
::
++  coup-fail  !!
++  coup-good  |=($~ abet:this)  ::  can't actually do anything useful with ack
::
++  poke-join   :: REVIEW highly questionable non-oneliners
  |=  app/an-app
  =<  abet  ^+  +>
  (update (~(put by connections) app))
::
++  poke-part
  |=  app/an-app
  =<  abet  ^+  +>
  (update (~(del by connections) app))
::
++  poke-clear
  |=  $~
  =<  abet ^+  +>
  (update ~)
::
::
++  diff-result
  |=  res/result
  =<  abet  ^+  this
  (emit %diff %result res)
::
::
++  this  .
++  abet  [(flop mow) .(mow ~)]
++  emil  `$-((list nice-card) _.)`!!
++  emit  `$-(nice-card _.)`!!
++  rehydrate-card  :: REVIEW useful abstraction?
  |=  a/nice-card  ^-  card
  ?-  -.a
    $poke  [%poke /[!!] [our app.a] pok.a]
    $diff  [%diff dif.a]
    $peer  [%peer /[app.a] [our app.a] /sole]
    $pull  [%pull /[app.a] [our app.a] ~]
  ==
::
++  app-wire  |=(a/an-app /[a]) :: REVIEW inline maybe
::
::
++  send-meta-info  (emit %diff %info connections)
::
::  conform subscriptions to requested set
++  update
  |=  new/(set an-app)
  =+  [add rem]=(~(difs by new) actual-subscriptions)
  =.  ost  fixed-ost
  :: TODO start apps maybe
  =.  +>  (emil (turn ~(tap by add) |=(a/an-app [%peer a])))
  =.  +>  (emil (turn ~(tap by rem) |=(a/an-app [%pull a])))
  +>(connections new)
::
++  actual-subscriptions
  ^-  (set an-app)
  %-  silt
  %+  turn  (~(tap by wex))  :: REVIEW check that wex is actually populated
  |=  {{bone wire} {bean ship path}}  ^-  an-app
  :: XX wait is there not like a target app in there?
  !!
::
++  fixed-ost  0 :: arbitrary sentinel
++  app-wire  |=(a/an-app /[a])
::
++  get-app-for-bone-path  (parse-app current-bone-subscription)
++  current-bone-subscription  q:(~(get by wex) ost)
++  parse-app  |=(a/path %.(a (raid /[%tas])))
--