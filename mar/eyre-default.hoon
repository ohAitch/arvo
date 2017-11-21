::
::::  /hoon/urb/mar
  ::
/?    310
/=    dependency-poll-js    /:    /%/dependency-poll    /js/
=,  format
=,  mimes:html
=,  html
::
|_  {{dep/@uvH hed/marl} {dep-bod/@uvH bod/marl}}
++  grow                                                ::  convert to
  |%
  ++  mime  [/text/html (as-octs html)]                 ::  convert to %mime
  ++  html  (crip (en-xml hymn))                        ::  convert to %html
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
                  ;-  (trip dependency-poll-js)
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
