::
::::  /hoon/gene/sur
  ::
/-  sole
=*  sole-prompt  sole-prompt:sole
|%
++  dialog                                              ::  standard dialog
  |*  out/$-(* *)                                       ::  output structure
  $-(input (result out))                                ::  output function
::                                                      ::
++  input  tape                                         ::  prompt input
++  result                                              ::  conditional result
  |*  out/$-(* *)                                       ::  output structure
  $@(@ud (product out))                                 ::  error position
::                                                      ::
++  product                                             ::  success result
  |*  out/$-(* *)                                       ::
  %+  pair  (list tank)                                 ::
  %+  each  (unit out)                                  ::  ~ is abort
  (pair sole-prompt (dialog out))                       ::  ask and continue
::                                                      ::
++  request                                             ::  scraper result
  |*  out/$-(* *)                                       ::  output structure
  %+  pair  (list tank)                                 ::
  %+  each  (unit out)                                  ::  ~ is abort
  %^    trel                                            ::  fetch and continue
      (unit knot)                                       ::
    hiss:^eyre                                          ::
  $-(httr:^eyre (request out))                          ::
::                                                      ::
::                                                      ::
++  generator                                           ::  XX virtual type
  $^  $-(* noun)                                        ::  simple gate
  $%  {$say $-((args) (cask))}                          ::  direct noun
      {$ask $-((args) (product (cask)))}                ::  dialog
      {$get $-((args) (request (cask)))}                ::  scraper
  ==                                                    ::
++  args                                                ::  generator arguments
  |*  {mold mold}                                       ::
  {{now/@da eny/@uvJ bek/beak} {+<- +<+}}               ::
::                                                      ::
++  dsl                                                 ::
  |%                                                    ::
  ++  so                                                ::  construct result
    |*  pro/*                                           ::
    [p=*(list tank) q=[%& p=[~ u=pro]]]                 ::
  ::                                                    ::
  ++  yo                                                ::  add output tank
    |*  {tan/tank res/(result)}                         ::
    ?@  res  res                                        ::
    [p=[i=tan t=p.res] q=q.res]                         ::
  ::                                                    ::
  ++  lo                                                ::  construct prompt
    |*  {pom/sole-prompt mor/(dialog)}                  ::
    [p=*(list tank) q=[%| p=pom q=mor]]                 ::
  ::                                                    ::
  ++  at                                                ::  fetch url
    =|  usr/knot                                        ::
    |*  {pul/_purl:^eyre fun/$-(httr:^eyre *)}          ::
    :-  p=*(list tank)                                  ::
    q=[%| p=`usr q=[pul %get ~ ~] r=fun]                ::
  ::                                                    ::
  ++  no                                                ::  empty result
    [p=*(list tank) q=[%& ~]]                           ::
  ::                                                    ::
  ++  go                                                ::  parse by rule
    |*  {sef/rule fun/$-(* *)}                          ::
    |=  txt/input                                       ::
    =+  vex=(sef [0 0] txt)                             ::
    ?:  |(!=((lent txt) q.p.vex) ?=($~ q.vex))          ::
      q.p.vex                                           ::
    (fun p.u.q.vex)                                     ::
  --
--
