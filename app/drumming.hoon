::                                                      ::  ::
::::  /hoon/drum/lib                                    ::  ::
  ::                                                    ::  ::
/?    310                                               ::  version
/-    sole
/+    sole, talk, styxes
[. ^sole]
::                                                      ::  ::
::::                                                    ::  ::  Schema
  ::                                                    ::  ::
|%                                                      ::  ::
++  drum-part      {$drum $2 drum-pith-2}               ::  current drum state
:: ++  drum-part-old  {$drum $1 drum-pith-1}               ::  old drum state
:: ::                                                      ::
:: ++  drum-pith-1                                         ::  pre-style
::   %+  cork  drum-pith-2                                 ::
::   |=(drum-pith-2 +<(bin *(map bone source-1)))          ::
:: ::                                                      ::
:: ++  source-1                                            ::
::   %+  cork  source                                      ::
::   |=(source +<(mir *(pair @ud (list @c))))              ::  style-less mir
:: ::                                                      ::
++  drum-pith-2                                         ::
  $:  sys/(unit bone)                                   ::  local console
      eel/(set gill:^gall)                              ::  connect to
      ray/(set well:^gall)                              ::
      fur/(map dude:^gall (unit server))                ::  servers
      bin/(map bone source)                             ::  terminals
  ==                                                    ::
::                                                      ::  ::
::::                                                    ::  ::  State
  ::                                                    ::  ::
++  server                                              ::  running server
  $:  syd/desk                                          ::  app identity
      cas/case                                          ::  boot case
  ==                                                    ::
++  kill                                                ::  kill ring
  $:  pos/@ud                                           ::  ring position
      num/@ud                                           ::  number of entries
      max/_60                                           ::  max entries
      old/(list (list @c))                              ::  entries proper
  ==                                                    ::
++  source                                              ::  input device
  $:  edg/_80                                           ::  terminal columns
::       off/@ud                                           ::  window offset
::       kil/kill                                          ::  kill buffer
      inx/@ud                                           ::  ring index
      fug/(map gill:^gall (unit target))                ::  connections
::       mir/(pair @ud stub:^dill)                         ::  mirrored terminal
  ==                                                    ::
++  history                                             ::  past input
  $:  pos/@ud                                           ::  input position
      num/@ud                                           ::  number of entries
      lay/(map @ud (list @c))                           ::  editing overlay
      old/(list (list @c))                              ::  entries proper
  ==                                                    ::
++  search                                              ::  reverse-i-search
  $:  pos/@ud                                           ::  search position
      str/(list @c)                                     ::  search string
  ==                                                    ::
++  target                                              ::  application target
  $:
::       $=  blt                                           ::  curr & prev belts
::         %+  pair
::           (unit dill-belt:^dill)
::         (unit dill-belt:^dill)
::       ris/(unit search)                                 ::  reverse-i-search
::       hit/history                                       ::  all past input
      pom/sole-prompt                                   ::  static prompt
      inp/sole-command                                  ::  input state
  ==                                                    ::
--
::                                                      ::  ::
::::                                                    ::  ::
  ::                                                    ::  ::
|%
++  default-servers                                     ::
  |=  our/ship
  %-  ~(gas in *(set well:^gall))
  ^-  (list well:^gall)
  =+  myr=(clan:title our)
  ?:  ?=($pawn myr)
    [[%base %talk] [%base %dojo] ~]
  ?:  ?=($earl myr)
    [[%home %dojo] ~]
  [[%home %talk] [%home %dojo] ~]
::
++  default-connects                                    ::  default connects
  |=  our/ship
  %-  ~(gas in *(set gill:^gall))
  ^-  (list gill:^gall)
  ?:  ?=($earl (clan:title our))
    [[(sein:title our) %talk] [our %dojo] ~]
  [[our %talk] [our %dojo] ~]
::
++  drum-make                                           ::  initial part
  |=  our/ship
  ^-  drum-part
  :*  %drum
      %2
      ~                                                 ::  sys
      (default-connects our)                            ::  eel
      (default-servers our)                             ::  ray
      ~                                                 ::  fur
      ~                                                 ::  bin
  ==                                                    ::
::
++  drum-path                                           ::  encode path
  |=  gyl/gill:^gall
  ^-  wire
  [%drum %phat (scot %p p.gyl) q.gyl ~]
::
++  decode-wire                                           ::  decode path
  |=  way/wire  ^-  gill:^gall
  ?>(?=({@ @ $~} way) [(slav %p i.way) i.t.way])
--
::
::::
  ::
