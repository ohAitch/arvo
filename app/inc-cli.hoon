::  client
=,  ^gall
|%
++  move
  $:  bone
  $%  {$peer wire dock path}
      {$poke wire dock {$noun @uv *}}
  ==  ==
--
::
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
++  poke-read-1  |=(* abet:(emit 0 %peer / [our %inc-serv] /0v1))
++  poke-read-2  |=(* abet:(emit 0 %peer / [our %inc-serv] /0v2))
++  diff-atom  |=({wire @u} ~&([%diff +<] abet))
++  poke-write-1  |=(* abet:(emit 0 %poke / [our %inc-serv] %noun 0v1 ~))
++  poke-write-2  |=(* abet:(emit 0 %poke / [our %inc-serv] %noun 0v2 ~))
--