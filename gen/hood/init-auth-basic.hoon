::  API: input basic auth credentials for domain
::
::::  /hoon/init-auth-basic/hood/gen
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
%+  lo.g  [%& %auth-user "username: "]
%+  go.g  (boss 256 (star ;~(less col prn)))
|=  usr/@t
%+  lo.g  [%| %auth-passwd "password: "]
%+  go.g  (boss 256 (star prn))
|=  pas/@t
%+  so.g  %write-sec-atom    :: XX typed pair
[hot (crip (sifo (rap 3 usr ':' pas ~)))]
