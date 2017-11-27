::
::::  /hoon/plain/ren
  ::
/?    310
/^    {dep/@uvh hym/manx}    /#  /|(/hymn/ /~[;none;])
/^    kid/(map knot $~)    /_    /~  ~
/^    sib/(map knot $~)    /:  /%%/    /_    /~  ~
/=    gas    /$  fuel:html
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
    ;+  =+  all=(sort ~(tap by sib) aor)
        =/  nex
          ?~  all  ~
          |-  ^-  marl
          ?~  t.all  ~
          ?:  =(fyl p.i.all)  [;a/"../{(trip p.i.t.all)}/":"Next"]~
          $(all t.all)
        =.  all  (flop all)  
        =/  pre
          ?~  all  ~
          |-  ^-  marl
          ?~  t.all  ~
          ?:  =(fyl p.i.all)  [;a/"../{(trip p.i.t.all)}/":"Prev"]~
          $(all t.all)
        ;div: *{pre} ;{a/"../" "Up"} *{nex}
    ;*  ?~  bod  ~
        [;hr; bod]
::     ;-  <gas>
    ;hr;
    ;ul
      ;*  %+  turn  (sort ~(tap by kid) aor)
          |=  {sub/knot $~}
          ;li: ;{a/"{(trip sub)}/" "{(trip sub)}"}
    ==
  ==
==
