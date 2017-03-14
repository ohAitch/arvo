::  API: input auth2 client_secret_*.json for .googleapis.com
::
::::  /hoon/google/init-oauth2/hood/gen
  ::
/?  314
/-  gene
::
::::
  ::
=>  [gene g=dsl:gene]
:-  %ask
|=  $:  {now/@da eny/@uvJ bec/beak}
        {arg/$@($~ {jon/json $~})}
        $~
    ==
^-  (result {$write-sec-atom p/host q/@})
%+  yo.g  leaf+"Accepting credentials for https://*.googleapis.com"
=+  hot=[%& /com/googleapis]
=-  ?~  arg  -
    (fun.q.q jon.arg)
%+  lo.g  [%& %oauth-json "json credentials: "]
%+  go.g  apex:poja
|=  jon/json
=+  ~|  bad-json+jon
    =-  `{cid/@t cis/@t}`(need (rep jon))
    rep=(ot web+(ot 'client_id'^so 'client_secret'^so ~) ~):jo
%+  so.g  %write-sec-atom    :: XX typed pair
[hot (role cid cis ~)]
