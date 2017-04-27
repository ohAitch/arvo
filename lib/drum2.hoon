::                                                      ::  ::
::::  /hoon/drum/lib                                    ::  ::
  ::                                                    ::  ::
::
/?    310                                               ::<  hoon version
/-    sole                                              ::<  structures
/+    sole, klr                                         ::<  libraries
::                                                      ::  ::
::::                                                    ::  ::
  ::                                                    ::  ::
::
:: TODO replace with =, rune ?
[. ^sole]
::                                                      ::  ::
::::                                                    ::  ::
  ::                                                    ::  ::
::>  ||
::>  ||  %arch
::>  ||
::>    data structures
::
::REVIEW determine coherent style wrt having or not
::  having => on structure cores
::
|%                                                      ::  ::
++  drum-part      {$drum $2 drum-pith}                 ::  drum state for hood
++  drum-part-old
  ::>  used to contain the definitions of versions %1
  ::>  and %0 of {drum-part}; those are no longer
  ::>  necessary for state adaption. will contain
  ::>  variants %2, %3, etc. in future {drum-part}s
  ::>  %3, %4. etc.
  ::
  _!!
::                                                      ::
++  drum-pith                                           ::
  ::>  all drum state
  ::>
  ::>  sys: used for |exit
  ::>  eel: apps we want to connect to
  ::>  ray: app desks
  ::>       TODO why is this not (map app/term desk)?
  ::>  fur: started apps
  ::>  bin: (most of the state is here) per-terminal state
  ::>       TODO move a lot of this out into fur
  ::
  $:  sys/(unit bone)                                   ::< local console
      eel/(set dock)                                    ::< connect to
      ray/(set well:^gall)                              ::< app desks
      fur/(map dude:^gall (unit server))                ::< servers
      bin/(map bone source)                             ::< terminals
  ==                                                    ::
::
::> ||
::> ||  components
::> ||
::>   pith parts
::+|
::
++  server                                              ::> server source
  ::> describes a desk and case an app is running from;
  ::> the ship is implicitly always {our}
  ::>
  ::> syd: boot desk
  ::> cas: boot case
  ::>
  {syd/desk cas/case}
::
++  kill                                                ::> kill ring
  ::> a list of lines deleted by ctrl-u ctrl-w etc,
  ::> available for retrieval with ctrl-y
  ::>
  ::> old: killed text snippets
  ::> pos: currrent position in {old}: cycle through
  ::>      ring with meta-y
  ::> num: (lent old)
  ::>      REVIEW would this really be prohibitive to
  ::>             recalculate as necessary?
  ::> max: kill ring limit REVIEW why is this limited?
  ::
  $:  old/(list (list @c))                              ::< entries proper
      pos/@ud                                           ::< ring position
      num/@ud                                           ::< number of entries
      max/_60                                           ::< max entries
  ==                                                    ::
++  source                                              ::> input device
  ::> all state for connected terminal
  ::>
  ::> edg: width
  ::> kil: kill ring
  ::> inx: currently selected app: cycle through with ^X
  ::> fug: per-terminal per-app state
  ::> mir: cursor position and buffer last sent to %dill
  ::>      TODO this is sort-of derived state, and
  ::>           should probably be in scope only for
  ::>           long enough that {se-abet} can determine
  ::>           whether it has changed, instead of
  ::>           storing it permanently
  ::>
  $:  edg/_80                                           ::< terminal columns
      kil/kill                                          ::< kill buffer
      {inx/@ud fug/(map dock target)}                   ::< connections
      mir/(pair @ud stub:^dill)                         ::< mirrored terminal
  ==                                                    ::
++  history                                             ::> past commands
  ::> old inputs, used for arrow up/down
  ::>
  ::> old: text lines
  ::> pos: selected history entry
  ::> num: (lent old)
  ::>      REVIEW would this really be prohibitive to
  ::>             recalculate as necessary?
  ::> lay: past entries that have been revised. elements
  ::>      are moved from {lay} to {old} once used
  ::>
  $:  old/(list (list @c))                              ::< entries proper
      pos/@ud                                           ::< input position
      num/@ud                                           ::< number of entries
      lay/(map @ud (list @c))                           ::< editing overlay
  ==                                                    ::
++  search                                              ::> reverse-i-search
  ::> reverse incremental search over {history}
  ::> enter with ctrl-r, exist with ctrl-g
  ::>
  ::> pos: how many history entries have been skipped
  ::>      REVIEW this seems to be chronological,
  ::>             motivation unknown
  ::> str: incrementally typed query
  ::>
  $:  pos/@ud                                           ::< search position
      str/(list @c)                                     ::< search string
  ==                                                    ::
++  target                                              ::> application target
  ::REVIEW a lot of this should be shared between
  ::       terminal connections
  ::
  ::> state maintained per application connection
  ::>
  ::> blt: recognize sequences of deletions to group them in
  ::>      kill ring
  ::> ris: reverse-incremental-search if active
  ::> hit: past command lines
  ::> pom: line prefix identifying target app
  ::> inp: shared buffer state, user enters text and
  ::>      connected app corrects/rejects syntax errors
  ::> ses: WIP %inc- persistent connection state
  ::> con: link is %new, then {%liv}e, occasionally %ded
  ::
  $:  $=  blt                                           ::< curr & prev belts
        %+  pair
          (unit dill-belt:^dill)
        (unit dill-belt:^dill)
      ris/(unit search)                                 ::< reverse-i-search
      hit/history                                       ::< all past input
      pom/sole-prompt                                   ::< static prompt
      inp/sole-cursor-share                             ::< input state
      ses/ses-data                                      ::< WIP %inc- client
      con/?($liv $ded $new)                             ::< subscription state
  ==                                                    ::
::
::TODO unify with sole-id
++  session  {@u dock}                                  ::< always [0 our dap]
++  ses-data                                            ::> WIP, RENAMEME
  ::> sus: seqn of current outbound subscription
  ::> rec: counter of recieved bumps
  ::
  {sus/@u rec/@u}
::
::
++  control-belt                                      ::> control drum itself
  $%  {$cru p/@tas q/(list tank)}                     ::< echo error
      {$hey $~}                                       ::< refresh
      {$rez p/@ud q/@ud}                              ::< resize, cols, rows
      {$yow p/dock}                                   ::< connect to app
  ==                                                  ::
