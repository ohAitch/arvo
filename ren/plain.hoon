::
::::  /hoon/plain/ren
  ::
/?    310
/^    {dep/@uvh hym/manx}    /#  /|(/hymn/ /~[;none;])
/^    sib/(map knot $~)    /:  /%%/    /_    /~  ~
/=    gas    /$  fuel
::
::::
  ::
^-  manx
=+  fyl=?~(s.bem.gas !! i.s.bem.gas)
=+  ^-  {hed/marl bod/marl}
  ?:  =(;none; hym)
    [~ ~]
  ~|  [%malformed-hymn hym]  :: XX types
  ?>  ?=({{$html $~} {{$head $~} *} {{$body $~} *} $~} hym)
  =<  [hed bod]
  `{{$html $~} {{$head $~} hed/marl} {{$body $~} bod/marl} $~}`hym
::
;html
  ;head
    ;title: Serving {<fyl>}
    ;script@"/~/on/{<dep>}.js";
    ;*  hed
  ==
  ;body
    ;+  =+  all=(sort (~(tap by sib)) aor)
        =/  nex
          ?~  all  ~
          |-  ^-  marl
          ?~  t.all  ~
          ?:  =(fyl p.i.all)  [;a/"../{(trip p.i.t.all)}/.plain":"Next"]~
          $(all t.all)
        =.  all  (flop all)  
        =/  pre
          ?~  all  ~
          |-  ^-  marl
          ?~  t.all  ~
          ?:  =(fyl p.i.all)  [;a/"../{(trip p.i.t.all)}/.plain":"Prev"]~
          $(all t.all)
        ;div: *{pre} ;{a/"../.plain" "Up"} *{nex}
    ;hr;
    ;*  bod
  ==
==
