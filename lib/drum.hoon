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
::TODO separate agent state
::++  drum-pith  {ges/agent-state gas/guardian-state}     ::<  all drum state
++  drum-pith  {ges/agent-state gas/guardian-state}     ::<  all drum state
++  agent-state  {say/sole-share}
++  guardian-state
  ::>
  ::>  sys: used for |exit
  ::>  eel: apps we want to connect to
  ::>  ray: app desks
  ::>       TODO why is this not (map app/term desk)?
  ::>  fur: started apps
  ::>  bin: (most of the state is here) per-terminal state
  ::>       TODO move a lot of this out into fur
  ::
  $:  * ::sys/(unit bone)                                   ::< local console
      * ::eel/(set dock)                                    ::< connect to
      * ::ray/(set well:^gall)                              ::< app desks
      fur/(map dude:^gall (unit server))                ::< servers
      :: bin/(map bone source)
      bin/target                             ::< terminals
      gen/{say/sole-share}                       ::< state for agents
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
::++  kill                                                ::> kill ring
::  ::> a list of lines deleted by ctrl-u ctrl-w etc,
::  ::> available for retrieval with ctrl-y
::  ::>
::  ::> old: killed text snippets
::  ::> pos: currrent position in {old}: cycle through
::  ::>      ring with meta-y
::  ::> num: (lent old)
::  ::>      REVIEW would this really be prohibitive to
::  ::>             recalculate as necessary?
::  ::> max: kill ring limit, as per emacs defaults
::  ::
::  $:  old/(list (list @c))                              ::< entries proper
::      pos/@ud                                           ::< ring position
::      num/@ud                                           ::< number of entries
::      max/_60                                           ::< max entries
::  ==                                                    ::
::++  source                                              ::> input device
::  ::> all state for connected terminal
::  ::>
::  ::> edg: width
::  ::> off: for future sticky prompt
::  ::> kil: kill ring
::  ::> inx: currently selected app: cycle through with ^X
::  ::> fug: per-terminal per-app state
::  ::> mir: cursor position and buffer last sent to %dill
::  ::>      TODO this is sort-of derived state, and
::  ::>           should probably be in scope only for
::  ::>           long enough that {se-abet} can determine
::  ::>           whether it has changed, instead of
::  ::>           storing it permanently
::  ::>     JB: see also the $hey dill-belt, which refreshes
::  ::>     the prompt by clearing {mir}
::  ::>
::  $:  edg/_80                                           ::< terminal columns
::       off/@ud                                           ::< window offset
::      kil/kill                                          ::< kill buffer
::      {inx/@ud fug/(map dock target)}                   ::< connections
::      mir/(pair @ud stub:^dill)                         ::< mirrored terminal
::  ==                                                    ::
::++  history                                             ::> past commands
::  ::> old inputs, used for arrow up/down
::  ::>
::  ::> old: text lines
::  ::> pos: selected history entry
::  ::> num: (lent old)
::  ::>      REVIEW would this really be prohibitive to
::  ::>             recalculate as necessary?
::  ::> lay: past entries that have been revised. elements
::  ::>      are moved from {lay} to {old} once used
::  ::>
::  $:  old/(list (list @c))                              ::< entries proper
::      pos/@ud                                           ::< input position
::      num/@ud                                           ::< number of entries
::      lay/(map @ud (list @c))                           ::< editing overlay
::  ==                                                    ::
::++  search                                              ::> reverse-i-search
::  ::> reverse incremental search over {history}
::  ::> enter with ctrl-r, exist with ctrl-g
::  ::>
::  ::> pos: how many history entries have been skipped
::  ::>      REVIEW this seems to be chronological,
::  ::>             motivation unknown
::  ::> str: incrementally typed query
::  ::>
::  $:  pos/@ud                                           ::< search position
::      str/(list @c)                                     ::< search string
::  ==                                                    ::
++  target                                              ::> application target
  ::REVIEW a lot of this should be shared between
  ::       terminal connections
  ::
  ::> state maintained per application connection
  ::>
  ::> blt: store events to recognize path-dependant commands
  ::>      (ex: repeat kills accumulate, repeat yanks rotate)
  ::> ris: reverse-incremental-search if active
  ::> hit: past command lines
  ::> pom: line prefix identifying target app
  ::> inp: shared buffer state, user enters text and
  ::>      connected app corrects/rejects syntax errors
  ::> ses: WIP %inc- persistent connection state
  ::> con: link is %new, then {%liv}e, occasionally %ded
  ::
  $:  :: $=  blt                                           ::< command sequence
      ::   %+  pair                                        ::
      ::     (unit dill-belt:^dill)                        ::< previous event
      ^ :: (unit dill-belt:^dill)                          ::< current event
      * ::ris/(unit search)                                 ::< reverse-i-search
      * ::hit/history                                       ::< all past input
      * ::pom/sole-prompt                                   ::< static prompt
      ::inp/sole-cursor-share                             ::< input state
      {@ say/sole-share}                                  ::< input state
      ^ ::ses/ses-data                                  ::< WIP %inc- client
      nil/?  ::TEMPORARY corresponds to !(~(has by fug))
      con/_`?($new $liv $ded)`%new                      ::< subscription state
  ==                                                    ::