++  app-specific-belt                                 ::> belt for current app
  $%  {$aro p/?($d $l $r $u)}                         ::< arrow key
      {$bac $~}                                       ::< true backspace
      {$ctl p/@}                                      ::< control-key
      {$del $~}                                       ::< true delete
      {$met p/@}                                      ::< meta-key
      {$ret $~}                                       ::< return
      {$txt p/(list @c)}                              ::< utf32 text
  ==                                                  ::
++  typecheck                                         ::> -belt type completeness
  `dill-belt:^dill`*?(control-belt app-specific-belt)
--
::                                                      ::  ::
::::                                                    ::  ::
  ::                                                    ::  ::
|%
++  drum-make                                           ::< initial part
  ::REVIEW move config to file system? It seems maybe
  ::       useful to be able to force dojo reconnect
  ::       from unix, for one thing
  ::
  ::> make initial {drum-part} state, by adding some
  ::> default apps to the bunt
  ::>
  ::> our: comets run off %base, moons use parent's talk
  ::>
  |=  our/ship
  |^  ^-  drum-part
      %*  .  *drum-part
        eel  deft-fish
        ray  deft-apps
      ==
  ::
  ++  deft-fish                                           ::< default connects
    ::> apps to connect to by default: talk, dojo
    ::>
    ::> if on a moon, use parent's talk instead of own
    ::
    %-  ~(gas in *(set dock))
    ^-  (list dock)
    ?:  ?=($earl (clan:title our))
      [[(sein:title our) %talk] [our %dojo] ~]
    [[our %talk] [our %dojo] ~]
  ::
  ++  deft-apps                                           ::< default servers
    ::> apps to start by default: talk, dojo
    ::>
    ::> if on a comet, use %base instead of %home;
    ::> if on a moon, don't start local %talk
    ::
    %-  ~(gas in *(set well:^gall))
    ^-  (list well:^gall)
    =+  myr=(clan:title our)
    ?:  ?=($pawn myr)
      [[%base %talk] [%base %dojo] ~]
    ?:  ?=($earl myr)
      [[%home %dojo] ~]
    [[%home %talk] [%home %dojo] ~]
  --
::
::>  ||
::>  || %wire-serdes
::>  ||
::>    encode and decode wires
::+|
::
++  drum-path                                           ::< encode wire
  ::>  `wire`[%drum %phat (dray `dock`dok /[%p]/[%tas])]
  |=  dok/dock  ^-  wire
  [%drum %phat (scot %p p.dok) q.dok ~]
::
++  drum-phat                                           ::< decode wire
  ::>  `dock`(raid `wire`way /[%p]/[%tas])
  |=  way/wire  ^-  dock
  ?>(?=({@ @ $~} way) [(slav %p i.way) i.t.way])
--
::
::::
  ::
::> ||
::> ||  %app
::> ||
::>   event + state -> reactions + state
::>
|=  {bow/bowl:^gall drum-part}                          ::  main drum work
::  new subscriptions default empty
=+  (fall (~(get by bin) ost.bow) *source)
=*  dev  -
=>  ::REVIEW move up outside of |=?
    ::>  ||
    ::>  ||  %interface-types
    ::>  ||
    ::
    |%
    ++  pear                                            ::> request (poke)
      $%  {$sole-id-action p/sole-id-action}            ::< buffer update
          ::{$talk-command command:talk}                ::< render stack trace
          {$dill-belt dill-belt:^dill}                  ::< proxied keystroke
      ==                                                ::
    ++  lime                                            ::> typed diff
      $%  {$dill-blit dill-blit:^dill}                  ::< screen or buf update
      ==                                                ::
    ++  card                                            ::> general card
      $%  {$conf wire dock $load ship term}             ::< configure app
          {$diff lime}                                  ::< give update
          {$peer wire dock path}                        ::< subscribe
          {$poke wire dock pear}                        ::< send message
          {$pull wire dock $~}                          ::< unsubscribe
      ==                                                ::
    ++  move  (pair bone card)                          ::< user-level move
    --
::> ||
::> ||  %door
::> ||
::>   more convenient lexical environment within %app
::
|_  {moz/(list move) biz/(list dill-blit:^dill)}
::
::>  ||
::>  ||  %interface-arms
::>  ||
::>    accept external events
::+|
++  diff-sole-backlog-phat                               ::< chunk of output
  ::> updates to virtual console on re/connect
  ::>
  ::> way: identifies the app sending the update,
  ::>      encoded as /[%p]/[%tas]
  ::> tot: total number of updates, including skipped %det
  ::> fec: list of backlog effects
  ::
  |=  {way/wire tot/@u fec/(list sole-effect)}
  =<  se-abet  =<  se-view
  =+  dok=(drum-phat way)
  ?:  (se-aint dok)  +>.$
  ta-abet:(ta-diff-backlog:(ta dok) tot fec)
::
++  diff-sole-effect-phat                               ::< console output
  ::> receive update to virual console
  ::>
  ::> way: identifies the app sending the update,
  ::>      encoded as /[%p]/[%tas]
  ::> fec: the update. print lines, delete/replace
  ::>      chars of input, etc
  ::
  |=  {way/wire fec/sole-effect}
  =<  se-abet  =<  se-view
  =+  dok=(drum-phat way)
  ?:  (se-aint dok)  +>.$
  ta-abet:(ta-diff-effect:(ta dok) fec)
::
++  peer                                                ::< new connection
  ::>  incoming subscription
  ::>
  ::>  _: unused path attribute
  |=  path
  ::TODO assert path is empty or sth
  ::
  ::> only allow connections from self or moons
  ::
  ~|  [%drum-unauthorized our+our.bow src+src.bow]
  ?>  (team:title our.bow src.bow)
  ::
  =<  se-abet  =<  se-view
  (se-text "[{<src.bow>}, driving {<our.bow>}]")
::
++  diff-dill-blit-phat                                 ::< raw dill output
  ::> proxy raw %dill- output from %drumming
  ::>
  ::> bil: the console update
  ::
  ::TEMP this is transitional to support multiple active
  ::     /+drum instances
  ::
  =,  ^dill
  |=  {wire bil/dill-blit}
  =<  se-abet  =<  se-view
  =.  bil  %.  bil
    |=  bil/dill-blit
    ?+  -.bil  bil
      $mor  bil(p (turn p.bil .))
    ::
      ::> turn prompt green to distinguish "inner" drum
      $pom  bil(p ?~(p.bil ~ p.bil(q.q.p.i %g)))
    ==
  (se-blit bil)
