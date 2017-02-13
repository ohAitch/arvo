::
::::  /hoon/paste/write/mar
  ::
/?    310
=,  format
::
|_  {who/@txname loc/@txloc}
++  grab
  |%
  ++  noun  {@txname @txloc}
  ++  json  =>(dejs (ot who+so loc+so ~))
  --
--
