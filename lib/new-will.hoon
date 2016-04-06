/-    new-will
=+  ^new-will                         :: XX namespacing
|%
++  new-deed  deed:new-will
--
|%
++  zeno  _0v0                        ::  XX todo
++  crypto  |=(@ *acru)               ::  XX todo
++  fingerprint  |=(pub/@ *@)         ::  XX todo
++  sure  |=({pub/@ sig/@ dat/*} %&)  ::  XX todo
++  verify
  |=  {him/ship now/@da wil/(map ship new-will)}  ^-  unexpired/?
  =+  his=(~(get ja wil) him)
  ~|  check-will+[him his]
  |^  apex
  ++  apex
    ?~  his  !!
    ?>  ~(launch check i.his)
    |-  ^-  ?
    ?~  t.his  ~(expiry check i.his)
    ?>  (~(succession check i.t.his) i.his)
    $(his t.his)
  ::
  ++  check
    |_  cur/new-deed
    ++  expiry
      ?~  exp.dat.cur  &
      (gth u.exp.dat.cur now)
    ::
    ++  succession
      |=  pre/new-deed  ^+  %&
      ~|  succession-deed+cur
      ?:  ?=($pawn (clan him))  
        ?>(signed-by-sein %&)
      ?>  ?~(sig-sein.cur %& signed-by-sein)
      (self-signed-with pre)
    ::
    ++  self-signed-with
      |=  her/new-deed  ^+  %&
      ~|  %own-signature
      (sure pub.dat.her (need sig-self.cur) dat.cur)
    ::
    ++  signed-by-sein
      ^+  %&
      ?~  sig-sein.cur
        ~|(%no-sein-signature !!)
      =+  sen=u.sig-sein.cur
      ~|  signed-by+who.sen
      =+  her=(snag lyf.sen (will-sein who.sen))
      ?.  expiry(cur her, now tym.dat.cur)
        ~|(expired-sein+[tym.dat.cur sen her] !!)
      (sure pub.dat.her sig.sen dat.cur)
    ::
    ++  will-sein      
      |=  her/ship  ^-  will
      =;  y/$&  (~(get ja wil) her)   ::  restructure into ++verify?
      ?>  ~|(%check-sein ^^$(him her))
      ~|  sein-disallowed+[[(clan him) (clan her)] him her]
      ?+  (clan him)  !!
        $pawn  ?>(=(%czar (clan her)) %&)
        $king  ?>(=(%czar (clan her)) %&)
        $duke  ?>(=(%king (clan her)) %&)
      ==
    ::
    ++  launch
      ~|  launch-deed+cur
      ?-    (clan him)
          ?($king $duke $earl)
        ?^  sig-self.cur  ~|(self-signed+(clan him) !!)
        ?~  sig-sein.cur  ~|(%unsigned !!)
        ?.  =((sein him) who.u.sig-sein.cur)
          ~|(bad-sein+[him=him got=who.u.sig-sein.cur want=(sein him)] !!)
        ?>(signed-by-sein %&)
      ::
          $pawn
        ?^  sig-sein.cur  ~|(sein-signed+(clan him) !!)
        ?>  =(him (fingerprint pub.dat.cur))
        (self-signed-with cur)
      ::
          $czar
        ?^  sig-sein.cur  ~|(sein-signed+(clan him) !!)
        ?>  =((zeno him) (fingerprint pub.dat.cur))
        (self-signed-with cur)
      ==
    --
  --
::
++  update
  |=  {who/ship now/@da wil/(map ship new-will) ole/(map ship new-will)}
  ^-  new-will
  =.  wil  (~(uni by ole) wil)
  ?>  (verify who now wil)
  ?>  (extends who wil ole)
  (~(get ja wil) who)
::
++  extends
  |=  {who/ship wil/(map ship new-will) ole/(map ship new-will)}
  ^+  %&
  =+  old=(~(get ja ole) who)
  =+  new=(~(get ja wil) who)
  =+  [nel=(lent new) oll=(lent old)]
  ?:  (lth nel oll)  !!
  ?:  (gth nel oll)
    ?>  =(old (scag oll new))
    %&
  ::  only check last element
  =:  new  (flop new)     old  (flop old)  ==
  ?~  new  !!             ?~  old  !!
  ?>  =(t.new t.old)
  ?~  sig-sein.i.new  !!  ?~  sig-sein.i.old  !!
  ?>  =(i.new(sig-sein ~) i.old(sig-sein ~))
  =+  sen=u.sig-sein.i.new
  ?>  =(who.sen who.u.sig-sein.i.old)
  ?>  =(lyf.sen (dec (lent (~(get ja wil) who.sen))))
  %&
--