::
++  poke-dill-belt                                      ::< terminal event
  ::> process keystroke
  ::>
  ::> bet: the character, key, or modified-key
  ::
  |=  bet/dill-belt:^dill
  =<  se-abet  =<  se-view
  ?.  ?=(?($cru $hey $rez $yow) -.bet)
    =+  gul=se-current-app
    ?:  |(?=($~ gul) (se-aint u.gul))
      (se-blit %bel ~)
    ta-abet:(ta-belt:(ta u.gul) bet)
  ::
  =.  bet  `control-belt`bet
  ?-  bet
    {$cru *}  (se-dump:(se-text (trip p.bet)) q.bet)
    {$hey *}  +>(mir [0 ~])                             ::< refresh
    {$rez *}  +>(edg (dec p.bet))                       ::< resize window
    {$yow *}  ~&([%no-yow -.bet] +>)
  ==
::
++  poke-start                                          ::< |start %app
  ::> init an app using gall, and link to its console
  ::
  |=  wel/well:^gall
  =<  se-abet  =<  se-view
  ?:  (~(has in ray) wel)
    (se-text "[already running {<p.wel>}/{<q.wel>}]")
  %=  +>
    ray  (~(put in ray) wel)
    eel  (~(put in eel) [our.bow q.wel])
  ==
::
++  poke-link                                           ::< |link %app, connect
  ::> connnect to an app's console
  ::
  |=  dok/dock
  =<  se-abet  =<  se-view
  +>(eel (~(put in eel) dok))
::
++  poke-unlink                                         ::< |unlink %app, close
  ::> disconnnect from an app's console
  ::
  |=  dok/dock
  =<  se-abet  =<  se-view
  +>(eel (~(del in eel) dok))
::
++  poke-exit                                           ::< |exit, shutdown urbit
  ::> shutdown running urbit instance
  ::
  |=  $~
  se-abet:(se-blit-sys `dill-blit:^dill`[%qit ~])
::
++  poke-put                                            ::< write file
  ::> write a text file to the pier's `.urb/put`
  ::> directory
  ::
  |=  {pax/path txt/@}
  se-abet:(se-blit-sys [%sav pax txt])
::
++  reap-phat                                           ::< get ack for connection
  ::> recieve acknowledgment on an app connection
  ::>
  ::> way: identifies the app being connected to,
  ::>      encoded as /[%p]/[%tas]
  ::> saw: stack trace, if the connection failed
  ::
  |=  {way/wire saw/(unit tang)}
  =<  se-abet  =<  se-view
  =+  dok=(drum-phat way)
  ?~  saw
    ta-abet:ta-peered:(ta dok)
  (se-dump:(se-nuke dok) u.saw)
::
++  take-coup-phat                                      ::< get ack for poke
  ::> recieve acknowledgment on an app command
  ::>
  ::> way: identifies the app being commanded,
  ::>      encoded as /[%p]/[%tas]
  ::> saw: stack trace, if the command failed
  ::
  |=  {way/wire saw/(unit tang)}
  =<  se-abet  =<  se-view
  ?~  saw  +>
  =+  dok=(drum-phat way)
  ?:  (se-aint dok)  +>.$
  =+  (mean >[%drum-coup-fail src.bow ost.bow dok]< u.saw)
  %-  se-dump:(se-nuke dok)
  :_  u.saw
  >[%drum-coup-fail src.bow ost.bow dok]<
