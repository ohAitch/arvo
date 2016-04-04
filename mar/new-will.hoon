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
++  grab
  |%
  ++  noun  new-will
  ++  json
    =+  jo
    |^  |=(a/json `new-will`(need (will a)))
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
++  grad  %mime
--