::
::TODO unify with sole-id
++  session  {@u dock}                                  ::< always [0 our dap]
::++  ses-data                                            ::> WIP, RENAMEME
::  ::> sus: seqn of current outbound subscription
::  ::> rec: counter of received bumps
::  ::
::  {sus/@u rec/@u}
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
++  side-effect
  $%  {$bel $~}                                         ::< beep
      {$blk p/@ud q/@c}                                 ::< blink+match char at
      {$clr $~}                                         ::< clear screen
      {$klr p/styx:^dill}                               ::< styled text line
      {$sag p/path q/*}                                 ::< save to jamfile
      {$sav p/path q/@}                                 ::< save to file
      {$tan p/(list tank)}                              ::< classic tank
  ::  {$taq p/tanq}                                     ::< modern tank
      {$txt p/tape}                                     ::< text line
      {$url p/@t}                                       ::< activate url
  ==                                                    ::
++  mutating-effect
  $%  {$det sole-change}                                ::< edit command
      {$err p/@ud}                                      ::< error point
      {$nex $~}                                         ::< save clear command
      {$say p/sole-share}                               ::< reset buffer
      {$pro sole-prompt}                                ::< set prompt
  ==
++  typecheck2
  `sole-effect`*?(side-effect mutating-effect {$mor (list sole-effect)})
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
  *drum-part
  ::|^  ^-  drum-part
  ::    %*  .  *drum-part
  ::      eel  deft-fish
  ::      ray  deft-apps
  ::    ==
  ::::
  ::::++  deft-fish                                           ::< default connects
  ::::  ::> apps to connect to by default: talk, dojo
  ::::  ::>
  ::::  ::> if on a moon, use parent's talk instead of own
  ::::  ::
  ::::  %-  ~(gas in *(set dock))
  ::::  ^-  (list dock)
  ::::  ?:  ?=($earl (clan:title our))
  ::::    [[(sein:title our) %talk] [our %dojo] ~]
  ::::  [[our %talk] [our %dojo] ~]
  ::::
  ::++  deft-apps                                           ::< default servers
  ::  ::> apps to start by default: talk, dojo
  ::  ::>
  ::  ::> if on a comet, use %base instead of %home;
  ::  ::> if on a moon, don't start local %talk
  ::  ::
  ::  %-  ~(gas in *(set well:^gall))
  ::  ^-  (list well:^gall)
  ::  =+  myr=(clan:title our)
  ::  ?:  ?=($pawn myr)
  ::    [[%base %talk] [%base %dojo] ~]
  ::  ?:  ?=($earl myr)
  ::    [[%home %dojo] ~]
  ::  [[%home %talk] [%home %dojo] ~]
  ::--
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
|%
++  agent-to-guardian
  $%  {$sole p/sole-id-action}
  ==
++  guardian-to-agent
  $%  {$sole-change p/sole-change}
      {$side-effect p/side-effect}
      {$prompt-update p/(pair @ud stub:^dill)}
  ==
--

::> ||
::> ||  %app
::> ||
::>   event + state -> reactions + state
::>
|%
++  agent
  =>  ::>  ||
      ::>  ||  %interface-types
      ::>  ||
      ::
      |%
      ++  lime                                            ::> typed diff
        $%  {$dill-blit dill-blit:^dill}                  ::< screen or buf update
        ==                                                ::
      ++  card                                            ::> general card
        $%  {$diff lime}                                  ::< give update
        ==                                                ::
      ++  move  (pair bone card)                          ::< user-level move
      --
  =|  {mov/(list move) out/(list agent-to-guardian) biz/(list dill-blit:^dill)}
  |_  {bow/bowl:^gall agent-state}
  ++  abet
    ^-  {(list dill-blit:^dill) (list move) (list agent-to-guardian) agent-state}
    ::=>  emit-biz
    [biz mov out +<+]
  ::
  ++  emit  |=(mow/move %_(+> mov [mow mov]))
  ++  emit-biz
    %_    .
        biz  ~
        mov
      ?~  biz  mov
      :_  mov
      [ost.bow %diff %dill-blit ?~(t.biz i.biz [%mor (flop biz)])]
    ==
  ::
  ++  do-blit                                             ::< give output
    ::> bil: blit to queue; later consolidated into a
    ::>      single %dill-blit diff
    ::REVIEW still less consolidated than a drum-wide one
    |=(bil/dill-blit:^dill +>(biz [bil biz]))
  ::
  ++  ring-bell  (do-blit %bel ~)
  ::+|
  ++  output  |=(a/agent-to-guardian +>(out [a out]))
  ++  do-action  |=(a/sole-action (output %sole our-sole-id a))
  ++  our-sole-id  `sole-id`[2 our dap]:bow                ::< XX multiple?
  ::+|
  ++  caused-by-console  (~(has by sup.bow) ost.bow)                ::< caused by console
  ::+|
  ++  print-tanks                                             ::< print tanks
    ::> tac: pretty-print objects to output as %out lines
    ::
    |=  tac/(list tank)
    ^+  +>
    ?.  caused-by-console  (show-in-talk tac)
    =/  wol/wall
      (zing (turn (flop tac) |=(a/tank (~(win re a) [0 120]))))
    |-  ^+  +>.^$
    ?~  wol  +>.^$
    ?.  ((sane %t) (crip i.wol))  :: XX upstream validation
      ~&  bad-text+<`*`i.wol>
      $(wol t.wol)
    $(wol t.wol, +>.^$ (do-blit %out (tuba i.wol)))
  ::
  ++  print-text                                          ::< return text
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
    ?.  caused-by-console  (show-in-talk [%leaf txt]~)
    (do-blit %out (tuba txt))
  ::
  ++  show-in-talk                                          ::< show in talk
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
  ++  local-edit                                       ::< local edit
    ::> ted: local change to apply
    ::
    |=  ted/sole-edit
    ^+  +>
    ::=^  det  say  (~(transmit cursored:sole inp) ted)
    =^  det  say  (~(transmit shared:sole say) ted)
    (do-action %det det)
  ::+|
  ::
  ++  from-guardian
    |=  gug/guardian-to-agent  ^+  +>
    ?-  -.gug
      $sole-change  +>(say +:(~(receive shared:sole say) p.gug))
      $side-effect  (do-effect p.gug)
      $prompt-update  (update-prompt p.gug)
    ==
  ::
  ++  update-prompt                                           ::< show buffer, raw
    ::> send updates for cursor position and/or buffer
    ::> contents
    ::
    |=  lin/(pair @ud stub:^dill)
    ^+  +>
    ::?:  =(mir lin)  +>
    ::=.  +>  ?:(=(p.mir p.lin) +> (se-blit %hop (add p.lin (lent-stye:klr q.lin))))
    ::=.  +>  ?:(=(q.mir q.lin) +> (se-blit %pom q.lin))
    ::+>(mir lin)
    ::
    (do-blit %mor [%pom q.lin] [%hop (add p.lin (lent-stye:klr q.lin))] ~)
  ::
  ++  do-effect
    |=  fec/side-effect  ^+  +>
    ?-  fec
      {$bel *}  ring-bell
      {$blk *}  +>
    ::
      {$sag *}  (do-blit fec)
      {$sav *}  (do-blit fec)
      {$url *}  (do-blit fec)
      {$clr *}  (do-blit fec)
    ::
      {$klr *}  (do-blit %klr (make:klr p.fec))
      {$tan *}  (print-tanks p.fec)
      {$txt *}  (print-text p.fec)
    ==
  ::
  ++  poke-belt                                      ::< terminal event
    ::> process keystroke
    ::>
    ::> bet: the character, key, or modified-key
    ::
    |=  bet/dill-belt:^dill  ^+  +>
    ?:  ?=(?($cru $hey $rez $yow) -.bet)
      (poke-window-control bet)
    (process-input bet)
  ::
  ++  poke-window-control
    |=  bet/control-belt  ^+  +>
    ?-  bet
      {$cru *}  (print-tanks:(print-text (trip p.bet)) q.bet)
      {$hey *}  +> ::+>(mir [0 ~])                             ::< refresh
      {$rez *}  +> ::+>(edg (dec p.bet))                       ::< resize window
      {$yow *}  ~&([%no-yow -.bet] +>)
    ==
  ::
  ++  process-input
    |=  bet/app-specific-belt  ^+  +>
    =<  ?+  -.bet  ring-bell ::TODO handle all
          $ret  (do-action %ret ~)
          $txt  (hear-text p.bet)
          $bac  backspace
          $ctl  (key-ctl p.bet)
        ==
    |%
    ++  hear-text                                            ::< hear text
      ::> hear regular text, into main buffer or
      ::> reverse-i-search if active
      ::>
      ::> ext: text to append, usually single character
      ::
      |=  txt/(list @c)
      ^+  +>.^$
      ::?^  ris
      ::  (ta-ser txt)
      ::(local-edit (cat:block:sole pos.inp txt))
      (local-edit (cat:block:sole (lent buf.say) txt))
    ::
    ++  backspace                                            ::< hear backspace
      ::> delete character under cursor from
      ::> reverse-i-search or buffer, sending a [%clr ~]
      ::> if the buffer is empty.
      ::
      ^+  ..process-input
      ::?^  ris
      ::  ?:  =(~ str.u.ris)
      ::    ta-bel
      ::  .(str.u.ris (scag (dec (lent str.u.ris)) str.u.ris))
      ::?:  =(0 pos.inp)
      ::  ?~  buf.say.inp
      ::    (ta-act %clr ~)
      ::  ta-bel
      ::(ta-hom %del (dec pos.inp))
      ?~  buf.say
        (do-action %clr ~)
      (local-edit %del (dec (lent buf.say)))
    ++  key-ctl                                            ::< hear control
      ::> handle ctrl key
      ::
      |=  key/@ud
      ^+  ..process-input
      ::=.  ris  ?.(?=(?($g $r) key) ~ ris)
      ?+    key    ring-bell
          ::$a  +>(pos.inp 0)
          ::$b  (ta-aro %l)
          $c  ring-bell
          ::$d  ?^  buf.say.inp
          ::    ta-del
          ::    > talk and dojo close console on ^d
          ::    > instead of actually disconnecting
          ::
          ::    ?:  (~(has in eel:(drum-make our.bow)) dok)
          ::      +>(..ta (se-blit qit+~))                  ::< quit pier
          ::    +>(eel (~(del in eel) dok))                 ::< unlink app
          $d  (do-blit qit+~)                               ::< quit pier
          ::$e  +>(pos.inp (lent buf.say.inp))
          ::$f  (ta-aro %r)
          ::$g  ?~  ris  ring-bell
          ::    (ta-hom(pos.hit num.hit, ris ~) [%set ~])
          ::$k  =+  len=(lent buf.say.inp)
          ::    ?:  =(pos.inp len)
          ::      ring-bell
          ::    (ta-kil %r [pos.inp (sub len pos.inp)])
          $l  (do-blit %clr ~)
          ::$n  (ta-aro %d)
          ::$p  (ta-aro %u)
          ::$r  ?~  ris
          ::      +>(ris `[pos.hit ~])
          ::    ?:  =(0 pos.u.ris)
          ::      ring-bell
          ::    (ta-ser ~)
          ::$t  =+  len=(lent buf.say.inp)
          ::    ?:  |(=(0 pos.inp) (lth len 2))
          ::      ring-bell
          ::    =+  sop=(sub pos.inp ?:(=(len pos.inp) 2 1))
          ::    (ta-hom (rep:block:sole [sop 2] (flop (swag [sop 2] buf.say.inp))))
          ::$u  ?:  =(0 pos.inp)
          ::      ring-bell
          ::    (ta-kil %l [0 pos.inp])
          $v  ring-bell
          ::$w  ?:  =(0 pos.inp)
          ::      ring-bell
          ::    =+  sop=(ta-off %l %ace pos.inp)
          ::    (ta-kil %l [(sub pos.inp sop) sop])
          ::$x  +>(..ta se-next-app)
          ::$y  ?:  =(0 num.kil)
          ::      ring-bell
          ::    (ta-hom (cat:block:sole pos.inp ta-yan))
      ==
    --
  --
::
++  guardian
  =>  ::>  ||
      ::>  ||  %interface-types
      ::>  ||
      ::
      |%
      ++  pear                                            ::> request (poke)
        $%  {$sole-id-action p/sole-id-action}            ::< buffer update
        ==                                                ::
      ++  lime                                            ::> typed diff
        _!!
  ::       $%  {$sole-effect sole-effect}                  ::< console changes
  ::       ==                                                ::
      ++  card                                            ::> general card
        $%  {$conf wire dock $load ship term}             ::< configure app
            {$diff lime}                                  ::< give update
            {$peer wire dock path}                        ::< subscribe
            {$poke wire dock pear}                        ::< send message
::             {$pull wire dock $~}                          ::< unsubscribe
        ==                                                ::
      ++  move  (pair bone card)                          ::< user-level move
      --
  =|  {mov/(list move) out/(list guardian-to-agent)}
  |_  {bow/bowl:^gall guardian-state}
  ++  abet
    ^-  {(list move) (list guardian-to-agent) guardian-state}
    ~|  [buf.say.bin buf.say.gen]
    ?>  =(buf.say.bin buf.say.gen)  ::REVIEW necessary?
    [mov out +<+]
  ::
  ++  emit  |=(mow/move %_(+> mov [mow mov]))
  ::+|
  ::REVIEW pubsub? things might get more interesting with multiple agents
  ++  output  |=(a/guardian-to-agent +>(out [a out]))
  ++  print-text  |=(txt/tape (output %side-effect %txt txt))
  ::+|
  ::++  show-cropped                                             ::< show adjusted buffer
  ::  ::> lin: buffer to display. {q.lin} is cropped to
  ::  ::> the terminal width {edg}, keeping the
  ::  ::> cursor {p.lin} visible
  ::  ::
  ::  |=  lin/(pair @ud stub:^dill)
  ::  ^+  +>
  ::  =.  off  ?:((lth p.lin edg) 0 (sub p.lin edg))
  ::  (show-raw-prompt (sub p.lin off) (scag:klr edg (slag:klr off q.lin)))
  ::
  ++  show-raw-prompt                                           ::< show buffer, raw
    ::> send updates for cursor position and/or buffer
    ::> contents
    ::
    |=  lin/(pair @ud stub:^dill)
    ^+  +>
    ::?:  =(mir lin)  +>
    ::=.  +>  ?:(=(p.mir p.lin) +> (se-blit %hop (add p.lin (lent-stye:klr q.lin))))
    ::=.  +>  ?:(=(q.mir q.lin) +> (se-blit %pom q.lin))
    ::+>(mir lin)
    ::
    (output %prompt-update lin)
  ::+|
  ++  connect  |=(dok/dock abet:connect:(ta dok))    ::< connect
  ++  peered  |=(dok/dock abet:peered:(ta dok))      ::< peered
  ++  diff-backlog                                   ::< apply backlog
    ::> tot: total number of emitted updates, including
    ::>      skipped %det
    ::> fes: list of backlog effects
    |=  {dok/dock tot/@u fes/(list sole-effect)}
    abet:(diff-backlog:(ta dok) tot fes)
  ::
  ++  diff-effect                                    ::< record and apply
    ::> register output, and apply it
    ::
    |=  {dok/dock fec/sole-effect}
    abet:(diff-effect:(ta dok) fec)
  ::
  ++  flush-buffer
    ^+  .
    =+  gul=current-app
    ?:  |(?=($~ gul) (invisible-app u.gul))  +
    ::(show-cropped computed-prompt:(ta u.gul))
    (show-raw-prompt computed-prompt:(ta u.gul))
  ::
  ++  from-agent
    |=  agg/agent-to-guardian  ^+  +>
    abet:(from-agent:(ta our %dojo) agg)
  ::+|
  ++  invisible-app                                     ::< is app ignorable
    ::> if an app has not been connected yet, or the
    ::> connection has been cancelled, ignore
    ::> input/output from it
    ::
    ::TODO with new disconnection semantics, this might
    ::     effectively be always &
    |=  dok/dock  ^-  ?
    ::?.  (~(has by bin) ost.bow)  &
    ::=+  gyr=(~(get by fug) dok)
    ::|(?=($~ gyr) !=(%liv con.u.gyr))
    !=(%liv con:(ta dok))
  ::
  ++  current-app                                      ::< current dock
    ::> app selected by ^X ring, if any
    ::
    ^-  (unit dock)
    `[our %dojo]
    ::=+  wag=se-amor
    ::?~  wag  ~
    ::`(snag inx `(list dock)`wag)
  ::
  ++  our-sole-id  `sole-id`[1 our dap]:bow                ::< XX multiple?
  ::+|
  ++  ta                                                  ::< per target
    ::> this core is used to perform operations specific
    ::> to a {target} app
    ::>
    ::> dok: what app
    ::>
    |=  dok/dock
    ::=+  `target`(~(got by fug) dok)                       ::< app and state
    =+  `target`bin                       ::< app and state
    |%
    ::>  ||
    ::>  ||  %convenience
    ::>  ||
    ::>    minor incantations
    ::+|
    ++  abet                                           ::< resolve
      ::>  exit {ta}, saving changed connection to {dok}
      ::..ta(fug (~(put by fug) dok `target`+<))
      ..ta(bin +<)
    ++  this  .
    ::
    ::+|
    ++  computed-prompt                                      ::< computed prompt
      ::> active i-search or app prompt, followed by
      ::> input text if visible or hash if typing in a
      ::> password etc
      ::
      ^-  (pair @ud stub:^dill)
      =/  lin/stub:^dill  [[~ ~ %b] (tuba "> ")]~
      :_  (welp lin [*stye:^dill buf.say]~)
      (add (lent buf.say) (lent-char:klr lin))
      ::=;  vew/(pair (list @c) styx:^dill)
      ::  =+  lin=(make:klr q.vew)
      ::  :_  (welp lin [*stye:^dill p.vew]~)
      ::  (add pos.inp (lent-char:klr lin))
      ::?:  vis.pom
      ::  ::
      ::  ::> default prompt
      ::  ::
      ::  :-  buf.say.inp
      ::  ::?~  ris
      ::  ::  cad.pom
      ::  :::(welp "(reverse-i-search)'" (tufa str.u.ris) "': ")
      ::  cad.pom
      ::::
      ::::> hidden input
      ::::
      :::-  (reap (lent buf.say.inp) `@c`'*')
      ::%+  welp
      ::  cad.pom
      ::?~  buf.say.inp  ~
      :::(welp "<" (scow %p (end 4 1 (sham buf.say.inp))) "> ")
    ::
    ::+|
    ::
    ::>  ||
    ::>  ||  %interfaces
    ::>  ||
    ::+|
    ::
    ++  peered                                         ::< subscription ack
      ::> on successful session {con}nection,
      ::> display "[linked]" message
      ::
      ~&  ta+peered+dok
      ~?  =(%liv con)
        ta+connection-succeeded-again+con
      =.  con  %liv
      =.  ta  (print-text "[linked to {<dok>}]")
      ?.  =(%new con)  .
      ::(ta-pro & %$ "<awaiting prompt> ")
      .
    ::
    ++  disconnect  .(con %ded)                         ::< disconnect
    ++  connect                                         ::< send a peer
      ::> this currently resolves between the %inc- and
      ::> %sole- protocols by hardcoded app name, sending
      ::> a subscription to the appropriate path
      ::
      ::WIP merge the sole- and inc- protocols
      ~&  [%ta-adze dok con]
      ::=.  sus.ses  rec.ses
      ::=<  (ta-peer /sole/(encode-id:sole our-sole-id)/(scot %ud sus.ses))
      =<  (send-peer /sole/(encode-id:sole our-sole-id)/0)
      ^+  .
      ?-  con
        $ded  .
        $liv  ~|(%ta-pull !!)
        ::$liv  ta-pull
        $new  (send-poke %sole-id-action our-sole-id %new)
      ==
    ::
    ++  diff-backlog                                   ::< apply backlog
      ::> tot: total number of emitted updates, including
      ::>      skipped %det
      ::> fes: list of backlog effects
      |=  {tot/@u fes/(list sole-effect)}
      ::REVIEW clarity
      ::=/  buf  buf.say.inp
      =/  buf  buf.say
      ::=.  inp  *sole-cursor-share
      =.  say  *sole-share
      =.  this  (local-edit %set buf)   :: XX cleaner sole share sync?
      ::=;  nex  ?>((lte rec.ses.nex tot) nex(rec.ses tot))
      |-  ^+  this
      ?~  fes  this
      $(fes t.fes, this (diff-effect i.fes))
    ::
    ++  diff-effect                                    ::< record and apply
      ::> register output, and apply it
      ::
      |=  fec/sole-effect
      ::=.  rec.ses  +(rec.ses)
      (apply-effect fec)
    ::
    ++  apply-effect                                   ::< apply effect
      ::> translate sole- output to raw dill-
      ::
      |=  fec/sole-effect  ^+  +>
      ::TODO optimize: split into side and mutating effects
      ?:  ?=($mor -.fec)
        ?~(p.fec +> $(p.fec t.p.fec, +> $(fec i.p.fec)))
      ?.  ?=(?($det $err $nex $say $pro) -.fec)
        +>(..ta (output %side-effect fec))
      ?-  fec
        {$det *}
           :: =^  det  inp  (~(receive cursored:sole inp) +.fec))
           =^  det  say  (~(receive shared:sole say) +.fec)
           =^  soc  say.gen  (~(transmit shared:sole say.gen) det)
           +>.$(..ta (output %sole-change soc))
        ::
        ::{$err *}  (ta-err p.fec)
        {$err *}  +>(..ta (output %side-effect bel+~))
        ::{$nex *}  ta-nex
        {$nex *}  +>
        ::{$pro *}  (ta-pro +.fec)
        {$pro *}  +>
        {$say *}  +>(say [[own=his his=own]:ven leg=~ buf]:p.fec)
      ==
    ::
    ++  from-agent
      |=  agg/agent-to-guardian  ^+  +>
      ?-  -.agg
        $sole  (agent-sole p.agg)
      ==
    ::
    ++  local-edit                                       ::< local edit
      ::> ted: local change to apply
      ::
      |=  ted/sole-edit
      ^+  +>
      ::=^  det  say  (~(transmit cursored:sole inp) ted)
      =^  det  say  (~(transmit shared:sole say) ted)
      =^  soc  say.gen  (~(transmit shared:sole say.gen) ted)
      =.  ..ta  (output %sole-change soc)
      (send-action %det det)
    ::
    ++  agent-sole
      |=  sol/sole-id-action
      ::TODO use id
      ?@  q.sol  !! ::TODO new sessions
      ?-  -.q.sol
        $ret  (send-action q.sol)
        $clr  (send-action q.sol)
        $det  (agent-change +.q.sol)
      ==
    ::
    ++  agent-change
      ::> soc: local change to apply
      |=  soc/sole-change
      ^+  +>
      =^  ted  say.gen  (~(receive shared:sole say.gen) soc)
      ::=^  det  say  (~(transmit cursored:sole inp) ted)
      =^  det  say  (~(transmit shared:sole say) ted)
      (send-action %det det)
    ::
    ::
    ::+|
    ++  send-action                                            ::< send action
      ::> act: action to send to {dok}
      ::
      |=  act/sole-action
      ^+  +>
      (send-poke %sole-id-action our-sole-id act)
    ++  send-poke                                             ::< send a poke
      ::> par: request data
      ::
      |=  par/pear
      +>(..ta (emit [ost.bow %poke (drum-path dok) dok par]))
    ::++  send-pull                                         ::< pull dok
    ::  .(..ta (emit ost.bow %pull (drum-path dok)))
    ++  send-peer                                           ::< peer dok
      |=  a/path
      +>(..ta (emit [ost.bow %peer (drum-path dok) dok a]))
    --
  --
--
=>  ::>  ||
    ::>  ||  %interface-types
    ::>  ||
    ::
    |%
    ++  pear                                            ::> request (poke)
      $%  {$sole-id-action p/sole-id-action}            ::< buffer update
          ::{$talk-command command:talk}                ::< render stack trace
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
|=  {bow/bowl:^gall drum-part}                          ::  main drum work
::  new subscriptions default empty
::=+  (fall (~(get by bin) ost.bow) *source)
=*  pith  +<+
=+  bin.gas
=*  dev  -
::> ||
::> ||  %door
::> ||
::>   more convenient lexical environment within %app
::
=|  biz/(list dill-blit:^dill)  ::FIXME only agent should know about blits
|_  moz/(list move)
::
::>  ||
::>  ||  %multitude
::>  ||
::>    subcore interfaces
::+|
++  run-agent  `_agent`~(. agent bow ges)
++  run-guardian  ~(. guardian bow gas(bin dev))
++  abet-agent
  |=  age/_agent
  =+  ^-  $:  bil/(list dill-blit:^dill)
              mov/(list move)
              out/(list agent-to-guardian)
              ges/agent-state
          ==
      abet:age
  ^+  +>.$
  =.  ^ges  ges
  =.  biz  (welp bil biz)
  =.  moz  (welp mov moz)
  |-  ^+  +>.^$
  ?~  out  +>.^$
  %_  $
    +>.^$  (abet-guardian (from-agent:run-guardian i.out))
    out  t.out
  ==
::
++  abet-guardian
  |=  ran/_guardian
  =+  ^-  {mov/(list move) out/(list guardian-to-agent) gas/guardian-state}
      abet:ran
  ^+  +>.$
  =.  ^gas  gas
  =.  dev  bin.gas
  =.  moz  (welp mov moz)
  |-  ^+  +>.^$
  ?~  out  +>.^$
  %_  $
    +>.^$  (abet-agent (from-guardian:run-agent i.out))
    out  t.out
  ==
::
++  wrap-agent
  =>  v=.
  =+  run-agent.v
  |*  a/$-(* _agent)
  |=  _+<.a  ^+  v
  (abet-agent.v (a +<))
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
  (abet-guardian (diff-backlog:run-guardian dok tot fec))
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
  (abet-guardian (diff-effect:run-guardian dok fec))
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
++  poke-dill-belt                                      ::< terminal event
  ::> process keystroke
  ::>
  ::> bet: the character, key, or modified-key
  ::
  |=  bet/dill-belt:^dill
  =<  se-abet  =<  se-view
  (abet-agent (poke-belt:run-agent bet))
  ::?:  ?=(?($cru $hey $rez $yow) -.bet)
  ::  (abet-agent (poke-window-control:run-agent bet))
  ::=+  gul=se-current-app
  ::?:  |(?=($~ gul) (se-aint u.gul))
  ::  (se-blit %bel ~)
  ::ta-abet:(ta-belt:(ta u.gul) bet)
  ::
::
:: ++  poke-start                                          ::< |start %app
::   ::> init an app using gall, and link to its console
::   ::
::   |=  wel/well:^gall
::   =<  se-abet  =<  se-view  ^+  +>
::   ::?:  (~(has in ray) wel)
::   ::  (se-text "[already running {<p.wel>}/{<q.wel>}]")
::   ::%=  +>
::   ::  ray  (~(put in ray) wel)
::   ::  eel  (~(put in eel) [our.bow q.wel])
::   ::==
::
:: ++  poke-link                                           ::< |link %app, connect
::   ::> connnect to an app's console
::   ::
::   |=  dok/dock
::   ::=<  se-abet  =<  se-view
::   ::+>(eel (~(put in eel) dok))
:: ::
:: ++  poke-unlink                                         ::< |unlink %app, close
::   ::> disconnnect from an app's console
::   ::
::   |=  dok/dock
::   ::=<  se-abet  =<  se-view
::   ::+>(eel (~(del in eel) dok))
:: ::
:: ++  poke-exit                                           ::< |exit, shutdown urbit
::   ::> shutdown running urbit instance
::   ::
::   |=  $~
::   ::se-abet:(se-blit-sys `dill-blit:^dill`[%qit ~])
:: ::
:: ++  poke-put                                            ::< write file
::   ::> write a text file to the pier's `.urb/put`
::   ::> directory
::   ::
::   |=  {pax/path txt/@}
::   ::se-abet:(se-blit-sys [%sav pax txt])
::
++  reap-phat                                           ::< get ack for connection
  ::> receive acknowledgment on an app connection
  ::>
  ::> way: identifies the app being connected to,
  ::>      encoded as /[%p]/[%tas]
  ::> saw: stack trace, if the connection failed
  ::
  |=  {way/wire saw/(unit tang)}
  =<  se-abet  =<  se-view  ^+  +>
  =+  dok=(drum-phat way)
  ?~  saw
    (abet-guardian (peered:run-guardian dok))
  (mean >%drum-reap-fail< u.saw)
  ::(se-dump:(se-nuke dok) u.saw)
::
++  take-coup-phat                                      ::< get ack for poke
  ::> receive acknowledgment on an app command
  ::>
  ::> way: identifies the app being commanded,
  ::>      encoded as /[%p]/[%tas]
  ::> saw: stack trace, if the command failed
  ::
  |=  {way/wire saw/(unit tang)}
  =<  se-abet  =<  se-view  ^+  +>
  ?~  saw  +>
  =+  dok=(drum-phat way)
  ?:  (se-aint dok)  +>.$
  (mean >[%drum-coup-fail src.bow ost.bow dok]< u.saw)
  ::%-  se-dump:(se-nuke dok)
  :::_  u.saw
  ::>[%drum-coup-fail src.bow ost.bow dok]<
::
++  take-onto                                           ::< get ack for start
  ::> receive acknowledgment on an app being started
  ::>
  ::> way: identifies the app being started,
  ::>      encoded as /[%p]/[%tas]
  ::> saw: stack trace, if the initialization failed
  ::
  |=  {way/wire saw/(each suss:^gall tang)}
  =<  se-abet  =<  se-view
  ?>  ?=({@ @ $~} way)
  ?>  (~(has by fur.gas) i.t.way)
  =/  wel/well:^gall  [i.way i.t.way]
  ?-  saw
    {$| *}  (se-dump p.saw)
    {$& *}  ?>  =(q.wel p.p.saw)
            ::  =.  +>.$  (se-text "live {<p.saw>}")
            +>.$(fur.gas (~(put by fur.gas) q.wel `[p.wel %da r.p.saw]))
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
  ^+(+> !!)
  ::=+  lag=se-current-app
  ::?.  (~(has by fug) dok)  +>.$
  ::=.  +>.$  (se-text "[dropped {<dok>}, relinking]")
  ::=.  +>.$  ta-abet:ta-adze:ta-drop:(ta dok)
  ::?.  &(?=(^ lag) !=(dok u.lag))
  ::  +>.$(inx 0)
  ::(se-select-app u.lag)
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
  ?.  caused-by-console:run-agent
    =.  .  se-adit
    [(flop moz) pith]
  ::=.  sys  ?^(sys sys `ost.bow)
  =.  .  se-subze:se-adze:se-adit
  :::_  pith(bin (~(put by bin) ost.bow dev))
  ::FIXME only agent should know about blits
  :_  pith(bin.gas dev)
  %-  flop
  ^-  (list move)
  ?~  biz  moz
  :_  moz
  [ost.bow %diff %dill-blit ?~(t.biz i.biz [%mor (flop biz)])]
::
++  se-adit                                             ::< update servers
  ::> start every server that wants to be up
  ::> that is not already up
  ::>
  ::> (apps in {ray} and not in {fur})
  ::
  ^+  .
  ::%+  roll  (~(tap in ray))
  ::=<  .(con +>)
  ::|=  {wel/well:^gall con/_..se-adit}  ^+  con
  ::=.  +>.$  con
  =/  wel/well:^gall  [%home %dojo]
  =+  hig=(~(get by fur.gas) q.wel)
  ?:  &(?=(^ hig) |(?=($~ u.hig) =(p.wel syd.u.u.hig)))  ..se-adit
  =.  ..se-adit  (se-text "activated app {(trip p.wel)}/{(trip q.wel)}")
  %-  se-emit(fur.gas (~(put by fur.gas) q.wel ~))
  [ost.bow %conf [%drum p.wel q.wel ~] [our.bow q.wel] %load our.bow p.wel]
::
++  se-adze                                             ::< add new connections
  ::> connect any desired-link that is not connected
  ::>
  ::> (apps in {eel} not in {fug})
  ::
  ^+  .
  ::%+  roll  (~(tap in eel))
  ::=<  .(con +>)
  ::|=  {dok/dock con/_.}  ^+  con
  ::=.  +>.$  con
  =/  dok  [our %dojo]
  ::?:  (~(has by fug) dok)
  ::  ?.  =(%ded con:(~(got by fug) dok))
  ::    ..se-adze
  ::  ta-abet:ta-adze:(ta dok)
  ::ta-abet:ta-adze:(new-ta dok)
  ?:  nil.dev
    =.  nil.dev  |
    (abet-guardian (connect:run-guardian dok))
  ?:  =(%ded con.dev)
    ~&  se-adze-ded+[dok]
    (abet-guardian (connect:run-guardian dok))
  ..se-adze
::
++  se-subze                                            ::< del old connections
  .
  ::::> disconnect no longer desired connections
  ::::
  ::=<  .(dev (~(got by bin) ost.bow))
  ::=.  bin  (~(put by bin) ost.bow dev)
  ::^+  .
  ::%-  ~(rep by bin)
  ::=<  .(con +>)
  ::|=  {{ost/bone dev/source} con/_.}  ^+  con
  ::::REVIEW this seems like it should just pass {ost}
  ::::       down to se-nuke
  ::=+  xeno=se-subze-local:%_(con ost.bow ost, dev dev)
  ::xeno(ost.bow ost.bow.con, dev dev.con, bin (~(put by bin) ost dev.xeno))
::
::++  se-subze-local                                      ::< nuke ost.bow apps
::  ::> disconnect anything not in {eel}
::  ^+  .
::  %-  ~(rep by fug)
::  =<  .(con +>)
::  |=  {{dok/dock *} con/_.}  ^+  con
::  =.  +>.$  con
::  ?:  (~(has in eel) dok)
::    +>.$
::  (se-nuke dok)
::
::> ||
::> ||  %accessors
::> ||
::>   retrieve derived state
::+|
++  se-aint   invisible-app:run-guardian  ::DEPRECATED
::
::++  se-amor                                             ::< live targets
::  ::> list apps which are successfully connected
::  ::
::  ^-  (list dock)
::  ?.  =(%liv con.dev)  ~
::  [our %dojo]~
::  ::%+  skim  (~(tap in eel))
::  ::|=(a/dock =((some %liv) (bind (~(get by fug) a) |=(target con))))
::
::> ||
::> ||  %indexing
::> ||
::>   operations on {inx}, the app selection
::+|
::++  se-select-app                                       ::< recalculate index
::  ::> select particular app, if connected
::  ::
::  ::REVIEW mutating inx in place is probably cleaner
::  |=  dok/dock
::  =+  [xin=0 wag=se-amor]
::  |-  ^+  +>.^$
::  ?~  wag  +>.^$(inx 0)
::  ?:  =(i.wag dok)  +>.^$(inx xin)
::  $(wag t.wag, xin +(xin))
::
::++  se-next-app                                         ::< rotate index
::  ::> select next connected app in ring
::  ::
::  =+  wag=se-amor
::  ?~  wag  +
::  ::  ~&  [%se-next-app inx+inx wag+wag nex+(mod +(inx) (lent se-amor))]
::  +(inx (mod +(inx) (lent wag)))
::
::
::> ||
::> ||  %disconnection
::> ||
::>   unlink helpers
::+|
::++  se-drop                                             ::< disconnect
::  ::> dok: app to unlink
::  ::>
::  ::> in the case of the local :dojo, reconnect
::  ::> immediately, so that there is always a repl
::  ::> available to manage /+drum
::  ::
::  |=  dok/dock
::  ^+  +>
::  =+  lag=se-current-app
::  ?.  (~(has by fug) dok)  +>.$
::  ?:  =(%ded con:(ta dok))  +>.$
::  =.  ta  ta-abet:ta-drop:(ta dok)
::  =.  +>.$  ?.  &(?=(^ lag) !=(dok u.lag))
::              +>.$(inx 0)
::            (se-select-app u.lag)
::  =.  +>.$  (se-text "[unlinked from {<dok>}]")
::  ::  temporarily disabled, use met-v
::  :: ?:  =(dok [our.bow %dojo])                            ::< undead dojo
::  ::   +>.$(eel (~(put in eel) dok))
::  +>.$
::
::++  se-nuke                                             ::< teardown connection
::  ::> forceful drop, pull immediately
::  ::
::  ::REVIEW shouldn't deleting from eel alone implicitly
::  ::       cause the connection to be cleaned up in
::  ::       subze?
::  |=  dok/dock
::  ^+  +>
::  =.  eel  (~(del in eel) dok)
::  (se-drop:(se-pull dok) dok)
::
::> ||
::> ||  %effect
::> ||
::>   emit pokes and dill outputs
::
::++  se-blit-sys                                         ::< output to system
::  ::> the initial connection from %dill is saved as
::  ::> {sys}, used for administartive tasks like
::  ::> shutting down urbit or logging to the
::  ::> pier's `.urb/put/` directory
::  ::
::  |=  bil/dill-blit:^dill  ^+  +>
::  ?~  sys  ~&(%se-blit-no-sys +>)
::  (se-emit [u.sys %diff %dill-blit bil])
::
++  se-dump   (. print-tanks):wrap-agent                ::DEPRECATED
++  se-view                                             ::< flush buffer
  ::> if an app is selected, sync out its input buffer
  ::
  ^+  .
  (abet-guardian flush-buffer:run-guardian)
::
++  se-emit                                             ::< emit move
  ::> mov: side-effect to queue for sending
  ::
  |=  mov/move
  %_(+> moz [mov moz])
::
++  se-text  (. print-text):wrap-agent               ::DEPRECATED
:: ++  se-poke                                             ::< send a poke
::   ::> dok: target app
::   ::> par: request data
::   ::
::   |=  {dok/dock par/pear}
::   (se-emit [ost.bow %poke (drum-path dok) dok par])
::
::++  se-pull                                             ::< cancel subscription
::  ::> dok: target app
::  ::
::  |=  dok/dock
::  (se-emit [ost.bow %pull (drum-path dok) dok ~])
::
::RENAMEME
::> ||
::> ||  %ta-core
::> ||
::>
::++  new-ta                                              ::< initialize new app
::  ::> bunt config, and use it to create a {ta} core
::  ::>
::  ::> dok: newly linked app
::  ::
::  |=  dok/dock  ^+  (ta)
::  ?<  (~(has by fug) dok)
::  =.  fug  (~(put by fug) dok *target)
::  (ta dok)
::
:: ++  ta                                                  ::< per target
  ::> this core is used to perform operations specific
  ::> to a {target} app
  ::>
  ::> dok: what app
  ::>
  ::|=  dok/dock
  ::=+  `target`(~(got by fug) dok)                       ::< app and state
  :: =+  `target`dev                       ::< app and state
  :: |%
  ::>  ||
  ::>  ||  %convenience
  ::>  ||
  ::>    minor incantations
  ::+|
  ::++  ta-abet                                           ::< resolve
  ::  ::>  exit {ta}, saving changed connection to {dok}
  ::  ::
  ::  ^+  ..ta
  ::  ::..ta(fug (~(put by fug) dok `target`+<))
  ::  ..ta(dev `target`+<)
  ::::
  ::++  ta-poke    |=(a/pear +>(..ta (se-poke dok a)))    ::< poke dok
  ::++  ta-pull    .(..ta (se-pull dok))                  ::< pull dok
  ::++  ta-peer                                           ::< peer dok
  ::  |=  a/path
  ::  +>(..ta (se-emit ost.bow %peer (drum-path dok) dok a))
  ::
  ::++  ta-aro                                            ::< process arrow
  ::  ::> key: arrow direction
  ::  ::
  ::  |=  key/?($d $l $r $u)
  ::  ^+  +>
  ::  ::=.  ris  ~
  ::  ?+  key  ta-bel
  ::    $l  ?:  =(0 pos.inp)  ta-bel
  ::        +>(pos.inp (dec pos.inp))
  ::    $r  ?:  =((lent buf.say.inp) pos.inp)
  ::          ta-bel
  ::        +>(pos.inp +(pos.inp))
  ::  ::
  ::    ::$u  ?:(=(0 pos.hit) ta-bel (ta-mov (dec pos.hit)))
  ::    ::$d  ?.  =(num.hit pos.hit)
  ::    ::      (ta-mov +(pos.hit))
  ::    ::    ?:  =(0 (lent buf.say.inp))
  ::    ::      ta-bel
  ::    ::    (ta-hom:ta-nex %set ~)
  ::  ==
  ::
  ::++  ta-bel  ::DEPRECATED ring-bell:agent                ::< beep
  ::
  ::++  ta-belt                                           ::< handle input
  ::  ::> bet: input keystroke
  ::  ::
  ::  |=  bet/app-specific-belt
  ::  ^+  +>
  ::  ::
  ::  ::
  ::  ::> save last two belts to recognize ctrl-w ctrl-w
  ::  ::> and similar sequences
  ::  ::
  ::  ::=.  blt  [q.blt `bet]
  ::  ::
  ::  ?+  bet  ta-bel
  ::    ::{$aro *}  (ta-aro p.bet)
  ::    ::{$ctl *}  (ta-ctl p.bet)
  ::    ::{$del *}  ta-del
  ::    ::{$met *}  (ta-met p.bet)
  ::    ::{$ret *}  (ta-act %ret ~)
  ::    ::{$txt *}  (ta-txt p.bet)
  ::  ==
  ::
  ::
  ::++  ta-del                                            ::< hear delete
  ::  ::> delete character after cursor if any
  ::  ::
  ::  ^+  .
  ::  ?:  =((lent buf.say.inp) pos.inp)
  ::  ?(  ta-bel -.fec)
  ::  (ta-hom %del pos.inp)
  ::
  ::++  ta-erl                                            ::< hear local error
  ::  ::> move cursor to error position, but not past
  ::  ::> the end of the buffer
  ::  ::
  ::  |=  pos/@ud
  ::  ta-bel(pos.inp (min pos (lent buf.say.inp)))
  ::
  ::++  ta-err                                            ::< hear remote error
  ::  ::> correct error position for pending edits
  ::  ::
  ::  |=  pos/@ud
  ::  (ta-erl (~(transpose shared:sole say.inp) pos))
  ::
  ::++  ta-hom  DEPRECATED see local-edit in agent, guardian
  ::++  ta-jump                                           ::< buffer pos
  ::  ::> get cursor location after moving
  ::  ::>
  ::  ::> dir: either {%l}eft or {%r}ight, to the next
  ::  ::> til: space, word boundary, or word
  ::  ::> pos: from a given cursor position
  ::  ::
  ::  |=  {dir/?($l $r) til/?($ace $edg $wrd) pos/@ud}
  ::  ^-  @ud
  ::  %-  ?:(?=($l dir) sub add)
  ::  [pos (ta-off dir til pos)]
  ::
  ::++  ta-kil                                            ::< kill selection
  ::  ::> remove section into kill ring
  ::  ::> adding a new entry or appending to old one
  ::  ::> depending on previous key event in {blt}
  ::  ::>
  ::  ::> dir: going {%l}eft or {%r}ight,
  ::  ::> sel: portion of the buffer to delete
  ::  ::
  ::  |=  {dir/?($l $r) sel/{@ @}}
  ::  ^+  +>
  ::  =+  buf=(swag sel buf.say.inp)
  ::  %.  (cut:block:sole sel)
  ::  %=  ta-hom
  ::      kil
  ::    ?.  ?&  ?=(^ old.kil)
  ::            ?=(^ p.blt)
  ::            ?|  ?=({$ctl ?($k $u $w)} u.p.blt)
  ::                ?=({$met ?($d $bac)} u.p.blt)
  ::        ==  ==
  ::      %=  kil                                         ::< prepend
  ::        num  +(num.kil)
  ::        pos  +(num.kil)
  ::        old  (scag max.kil `(list (list @c))`[buf old.kil])
  ::      ==
  ::    %=  kil                                           ::< cumulative yanks
  ::      pos  num.kil
  ::      old  :_  t.old.kil
  ::           ?-  dir
  ::             $l  (welp buf i.old.kil)
  ::             $r  (welp i.old.kil buf)
  ::    ==     ==
  ::  ==
  ::
  ::++  ta-met                                            ::< meta key
  ::  ::>  handle meta key
  ::  ::
  ::  |=  key/@ud
  ::  ^+  +>
  ::  ::=.  ris  ~
  ::  ?+    key    ta-bel
      ::$v    %_  +>
      ::        eel  ?:  (~(has in eel) our.bow %dojo)
      ::               (~(del in eel) our.bow %dojo)
      ::             (~(put in eel) our.bow %dojo)
      ::      ==
      ::$dot  ?.  &(?=(^ old.hit) ?=(^ i.old.hit))        ::< last "arg" from hist
      ::        ta-bel
      ::      =+  old=`(list @c)`i.old.hit
      ::      =+  sop=(ta-jump(buf.say.inp old) %l %ace (lent old))
      ::      (ta-hom (cat:block:sole pos.inp (slag sop old)))
            ::
      ::$bac  ?:  =(0 pos.inp)                            ::< kill left-word
      ::        ta-bel
      ::      =+  sop=(ta-off %l %edg pos.inp)
      ::      (ta-kil %l [(sub pos.inp sop) sop])
      ::      ::
      ::$b    ?:  =(0 pos.inp)                            ::< jump left-word
      ::        ta-bel
      ::      +>(pos.inp (ta-jump %l %edg pos.inp))
            ::
      ::$c    ?:  =(pos.inp (lent buf.say.inp))           ::< capitalize
      ::        ta-bel
      ::      =+  sop=(ta-jump %r %wrd pos.inp)
      ::      %-  ta-hom(pos.inp (ta-jump %r %edg sop))
      ::      %+  rep:block:sole  [sop 1]
      ::      ^-  (list @c)  ^-  (list @)                 :: XX unicode
      ::      (cuss `tape``(list @)`(swag [sop 1] buf.say.inp))
            ::
      ::$d    ?:  =(pos.inp (lent buf.say.inp))           ::< kill right-word
      ::        ta-bel
      ::      (ta-kil %r [pos.inp (ta-off %r %edg pos.inp)])
      ::      ::
      ::$f    ?:  =(pos.inp (lent buf.say.inp))           ::< jump right-word
      ::        ta-bel
      ::      +>(pos.inp (ta-jump %r %edg pos.inp))
            ::
      ::$r    %-  ta-hom(lay.hit (~(put by lay.hit) pos.hit ~))
      ::      :-  %set                                    ::< revert hist edit
      ::      ?:  =(pos.hit num.hit)  ~
      ::      (snag (sub num.hit +(pos.hit)) old.hit)
            ::
      ::$t    =+  a=(ta-jump %r %edg pos.inp)             ::< transpose words
      ::      =+  b=(ta-jump %l %edg a)
      ::      =+  c=(ta-jump %l %edg b)
      ::      ?:  =(b c)
      ::        ta-bel
      ::      =+  next=[b (sub a b)]
      ::      =+  prev=[c (ta-off %r %edg c)]
      ::      %-  ta-hom(pos.inp a)
      ::      :~  %mor
      ::          (rep:block:sole next (swag prev buf.say.inp))
      ::          (rep:block:sole prev (swag next buf.say.inp))
      ::      ==
      ::      ::
      ::?($u $l)                                          ::< upper/lower case
      ::      ?:  =(pos.inp (lent buf.say.inp))
      ::        ta-bel
      ::      =+  case=?:(?=($u key) cuss cass)
      ::      =+  sop=(ta-jump %r %wrd pos.inp)
      ::      =+  sel=[sop (ta-off %r %edg sop)]
      ::      %-  ta-hom
      ::      %+  rep:block:sole  sel
      ::      ^-  (list @c)  ^-  (list @)                 :: XX unicode
      ::      (case `tape``(list @)`(swag sel buf.say.inp))
            ::
      ::$y    ?.  ?&  ?=(^ old.kil)                       ::< rotate & yank
      ::              ?=(^ p.blt)
      ::              ?|  ?=({$ctl $y} u.p.blt)
      ::                  ?=({$met $y} u.p.blt)
      ::          ==  ==
      ::        ta-bel
      ::      =+  las=(lent ta-yan)
      ::      =.  pos.kil  ?:(=(1 pos.kil) num.kil (dec pos.kil))
      ::      (ta-hom (rep:block:sole [(sub pos.inp las) las] ta-yan))
    ::==
  ::
  ::++  ta-mov                                            ::< move in history
  ::  ::> sop: position in history to switch to
  ::  ::
  ::  |=  sop/@ud
  ::  ^+  +>
  ::  ?:  =(sop pos.hit)  +>
  ::  %-  %=  ta-hom
  ::        pos.hit  sop
  ::        lay.hit  (~(put by lay.hit) pos.hit buf.say.inp)
  ::      ==
  ::  :-  %set
  ::  %.  (~(get by lay.hit) sop)
  ::  (bond |.((snag (sub num.hit +(sop)) old.hit)))
  ::
  ::++  ta-nex                                            ::< add line to history
  ::  ::> when a history entry is accepted, clear search
  ::  ::> and edit overlay, save current buffer to {old.hit}
  ::  ::
  ::  ^+  .
  ::  ::=.  ris  ~
  ::  =.  lay.hit  ~
  ::  ?:  ?|  ?=($~ buf.say.inp)
  ::          &(?=(^ old.hit) =(buf.say.inp i.old.hit))
  ::      ==
  ::    .(pos.hit num.hit)
  ::  %_  .
  ::    num.hit  +(num.hit)
  ::    pos.hit  +(num.hit)
  ::    old.hit  [buf.say.inp old.hit]
  ::  ==
  ::
  ::++  ta-off                                            ::< buffer pos offset
  ::  ::> get distance to boundary
  ::  ::>
  ::  ::> dir: either {%l}eft or {%r}ight, to the next
  ::  ::> til: space, word boundary, or word, from
  ::  ::> pos: a cursor position
  ::  ::
  ::  |=  {dir/?($l $r) til/?($ace $edg $wrd) pos/@ud}
  ::  ^-  @ud
  ::  =*  not  |*(a/rule ;~(less a next))               ::  helper
  ::  %+  offset
  ::      ?-  til  $ace  ;~(plug (star ace) (star (not ace)))
  ::               $edg  ;~(plug (star aln) (star (not aln)))
  ::               $wrd  (star (not aln))
  ::      ==
  ::  ?-  dir  $l  (flop (scag pos buf.say.inp))
  ::           $r  (slag pos buf.say.inp)
  ::  ==
  ::
  ::++  ta-pro                                            ::< set prompt
  ::  ::> receive prompt, inserting ship and app title
  ::  ::
  ::  |=  pom/sole-prompt
  ::  %_    +>
  ::      pom
  ::    %_    pom
  ::        cad
  ::      ;:  welp
  ::        ?.  ?=($earl (clan:title p.dok))
  ::          (cite:title p.dok)
  ::        (scow %p p.dok)
  ::      ::
  ::        ":"
  ::        (trip q.dok)
  ::        cad.pom
  ::      ==
  ::    ==
  ::  ==
  ::
  ::++  ta-ser                                            ::< reverse search
  ::  ::> add to incremental search buffer
  ::  ::>
  ::  ::> ext: text to append, usually single character
  ::  ::
  ::  |=  ext/(list @c)
  ::  ^+  +>
  ::  ?:  |(?=($~ ris) =(0 pos.u.ris))
  ::    ta-bel
  ::  =+  sop=?~(ext (dec pos.u.ris) pos.u.ris)
  ::  =+  tot=(weld str.u.ris ext)
  ::  =+  dol=(slag (sub num.hit sop) old.hit)
  ::  =/  sup
  ::      |-  ^-  (unit @ud)
  ::      ?~  dol  ~
  ::      ?^  (find tot i.dol)
  ::        `sop
  ::      $(sop (dec sop), dol t.dol)
  ::  ?~  sup  ta-bel
  ::  (ta-mov(str.u.ris tot, pos.u.ris u.sup) (dec u.sup))
  ::
  ::++  ta-yan                                            ::< yank
  ::  ::> current ctrl-y text from kill ring
  ::  ::
  ::  (snag (sub num.kil pos.kil) old.kil)
  ::--
::
::> ||
::> ||  %moveme
::> ||
::>   this is helper code that belongs in its own libraries
::+|
::
::::
::::MOVEME trivial helper: maybe inline, maybe extract
::::       to tiny library similar to {/+time-to-id},
::::       maybe just move to a "helpers" core outside
::::       the app proper
::++  offset                                              ::< calculate offsets
::  ::>  fel: parsing {rule} that is matching characters
::  ::>  inp: input whose match-length is being determined
::  ::
::  |=  {fel/$-(nail edge) inp/(list @)}  ^-  @ud
::  q.p:(fel [0 0] inp)
--
