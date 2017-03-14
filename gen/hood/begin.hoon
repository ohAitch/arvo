::  Redeem ticket to replace current urbit with full one  XX DEPRECATED
::
::::  /hoon/begin/hood/gen
  ::
/?    310
/-  gene
::
::::
  ::
=>  [gene g=dsl:gene]
=>  |%
    ++  begs  {his/@p tic/@p yen/@t ges/gens}
    ++  scug  |*({a/@ b/(pole)} ?~(b ~ ?~(a ~ [-.b $(b +.b, a (dec a))])))
    --
:-  %ask
|=  $:  {now/@da eny/@uvJ bec/beak}
        {arg/_(scug *@ *{his/@p tic/@p $~})}
        safety/?($on $off)
    ==
^-  (result (cask begs))
?.  =(safety %off)
  %+  yo.g
    :-  %leaf
    "|begin is deprecated, please invoke urbit with -w [name] -t [ticket]"
  no.g
=-  -
%+  lo.g  [%& %helm-begin "your urbit: ~"]
%+  go.g  fed:ag
|=  his/@p
%+  lo.g  [%& %helm-ticket "your ticket: ~"]
%+  go.g  fed:ag
|=  tic/@p
%+  lo.g  [%& %helm-entropy "some entropy: "]
%+  go.g  (boss 256 (more gon qit))
|=  yen/@t
=+  ney=(shax yen)
%+  yo.g  `tank`[%leaf "entropy check: {(scow %p `@p`(mug ney))}"]
%+  so.g  %helm-begin
:*  his
    tic
    ney
::
    ^-  gens
    :-  %en
    =+  can=(clan his)
    ?-  can
      $czar  [%czar ~]
      $duke  [%duke %anon ~]
      $earl  [%earl (scot %p his)]
      $king  [%king (scot %p his)]
      $pawn  [%pawn ~]
    ==
==
