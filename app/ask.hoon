::
::::  /hoon/ask/app
  ::
/?    310
/+    sole, womb, prey
[. sole]
|%
  ++  card
    $%  {$diff $sole-effect sole-effect}
        {$poke wire {ship $hood} $womb-invite {cord invite}:womb}
    ==
  ++  invited  ?($new $sent $ignored)
  ++  email  @t
--
::
=,  ^gall
=|  mow/(list {bone card})
=|  sef/(list sole-effect)
|_  $:  bow/bowl
        adr/(map email {time invited})
        sos/(map sole-id sole-share)
        wom/(unit ship)
        admins/(set ship)
    ==
++  abet
  ^-  (quip {bone card} .)
  =.  .  ?:(=(~ sef) . (emit (effect %mor sef)))
  [(flop mow) .(mow ~, sef ~)]
::
++  emit  |=(a/card +>(mow [[ost.bow a] mow]))
++  emit-all
  |=  a/card
  =/  mos
    (turn (prey /sole bow) |=({ost/bone ^} [ost a]))
  +>.$(mow (welp mos mow))
::
++  give-effect  |=(a/sole-effect +>(sef [a sef]))
::
++  prompt
  ^-  sole-prompt
  ?~  wom  [& %ask-ship ":womb-ship? ~"]
  =/  new  new-adrs
  ?~  new  [& %$ "<listening> (0) [l,a,i,w,?]"]
  [& %$ ": approve {<ask.i.new>}? ({<(lent new)>}) [y,n,l,a,i,w,?]"]
::
++  peer-sole
  |=  path
  =<  abet  ^+  +>
  =/  sid/sole-id  [ost our dap]:bow  ::  XX get from path
  ~|  [%not-in-whitelist src.bow]
  ?>  |((~(has in admins) src.bow) =(our.bow src.bow))
  =.  di  (new-di sid)                ::  XX explicit %new act
  %-  emit
  %^  effect  %mor
    pro+prompt
  =+  all=adrs
  [(render all) (turn all put-mail)]
::
++  render                            :: show list of invites
  |=  a/(list {time email invited})  ^-  sole-effect
  ?:  =(~ a)  txt+"~"
  tan+(flop (turn a message))
::
++  adrs
  =-  (sort - lor)
  %+  turn  (~(tap by adr))
  |=({a/email b/time c/invited} [tym=b ask=a inv=c])
::
++  new-adrs  (skim adrs |=({@ @ inv/invited} =(%new inv)))
++  ignored-adrs  (skim adrs |=({@ @ inv/invited} =(%ignored inv)))
++  effect  |=(fec/sole-effect [%diff %sole-effect fec])
++  message
  |=  {now/time ask/@t inv/invited}  ^-  tank
  =.  now  (sub now (mod now ~s1))
  leaf+"ask: {<inv>} {<now>} {(trip ask)}"
::
++  put-mail
  |=  {@ ask/@t inv/invited}
  =/  pax  (rash ask unix-path)
  [%sav pax `@t`inv]
::
++  unix-path  ::  split into path of "name" and "extension"
  ;~  (glue dot)
    (cook crip (star ;~(less dot next)))
    ;~(plug (cook crip (star next)) (easy ~))
  ==
::
++  poke-ask-admins
  |=  a/(set ship)
  ?>  =(our.bow src.bow)
  abet(admins a)
::
++  poke-ask-mail
  |=  ask/@t
  =<  abet  ^+  +>
  ~|  have-mail+ask
  ?<  (~(has by adr) ask)
  =.  adr  (~(put by adr) ask now.bow %new) :: XX electroplating
  %-  emit-all
  =/  new  [now.bow ask %new]
  (effect %mor tan+[(message new)]~ pro+prompt (put-mail new) ~)