=<  |_  {hid/bowl:^gall drum-part}                          ::  main drum work
    ++  diff-sole-effect-drum-phat  (. diff-sole-effect-phat):wrap  ::  app event
    ++  peer-sole                   (. peer-sole):wrap         ::
    ++  poke-dill-belt         (. poke-dill-belt):wrap         ::  terminal event
    ++  poke-sole-action       (. poke-sole-action):wrap         ::
    ++  poke-drum-start        (. poke-start):wrap             ::  start app
    ++  poke-drum-link         (. poke-link):wrap              ::  connect app
    ++  poke-drum-unlink       (. poke-unlink):wrap            ::  disconnect app
    ++  poke-drum-exit         (. poke-exit):wrap              ::  shutdown
    ++  poke-drum-put          (. poke-put):wrap               ::  write file
    ++  reap-drum-phat         (. reap-phat):wrap              ::  ack connect
    ++  take-coup-drum-phat    (. take-coup-phat):wrap         ::  ack poke
    ++  take-onto              (. take-onto):wrap              ::  ack start
    ++  quit-drum-phat         (. quit-phat):wrap              ::
    ++  wrap
      =<  [^?(.) (+> +<):..wrap]
      |*  handle/_|=(* *(quip (cask) *drum-part))
      |=  arg/_+<.handle
      =^  mow  +<+.wrap  (handle arg)
      [mow ..wrap]
    ++  prep
      _`.
::       |=  a/(unit drum-part)  ^+  [~ +>]
::       ?~  a  `+>(+<+ (drum-make our.hid))
::       ?:  =(u.a *drum-part)  `+>(+<+ (drum-make our.hid))
::       `+>(+<+ u.a)
    --
|=  {hid/bowl:^gall drum-part}                          ::  main drum work
=+  (fall (~(get by bin) ost.hid) *source)
=*  dev  -
=>  |%                                                ::  arvo structures
    ++  pear                                          ::  request
      $%  {$sole-action p/sole-action}                ::  some OT thing
::           {$talk-command command:talk}                ::  unused kay
      ==                                              ::
    ++  lime                                          ::  update
      $%  {$dill-blit dill-blit:^dill}                ::  terminal should do a thing
      ==                                              ::
    ++  card                                          ::  general card
      $%  {$conf wire dock $load ship term}           ::  boot an app XX this should be auto
          {$diff lime}                                ::  you got a subscription result
          {$peer wire dock path}                      ::  listen to an app somewhere
          {$poke wire dock pear}                      ::  app should do a thing
          {$pull wire dock $~}                        ::  stop listen to an app
      ==                                              ::
    ++  move  (pair bone card)                        ::  user-level move
    --
|_  {moz/(list move) biz/(list dill-blit:^dill)}
++  diff-sole-effect-phat                             ::  app event
  |=  {way/wire fec/sole-effect}
  =/  gyl  (decode-wire way)
  se-abet:se-view:(~(diff-sole-effect-phat su gyl) fec)
::
++  peer-sole                                         ::  someone is listening
  |=  pax/path  ^+  se-abet
  ~|  [%drum-unauthorized our+our.hid src+src.hid]    ::  ourself
  ?>  (team:title our.hid src.hid)               ::  or our own moon
  se-abet:se-view:(se-text "[{<src.hid>}, driving {<our.hid>}]")
::
++  poke-dill-belt                                    ::  terminal event
  |=  bet/dill-belt:^dill
  se-abet:se-view:(se-belt bet)
::
++  poke-sole-action                                    ::  terminal transpose
  |=  act/sole-action
  se-abet:se-view:(su-poke-sole-action act)
::
++  poke-start                                        ::  start app
  |=  wel/well:^gall
  se-abet:se-view:(se-born wel)
::
++  poke-link                                         ::  connect app
  |=  gyl/gill:^gall
  se-abet:se-view:~(poke-link su gyl)
::
++  poke-unlink                                       ::  disconnect app
  |=  gyl/gill:^gall
  se-abet:se-view:~(poke-unlink su gyl)
::
++  reap-phat                                         ::  ack connect
  |=  {way/wire saw/(unit tang)}
  =/  gyl  (decode-wire way)
  se-abet:se-view:(~(reap-phat su gyl) saw)
::
++  take-coup-phat                                    ::  ack poke
  |=  {way/wire saw/(unit tang)}
  =/  gyl  (decode-wire way)
  se-abet:se-view:(~(take-coup-phat su gyl) saw)
::
++  quit-phat                                         ::
  |=  way/wire
  =/  gyl  (decode-wire way)
  se-abet:se-view:~(quit-phat su gyl)
