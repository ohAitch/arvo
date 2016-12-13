::  Last recieved message from a ship
::
::::  /hoon/ames-last-seen/lib
  ::
|%
++  ames-tell                                           ::  .^ a+/=tell= type
  |^  {p/(list elem) q/(list elem)}                     ::
  ++  elem  $^  {p/elem q/elem}                         ::
            {term p/*}                                  ::  underspecified
  --                                                    ::
--
::                                                      ::  ::
::::                                                    ::  ::
  ::                                                    ::  ::
|%
++  ames-grab                                           :: XX better ames scry
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
::::  Main interface
  ::
|=  {now/time him/ship}  ~+  ^-  (unit time)
?:  =(him our)  (some now)
%-  (hard (unit time))
~|  ames-look+/(scot %p our)/tell/(scot %da now)/(scot %p him)
%+  ames-grab  %rue
.^(ames-tell %a /(scot %p our)/tell/(scot %da now)/(scot %p him))
