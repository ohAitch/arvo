::
::::  /hoon/blit/dill/mar
  ::
/?    310
/-    sole
=,  sole
=,  ^dill
=,  js:eyre
|_  dib/dill-blit
::
++  grab                                                ::  convert from
  |%
  ++  noun  dill-blit                                       ::  clam from %noun
  --
++  grow
  |%
  ++  json
    ^-  ^json
    ?-  -.dib
      ?($sav $sag)  ~|(unsupported-blit+-.dib !!)
      $mor  [%a (turn p.dib |=(a/dill-blit json(dib a)))]
      $url  (joba %url s+p.dib)
      $hop  (joba %hop (jone p.dib))
      ?($pro $out)  (joba -.dib (jape (tufa p.dib)))
      ?($bel $clr $qit)  (joba %act %s -.dib)
      ?($pom $klr)
        %+  joba  -.dib
        :-  %a
        %+  turn  p.dib
        |=  {{dek/(set deco) bac/tint for/tint} txt/(list @c)}
        %-  jobe  :~
          deco+(jobe (turn (~(tap in dek)) |=(a/deco [`@t`a %b &])))
          back+s+`@t`bac
          fore+s+`@t`for
          text+(jape (tufa txt))
        ==
    ==
  --
--
