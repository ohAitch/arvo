::
::::  /hoon/action/sole/mar
  ::
/?    310
/-    sole, client-id
::
::::
  ::
=,  sole
|_  {client-id sole-action}
::
++  grab                                                ::  convert from
  |%
  ++  json
    |=  jon/^json  ^-  {client-id sole-action}
    :-  *client-id  :: XX write json parser later
    %.  jon
    =>  [dejs:format ..sole-action:sole]
    |^  (fo %ret (of det+change ~))
    ++  fo
      |*  {a/term b/fist}
      |=  c/json
      ?:  =([%s a] c)  [a ~]
      (b c)
    ::
    ++  ra
      |*  {a/{term fist} b/fist}
      |=  c/json  %.  c
      ?.(=(%a -.c) b (pe -.a (ar +.a)))
    ::
    ++  change  (ot ler+(at ni ni ~) ted+(cu |*(a/* [0v0 a]) edit) ~)
    ++  char  (cu turf so)
    ++  edit
      %+  fo  %nop
      %+  ra  mor+|=(json (edit +<))
      (of del+ni set+(cu tuba sa) ins+(ot at+ni cha+char ~) ~)
    --
  ::
  ++  noun  sole-action                                   ::  clam from %noun
  --
--
