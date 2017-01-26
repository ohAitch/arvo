::
::::  /hoon/urb/mar
  ::
/?    310
/=  urb-wasp-data-js    /:    /%/wasp-data    /js/
=,  js:eyre
=,  xml:eyre
=,  bytes:eyre
::
|_  {{dep/@uvH hed/marl} {dep-bod/@uvH bod/marl}}
++  grow                                                ::  convert to
  |%
  ++  mime  [/text/html (taco html)]                    ::  convert to %mime
  ++  html  (crip (print hymn))                         ::  convert to %html
  ++  hymn                                              ::  inject dependencies
    ^-  manx
    ;html
      ;head
        ;meta(charset "utf-8", urb_injected "");
        ;*  hed
      ==
      ;body
        ;*  bod
        ;*  ?~  dep  ~
            :~  ;script(urb_injected "")
                  ;-  (trip urb-wasp-data-js)
                  ;  urb.addDependency("{<dep>}")
                  ;  urb.addDependency("{<dep-bod>}", 'data')
                  ;  setTimeout(urb.initDependencies, 2000)
                ==
            ==
      ==
    ==
  --
++  grab
  |%                                                    ::  convert from
  ++  noun  {@uvH manx}                                 ::  clam from %noun
  --
--