::
++  take-onto                                         ::  ack start
  |=  {way/wire saw/(each suss:^gall tang)}  
  ?>  ?=({@ @ $~} way)
  =/  wel/well:^gall  [i.way i.t.way]
  =<  se-abet  =<  se-view  :: XX se view necessary?
  ?>  (~(has by fur) q.wel)
  ?-  saw
    {$| *}  (se-dump p.saw)
    {$& *}  ?>  =(q.wel p.p.saw)
            ::  =.  +>.$  (se-text "live {<p.saw>}")
            +>.$(fur (~(put by fur) q.wel `[p.wel %da r.p.saw]))
  ==
::
::
++  poke-exit                                         ::  shutdown
  |=  $~
  se-abet:(se-blit-sys `dill-blit:^dill`[%qit ~])
::
++  poke-put                                          ::  write file
  |=  {pax/path txt/@}
  se-abet:(se-blit-sys [%sav pax txt])
::
::::                                                  ::  ::
  ::                                                  ::  ::
++  su-poke-sole-action
  |=  act/sole-action
  =/  gul   current-gill
  ?~  gul  (se-blit %bel ~)
  (~(poke-sole-action su u.gul) act)
::
++  su
  |_  gyl/gill:^gall  :: XX smeeeeell
  ++  diff-sole-effect-phat                             ::  app event
    |=  fec/sole-effect  ^+  ..su
    ?:  (dropped-app gyl)  ..su
    (se-diff gyl fec)
  ::
  ++  poke-sole-action                                    ::  terminal transpose
    |=  act/sole-action  ^+  ..su
    ?:  ?=($det -.act)  (se-chay +.act)
    ?:  (dropped-app gyl)
      (se-blit %bel ~)
    ta-abet:(ta-act:(se-tame gyl) act)
  ::
  ++  poke-link    (se-link gyl)                        ::  connect app
  ++  poke-unlink  (se-klin gyl)                        ::  disconnect app
  ++  reap-phat                                         ::  ack connect
    |=  saw/(unit tang)  ^+  ..su
    ?~  saw
      (se-join gyl)
    (se-dump:(se-drop & gyl) u.saw)
  ::
  ++  take-coup-phat                                    ::  ack poke
    |=  saw/(unit tang)  ^+  ..su
    ?~  saw  ..su
    ?:  (dropped-app gyl)  ..su
    %-  se-dump:(se-drop & gyl)
    :_  u.saw
    >[%drum-coup-fail src.hid ost.hid gyl]<
  ::
  ++  quit-phat                                         ::
    ~&  [%drum-quit src.hid ost.hid gyl]
    (se-drop %| gyl)
  --
::                                                    ::  ::
::::                                                  ::  ::
  ::                                                  ::  ::
++  se-abet                                           ::  resolve
  ^-  (quip move *drum-part)
::   ~&  se-abet+[ost.hid sup.hid]
  =*  pith  +>+>+<+
  ?.  se-ably
    =.  .  se-adit
    [(flop moz) pith]
  =.  sys  ?^(sys sys `ost.hid)
  =.  .  se-subze:se-adze:se-adit
  :_  pith(bin (~(put by bin) ost.hid dev))
  %-  flop
  ^-  (list move)
  ?~  biz  moz
  :_  moz
  [ost.hid %diff %dill-blit ?~(t.biz i.biz [%mor (flop biz)])]
::
++  se-ably  (~(has by sup.hid) ost.hid)              ::  caused by console
::
++  se-adit                                           ::  update servers
  ^+  .
  %+  roll  (~(tap in ray))
  =<  .(con +>)
  |=  {wel/well:^gall con/_..se-adit}  ^+  con
  =.  +>.$  con
  =+  hig=(~(get by fur) q.wel)
  ?:  &(?=(^ hig) |(?=($~ u.hig) =(p.wel syd.u.u.hig)))  +>.$
  =.  +>.$  (se-text "activated app {(trip p.wel)}/{(trip q.wel)}")
  %-  se-emit(fur (~(put by fur) q.wel ~))
  [ost.hid %conf [dap.hid p.wel q.wel ~] [our.hid q.wel] %load our.hid p.wel]
::
++  se-adze                                           ::  update connections
  ^+  .
  %+  roll  (~(tap in eel))
  =<  .(con +>)
  |=  {gil/gill:^gall con/_.}  ^+  con
  =.  +>.$  con
  ?:  (~(has by fug) gil)
    +>.$
  (se-peer gil)
::
++  se-subze                                          ::  downdate connections
  =<  .(dev (~(got by bin) ost.hid))
  =.  bin  (~(put by bin) ost.hid dev)
  ^+  .
  %-  ~(rep by bin)
  =<  .(con +>)
  |=  {{ost/bone dev/source} con/_.}  ^+  con
  =+  xeno=se-subze-local:%_(con ost.hid ost, dev dev)
  xeno(ost.hid ost.hid.con, dev dev.con, bin (~(put by bin) ost dev.xeno))
::
++  se-subze-local
  ^+  .
  %-  ~(rep by fug)
  =<  .(con +>)
  |=  {{gil/gill:^gall *} con/_.}  ^+  con
  =.  +>.$  con
  ?:  (~(has in eel) gil)
    +>.$
  (se-nuke gil)
::
++  dropped-app                                           ::  ignore result
  |=  gyl/gill:^gall
  ^-  ?
  ?.  (~(has by bin) ost.hid)  &
  =+  gyr=(~(get by fug) gyl)
  |(?=($~ gyr) ?=($~ u.gyr))
::
++  se-alas                                           ::  recalculate index
  |=  gyl/gill:^gall
  =+  [xin=0 wag=live-targets]
  |-  ^+  +>.^$
  ?~  wag  +>.^$(inx 0)
  ?:  =(i.wag gyl)  +>.^$(inx xin)
  $(wag t.wag, xin +(xin))
::
++  live-targets                                           ::  live targets
  ^-  (list gill:^gall)
  %+  skim  (~(tap in eel))
  |=(a/gill:^gall ?=({$~ $~ *} (~(get by fug) a)))
::
++  se-anon                                           ::  rotate index
  =+  wag=live-targets
  ?~  wag  +
  ::  ~&  [%se-anon inx+inx wag+wag nex+(mod +(inx) (lent live-targets))]
  +(inx (mod +(inx) (lent wag)))
::
++  current-gill                                           ::  current gill
  ^-  (unit gill:^gall)
  =+  wag=live-targets
  ?~  wag  ~
  ~|  [inx wag]
  `(snag inx `(list gill:^gall)`wag)
::
++  se-belt                                           ::  handle input
  |=  bet/dill-belt:^dill
  ^+  +>
  ?:  ?=({?($cru $hey $rez $yow) *} bet)              ::  target-agnostic
    ?-  bet
      {$cru *}  (se-dump:(se-text (trip p.bet)) q.bet)
::       {$hey *}  +>(mir [0 ~])                         ::  refresh
      {$hey *}  +>
      {$rez *}  +>(edg (dec p.bet))                   ::  resize window
      {$yow *}  ~&([%no-yow -.bet] +>)
    ==
  =+  gul=current-gill
  ?:  |(?=($~ gul) (dropped-app u.gul))
    (se-blit %bel ~)
  ta-abet:(ta-belt:(se-tame u.gul) bet)
::
++  se-chay                                           ::  handle transform
  |=  cha/sole-change
  ^+  +>
  =+  gul=current-gill
  ?:  |(?=($~ gul) (dropped-app u.gul))
    (se-blit %bel ~)
  ::  XX check other parts of change?
  ta-abet:(ta-hom:(se-tame u.gul) ted.cha)
::
++  se-born                                           ::  new server
  |=  wel/well:^gall
  ^+  +>
  ?:  (~(has in ray) wel)
    (se-text "[already running {<p.wel>}/{<q.wel>}]")
  %=  +>
    ray  (~(put in ray) wel)
    eel  (~(put in eel) [our.hid q.wel])
  ==
::
++  se-drop                                           ::  disconnect
  |=  {pej/? gyl/gill:^gall}
  ^+  +>
  =+  lag=current-gill
  ?.  (~(has by fug) gyl)  +>.$
  =.  fug  (~(del by fug) gyl)
  =.  eel  ?.(pej eel (~(del in eel) gyl))
  =.  +>.$  ?.  &(?=(^ lag) !=(gyl u.lag))
              +>.$(inx 0)
            (se-alas u.lag)
  =.  +>.$  (se-text "[unlinked from {<gyl>}]")
  ?:  =(gyl [our.hid %dojo])                          ::  undead dojo
    (se-link gyl)
  +>.$
::
++  se-dump                                           ::  print tanks
  |=  tac/(list tank)
  ^+  +>
  ?.  se-ably  (se-talk tac)
  =/  wol/wall
    (zing (turn (flop tac) |=(a/tank (~(win re a) [0 edg]))))
  |-  ^+  +>.^$
  ?~  wol  +>.^$
  ?.  ((sane %t) (crip i.wol))  :: XX upstream validation
    ~&  bad-text+<`*`i.wol>
    $(wol t.wol)
  $(wol t.wol, +>.^$ (se-blit %out (tuba i.wol)))
::
++  se-join                                           ::  confirm connection
  |=  gyl/gill:^gall
  ^+  +>
  =.  +>  (se-text "[linked to {<gyl>}]")
  ?>  ?=($~ (~(got by fug) gyl))
  (se-alas(fug (~(put by fug) gyl `*target)) gyl)
