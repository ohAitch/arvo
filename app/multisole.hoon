::  
::
::::  /multisole/app
  ::
/-  *multisole   :: some subset of the first two cores
/+  sole
::
::::  Structures: totally fake rn, intention over detail
  ::
|%
++  an-app  {term}                                      ::  proxy target
++  command  sole-stuff                                 ::  proxied task
++  result  sole-stuff                                  ::  proxied gift
--
::
::::  Interfaces
  ::
|%
++  a-poke                                              ::  ipc cask
  $%  {$command command}                                ::  proxied task
  ==                                                    ::
++  a-diff                                              ::  subscription data
  $%  {$result result}                                  ::  proxied gift
      {$info (set an-app)}                              ::  set of tabs
  ==                                                    ::
++  card                                                ::  system effect
  $%                                                    ::
::       {$conf wire dock $load ship term}                 ::  boot
      {$poke wire dock pear}                            ::  ipc
      {$diff a-diff}                                    ::  subscription data
      {$peer wire dock path}                            ::  connection open
      {$pull wire dock $~}                              ::  connection close
  ==                                                    ::
++  nice-card                                           ::  card subset in use
  $%                                                    ::
::       {$load an-app}  :: auto wire, ship, name          ::  boot
      {$poke app/an-app pok/a-poke}  :: auto wire, ship ::  ipc
      {$diff dif/a-diff}  :: passthrough                ::  subscription data     
      {$peer app/an-app}  :: auto wire, ship, path      ::  connection open     
      {$pull app/an-app}  :: auto wire, ship            ::  connection close     
  ==                                                    ::
++  move  (pair bone card)                              ::  targeted effect
--
::
::::  App proper
  ::
=,  wired:userlib                                       ::  wire decoding
=,  pubsub:userlib                                      ::  subs extraction
=|  mow/(list move)                                     ::  outgoing effects
|_  {connections/(set an-app) bowl}                     ::  state
::
++  peer                                                ::  new subscription
  |=  pax/path
  =<  abet  ^+  this
  ?-  pax
    $~  (emit meta-info)
  ::
    :: TODO store backlog of lines?
    {@ $~}  this
  ::
    *  !!
  ==
::
++  poke-command                                        ::  proxy task
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
++  coup-fail  !!                                       ::  task failed
++  coup-good                                           ::  task success
  ::  can't actually do anything useful with ack
  |=($~ abet:this)
::
:: REVIEW highly questionable non-oneliners
++  poke-join                                           ::  join app
  |=  app/an-app
  =<  abet  ^+  this
  (update (~(put by connections) app))
::
++  poke-leave                                          ::  leave app
  |=  app/an-app
  =<  abet  ^+  this
  (update (~(del by connections) app))
::
++  poke-leave-all                                      ::  leave all apps
  |=  $~
  =<  abet ^+  this
  (update ~)
::
::
++  diff-result                                         ::  proxy gift to all
  |=  {wir/wire res/result}
  =<  abet  ^+  this
  (emits (wire-to-subs-path wir) [%diff %result res])
::
::
++  this  .                                             ::  self reference
++  abet  [(flop mow) .(mow ~)]                         ::  produce moves
++  emil  `$-((list {bone nice-card}) _.)`!!            ::  emit list
++  emit  `$-(nice-card _.)`!!                          ::  record move
++  emits  `$-({path nice-card} _.)`!!                  ::  broadcast move
++  rehydrate-card  :: REVIEW useful abstraction?       ::  fill in boilerplate
  |=  a/nice-card  ^-  card
  ?-  -.a
    $poke  [%poke /[!!] [our app.a] pok.a]              ::  auto wire, ship
    $diff  [%diff dif.a]                                ::  passthrough
    $peer  [%peer /[app.a] [our app.a] /sole]           ::  auto wire, ship, path
    $pull  [%pull /[app.a] [our app.a] ~]               ::  auto wire, ship
  ==
::
++  app-wire  |=(a/an-app /[a]) :: REVIEW inline maybe  ::  encode app in wire
::
::
++  meta-info  [%diff %info connections]                ::  tab list
::
::  conform subscriptions to requested set
++  update                                              ::  new connections
  |=  new/(set an-app)
  =+  [add rem]=(~(difs by new) actual-subscriptions)
  =.  ost  fixed-ost
  :: TODO start apps maybe
  =.  this  (emil (turn ~(tap by add) |=(a/an-app [%peer a])))
  =.  this  (emil (turn ~(tap by rem) |=(a/an-app [%pull a])))
  =.  connections  new
  (emits / meta-info)
::
::  REVIEW too complicated? seems like either the moves should be generated as a
::  function of connections in state, or as a function of subscriptions, but not
::  both.
++  actual-subscriptions                                ::  retrieve state from gall
  ^-  (set an-app)
  %-  silt
  %+  turn  (~(tap by wex))  :: REVIEW check that wex is actually populated
  |=  {{bone wire} {bean ship path}}  ^-  an-app
  :: XX wait is there not like a target app in there?
  !!
::
++  fixed-ost  0                                        ::  arbitrary sentinel
::
::  REVIEW inline maybe
++  wire-to-subs-path  |=(a/wire a)                     ::  path matching wire
++  get-app-for-bone-path                               ::  get app for bone path
  (parse-app current-bone-subscription)
::
++  current-bone-subscription  q:(~(get by wex) ost)    ::  associated subscription
++  parse-app  |=(a/path %.(a (raid /[%tas])))          ::  get app from subs path
--