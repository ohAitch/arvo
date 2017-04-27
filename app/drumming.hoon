::                                                      ::  ::
::::  /hoon/drumming/app                                ::  ::
  ::                                                    ::  ::
/+    drum2,   talk, sole
::
::::
  ::
=,  drum2
|_  {hid/bowl:^gall drum-part}                          ::  main drum work
++  diff-sole-effect-drum-phat  (. diff-sole-effect-phat):wrap  ::  app event
++  diff-sole-backlog-drum-phat  (. diff-sole-backlog-phat):wrap  ::  app event
::
++  diff-backlog-atoms-drum-phat  (. diff-backlog-atoms-phat):wrap  ::  app event
++  diff-atom-drum-phat  (. diff-atom-phat):wrap  ::  app event
++  peer                   (. peer):wrap                   ::
++  poke-dill-belt         (. poke-dill-belt):wrap         ::  terminal event
:: ++  poke-sole-action       (. poke-sole-action):wrap         ::  terminal event
++  poke-drum-start        (. poke-start):wrap             ::  start app
++  poke-drum-link         (. poke-link):wrap              ::  connect app
++  poke-drum-unlink       (. poke-unlink):wrap            ::  disconnect app
++  poke-drum-exit         (. poke-exit):wrap              ::  shutdown
++  poke-drum-put          (. poke-put):wrap               ::  write file
++  reap-drum-phat         (. reap-phat):wrap              ::  ack connect
++  take-coup-drum-phat    (. take-coup-phat):wrap         ::  ack poke
++  take-onto              (. take-onto):wrap              ::  ack start
++  quit-drum-phat         (. quit-phat):wrap              ::
++  wrap
  =<  [^?(.) (drum2 +<):..wrap]
  |*  handle/_|=(* *(quip (cask) *drum-part))
  |=  arg/_+<.handle
  =^  mow  +<+.wrap  (handle arg)
  [mow ..wrap]
++  prep
::   =<  _`..prep(+<+ (drum-make our.hid))
  |=  a/(unit drum-part)  ^+  [~ +>]
  ?~  a  `+>(+<+ (drum-make our.hid))
  ?:  =(u.a *drum-part)  `+>(+<+ (drum-make our.hid))
  `+>(+<+ u.a)
--
