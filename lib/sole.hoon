::
::::  /hoon/sole/lib
  ::
/?    310
/-    sole
[. ^sole]
::
::::
  ::
:: TODO move to %zuse
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
::::
  ::
=,  wired
|%
++  encode-id                                           ::< encode client id
  ::> encodes a sole client source id.
  ::>
  |=  a/sole-id  ^-  @t
  (pack (dray /[%ud]/[%p]/[%tas] a))
::
++  decode-id                                           ::< decode client id
  ::> decodes a sole client source id.
  ::>
  |=  a/@t  ^-  sole-id
  (raid (need (pick a)) /[%ud]/[%p]/[%tas])
::
++  shared
  ::> ||
  ::> ||  %shared-state-engine
  ::> ||
  ::>   apply remote and local effects to a sole-share
  |_  sole-share
  ++  abet  +<                                          ::< return data
  ++  apply                                             ::< apply edit to buffer
    ::> %del: concatenate buffer before delete point
    ::>       with buffer after.
    ::> %ins: append new char to rest of buffer at
    ::>       insert point.
    ::> %mor: apply sole-edits as sequence.
    ::> %nop: do nothing.
    ::> %set: set buffer to specific buffer value.
    ::>
    |=  ted/sole-edit
    ^+  +>
    ?-    -.ted
      $del  +>.$(buf (weld (scag p.ted buf) (slag +(p.ted) buf)))
      $ins  +>.$(buf (weld (scag p.ted buf) `_buf`[q.ted (slag p.ted buf)]))
      $mor  |-  ^+  +>.^$
            ?~  p.ted
              +>.^$
            $(p.ted t.p.ted, +>.^$ ^$(ted i.p.ted))
      $nop  +>.$
      $set  +>.$(buf p.ted)
    ==
  ::
  ++  transmute                                         ::< move dex past sin
    ::> symmetric operational transformation.
    ::>
    ::> REVIEW: need to add sole doc examples soon.
    ::>
    ::> if dex happens after din, apply
    ::>
    ::> for any sole state +>, obeys
    ::>
    ::>     =+  [x=(transmute a b) y=(transmute b a)]
    ::>     .=  (apply:(apply a) x)
    ::>         (apply:(apply b) y)
    ::>
    ::>  sin: edit being moved against, =(x (transmute /nop x))
    ::>  dex: edit being adjusted, =(/nop (transmute x /nop))
    ::
    |=  {sin/sole-edit dex/sole-edit}
    ~|  [%transmute sin dex]
    ^-  sole-edit
    ?:  ?=($mor -.sin)
      |-  ^-  sole-edit
      ?~  p.sin  dex
      $(p.sin t.p.sin, dex ^$(sin i.p.sin))
    ::
    ?:  ?=($mor -.dex)
      :-  %mor
      |-  ^-  (list sole-edit)
      ?~  p.dex  ~
      [^$(dex i.p.dex) $(p.dex t.p.dex)]
    ::
    ?:  |(?=($nop -.sin) ?=($nop -.dex))  dex
    ?:  ?=($set -.sin)                    [%nop ~]
    ?:  ?=($set -.dex)                    dex
    ::
    ?-    -.sin
        $del
      ?-  -.dex
        $del  ?:  =(p.sin p.dex)  [%nop ~]
              ?:((lth p.sin p.dex) dex(p (dec p.dex)) dex)
        $ins  ?:((lth p.sin p.dex) dex(p (dec p.dex)) dex)
      ==
    ::
        $ins
      ?-  -.dex
        $del  ?:((lte p.sin p.dex) dex(p +(p.dex)) dex)
        $ins  ?:  =(p.sin p.dex)
                ?:((lth q.sin q.dex) dex dex(p +(p.dex)))
              ?:((lte p.sin p.dex) dex(p +(p.dex)) dex)
      ==
    ==
  ::
  ++  commit                                            ::< local change
    ::> record new edit, append to list of unmerged
    ::> edits. and apply.
    ::>
    ::> for this to do anything useful, {ted} should also be sent to
    ::> the symmetrical remote {sole-share}, which should then
    ::> (~(receive shared:sole ...) ted) bringing the buffer to the same state
    ::
    |=  ted/sole-edit
    ^-  sole-share
    abet:(apply(own.ven +(own.ven), leg [ted leg]) ted)
  ::
  ++  inverse                                           ::< relative inverse
    ::> inverse of change in context.
    ::>
    ::> for any sole state +>, obeys
    ::>
    ::>     =(+> (apply:(apply a) (inverse a)))
    ::>
    |=  ted/sole-edit
    ^-  sole-edit
    =.  ted
     ::REVIEW surely this can't be right
      ?.(?=({$mor * $~} ted) ted i.p.ted)
    ?-  -.ted
      $del  [%ins p.ted (snag p.ted buf)]
      $ins  [%del p.ted]
      $mor  :-  %mor
            %-  flop
            |-  ^-  (list sole-edit)
            ?~  p.ted  ~
            :-  ^$(ted i.p.ted)
            $(p.ted t.p.ted, +>.^$ (apply i.p.ted))
      $nop  [%nop ~]
      $set  [%set buf]
    ==
  ::
  ++  receive                                           ::< remote change
    ::> receive change {transmit}ted by the symmetric
    ::> remote sole-share
    ::>
    |=  soc/sole-change
    ^-  {sole-edit sole-share}
    =*  ler  ler.soc  ::REVIEW go back to no {soc} face? explicit .soc?
    ?.  &(=(his.ler his.ven) (lte own.ler own.ven))
      ~&  [%receive-sync his+[his.ler his.ven] own+[own.ler own.ven]]
      !!
    ?>  &(=(his.ler his.ven) (lte own.ler own.ven))
    ?>  |(!=(own.ler own.ven) =(`@`0 haw.soc) =(haw.soc (sham buf)))
    =.  leg  (scag (sub own.ven own.ler) leg)
    ::  ~?  !=(own.ler own.ven)  [%miss-leg leg]
    =+  dat=(transmute [%mor leg] ted.soc)
    ::  ~?  !=(~ leg)  [%transmute from+ted to+dat ~]
    [dat abet:(apply(his.ven +(his.ven)) dat)]
  ::
  ++  remit                                             ::< conditional accept
    ::> receive, then invert if buf fails test
    ::>
    ::> cal: change
    ::> ask: predicate to accept or revert change
    ::>
    |=  {cal/sole-change ask/$-((list @c) ?)}
    ^-  {(unit sole-change) sole-share}
    =+  old=buf
    =^  dat  +>+<.$  (receive cal)
    ?:  (ask buf)
      [~ +>+<.$]
    =^  lic  +>+<.$  (transmit (inverse(buf old) dat))
    [`lic +>+<.$]
  ::
  ++  transmit                                          ::< outgoing change
    ::> send change and own vector clock.
    ::>
    |=  ted/sole-edit
    ^-  {sole-change sole-share}
    [[[his.ven own.ven] (sham buf) ted] (commit ted)]
  ::
  ++  transceive                                        ::< receive and invert
    ::> receive a change and produce edit-share pair
    ::> for potential revert via ++transmit later
    ::>
    |=  soc/sole-change
    ^-  {sole-edit sole-share}
    =+  old=buf
    =^  dat  +<.abet  (receive soc)
    [(inverse(buf old) dat) +<.abet]
  ::
  ++  transpose                                         ::< adjust position
    ::> move according to local edits that haven't been
    ::> received yet.
    ::>
    ::> pos: remote error position
    ::>
    |=  pos/@ud  ^-  @ud
    =+  dat=(transmute [%mor leg] [%ins pos `@c`0])
    ?>  ?=($ins -.dat)
    p.dat
  --
++  cursored
  ::> ||
  ::> ||  %cursor-movement-door
  ::> ||
  ::>   wrap ++shared moving cursor position.
  |_  sole-cursor-share
  ++  commit                                            ::< local change
    ::> record new change and move cursor accordingly
    ::>
    |=  ted/sole-edit  ^-  sole-cursor-share
    =.  say  (~(commit shared say) ted)
    (transpose ted)
  ::
  ++  receive                                           ::< remote change
    ::> record remote change and move cursor accordingly
    ::>
    |=  cal/sole-change  ^-  {sole-edit sole-cursor-share}
    =^  ted  say  (~(receive shared say) cal)
    [ted (transpose ted)]
  ::
  ::REVIEW different from transpose:shared?
  ++  transpose                                         ::< change cursor
    ::> helper function: adjust cursor position
    ::> according to newly recorded edit
    ::>
    ::> ted: new/remote edit
    ::>
    |=  ted/sole-edit  ^-  sole-cursor-share
    %_    +<.transpose
        pos
      =+  len=(lent buf.say)
      %+  min  len
      |-  ^-  @ud
      ?-  ted
        {$del *}  ?:((gth pos p.ted) (dec pos) pos)
        {$ins *}  ?:((gte pos p.ted) +(pos) pos)
        {$mor *}  |-  ^-  @ud
                  ?~  p.ted  pos
                  $(p.ted t.p.ted, pos ^$(ted i.p.ted))
        {$nop *}  pos
        {$set *}  len
      ==
    ==
  --
--
