::
::::  /hoon/plain/ren
  ::
/?    310
/^    {dep/@uvh hym/manx}    /#  /|(/hymn/ /~[;none;])
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
    ;a/"../.plain": Up
    ;hr;
    ;*  bod
  ==
==
