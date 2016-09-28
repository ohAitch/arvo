/+  gcloud-dns, ames-grab
|%
++  goog-req  _!!
++  move  {bone card}
++  card
  $%  {$hiss wire {$~ $~} _-:*result:gcloud-dns {$gcloud-dns-req request:gcloud-dns}}
      {$diff result:gcloud-dns}
  ==
++  axle  {$1 sav/(map ship host)}
--
::
::::
  ::
|%  :: XX constants
++  project  %tonal-griffin-853
++  zone     %urbit-one
++  zone-host  `path`/one/urbit
++  ttl  300  :: XX configure at all
--
::
::::
  ::
|%
++  parse-hostname  |=(a/cord (flop `path`(rash a (plus ;~(sfix dlab:urlp dot)))))
++  print-hostname  |=(a/(list @t) (rap 3 (turn (flop a) |=(a/@t (cat 3 a '.')))))
++  host-to-record
  |=  a/host  ^-  record:gcloud-dns
  ?-  -.a
    $|  a+[p.a]~
    $&  cname+(print-hostname p.a)
  ==
::
++  record-to-host
  |=  a/record:gcloud-dns  ^-  (unit host)
  ?+  -.a  ~
    $cname  `&+(parse-hostname p.a)
    $a      ?+(p.a ~ {@ $~} `|+i.p.a)  :: XX handle multiple ips
  ==
++  make-records
  |=  a/(map ship host)  ^-  (list record-set):gcloud-dns
  =-  (sort - aor)
  %+  turn  (~(tap by a))
  |=  {ship/ship host/host}  ^-  record-set:gcloud-dns
  =/  hostname  (welp zone-host /(crip +:<ship>))
  [(print-hostname hostname) ttl (host-to-record host)]
--
::
::::
  ::
=|  mow/(list move)
|_  {bowl axle}
++  abet  [mow .(mow ~)]
++  emit  |=(a/card +>(mow :_(mow [ost a])))
++  emit-req  
  |=  {a/wire b/request:gcloud-dns}
  =/  mar  (response-mark:gcloud-dns &2.b)
  (emit %hiss a `~ mar gcloud-dns-req+b)
::
++  poke-noun
  |=  *  =<  abet
  =.  emit-req  (emit-req / project %changes-list zone)
  .
::
++  poke-gcloud-ships
  |=  a/(map ship host)  =<  abet
  =.  sav  a
  (emit-req /update project %records-list zone)
::
++  poke-gcloud-dns-me
  |=  $~  =<  abet
  ~&  dns-me+[src ;;((unit lane) (ames-grab %lun src +<-.abet))]
  .
::
++  sigh-gcloud-dns-records-list-update
  |=  {wire a/(list record-set):gcloud-dns}  =<  abet
  =/  got/(map ship host)
    %-  malt
    %+  murn  a
    |=  {host/@t @u rec/record:gcloud-dns}
    =/  dom/path  (parse-hostname host)
    ?>  =(zone-host (scag (lent zone-host) dom))
    =.  dom  (slag (lent zone-host) dom)
    ?.  ?=({@t $~} dom)  ~
    %+  both  (rush i.dom fed:ag)
    (record-to-host rec)
  =+  [add=(~(dif in sav) got) del=(~(dif in got) sav)]
  ~&  update+-
  ?:  =([~ ~] -)  +>.$
  =/  change  [| (make-records add) (make-records del)]
  ~&  change
  (emit-req /do-update project %changes-create zone change)
::
++  sigh-gcloud-dns-change
  |=  {wire a/change:gcloud-dns}  =<  abet
  ~&  a
  .
::
++  sigh-tang  |=({wire a/tang} (mean a))
++  sigh-gcloud-dns-changes-list
  |=  {wire a/(list change:gcloud-dns)}  =<  abet
  ~&  a
  .
::
++  sigh-gcloud-dns-records-list-peer
  |=  {wire a/(list record-set):gcloud-dns}  =<  abet
  (emit %diff gcloud-dns-records-list+a)
::
++  peek  _~
++  peer-scry-x-records
  |=  a/path  =<  abet
  ?^  a  !!
  (emit-req /peer project %records-list zone)
--
