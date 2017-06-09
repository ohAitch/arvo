::                                                      ::  ::
::::  /hoon/hood/app                                    ::  ::
  ::                                                    ::  ::
/?    310                                               ::  zuse version
/+  drum                                                ::  libraries
[. drum]
::                                                      ::  ::
::::                                                    ::  ::
  ::                                                    ::  ::
=>  |%                                                  ::  module boilerplate
    ++  hood-2                                          ::
      {$2 lac/hood-part}                     ::
    ++  hood-good                                       ::
      |*  hed/hood-head                                 ::
      |=  paw/hood-part  ^-  drum-part                               ::
      ?-  hed                                           ::
        $drum  ?>(?=($drum -.paw) `drum-part`paw)       ::
      ==                                                ::
    ++  hood-head  _-:*hood-part                        ::
    ++  hood-make                                       ::
      |*  {our/@p hed/hood-head}                        ::
      ?-  hed                                           ::
        $drum  (drum-make our)                          ::
      ==                                                ::
    ++  hood-part  {$drum $2 drum-pith}
    --                                                  ::
::                                                      ::  ::
::::                                                    ::  ::
  ::                                                    ::  ::
=,  ^gall
|_  $:  hid/bowl                                       ::  system state
        hood-2                                          ::  server state
    ==                                                  ::
++  able                                                ::  find+make part
  |*  hed/hood-head
  ((hood-good hed) lac)
::
++  ably                                                ::  save part
  |*  {(list) hood-part}
  [(flop +<-) %_(+> lac `hood-part`+<+)]
::                                                      ::  ::
::::                                                    ::  ::
  ::                                                    ::  ::
++  prep
  |=  old/(unit hood-2)
  ~&  %hood-2-prep
  ?~  old  start-drum(lac (drum-make our.hid))
  ^-  (quip _!! +>)            ::
  [~ +>(lac lac.u.old)]
::
++  start-drum  (poke-drum-init ~)  ::TEMPORARY drum is moving out
::   :_  .
::   :~  [ost.hid %conf /cone [our.hid %cone] %load our.hid q.byk.hid]
::       [ost.hid %conf /deck [our.hid %deck] %load our.hid q.byk.hid]
::       [ost.hid %poke /deck [our.hid %deck] %deck-init ~]
::   ==
++  onto
  |=  {wire saw/(each suss:^gall tang)}
  ?-  -.saw
    $&  ~&([%live p.saw] [~ +>.$])
    $|  ((slog p.saw) [~ +>.$])
  ==
::
++  coup-drum-phat  (wrap take-coup-phat):from-drum
++  diff-sole-effect-drum-phat  (wrap diff-sole-effect-phat):from-drum
++  diff-sole-backlog-drum-phat  (wrap diff-sole-backlog-phat):from-drum
::
++  from-drum
  =-  [wrap=- *drum]                 ::  usage (wrap handle-arm):from-drum
  |*  wrapped-arm/$-(* _se-abet:*drum)
  |=  _+<.wrapped-arm
  =.  +>.wrapped-arm  (drum hid (able %drum))
  (ably (wrapped-arm +<))
++  onto-drum                 (wrap take-onto):from-drum
++  peer-drum                 (wrap peer):from-drum
++  poke-dill-belt            (wrap poke-dill-belt):from-drum
++  poke-drum-init            (wrap poke-drum-init):from-drum
:: ++  poke-drum-put             (wrap poke-put):from-drum
:: ++  poke-drum-link            (wrap poke-link):from-drum
:: ++  poke-drum-unlink          (wrap poke-unlink):from-drum
:: ++  poke-drum-exit            (wrap poke-exit):from-drum
:: ++  poke-drum-start           (wrap poke-start):from-drum
++  quit-drum-phat            (wrap quit-phat):from-drum
++  reap-drum-phat            (wrap reap-phat):from-drum
--
