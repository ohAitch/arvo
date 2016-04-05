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
  =+  [rac=(clan him) his=(~(get ja wil) him)]
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
      ?:  ?=($pawn rac)  
        ?>(signed-by-sein %&)
      ?>  ?~(sig-sein.cur %& signed-by-sein)
      (self-signed-with pre)
    ::
    ++  self-signed-with
      |=  her/new-deed  ^+  %&
      (sure pub.dat.her (need sig-self.cur) dat.cur)
    ::
    ++  signed-by-sein
      ^+  %&
      ?~  sig-sein.cur  !!
      =+  sen=u.sig-sein.cur
      =+  her=(snag lyf.sen (will-sein who.sen))
      ?>  expiry(cur her, now tym.dat.cur)
      (sure pub.dat.her sig.sen dat.cur)
    ::
    ++  will-sein      
      |=  her/ship  ^-  will
      =;  y/$&  (~(get ja wil) her)   ::  restructure into ++verify?
      ?>  ^^$(him her)
      ?+  rac  ~|(sein-disallowed+[rac her] !!)
        $king  ?>(=(%czar (rank her)) %&)
        $duke  ?>(=(%king (rank her)) %&)
      ==
    ::
    ++  launch
      ?-    rac
          ?($king $duke $earl)
        ?>(signed-by-sein %&)
      ::
          $pawn
        ?>  =(him (fingerprint pub.dat.cur))
        (self-signed-with cur)
      ::
          $czar
        ?>  =((zeno him) (fingerprint pub.dat.cur))
        (self-signed-with cur)
      ==
    --
  --
::
++  update
  |=  {who/ship now/@da wil/(map ship new-will) ole/(map ship new-will)}
  ^-  new-will
  ?>  (verify who now wil)
  ?>  (extends who wil ole)
  (~(get ja wil) who)
::
++  extends
  |=  {who/ship wil/(map ship new-will) ole/(map ship new-will)}
  ^+  %&
  =+  rac=(clan who)
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
  ?>  =(lyf.sen (lent (~(get ja wil) who.sen)))
  %&
--
