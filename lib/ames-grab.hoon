::                                                      ::  ::
::::  /hoon/ames-grab/lib                               ::  ::
  ::                                                    ::  ::
/?    310                                               ::  version
/+    talk, old-phon
::                                                      ::  ::
::::                                                    ::  ::
  ::                                                    ::  ::
|%                                                  ::
++  ames-tell                                           ::  .^ a+/=tell= type
  |^  {p/(list elem) q/(list elem)}                     ::
  ++  elem  $^  {p/elem q/elem}                         ::
            {term p/*}                                  ::  somewhat underspecified
  --                                                    ::
--                                                      ::
::                                                      ::  ::
::::                                                    ::  ::
  ::                                                    ::  ::
|%
++  ames-tell-got                                       :: XX better ames scry
  |=  {a/term b/ames-tell}  ^-  *
  =;  all  (~(got by all) a)
  %-  ~(gas by *(map term *))
  %-  zing
  %+  turn  (weld p.b q.b)
  |=  b/elem:ames-tell  ^-  (list {term *})
  ?@  -.b  [b]~
  (weld $(b p.b) $(b q.b))
--
::
::::
  ::
|=  {sel/term who/ship bow/bowl}
%+  ames-tell-got  sel
.^(ames-tell %a /(scot %p our.bow)/tell/(scot %da now.bow)/(scot %p who))
