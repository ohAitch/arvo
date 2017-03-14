::  API: input oauth1 application credentials for domain
::
::::  /hoon/init-oauth1/hood/gen
  ::
/?  314
/-  gene
::
::::
  ::
=>  [gene g=dsl:gene]
:-  %ask
|=  $:  {now/@da eny/@uvJ bec/beak}
        {arg/$@($~ {dom/path $~})}
        $~
    ==
^-  (result {$write-sec-atom p/host q/@})
=-  ?~  arg  -
    (fun.q.q [%& dom.arg])
%+  lo.g  [%& %oauth-hostname "api hostname: https://"]
%+  go.g  thos:urlp
|=  hot/host
?:  ?=($| -.hot)
  ~|(%ips-unsupported !!)
%+  lo.g  [%& %oauth-client "consumer key: "]
%+  go.g  (boss 256 (star prn))
|=  key/@t
%+  lo.g  [%& %oauth-secret "consumer secret: "]
%+  go.g  (boss 256 (star prn))
|=  sec/@t
%+  so.g  %write-sec-atom    :: XX typed pair
[hot (role key sec ~)]