::
++  se-nuke                                           ::  teardown connection
  |=  gyl/gill:^gall
  ^+  +>
  (se-drop:(se-pull gyl) & gyl)
::
++  se-klin                                           ::  disconnect app
  |=  gyl/gill:^gall
  +>(eel (~(del in eel) gyl))
::
++  se-link                                           ::  connect to app
  |=  gyl/gill:^gall
  +>(eel (~(put in eel) gyl))
::
++  se-blit                                           ::  give output
  |=  bil/dill-blit:^dill
  +>(biz [bil biz])
::
++  se-blit-sys                                       ::  output to system
  |=  bil/dill-blit:^dill  ^+  +>
  ?~  sys  ~&(%se-blit-no-sys +>)
  (se-emit [u.sys %diff %dill-blit bil])
::
++  se-show                                           ::  show buffer, raw
  |=  lin/(pair @ud stub:^dill)
  ^+  +>
::   ?:  =(mir lin)  +>
::   =.  +>  ?:(=(p.mir p.lin) +> (se-blit %hop (add p.lin (lent-stye:klr q.lin))))
::   =.  +>  ?:(=(q.mir q.lin) +> (se-blit %pom q.lin))
::   +>(mir lin)
  =.  +>  (se-blit %hop (add p.lin (lent-stye:klr q.lin)))
  =.  +>  (se-blit %pom q.lin)
  +>
::
++  se-just                                           ::  adjusted buffer
  |=  lin/(pair @ud stub:^dill)
  ^+  +>
::   =.  off  ?:((lth p.lin edg) 0 (sub p.lin edg))
::   (se-show (sub p.lin off) (scag:klr edg (slag:klr off q.lin)))
  (se-show p.lin q.lin)
