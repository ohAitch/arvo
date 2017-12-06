::
::::  /hoon/effect/sole/mar
  ::
/?    310
/-    sole
/+    old-zuse
::
::::
  ::
=,  sole
=,  format
=,  old-zuse
|%
++  mar-sole-change                       ::  XX  dependency
  =,  old-zuse
  |_  cha/sole-change
  ++  grow
    |%  ++  json
      ^-  ^json
      =,  enjs
      =;  edi
        =,(cha (table ted+(edi ted) ler+a+~[(numb own.ler) (numb his.ler)] ~))
      |=  det/sole-edit
      ?-  -.det
        $nop  [%s 'nop']
        $mor  [%a (turn p.det ..$)]
        $del  (wrap %del (numb p.det))
        $set  (wrap %set (tape (tufa p.det)))
        $ins  (wrap %ins (table at+(numb p.det) cha+s+(tuft q.det) ~))
      ==
    --  
  --
++  wush
  |=  {wid/@u tan/tang}
  ^-  tape
  (of-wall (turn (flop tan) |=(a/tank (of-wall (wash 0^wid a)))))
::
++  purge                                               ::  discard ++styx style
  |=  a/styx  ^-  tape
  %-  zing  %+  turn  a
  |=  a/_?>(?=(^ a) i.a)
  ?@(a (trip a) ^$(a q.a))
--
::
|_  sef/sole-effect
::
++  grab                                                ::  convert from
  |%
  ++  noun  sole-effect                                 ::  clam from %noun
  --
++  grow
  =,  enjs
  |%
  ++  lens-json                       :: json for cli client
    ^-  ?($~ ^json)                   :: null = ignore
    ?+    -.sef  ~
        $tan  (wall (turn (flop p.sef) |=(a/tank ~(ram re a))))
        $txt  s+(crip p.sef)
        $sav
      (table file+s+(crip <`path`p.sef>) data+s+(crip (sifo q.sef)) ~)
    ::
        $mor
      =+  all=(turn p.sef |=(a/sole-effect lens-json(sef a)))
      =.  all  (skip all |=(a/^json ?=($~ a)))
      ?~  all  ~
      ?~  t.all  i.all
      ~|(multiple-effects+`(list ^json)`all !!)
    ==
  ::
  ++  json
    ^-  ^json
    ?+    -.sef  
              ~|(unsupported-effect+-.sef !!)
        $mor  [%a (turn p.sef |=(a/sole-effect json(sef a)))]
        $err  (wrap %hop (numb p.sef))
        $txt  (wrap %txt (tape p.sef))
        $tan  (wrap %tan (tape (wush 160 p.sef)))
        $det  (wrap %det json:~(grow mar-sole-change +.sef))
    ::
        $pro
      %+  wrap  %pro
      (table vis+b+vis.sef tag+s+tag.sef cad+(tape (purge cad.sef)) ~)
    ::
        ?($bel $clr $nex)
      (wrap %act %s -.sef)
    ==
  --
--
