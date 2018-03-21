::
::  /app/fora/hoon
::
::TODO  maybe stop relying on %hood one day.
::
/-  hall
/+  hall, time-to-id
=,  format
=,  title
::
|%
++  move  (pair bone card)
++  card
  $%  {$poke wire dock poke}
      {$exec wire @p $~ {beak silk:ford}}
      {$info wire @p toro:clay}
  ==
++  poke
  $%  {$hall-action action:hall}
      {$write-fora-post spur ship cord cord}
      {$write-comment spur ship cord}
  ==
--
::
|%
++  starts-with
  |=  [a=@t b=@t]
  =(a (end 3 (met 3 a) b))
--
::
|_  {bol/bowl:gall $~}
::
++  prep
  |=  old/(unit $~)
  ^-  (quip move _..prep)
  ?^  old  [~ ..prep(+<+ u.old)]
  :_  ..prep
  :~  (act %create %fora-posts 'fora posts' %journal)
      (act %create %fora-comments 'fora comments' %journal)
  ==
::
++  act
  |=  a/action:hall
  ^-  move
  [ost.bol %poke / [our.bol %hall] %hall-action a]
::
++  ra-base-hart  .^(hart:eyre %e /(scot %p our.bol)/host/(scot %da now.bol))
::
++  poke-fora-post-code
  |=  {pax/path sup/spur hed/@t txt/@t cod/@t}
  ^-  (quip move _+>)
  ?:  (starts-with '::PLACEHOLDER' cod)
    ~|(%posted-dummy-code !!)
  =.  txt  (rap 3 txt '\0a```\0a' cod '\0a```\0a' ~)
  (poke-fora-post pax sup hed txt)
::
++  poke-fora-post
  |=  {pax/path sup/spur hed/@t txt/@t}
  ^-  (quip move _+>)
  :_  +>
  :~  %-  act
      :+  %phrase  [[our.bol %fora-posts] ~ ~]
      :_  ~
      :+  %app  dap.bol
      :+  %fat
        :+  %name
          (crip "post by {(cite src.bol)}: {(trip hed)}")
        text+(to-wain txt)
      =.  pax  (welp pax /posts/(crip "{<now.bol>}~"))
      [%url [ra-base-hart `pax ~] ~]
    ::
      :*  ost.bol
          %poke
          /fora-post
          [our.bol %hood]
          [%write-fora-post sup src.bol hed txt]
      ==
  ==
::
++  poke-fora-comment
  |=  {pax/path sup/spur txt/@t}
  ^-  (quip move _+>)
  :_  +>
  :~  ^-  move
      %-  act
      :+  %phrase  [[our.bol %fora-comments] ~ ~]
      :_  ~
      :+  %app  dap.bol
      ^-  speech:hall
      :+  %fat
        :+  %name
          =+  nam=?~(sup "" (trip i.sup))
          (crip "comment by {(cite src.bol)} on /{nam}")
        text+(to-wain txt)
      =+  fra=(crip (time-to-id now.bol))
      [%url [ra-base-hart `pax ~] `fra]
    ::
      :*  ost.bol
          %poke
          /fora-comment
          [our.bol %hood]
          [%write-comment sup src.bol txt]
      ==
  ==
--
