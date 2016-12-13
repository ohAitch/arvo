::
::::  /hoon/womb/sur
  ::
^?
|%                                                      ::
++  ticket  @G                                          ::  old 64-bit ticket
++  passcode  @uvH                                      ::  128-bit passcode
++  passhash  @uwH                                      ::  passocde hash
++  mail  @t                                            ::  email address
++  balance                                             ::  invitation balance
  $:  planets/@ud                                       ::  planet count
      stars/@ud                                         ::  star count
      owner/mail                                        ::  owner's email
      history/(list mail)                               ::  transfer history
  ==                                                    ::
++  invite                                              ::
  $:  who/mail                                          ::  who to send to
      pla/@ud                                           ::  planets to send
      sta/@ud                                           ::  stars to send
      wel/welcome                                       ::  welcome message
  ==                                                    ::
++  welcome                                             ::  welcome message
  $:  intro/tape                                        ::  in invite email
      hello/tape                                        ::  as talk message
  ==                                                    ::
++  stat  (pair live dist)                              ::  external info
++  live  ?($cold $seen $live)                          ::  online status
++  dist                                                ::  allocation
  $%  {$free $~}                                        ::  unallocated
      {$owned p/mail}                                   ::  granted, status
      {$split p/(map ship stat)}                        ::  all given ships
  ==                                                    ::
--                                                      ::