::
++  poke-sole-action--no-womb-ship
  |=  {sid/sole-id act/sole-action}  ^+  +>
  =/  buf   buf.som:(di sid)
  ?-    -.act
      $clr  +>.$
      $ret
    ?:  =(~ buf)
      (give-effect txt+"Please enter womb ship")
    =/  try  (rose (tufa buf) fed:ag)
    ?.  ?=({$& ^} try)
      (give-effect bel+~)
    =.  wom  p.try
    =>  (transmit:(di sid) set+~)
    (give-effect pro+prompt)   :: XX handle multiple links?
  ::
      $det
    =^  gud  di
      %+  remit:(di sid)  +.act
      |=  buf/(list @c)
      ?=({$& *} (rose (tufa buf) fed:ag))
    ?:  gud  +>.$
    (give-effect bel+~)
  ==
::
++  poke-sole-action
  |=  act/sole-action
  =<  abet  ^+  +>
  =/  sid/sole-id  [ost our dap]:bow  ::  XX get from poke
  ?:  =(~ wom)
    (poke-sole-action--no-womb-ship sid act)
  ?-    -.act
      $clr  +>.$
      $ret  (give-effect mor+help)
      $det                              :: reject all input
    =^  buf  di  (read-reject:(di sid) +.act)
    ::
    ?:  =("?" buf)  (give-effect mor+help)
    ?:  =("a" buf)  (give-effect (render adrs))
    ?:  =("l" buf)  (give-effect (render new-adrs))
    ?:  =("i" buf)  (give-effect (render ignored-adrs))
    ?:  =("w" buf)  =.(wom ~ (give-effect pro+prompt))
    ?:  =("n" buf)
      =/  new  new-adrs
      ?~  new  (give-effect bel+~)
      =.  inv.i.new  %ignored
      =.  adr  (~(put by adr) ask.i.new [tym inv]:i.new)
      (give-effect %mor tan+[(message i.new)]~ pro+prompt ~)
    ?:  =("y" buf)
      =/  new  new-adrs
      ?~  new  (give-effect bel+~)
      =.  inv.i.new  %sent  :: XX pending
      =.  emit  (emit (invite ask.i.new))
      =.  adr  (~(put by adr) ask.i.new [tym inv]:i.new)
      (give-effect %mor tan+[(message i.new)]~ pro+prompt ~)
    (give-effect bel+~)
  ==
::
++  new-di  |=(sid/sole-id +>(sos (~(put by sos) sid *sole-share)))
++  di
  |=  sid/sole-id
  =/  som  (~(got by sos) sid)
  |%
  ++  abet  ..di(sos (~(put by sos) sid som))
  ++  transmit
    |=  dit/sole-edit  ^+  ..di
    =^  det  som  (~(transmit shared:sole som) dit)
    abet(di (give-effect det+det))
  ::
  ++  remit
    |=  {cal/sole-change ask/$-((list @c) ?)}
    ^+  [*? ..di]
    =^  lic  som
      (~(remit shared:sole som) cal ask)
    ?~  lic  [& abet]
    [| abet(di (give-effect det+u.lic))]
  ::
  ++  read-reject
    |=  cal/sole-change  ^+  ["" ..di]
    =^  inv  som  (~(transceive shared:sole som) cal)
    :-  (tufa buf.som)
    (transmit inv)
  --
::
++  help
  ^-  (list sole-effect)
  =-  (scan - (more (just '\0a') (stag %txt (star prn))))
  %+  welp
    ?~  [new-adrs]  ""
    """
    y - invite current ask
    n - ignore current ask

    """
  """
  l - list new asks
  i - list ignored asks
  a - list all asks
  w - reset womb ship
  ? - print help
  """
::
++  invite
  |=  ask/email
  ^-  card
  :^  %poke  /invite/(scot %t ask)  [(need wom) %hood]
  :-  %womb-invite
  ^-  {cord invite}:womb
  =+  inv=(scot %uv (end 7 1 eny.bow))
  [inv [ask 1 0 "You have been invited to Urbit: {(trip inv)}" ""]]
--