::
++  se-view                                           ::  flush buffer
  ^+  .
  =+  gul=current-gill
  ?:  |(?=($~ gul) (dropped-app u.gul))  +
  (se-just ta-vew:(se-tame u.gul))
::
++  se-emit                                           ::  emit move
  |=  mov/move
  %_(+> moz [mov moz])
::
++  se-talk
  |=  tac/(list tank)
  ^+  +>
  :: XX talk should be usable for stack traces, see urbit#584 which this change
  :: closed for the problems there
  ((slog (flop tac)) +>)
  ::(se-emit 0 %poke /drum/talk [our.hid %talk] (said:talk our.hid %drum now.hid eny.hid tac))
::
++  se-text                                           ::  return text
  |=  txt/tape
  ^+  +>
  ?.  ((sane %t) (crip txt))  :: XX upstream validation
    ~&  bad-text+<`*`txt>
    +>
  ?.  se-ably  (se-talk [%leaf txt]~)
  (se-blit %out (tuba txt))
::
++  se-poke                                           ::  send a poke
  |=  {gyl/gill:^gall par/pear}
  (se-emit [ost.hid %poke (drum-path gyl) gyl par])
::
++  se-peer                                           ::  send a peer
  |=  gyl/gill:^gall
  %-  se-emit(fug (~(put by fug) gyl ~))
  [ost.hid %peer (drum-path gyl) gyl /sole]
::
++  se-pull                                           ::  cancel subscription
  |=  gyl/gill:^gall
  (se-emit [ost.hid %pull (drum-path gyl) gyl ~])
::
++  se-tame                                           ::  switch connection
  |=  gyl/gill:^gall
  ^+  ta
  ~(. ta gyl (need (~(got by fug) gyl)))
::
++  se-diff                                           ::  receive results
  |=  {gyl/gill:^gall fec/sole-effect}
  ^+  +>
  ta-abet:(ta-fec:(se-tame gyl) fec)
