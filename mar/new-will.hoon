/-  new-will
|_  wil/new-will
++  grow
  |%
  ++  json
    :-  %a
    %+  turn  wil
    |=  dee/deed:new-will
    %-  jobe  :~
      sig+(jape (sifo sig.dee))
      pub+(jape (sifo pub.dee))
      tym+(jape <`@da`tym.dee>)
      who+(jape +:<`@p`who.dee>)
      lyf+(jone lyf.dee)
    ==
  ++  tree-elem
    ?~  wil  ;div.will.error: Empty will
    ;div.will
      ;h2: Will for {<who.i.wil>}
      ;*  |-  ^-  marl
          :_  ?~(t.wil ~ [;h4:"Using" $(wil t.wil)])
          =+  i.wil
          ;blockquote.blockquote.deed
            ;p: pubkey ;{code "{(scow %uw pub)}"}
            ;p: {<who>} #{<lyf>}, issued at {<tym>}
            ;p
              ; signature ;{code "{(scow %uw sig)}"} on
              ; ;{code "{~(rend co many+~[$+uw+pub $+da+tym $+p+who $+ud+lyf])}"}
            ==
    ==    ==
  --
++  verify  |=(a/new-will a)  ::  XX crypto logic
++  grab
  |%
  ++  noun    |=(a/* (verify (new-will a)))
  ++  json
    =+  jo
    |^  |=(a/json (verify `new-will`(need (will a))))
    ++  will  (ar deed)
    ++  deed
      %-  ot  :~
        sig+so64
        pub+so64
        tym+time
        who+(su fed:ag)
        lyf+ni
      ==
    ++  so64  (cu ofis so)
    ++  time  (ci |=(a/@t `(unit @da)`(slaw %da a)) so)
    --
  ++  mime
    |=  a/^mime  ^-  new-will
    (json (need (poja q.q.a)))
  --
++  grad
  |%
  ++  form  %new-will
  ++  pact
    |=  dif/new-will  ^-  new-will
    =;  err  ?~(err dif ~|([wil=wil neu=dif] ~_(err !!)))
    =:  wil  (flop wil)
        dif  (flop (verify dif))
      ==
    |-  ^-  $@($~ tank)
    ?~  wil  ~
    ?~  dif  >[%shorter-will]<
    ?.  =(i.wil i.dif)  >[deed-mismatch+[i.wil i.dif]]<
    $(wil t.wil, dif t.dif)
  ::
  :: a will accpetable as a patch is a valid diff
  ++  diff  |=(dif/new-will (pact dif))
  ++  join
    |=  {ali/new-will bob/new-will}  ^-  (unit new-will)
    ?:  =(ali bob)  `ali
    ?:  =((lent ali) (lent bob))
      ~&(will-join-mismatch+[ali bob] ~)  
    ?:  (lth (lent ali) (lent bob))
      `(pact(wil ali) bob)
    `(pact(wil bob) ali)
  --
--