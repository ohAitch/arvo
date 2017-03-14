::  client
=,  ^gall
|%
++  move
  $:  bone
  $%  {$peer wire dock path}
      {$poke wire dock {$noun {@u dock} *}}
  ==  ==
--
::
=,  wired
=|  mow/(list move)
|_  {bowl $~}
++  this  .
++  abet  [(flop mow) .(mow ~)]
++  emit  |=(a/move this(mow [a mow]))
::
++  poke-noun
  |=  a/*
  ?+  a  abet
    $read-1  (poke-read-1 ~)
    $read-2  (poke-read-2 ~)
    $write-1  (poke-write-1 ~)
    $write-2  (poke-write-2 ~)
  ==
++  sesh  |=(a/@u [a our dap])
++  as-peer  |=(ses/{@u dock} (dray /[%ud]/[%p]/[%tas] ses))
++  poke-read-1  |=(* abet:(emit 0 %peer / [our %inc-serv] (as-peer (sesh 1))))
++  poke-read-2  |=(* abet:(emit 0 %peer / [our %inc-serv] (as-peer (sesh 2))))
++  diff-atom  |=({wire @u} ~&([%diff +<] abet))
++  poke-write-1  |=(* abet:(emit 0 %poke / [our %inc-serv] %noun (sesh 1) ~))
++  poke-write-2  |=(* abet:(emit 0 %poke / [our %inc-serv] %noun (sesh 2) ~))
--