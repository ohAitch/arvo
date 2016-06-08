::  Tlon long-poll proxy command
::
::::  /hoon/long/tlon/mar
  ::
/-  tlon
[. tlon]
|_  {har/hart req/long-call}
++  grab
  |%
  ++  noun  {hart long-call}
  --
++  grow
  |%
  ++  hiss
    ^-  ^hiss
    =+  quy=?-(-.req $invalidate (turn p.req |=(a/path [(crip (spud a)) ''])))
    :-  [har `/'_'/[-.req] quy]
    [%post (my accept+['application/json']~ ~) ~]
  --
--