::
++  ta                                                ::  per target
  |_  {gyl/gill:^gall target}                         ::  app and state
  ++  ta-abet                                         ::  resolve
    ^+  ..ta
    ..ta(fug (~(put by fug) gyl ``target`+<+))
  ::
  ++  ta-poke  |=(a/pear +>(..ta (se-poke gyl a)))    ::  poke gyl
  ::
  ++  ta-act                                          ::  send action
    |=  act/sole-action
    ^+  +>
    (ta-poke %sole-action act)
  ::
  ++  ta-aro                                          ::  hear arrow
    |=  key/?($d $l $r $u)
    ^+  +>
::     =.  ris  ~
    ?-  key
      $d  +>
::       $d  ?.  =(num.hit pos.hit)
::             (ta-mov +(pos.hit))
::           ?:  =(0 (lent buf.say.inp))
::             ta-bel
::           (ta-hom:ta-nex %set ~)
      $l  ?:  =(0 pos.inp)  ta-bel
          +>(pos.inp (dec pos.inp))
      $r  ?:  =((lent buf.say.inp) pos.inp)
            ta-bel
          +>(pos.inp +(pos.inp))
      $u  +>
::       $u  ?:(=(0 pos.hit) ta-bel (ta-mov (dec pos.hit)))
    ==
  ::
  ++  ta-bel                                          ::  beep
::     .(..ta (se-blit %bel ~), q.blt ~)                 ::  forget belt
    .(..ta (se-blit %bel ~))
  ::
  ++  ta-belt                                         ::  handle input
    |=  bet/dill-belt:^dill
    ^+  +>
    ?<  ?=({?($cru $hey $rez $yow) *} bet)            ::  target-specific
::     =.  blt  [q.blt `bet]                             ::  remember belt
    ?-  bet
      {$aro *}  (ta-aro p.bet)
      {$bac *}  ta-bac
      {$ctl *}  (ta-ctl p.bet)
      {$del *}  ta-del
      {$met *}  (ta-met p.bet)
      {$ret *}  ta-ret
      {$txt *}  (ta-txt p.bet)
    ==
  ::
  ++  ta-det                                          ::  send edit
    |=  ted/sole-edit
    ^+  +>
    (ta-act %det [[his.ven.say.inp own.ven.say.inp] (sham buf.say.inp) ted])
  ::
  ++  ta-bac                                          ::  hear backspace
    ^+  .
::     ?^  ris
::       ?:  =(~ str.u.ris)
::         ta-bel
::       .(str.u.ris (scag (dec (lent str.u.ris)) str.u.ris))
    ?:  =(0 pos.inp)
      ?~  buf.say.inp
        (ta-act %clr ~)
      ta-bel
    (ta-hom %del (dec pos.inp))
  ::
  ++  ta-ctl                                          ::  hear control
    |=  key/@ud
    ^+  +>
::     =.  ris  ?.(?=(?($g $r) key) ~ ris)
    ?+    key    ta-bel
        $b  (ta-aro %l)
        $f  (ta-aro %r)
        $n  (ta-aro %d)
        $p  (ta-aro %u)
    ::
        $a  +>(pos.inp 0)
        $e  +>(pos.inp (lent buf.say.inp))
    ::
        $c  ta-bel
        $d  ?^  buf.say.inp
              ta-del
            ?:  (~(has in (default-connects our.hid)) gyl)
              +>(..ta (se-blit qit+~))                ::  quit pier
            +>(..ta (se-klin gyl))                    ::  unlink app
        $l  +>(..ta (se-blit %clr ~))
        $v  ta-bel
        $x  +>(..ta se-anon)
    ::
::         $k  =+  len=(lent buf.say.inp)
::             ?:  =(pos.inp len)
::               ta-bel
::             (ta-kil %r [pos.inp (sub len pos.inp)])
::         $t  =+  len=(lent buf.say.inp)
::             ?:  |(=(0 pos.inp) (lth len 2))
::               ta-bel
::             =+  sop=(sub pos.inp ?:(=(len pos.inp) 2 1))
::             (ta-hom (rep:edit [sop 2] (flop (swag [sop 2] buf.say.inp))))
::         $u  ?:  =(0 pos.inp)
::               ta-bel
::             (ta-kil %l [0 pos.inp])
::         $w  ?:  =(0 pos.inp)
::               ta-bel
::             =+  sop=(ta-off %l %ace pos.inp)
::             (ta-kil %l [(sub pos.inp sop) sop])
::         $y  ?:  =(0 num.kil)
::               ta-bel
::             (ta-hom (cat:edit pos.inp ta-yan))
    ::
::         $g  ?~  ris  ta-bel
::             (ta-hom(pos.hit num.hit, ris ~) [%set ~])
::         $r  ?~  ris
::               +>(ris `[pos.hit ~])
::             ?:  =(0 pos.u.ris)
::               ta-bel
::             (ta-ser ~)
    ==
  ::
  ++  ta-del                                          ::  hear delete
    ^+  .
    ?:  =((lent buf.say.inp) pos.inp)
      ta-bel
    (ta-hom %del pos.inp)
  ::
  ++  ta-erl                                          ::  hear local error
    |=  pos/@ud
    ta-bel(pos.inp (min pos (lent buf.say.inp)))
  ::
  ++  ta-err                                          ::  hear remote error
    |=  pos/@ud
    (ta-erl (~(transpose sole say.inp) pos))
  ::
  ++  ta-fec                                          ::  apply effect
    |=  fec/sole-effect
::     ~&  ta-fec+[ost.hid -.fec +<.ta-fec]
    ^+  +>
    ?-  fec
      {$bel *}  ta-bel
      {$blk *}  +>
      {$clr *}  +>(..ta (se-blit fec))
      {$det *}  (ta-got +.fec)
      {$err *}  (ta-err p.fec)
      {$klr *}  +>(..ta (se-blit %klr (make:klr p.fec)))
      {$mor *}  |-  ^+  +>.^$
                ?~  p.fec  +>.^$
                $(p.fec t.p.fec, +>.^$ ^$(fec i.p.fec))
      {$nex *}  +>
::       {$nex *}  ta-nex
      {$pro *}  (ta-pro +.fec)
      {$tan *}  +>(..ta (se-dump p.fec))
      {$sag *}  +>(..ta (se-blit fec))
      {$sav *}  +>(..ta (se-blit fec))
      {$txt *}  +>(..ta (se-text p.fec))
      {$url *}  +>(..ta (se-blit fec))
    ==
  ::
  ++  ta-dog                                          ::  change cursor
    |=  ted/sole-edit
    %_    +>
        pos.inp
      =+  len=(lent buf.say.inp)
      %+  min  len
      |-  ^-  @ud
      ?-  ted
        {$del *}  ?:((gth pos.inp p.ted) (dec pos.inp) pos.inp)
        {$ins *}  ?:((gte pos.inp p.ted) +(pos.inp) pos.inp)
        {$mor *}  |-  ^-  @ud
                  ?~  p.ted  pos.inp
                  $(p.ted t.p.ted, pos.inp ^$(ted i.p.ted))
        {$nop *}  pos.inp
        {$set *}  len
      ==
    ==
  ::
  ++  ta-got                                          ::  apply change
    |=  cal/sole-change
    =^  ted  say.inp  (~(receive sole say.inp) cal)
    (ta-dog ted)
  ::
  ++  ta-hom                                          ::  local edit
    |=  ted/sole-edit
    ^+  +>
    =.  +>  (ta-det ted)
    (ta-dog(say.inp (~(commit sole say.inp) ted)) ted)
  ::
  ++  ta-jump                                         ::  buffer pos
    |=  {dir/?($l $r) til/?($ace $edg $wrd) pos/@ud}
    ^-  @ud
    %-  ?:(?=($l dir) sub add)
    [pos (ta-off dir til pos)]
  ::
::   ++  ta-kil                                          ::  kill selection
::     |=  {dir/?($l $r) sel/{@ @}}
::     ^+  +>
::     =+  buf=(swag sel buf.say.inp)
::     %.  (cut:edit sel)
::     %=  ta-hom
::         kil
::       ?.  ?&  ?=(^ old.kil)
::               ?=(^ p.blt)
::               ?|  ?=({$ctl ?($k $u $w)} u.p.blt)
::                   ?=({$met ?($d $bac)} u.p.blt)
::           ==  ==
::         %=  kil                                       ::  prepend
::           num  +(num.kil)
::           pos  +(num.kil)
::           old  (scag max.kil `(list (list @c))`[buf old.kil])
::         ==
::       %=  kil                                         ::  cumulative yanks
::         pos  num.kil
::         old  :_  t.old.kil
::              ?-  dir
::                $l  (welp buf i.old.kil)
::                $r  (welp i.old.kil buf)
::       ==     ==
::     ==
  ::
  ++  ta-met                                          ::  meta key
    |=  key/@ud
    ^+  +>
::     =.  ris  ~
    ?+    key    ta-bel
::       $dot  ?.  &(?=(^ old.hit) ?=(^ i.old.hit))      ::  last "arg" from hist
::               ta-bel
::             =+  old=`(list @c)`i.old.hit
::             =+  sop=(ta-jump(buf.say.inp old) %l %ace (lent old))
::             (ta-hom (cat:edit pos.inp (slag sop old)))
            ::
::       $bac  ?:  =(0 pos.inp)                          ::  kill left-word
::               ta-bel
::             =+  sop=(ta-off %l %edg pos.inp)
::             (ta-kil %l [(sub pos.inp sop) sop])
::             ::
      $b    ?:  =(0 pos.inp)                          ::  jump left-word
              ta-bel
            +>(pos.inp (ta-jump %l %edg pos.inp))
            ::
      $c    ?:  =(pos.inp (lent buf.say.inp))         ::  capitalize
              ta-bel
            =+  sop=(ta-jump %r %wrd pos.inp)
            %-  ta-hom(pos.inp (ta-jump %r %edg sop))
            %+  rep:edit  [sop 1]
            ^-  (list @c)  ^-  (list @)               :: XX unicode
            (cuss `tape``(list @)`(swag [sop 1] buf.say.inp))
            ::
::       $d    ?:  =(pos.inp (lent buf.say.inp))         ::  kill right-word
::               ta-bel
::             (ta-kil %r [pos.inp (ta-off %r %edg pos.inp)])
::             ::
      $f    ?:  =(pos.inp (lent buf.say.inp))         ::  jump right-word
              ta-bel
            +>(pos.inp (ta-jump %r %edg pos.inp))
            ::
::       $r    %-  ta-hom(lay.hit (~(put by lay.hit) pos.hit ~))
::             :-  %set                                  ::  revert hist edit
::             ?:  =(pos.hit num.hit)  ~
::             (snag (sub num.hit +(pos.hit)) old.hit)
            ::
      $t    =+  a=(ta-jump %r %edg pos.inp)           ::  transpose words
            =+  b=(ta-jump %l %edg a)
            =+  c=(ta-jump %l %edg b)
            ?:  =(b c)
              ta-bel
            =+  next=[b (sub a b)]
            =+  prev=[c (ta-off %r %edg c)]
            %-  ta-hom(pos.inp a)
            :~  %mor
                (rep:edit next (swag prev buf.say.inp))
                (rep:edit prev (swag next buf.say.inp))
            ==
            ::
      ?($u $l)                                        ::  upper/lower case
            ?:  =(pos.inp (lent buf.say.inp))
              ta-bel
            =+  case=?:(?=($u key) cuss cass)
            =+  sop=(ta-jump %r %wrd pos.inp)
            =+  sel=[sop (ta-off %r %edg sop)]
            %-  ta-hom
            %+  rep:edit  sel
            ^-  (list @c)  ^-  (list @)               :: XX unicode
            (case `tape``(list @)`(swag sel buf.say.inp))
            ::
::       $y    ?.  ?&  ?=(^ old.kil)                     ::  rotate & yank
::                     ?=(^ p.blt)
::                     ?|  ?=({$ctl $y} u.p.blt)
::                         ?=({$met $y} u.p.blt)
::                 ==  ==
::               ta-bel
::             =+  las=(lent ta-yan)
::             =.  pos.kil  ?:(=(1 pos.kil) num.kil (dec pos.kil))
::             (ta-hom (rep:edit [(sub pos.inp las) las] ta-yan))
    ==
  ::
::   ++  ta-mov                                          ::  move in history
::     |=  sop/@ud
::     ^+  +>
::     ?:  =(sop pos.hit)  +>
::     %-  %=  ta-hom
::           pos.hit  sop
::           lay.hit  (~(put by lay.hit) pos.hit buf.say.inp)
::         ==
::     :-  %set
::     %.  (~(get by lay.hit) sop)
::     (bond |.((snag (sub num.hit +(sop)) old.hit)))
  ::
::   ++  ta-nex                                          ::  advance history
::     ^+  .
::     =.  ris  ~
::     =.  lay.hit  ~
::     ?:  ?|  ?=($~ buf.say.inp)
::             &(?=(^ old.hit) =(buf.say.inp i.old.hit))
::         ==
::       .(pos.hit num.hit)
::     %_  .
::       num.hit  +(num.hit)
::       pos.hit  +(num.hit)
::       old.hit  [buf.say.inp old.hit]
::     ==
  ::
  ++  ta-off                                          ::  buffer pos offset
    |=  {dir/?($l $r) til/?($ace $edg $wrd) pos/@ud}
    ^-  @ud
    %-  ?-  til  $ace  ace:offset
                 $edg  edg:offset
                 $wrd  wrd:offset
        ==
    ?-  dir  $l  (flop (scag pos buf.say.inp))
             $r  (slag pos buf.say.inp)
    ==
  ::
  ++  ta-pro                                          ::  set prompt
    |=  pom/sole-prompt
    %_    +>
        pom
      %_    pom
          cad
        ;:  welp
          ?.  ?=($earl (clan:title p.gyl))
            (cite:title p.gyl)
          (scow %p p.gyl)
        ::
          ":"
          (trip q.gyl)
          cad.pom
        ==
      ==
    ==
  ::
  ++  ta-ret                                          ::  hear return
    (ta-act %ret ~)
  ::
::   ++  ta-ser                                          ::  reverse search
::     |=  ext/(list @c)
::     ^+  +>
::     ?:  |(?=($~ ris) =(0 pos.u.ris))
::       ta-bel
::     =+  sop=?~(ext (dec pos.u.ris) pos.u.ris)
::     =+  tot=(weld str.u.ris ext)
::     =+  dol=(slag (sub num.hit sop) old.hit)
::     =/  sup
::         |-  ^-  (unit @ud)
::         ?~  dol  ~
::         ?^  (find tot i.dol)
::           `sop
::         $(sop (dec sop), dol t.dol)
::     ?~  sup  ta-bel
::     (ta-mov(str.u.ris tot, pos.u.ris u.sup) (dec u.sup))
::   ::
  ++  ta-txt                                          ::  hear text
    |=  txt/(list @c)
    ^+  +>
::     ?^  ris
::       (ta-ser txt)
    (ta-hom (cat:edit pos.inp txt))
  ::
  ++  ta-vew                                          ::  computed prompt
    ^-  (pair @ud stub:^dill)
    =;  vew/(pair (list @c) styx:^dill)
      =+  lin=(make:klr q.vew)
      :_  (welp lin [*stye:^dill p.vew]~)
      (add pos.inp (lent-char:klr lin))
    ?:  vis.pom
      :-  buf.say.inp                                 ::  default prompt
::       ?~  ris
        cad.pom
::       :(welp "(reverse-i-search)'" (tufa str.u.ris) "': ")
    :-  (reap (lent buf.say.inp) `@c`'*')             ::  hidden input
    %+  welp
      cad.pom
    ?~  buf.say.inp  ~
    :(welp "<" (scow %p (end 4 1 (sham buf.say.inp))) "> ")
  ::
::   ++  ta-yan                                          ::  yank
::     (snag (sub num.kil pos.kil) old.kil)
  --
++  edit                                              ::  produce sole-edits
  |%
  ++  cat                                             ::  mass insert
    |=  {pos/@ud txt/(list @c)}
    ^-  sole-edit
    :-  %mor
    |-  ^-  (list sole-edit)
    ?~  txt  ~
    [[%ins pos i.txt] $(pos +(pos), txt t.txt)]
  ::
  ++  cut                                             ::  mass delete
    |=  {pos/@ud num/@ud}
    ^-  sole-edit
    :-  %mor
    |-  ^-  (list sole-edit)
    ?:  =(0 num)  ~
    [[%del pos] $(num (dec num))]
  ::
  ++  rep                                             ::  mass replace
    |=  {{pos/@ud num/@ud} txt/(list @c)}
    ^-  sole-edit
    :~  %mor
        (cut pos num)
        (cat pos txt)
    ==
  --
++  offset                                            ::  calculate offsets
  |%
  ++  alnm                                            ::  alpha-numeric
    |=  a/@  ^-  ?
    ?|  &((gte a '0') (lte a '9'))
        &((gte a 'A') (lte a 'Z'))
        &((gte a 'a') (lte a 'z'))
    ==
  ::
  ++  ace                                             ::  next whitespace
    |=  a/(list @)
    =|  {b/_| i/@ud}
    |-  ^-  @ud
    ?~  a  i
    =/  c  !=(32 i.a)
    =.  b  |(b c)
    ?:  &(b !|(=(0 i) c))  i
    $(i +(i), a t.a)
  ::
  ++  edg                                             ::  next word boundary
    |=  a/(list @)
    =|  {b/_| i/@ud}
    |-  ^-  @ud
    ?~  a  i
    =/  c  (alnm i.a)
    =.  b  |(b c)
    ?:  &(b !|(=(0 i) c))  i
    $(i +(i), a t.a)
  ::
  ++  wrd                                             ::  next or current word
    |=  a/(list @)
    =|  i/@ud
    |-  ^-  @ud
    ?:  |(?=($~ a) (alnm i.a))  i
    $(i +(i), a t.a)
  --
::
++  klr  styxes                                               ::  styx/stub engine
--