::
++  take-onto                                           ::< get ack for start
  ::> recieve acknowledgment on an app being started
  ::>
  ::> way: identifies the app being started,
  ::>      encoded as /[%p]/[%tas]
  ::> saw: stack trace, if the initialization failed
  ::
  |=  {way/wire saw/(each suss:^gall tang)}
  =<  se-abet  =<  se-view
  ?>  ?=({@ @ $~} way)
  ?>  (~(has by fur) i.t.way)
  =/  wel/well:^gall  [i.way i.t.way]
  ?-  saw
    {$| *}  (se-dump p.saw)
    {$& *}  ?>  =(q.wel p.p.saw)
            ::  =.  +>.$  (se-text "live {<p.saw>}")
            +>.$(fur (~(put by fur) q.wel `[p.wel %da r.p.saw]))
  ==
::
++  quit-phat                                           ::< get link termination
  ::> called when an open console link disconnects
  ::>
  ::> way: identifies the app that disconnected,
  ::>      encoded as /[%p]/[%tas]
  ::
  |=  way/wire
  =<  se-abet  =<  se-view
  =+  dok=(drum-phat way)
  ~&  [%drum-quit src.bow ost.bow dok]
  ::
  ::REVIEW this selects a different non-dropped app,
  ::       which is not ideal
  =+  lag=se-current-app
  ?.  (~(has by fug) dok)  +>.$
  =.  +>.$  (se-text "[dropped {<dok>}, relinking]")
  =.  +>.$  ta-abet:ta-readze:(ta dok)
  ?.  &(?=(^ lag) !=(dok u.lag))
    +>.$(inx 0)
  (se-select-app u.lag)
::
::> ||
::> ||  %resolution
::> ||
::>   abet (end a transaction), and its helper arms
::+|
++  se-abet                                             ::< resolve
  ::>  marshal {eel}, {bin}, {biz}, and {mow} into a
  ::>  consolidated set of external requests
  ::
  ^-  (quip move *drum-part)
  =*  pith  +>+>+<+
  ?.  se-ably
    =.  .  se-adit
    [(flop moz) pith]
  =.  sys  ?^(sys sys `ost.bow)
  =.  .  se-subze:se-adze:se-adit
  :_  pith(bin (~(put by bin) ost.bow dev))
  %-  flop
  ^-  (list move)
  ?~  biz  moz
  :_  moz
  [ost.bow %diff %dill-blit ?~(t.biz i.biz [%mor (flop biz)])]
::
++  se-ably  (~(has by sup.bow) ost.bow)                ::< caused by console
::
++  se-adit                                             ::< update servers
  ::> start every server that wants to be up
  ::> that is not already up
  ::>
  ::> (apps in {ray} and not in {fur})
  ::
  ^+  .
  %+  roll  (~(tap in ray))
  =<  .(con +>)
  |=  {wel/well:^gall con/_..se-adit}  ^+  con
  =.  +>.$  con
  =+  hig=(~(get by fur) q.wel)
  ?:  &(?=(^ hig) |(?=($~ u.hig) =(p.wel syd.u.u.hig)))  +>.$
  =.  +>.$  (se-text "activated app {(trip p.wel)}/{(trip q.wel)}")
  %-  se-emit(fur (~(put by fur) q.wel ~))
  [ost.bow %conf [%drum p.wel q.wel ~] [our.bow q.wel] %load our.bow p.wel]
::
++  se-adze                                             ::< add new connections
  ::> connect any desired-link that is not connected
  ::>
  ::> (apps in {eel} not in {fug})
  ::
  ^+  .
  %+  roll  (~(tap in eel))
  =<  .(con +>)
  |=  {gil/dock con/_.}  ^+  con
  =.  +>.$  con
  ?:  (~(has by fug) gil)
    +>.$
  ta-abet:ta-adze:(new-ta gil)
::
++  se-subze                                            ::< del old connections
  ::> disconnect no longer desired connections
  ::
  =<  .(dev (~(got by bin) ost.bow))
  =.  bin  (~(put by bin) ost.bow dev)
  ^+  .
  %-  ~(rep by bin)
  =<  .(con +>)
  |=  {{ost/bone dev/source} con/_.}  ^+  con
  ::REVIEW this seems like it should just pass {ost}
  ::       down to se-nuke
  =+  xeno=se-subze-local:%_(con ost.bow ost, dev dev)
  xeno(ost.bow ost.bow.con, dev dev.con, bin (~(put by bin) ost dev.xeno))
::
++  se-subze-local                                      ::< nuke ost.bow apps
  ::> disconnect anything not in {eel}
  ^+  .
  %-  ~(rep by fug)
  =<  .(con +>)
  |=  {{gil/dock *} con/_.}  ^+  con
  =.  +>.$  con
  ?:  (~(has in eel) gil)
    +>.$
  (se-nuke gil)
::
::> ||
::> ||  %accessors
::> ||
::>   retrieve derived state
::+|
++  se-aint                                             ::< is app ignorable
  ::> if an app has not been connected yet, or the
  ::> connection has been cancelled, ignore
  ::> input/output from it
  ::
  ::TODO with new disconnection semantics, this might
  ::     effectively be always &
  |=  dok/dock  ^-  ?
  ?.  (~(has by bin) ost.bow)  &
  =+  gyr=(~(get by fug) dok)
  |(?=($~ gyr) !=(%liv con.u.gyr))
::
++  se-amor                                             ::< live targets
  ::> list apps which are succesfully connected
  ::
  ^-  (list dock)
  %+  skim  (~(tap in eel))
  |=(a/dock =((some %liv) (bind (~(get by fug) a) |=(target con))))
::
::> ||
::> ||  %indexing
::> ||
::>   operations on {inx}, the app selection
::+|
++  se-select-app                                       ::< recalculate index
  ::> select particular app, if connected
  ::
  ::REVIEW mutating inx in place is probably cleaner
  |=  dok/dock
  =+  [xin=0 wag=se-amor]
  |-  ^+  +>.^$
  ?~  wag  +>.^$(inx 0)
  ?:  =(i.wag dok)  +>.^$(inx xin)
  $(wag t.wag, xin +(xin))
::
++  se-next-app                                         ::< rotate index
  ::> select next connected app in ring
  ::
  =+  wag=se-amor
  ?~  wag  +
  ::  ~&  [%se-next-app inx+inx wag+wag nex+(mod +(inx) (lent se-amor))]
  +(inx (mod +(inx) (lent wag)))
::
++  se-current-app                                      ::< current dock
  ::> app selected by ^X ring, if any
  ::
  ^-  (unit dock)
  =+  wag=se-amor
  ?~  wag  ~
  `(snag inx `(list dock)`wag)
::
::> ||
::> ||  %disconnection
::> ||
::>   unlink helpers
::+|
++  se-drop                                             ::< disconnect
  ::> dok: app to unlink
  ::>
  ::> in the case of the local :dojo, reconnect
  ::> immediately, so that there is always a repl
  ::> available to manage /+drum
  ::
  |=  dok/dock
  ^+  +>
  =+  lag=se-current-app
  ?.  (~(has by fug) dok)  +>.$
  =.  ta  ta-abut:(ta dok)
  =.  +>.$  ?.  &(?=(^ lag) !=(dok u.lag))
              +>.$(inx 0)
            (se-select-app u.lag)
  =.  +>.$  (se-text "[unlinked from {<dok>}]")
  ?:  =(dok [our.bow %dojo])                            ::< undead dojo
    +>.$(eel (~(put in eel) dok))
  +>.$
::
++  se-nuke                                             ::< teardown connection
  ::> forceful drop, pull immediately
  ::
  ::REVIEW shouldn't deleting from eel alone implicitly
  ::       cause the connection to be cleaned up in
  ::       subze?
  |=  dok/dock
  ^+  +>
  =.  eel  (~(del in eel) dok)
  (se-drop:(se-pull dok) dok)
::
::> ||
::> ||  %effect
::> ||
::>   emit pokes and dill outputs
::
++  se-blit                                             ::< give output
  ::> bil: blit to queue; later consolidated into a
  ::>      single %dill-blit diff
  ::
  |=  bil/dill-blit:^dill
  +>(biz [bil biz])
::
++  se-blit-sys                                         ::< output to system
  ::> the initial connection from %dill is saved as
  ::> {sys}, used for administartive tasks like
  ::> shutting down urbit or logging to the
  ::> pier's `.urb/put/` directory
  ::
  |=  bil/dill-blit:^dill  ^+  +>
  ?~  sys  ~&(%se-blit-no-sys +>)
  (se-emit [u.sys %diff %dill-blit bil])
::
++  se-dump                                             ::< print tanks
  ::> tac: pretty-print objects to output as %out lines
  ::
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
++  se-show                                             ::< show buffer, raw
  ::> send updates for cursor position and/or buffer
  ::> contents
  ::
  |=  lin/(pair @ud stub:^dill)
  ^+  +>
  ?:  =(mir lin)  +>
  =.  +>  ?:(=(p.mir p.lin) +> (se-blit %hop (add p.lin (lent-stye:klr q.lin))))
  =.  +>  ?:(=(q.mir q.lin) +> (se-blit %pom q.lin))
  +>(mir lin)
::
++  se-just                                             ::< show adjusted buffer
  ::> lin: buffer to display. {q.lin} is cropped to
  ::> the terminal width {edg}, keeping the
  ::> cursor {p.lin} visible
  ::
  |=  lin/(pair @ud stub:^dill)
  ^+  +>
  =/  off  ?:((lth p.lin edg) 0 (sub p.lin edg))
  (se-show (sub p.lin off) (scag:klr edg (slag:klr off q.lin)))
::
++  se-view                                             ::< flush buffer
  ::> if an app is selected, sync out its input buffer
  ::
  ^+  .
  =+  gul=se-current-app
  ?:  |(?=($~ gul) (se-aint u.gul))  +
  (se-just ta-vew:(ta u.gul))
::
++  se-emit                                             ::< emit move
  ::> mov: side-effect to queue for sending
  ::
  |=  mov/move
  %_(+> moz [mov moz])
::
++  se-talk                                             ::< show in talk
  ::> display stack trace using talk if not cause by console
  ::
  ::REVIEW maybe at least use {se-blit-sys}?
  |=  tac/(list tank)
  ^+  +>
  :: XX talk should be usable for stack traces, see urbit#584 which this change
  :: closed for the problems there
  ((slog (flop tac)) +>)
  ::=-  (se-emit 0 %poke /drum/talk [our.bow %talk] -)
  ::(said:talk our.bow %drum now.bow eny.bow tac)
::
++  se-text                                             ::< return text
  ::> print message to screen, whatever that means
  ::>
  ::> usually this means sending a %out effect, but
  ::> when the message wasn't caused by a stack trace
  ::> it is still recorded
  ::>
  ::> txt: the message. sanitized if invalid @t
  ::
  |=  txt/tape
  ^+  +>
  ?.  ((sane %t) (crip txt))  :: XX upstream validation
    ~&  bad-text+<`*`txt>
    +>
  ?.  se-ably  (se-talk [%leaf txt]~)
  (se-blit %out (tuba txt))
::
++  se-poke                                             ::< send a poke
  ::> dok: target app
  ::> par: request data
  ::
  |=  {dok/dock par/pear}
  (se-emit [ost.bow %poke (drum-path dok) dok par])
::
++  se-pull                                             ::< cancel subscription
  ::> dok: target app
  ::
  |=  dok/dock
  (se-emit [ost.bow %pull (drum-path dok) dok ~])
::
++  se-sole-id  `sole-id`[1 our dap]:bow                ::< XX multiple?
::RENAMEME
::> ||
::> ||  %ta-core
::> ||
::>
++  new-ta                                              ::< initialize new app
  ::> bunt config, and use it to create a {ta} core
  ::>
  ::> dok: newly linked app
  ::
  |=  dok/dock  ^+  (ta)
  ?<  (~(has by fug) dok)
  =.  fug  (~(put by fug) dok *target)
  (ta dok)
::
++  ta                                                  ::< per target
  ::> this core is used to perform operations specific
  ::> to a {target} app
  ::>
  ::> dok: what app
  ::>
  |=  dok/dock
  =+  `target`(~(got by fug) dok)                       ::< app and state
  |%
  ::>  ||
  ::>  ||  %convenience
  ::>  ||
  ::>    minor incantations
  ::+|
  ++  ta-this    .                                      ::< self
  ++  ta-abut                                           ::< retreat
    ::>  exit {ta}, deleting connection to {dok}
    ::
    ..ta(fug (~(del by fug) dok))
  ::
  ++  ta-abet                                           ::< resolve
    ::>  exit {ta}, saving changed connection to {dok}
    ::
    ^+  ..ta
    ..ta(fug (~(put by fug) dok `target`+<))
  ::
  ++  ta-poke    |=(a/pear +>(..ta (se-poke dok a)))    ::< poke dok
  ++  ta-pull    .(..ta (se-pull dok))                  ::< pull dok
  ++  ta-peer                                           ::< peer dok
    |=  a/path
    +>(..ta (se-emit ost.bow %peer (drum-path dok) dok a))
  ::
  ::>  ||
  ::>  ||  %interfaces
  ::>  ||
  ::+|
  ::
  ++  ta-peered                                         ::< subscription ack
    ::> on succesful session {con}nection,
    ::> display "[linked]" message
    ::
    ?<  =(%liv con)
    =.  con  %liv
    =.  ta  (se-text "[linked to {<dok>}]")
    (ta-pro & %$ "<awaiting prompt> ")
  ::
  ++  ta-readze  ta-adze(con %ded)                      ::< repeer on drop
  ++  ta-adze                                           ::< send a peer
    ::> this currently resolves between the %inc- and
    ::> %sole- protocols by hardcoded app name, sending
    ::> a subscription to the appropriate path
    ::
    ::WIP merge the sole- and inc- protocols
    ?.  =(%ask q.dok)  (ta-peer /sole/(encode-id:sole se-sole-id))
    =.  sus.ses  rec.ses
    =<  (ta-peer /sole/(encode-id:sole se-sole-id)/(scot %ud sus.ses))
    ^+  .
    ?-  con
      $ded  .
      $liv  ta-pull
      $new  (ta-poke %sole-id-action se-sole-id %new)
    ==
  ::
  ++  ta-act                                            ::< send action
    ::> act: action to send to {dok}
    ::
    |=  act/sole-action
    ^+  +>
    (ta-poke %sole-id-action se-sole-id act)
  ::
  ++  ta-aro                                            ::< process arrow
    ::> key: arrow direction
    ::
    |=  key/?($d $l $r $u)
    ^+  +>
    =.  ris  ~
    ?-  key
      $l  ?:  =(0 pos.inp)  ta-bel
          +>(pos.inp (dec pos.inp))
      $r  ?:  =((lent buf.say.inp) pos.inp)
            ta-bel
          +>(pos.inp +(pos.inp))
    ::
      $u  ?:(=(0 pos.hit) ta-bel (ta-mov (dec pos.hit)))
      $d  ?.  =(num.hit pos.hit)
            (ta-mov +(pos.hit))
          ?:  =(0 (lent buf.say.inp))
            ta-bel
          (ta-hom:ta-nex %set ~)
    ==
  ::
  ++  ta-bel                                            ::< beep
    ::> send "bell" signal to terminal
    ::
    :: producing a bell interupts a deletion sequence
    .(..ta (se-blit %bel ~), q.blt ~)
  ::
  ++  ta-belt                                           ::< handle input
    ::> bet: input keystroke
    ::
    |=  bet/app-specific-belt
    ^+  +>
    ::
    ::
    ?:  &(=(%drumming q.dok) !=([%met %x] bet))
      ::TEMP this is transitional to support multiple active
      ::     /+drum instances
      (ta-poke %dill-belt bet)
    ::
    ::> save last two belts to recognize ctrl-w ctrl-w
    ::> and similar sequences
    ::
    =.  blt  [q.blt `bet]
    ::
    ?-  bet
      {$aro *}  (ta-aro p.bet)
      {$bac *}  ta-bac
      {$ctl *}  (ta-ctl p.bet)
      {$del *}  ta-del
      {$met *}  (ta-met p.bet)
      {$ret *}  (ta-act %ret ~)
      {$txt *}  (ta-txt p.bet)
    ==
  ::
  ++  ta-send-edit                                      ::< send edit
    ::> capture context for sole edit, and send it to
    ::> {dok} 
    ::
    |=  ted/sole-edit
    ^+  +>
    (ta-act %det [[his.ven.say.inp own.ven.say.inp] (sham buf.say.inp) ted])
  ::
  ++  ta-bac                                            ::< hear backspace
    ::> delete character under cursor from
    ::> reverse-i-search or buffer, sending a [%clr ~]
    ::> if the buffer is empty.
    ::
    ^+  .
    ?^  ris
      ?:  =(~ str.u.ris)
        ta-bel
      .(str.u.ris (scag (dec (lent str.u.ris)) str.u.ris))
    ?:  =(0 pos.inp)
      ?~  buf.say.inp
        (ta-act %clr ~)
      ta-bel
    (ta-hom %del (dec pos.inp))
  ::
  ++  ta-ctl                                            ::< hear control
    ::> handle ctrl key
    ::
    |=  key/@ud
    ^+  +>
    =.  ris  ?.(?=(?($g $r) key) ~ ris)
    ?+    key    ta-bel
        $a  +>(pos.inp 0)
        $b  (ta-aro %l)
        $c  ta-bel
        $d  ?^  buf.say.inp
              ta-del
            ::> talk and dojo close console on ^d
            ::> instead of actually disconnecting
            ::
            ?:  (~(has in eel:(drum-make our.bow)) dok)
              +>(..ta (se-blit qit+~))                  ::< quit pier
            +>(eel (~(del in eel) dok))                 ::< unlink app
        $e  +>(pos.inp (lent buf.say.inp))
        $f  (ta-aro %r)
        $g  ?~  ris  ta-bel
            (ta-hom(pos.hit num.hit, ris ~) [%set ~])
        $k  =+  len=(lent buf.say.inp)
            ?:  =(pos.inp len)
              ta-bel
            (ta-kil %r [pos.inp (sub len pos.inp)])
        $l  +>(..ta (se-blit %clr ~))
        $n  (ta-aro %d)
        $p  (ta-aro %u)
        $r  ?~  ris
              +>(ris `[pos.hit ~])
            ?:  =(0 pos.u.ris)
              ta-bel
            (ta-ser ~)
        $t  =+  len=(lent buf.say.inp)
            ?:  |(=(0 pos.inp) (lth len 2))
              ta-bel
            =+  sop=(sub pos.inp ?:(=(len pos.inp) 2 1))
            (ta-hom (rep:edit [sop 2] (flop (swag [sop 2] buf.say.inp))))
        $u  ?:  =(0 pos.inp)
              ta-bel
            (ta-kil %l [0 pos.inp])
        $v  ta-bel
        $w  ?:  =(0 pos.inp)
              ta-bel
            =+  sop=(ta-off %l %ace pos.inp)
            (ta-kil %l [(sub pos.inp sop) sop])
        $x  +>(..ta se-next-app)
        $y  ?:  =(0 num.kil)
              ta-bel
            (ta-hom (cat:edit pos.inp ta-yan))
    ==
  ::
  ++  ta-del                                            ::< hear delete
    ::> delete character after cursor if any
    ::
    ^+  .
    ?:  =((lent buf.say.inp) pos.inp)
      ta-bel
    (ta-hom %del pos.inp)
  ::
  ++  ta-erl                                            ::< hear local error
    ::> move cursor to error position, but not past
    ::> the end of the buffer
    ::
    |=  pos/@ud
    ta-bel(pos.inp (min pos (lent buf.say.inp)))
  ::
  ++  ta-err                                            ::< hear remote error
    ::> correct error position for pending edits
    ::
    |=  pos/@ud
    (ta-erl (~(transpose shared:sole say.inp) pos))
  ::
  ++  ta-diff-backlog                                   ::< apply backlog
    ::> tot: total number of emitted updates, including
    ::>      skipped %det
    ::> fes: list of backlog effects
    |=  {tot/@u fes/(list sole-effect)}
    ::REVIEW clarity
    =.  inp  *sole-cursor-share  :: XX proper sole share sync
    =;  nex  ?>((lte rec.ses.nex tot) nex(rec.ses tot))
    |-  ^+  ta-this
    ?~  fes  ta-this
    $(fes t.fes, ta-this (ta-diff-effect i.fes))
  ::
  ++  ta-diff-effect                                    ::< record and apply
    ::> register output, and apply it
    ::
    |=  fec/sole-effect
    =.  rec.ses  +(rec.ses)
    (ta-apply-effect fec)
  ::
  ++  ta-apply-effect                                   ::< apply effect
    ::> translate sole- output to raw dill-
    ::
    |=  fec/sole-effect
    ^+  +>
    ?-  fec
      {$bel *}  ta-bel
      {$blk *}  +>
      {$clr *}  +>(..ta (se-blit fec))
      {$det *}  +>(inp +:(~(receive cursored:sole inp) +.fec))
      {$err *}  (ta-err p.fec)
      {$klr *}  +>(..ta (se-blit %klr (make:klr p.fec)))
      {$mor *}  |-  ^+  +>.^$
                ?~  p.fec  +>.^$
                $(p.fec t.p.fec, +>.^$ ^$(fec i.p.fec))
      {$nex *}  ta-nex
      {$pro *}  (ta-pro +.fec)
      {$tan *}  +>(..ta (se-dump p.fec))
      {$sag *}  +>(..ta (se-blit fec))
      {$sav *}  +>(..ta (se-blit fec))
      {$txt *}  +>(..ta (se-text p.fec))
      {$url *}  +>(..ta (se-blit fec))
      {$say *}  +>(say.inp [[own=his his=own]:ven leg=~ buf]:p.fec)
    ==
  ::
  ++  ta-hom                                            ::< local edit
    ::> ted: local change to apply
    ::
    |=  ted/sole-edit
    ^+  +>
    =.  +>  (ta-send-edit ted)
    +>(inp (~(commit cursored:sole inp) ted))
  ::
  ++  ta-jump                                           ::< buffer pos
    ::> get cursor location after moving
    ::>
    ::> dir: either {%l}eft or {%r}ight, to the next
    ::> til: space, word boundary, or word
    ::> pos: from a given cursor position
    ::
    |=  {dir/?($l $r) til/?($ace $edg $wrd) pos/@ud}
    ^-  @ud
    %-  ?:(?=($l dir) sub add)
    [pos (ta-off dir til pos)]
  ::
  ++  ta-kil                                            ::< kill selection
    ::> remove section into kill ring
    ::> adding a new entry or appending to old one
    ::> depending on previous key event in {blt}
    ::>
    ::> dir: going {%l}eft or {%r}ight,
    ::> sel: portion of the buffer to delete
    ::
    |=  {dir/?($l $r) sel/{@ @}}
    ^+  +>
    =+  buf=(swag sel buf.say.inp)
    %.  (cut:edit sel)
    %=  ta-hom
        kil
      ?.  ?&  ?=(^ old.kil)
              ?=(^ p.blt)
              ?|  ?=({$ctl ?($k $u $w)} u.p.blt)
                  ?=({$met ?($d $bac)} u.p.blt)
          ==  ==
        %=  kil                                         ::< prepend
          num  +(num.kil)
          pos  +(num.kil)
          old  (scag max.kil `(list (list @c))`[buf old.kil])
        ==
      %=  kil                                           ::< cumulative yanks
        pos  num.kil
        old  :_  t.old.kil
             ?-  dir
               $l  (welp buf i.old.kil)
               $r  (welp i.old.kil buf)
      ==     ==
    ==
  ::
  ++  ta-met                                            ::< meta key
    ::>  handle meta key
    ::
    |=  key/@ud
    ^+  +>
    =.  ris  ~
    ?+    key    ta-bel
      $v    +>(eel (~(del in eel) our %dojo))
      $dot  ?.  &(?=(^ old.hit) ?=(^ i.old.hit))        ::< last "arg" from hist
              ta-bel
            =+  old=`(list @c)`i.old.hit
            =+  sop=(ta-jump(buf.say.inp old) %l %ace (lent old))
            (ta-hom (cat:edit pos.inp (slag sop old)))
            ::
      $bac  ?:  =(0 pos.inp)                            ::< kill left-word
              ta-bel
            =+  sop=(ta-off %l %edg pos.inp)
            (ta-kil %l [(sub pos.inp sop) sop])
            ::
      $b    ?:  =(0 pos.inp)                            ::< jump left-word
              ta-bel
            +>(pos.inp (ta-jump %l %edg pos.inp))
            ::
      $c    ?:  =(pos.inp (lent buf.say.inp))           ::< capitalize
              ta-bel
            =+  sop=(ta-jump %r %wrd pos.inp)
            %-  ta-hom(pos.inp (ta-jump %r %edg sop))
            %+  rep:edit  [sop 1]
            ^-  (list @c)  ^-  (list @)                 :: XX unicode
            (cuss `tape``(list @)`(swag [sop 1] buf.say.inp))
            ::
      $d    ?:  =(pos.inp (lent buf.say.inp))           ::< kill right-word
              ta-bel
            (ta-kil %r [pos.inp (ta-off %r %edg pos.inp)])
            ::
      $f    ?:  =(pos.inp (lent buf.say.inp))           ::< jump right-word
              ta-bel
            +>(pos.inp (ta-jump %r %edg pos.inp))
            ::
      $r    %-  ta-hom(lay.hit (~(put by lay.hit) pos.hit ~))
            :-  %set                                    ::< revert hist edit
            ?:  =(pos.hit num.hit)  ~
            (snag (sub num.hit +(pos.hit)) old.hit)
            ::
      $t    =+  a=(ta-jump %r %edg pos.inp)             ::< transpose words
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
      ?($u $l)                                          ::< upper/lower case
            ?:  =(pos.inp (lent buf.say.inp))
              ta-bel
            =+  case=?:(?=($u key) cuss cass)
            =+  sop=(ta-jump %r %wrd pos.inp)
            =+  sel=[sop (ta-off %r %edg sop)]
            %-  ta-hom
            %+  rep:edit  sel
            ^-  (list @c)  ^-  (list @)                 :: XX unicode
            (case `tape``(list @)`(swag sel buf.say.inp))
            ::
      $x    =.  ..ta  se-next-app
            =/  gil  (fall se-current-app dok)
            ?.  =(%drumming q.gil)  ..ta-ctl
            ..ta-ctl(..se-poke (se-poke gil `pear`[%dill-belt %hey ~]))
            ::
      $y    ?.  ?&  ?=(^ old.kil)                       ::< rotate & yank
                    ?=(^ p.blt)
                    ?|  ?=({$ctl $y} u.p.blt)
                        ?=({$met $y} u.p.blt)
                ==  ==
              ta-bel
            =+  las=(lent ta-yan)
            =.  pos.kil  ?:(=(1 pos.kil) num.kil (dec pos.kil))
            (ta-hom (rep:edit [(sub pos.inp las) las] ta-yan))
    ==
  ::
  ++  ta-mov                                            ::< move in history
    ::> sop: position in history to switch to
    ::
    |=  sop/@ud
    ^+  +>
    ?:  =(sop pos.hit)  +>
    %-  %=  ta-hom
          pos.hit  sop
          lay.hit  (~(put by lay.hit) pos.hit buf.say.inp)
        ==
    :-  %set
    %.  (~(get by lay.hit) sop)
    (bond |.((snag (sub num.hit +(sop)) old.hit)))
  ::
  ++  ta-nex                                            ::< add line to history
    ::> when a history entry is accepted, clear search
    ::> and edit overlay, save current buffer to {old.hit}
    ::
    ^+  .
    =.  ris  ~
    =.  lay.hit  ~
    ?:  ?|  ?=($~ buf.say.inp)
            &(?=(^ old.hit) =(buf.say.inp i.old.hit))
        ==
      .(pos.hit num.hit)
    %_  .
      num.hit  +(num.hit)
      pos.hit  +(num.hit)
      old.hit  [buf.say.inp old.hit]
    ==
  ::
  ++  ta-off                                            ::< buffer pos offset
    ::> get distance to boundary
    ::>
    ::> dir: either {%l}eft or {%r}ight, to the next
    ::> til: space, word boundary, or word, from
    ::> pos: a cursor position
    ::
    |=  {dir/?($l $r) til/?($ace $edg $wrd) pos/@ud}
    ^-  @ud
    =*  not  |*(a/rule ;~(less a next))               ::  helper
    %+  offset
        ?-  til  $ace  ;~(plug (star ace) (star (not ace)))
                 $edg  ;~(plug (star aln) (star (not aln)))
                 $wrd  (star (not aln))
        ==
    ?-  dir  $l  (flop (scag pos buf.say.inp))
             $r  (slag pos buf.say.inp)
    ==
  ::
  ++  ta-pro                                            ::< set prompt
    ::> recieve prompt, inserting ship and app title
    ::
    |=  pom/sole-prompt
    %_    +>
        pom
      %_    pom
          cad
        ;:  welp
          ?.  ?=($earl (clan:title p.dok))
            (cite:title p.dok)
          (scow %p p.dok)
        ::
          ":"
          (trip q.dok)
          cad.pom
        ==
      ==
    ==
  ::
  ++  ta-ser                                            ::< reverse search
    ::> add to incremental search buffer
    ::>
    ::> ext: text to append, usually single character
    ::
    |=  ext/(list @c)
    ^+  +>
    ?:  |(?=($~ ris) =(0 pos.u.ris))
      ta-bel
    =+  sop=?~(ext (dec pos.u.ris) pos.u.ris)
    =+  tot=(weld str.u.ris ext)
    =+  dol=(slag (sub num.hit sop) old.hit)
    =/  sup
        |-  ^-  (unit @ud)
        ?~  dol  ~
        ?^  (find tot i.dol)
          `sop
        $(sop (dec sop), dol t.dol)
    ?~  sup  ta-bel
    (ta-mov(str.u.ris tot, pos.u.ris u.sup) (dec u.sup))
  ::
  ++  ta-txt                                            ::< hear text
    ::> hear regular text, into main buffer or
    ::> reverse-i-search if active
    ::>
    ::> ext: text to append, usually single character
    ::
    |=  txt/(list @c)
    ^+  +>
    ?^  ris
      (ta-ser txt)
    (ta-hom (cat:edit pos.inp txt))
  ::
  ++  ta-vew                                            ::< computed prompt
    ::> active i-search or app prompt, followed by
    ::> input text if visible or hash if typing in a 
    ::> password etc
    ::
    ^-  (pair @ud stub:^dill)
    =;  vew/(pair (list @c) styx:^dill)
      =+  lin=(make:klr q.vew)
      :_  (welp lin [*stye:^dill p.vew]~)
      (add pos.inp (lent-char:klr lin))
    ?:  vis.pom
      ::
      ::> default prompt
      ::
      :-  buf.say.inp
      ?~  ris
        cad.pom
      :(welp "(reverse-i-search)'" (tufa str.u.ris) "': ")
    ::
    ::> hidden input
    ::
    :-  (reap (lent buf.say.inp) `@c`'*')
    %+  welp
      cad.pom
    ?~  buf.say.inp  ~
    :(welp "<" (scow %p (end 4 1 (sham buf.say.inp))) "> ")
  ::
  ++  ta-yan                                            ::< yank
    ::> current ctrl-y text from kill ring
    ::
    (snag (sub num.kil pos.kil) old.kil)
  --
::
::> ||
::> ||  %moveme
::> ||
::>   this is helper code that belongs in its own libraries
::+|
::
::MOVEME to lib/sole
++  edit                                                ::< produce sole-edits
  |%
  ++  cat                                               ::< mass insert
    ::>  pos: first position
    ::>  txt: text to insert
    ::
    |=  {pos/@ud txt/(list @c)}
    ^-  sole-edit
    :-  %mor
    |-  ^-  (list sole-edit)
    ?~  txt  ~
    [[%ins pos i.txt] $(pos +(pos), txt t.txt)]
  ::
  ++  cut                                               ::< mass delete
    ::>  pos: first position
    ::>  num: characters to delete
    ::
    |=  {pos/@ud num/@ud}
    ^-  sole-edit
    :-  %mor
    |-  ^-  (list sole-edit)
    ?:  =(0 num)  ~
    [[%del pos] $(num (dec num))]
  ::
  ++  rep                                               ::< mass replace
    ::>  combined cut and cat
    ::>
    ::>  pos: position
    ::>  num: characters to delete
    ::>  txt: characters to replace them with
    ::
    |=  {{pos/@ud num/@ud} txt/(list @c)}
    ^-  sole-edit
    :~  %mor
        (cut pos num)
        (cat pos txt)
    ==
  --
::
::MOVEME trivial helper: maybe inline, maybe extract
::       to tiny library similar to {/+time-to-id},
::       maybe just move to a "helpers" core outside
::       the app proper
++  offset                                              ::< calculate offsets
  ::>  fel: parsing {rule} that is matching characters
  ::>  inp: input whose match-length is being determined
  ::
  |=  {fel/$-(nail edge) inp/(list @)}  ^-  @ud
  q.p:(fel [0 0] inp)
--
