/=  gas  /$  fuel
=<  apex
=+  [wid=10 tol=20]
:: =+  [wid=8 tol=5]
=/  board  (reap tol (reap wid ' '))
=/  rand  ~(. og 'tetris!')
=^  typ  rand  (rads:rand 10)
=^  sym  rand  (rads:rand 4)
=/  rot  0
|%
:: ++  dim  |=(a/@u (scow %ud (mul 10 a)))
:: ++  sq   |=  {fil/tape x/@u y/@u d/@u}
::          ;rect(x (dim x), y (dim y), height (dim d), width (dim d), fill fil);
:: ++  red  (cury sq "red")
:: ++  blue  (cury sq "blue")
:: ++  green  (cury sq "green")
:: ++  step
::   ;svg(width (dim 16), height (dim 16))
::     ;+  (red 0 0 4)
::     ;+  (blue 0 4 4)
::     ;+  (green 4 0 4)
::   ==
++  steps  (cass (trip (crip (~(tap in ~(key by qix.gas))))))
++  xss  ;script:'''
                 window.onkeypress = ({key}) => document.location.search += key
                 setTimeout((()=> document.location.search += '_'), 500)
                 '''
::
++  next
  =^  typ  rand  (rads:rand 10)
  =^  sym  rand  (rads:rand 4)
  ..next(typ typ, sym sym, rot 0)
++  tetrs
  ^-  (list wall)
  :~  :~  "####"
      ==
      :~  "##"
          "##"
      ==
      :~  "###"
          "  #"
      ==
      :~  " ##"
          "## "
      ==
      :~  "###"
          " # "
  ==  ==
::
++  rotate
  |=  tet/wall
  =.  tet  (flop tet)
  |-  ^+  tet
  ?:  (levy tet |=(a/tape =(~ a)))
    ~
  :-  (turn tet head)
  $(tet (turn tet tail))
::
++  paint
  |=  {rep/char a/wall}
  %+  turn  a
  |=  b/tape
  %+  turn  b
  |=  c/char
  ?:  =(' ' c)  c
  rep
::
++  tetr
  ^-  wall
  ?.  =(0 rot)  (rotate tetr(rot (dec rot)))
  %+  paint  (snag sym "@#%*")
  =/  tet  (snag (rsh 0 1 typ) tetrs)
  ?~  (end 0 1 typ)  tet
  (flop tet)
::
++  tetr-wid  (roll (turn tetr lent) max)
::
++  intersects
  |=  {{x/@u y/@u} new/wall}  ^-  ?
  ?~  new  |
  ?~  board  &
  ?.  =(0 y)  $(board t.board, y (dec y))
  ?|  (t-intersects (runt [x ' '] i.new) i.board)
      $(board t.board, new t.new)
  ==
++  t-intersects
  |=  {a/tape b/tape}  ^-  ?
  ?~  a  |
  ?~  b  |
  ?:  =(' ' i.a)  $(a t.a, b t.b)
  ?:  =(' ' i.b)  $(a t.a, b t.b)
  &
::
++  place
  |=  {{x/@u y/@u} new/wall}  ^+  board
  ?~  new  board
  ?~  board  ~|(%too-low !!)
  ?.  =(0 y)  [i.board $(board t.board, y (dec y))]
  :_  $(board t.board, new t.new)
  (t-join (runt [x ' '] i.new) i.board)
::
++  t-join
  |=  {a/tape b/tape}  ^+  b
  ?~  a  b
  ?~  b  ~|(%too-long !!)
  ?:  =(' ' i.a)  [i.b $(a t.a, b t.b)]
  ?:  =(' ' i.b)  [i.a $(a t.a, b t.b)]
  ?:  =('.' i.b)  [i.a $(a t.a, b t.b)]
  ~|([%collision i.a i.b] !!)
::
::
++  ghost
  =|  y/@
  |=  {x/@ new/wall}
  ?.  (intersects [x +(y)] new)
    $(y +(y))
  (place [x y] (paint '.' new))
::
++  clear-lines
  =|  clr/@
  =.  board  (flop board)
  %-  flop
  |-  ^+  board
  ?~  board  (reap clr (reap wid ' '))
  ?:  (lien i.board |=(a/char =(a ' ')))
    [i.board $(board t.board)]
  $(clr +(clr), board t.board)
::
++  decorate
  |=  a/wall  ^+  a
  :-  "/{(turn ?~(a !! i.a) _'-')}\\"
  %+  welp  (turn a |=(b/tape "|{b}|"))
  ["\\{(turn ?~(a !! i.a) _'-')}/"]~
::
::
++  accept
  |=  {{x/@ y/@} new/wall}  ^+  +>
  =.  board  (place [x y] new)
  =.  board  clear-lines
  next
::
++  output
  %-  flop
  ^-  wall
  :-  [(crip (poxo xss))]~
  %-  decorate
  =+  [x=(dec (div wid 2)) y=0]
  =/  eve  steps
  |-  ^+  board
  =^  key  eve  ?~(eve [~ eve] eve)
  =.  a.rand  (shas key a.rand)
  ?+    key  $
      $~
    =.  board  (ghost x tetr)
    (place [x y] tetr)
  ::
      $a
    $(x ?:(=(0 x) x (dec x)))
  ::
      $d
    $(x ?:(=((sub wid tetr-wid) x) x +(x)))
  ::
      $w  $(rot +(rot))
      $s
    |-
    ?.  (intersects [x +(y)] tetr)
      $(y +(y))
    =.  place  (accept [x y] tetr)
    ^$(y 0, x (dec (div wid 2)))
  ::
      $'_'
    ?.  (intersects [x +(y)] tetr)
      $(y +(y))
    =.  place  (accept [x y] tetr)
    $(y 0, x (dec (div wid 2)))
  ==
::
++  apex
  %+  fear  (turn output |=(a/tape leaf+a))  |.
  !!
--
