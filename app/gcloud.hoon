::  /hoon/gcloud-dns/lib
::
::::  Types, encodes, are decoders for interacting with Google DNS
  ::
/?    310
/+  gcloud-dns, ames-grab
::                                                      ::::
::::                                                    ::  base types
  ::                                                    ::::
  ::  ~fyr
|%
++  api-call                                            ::  gcloud round trip
  {_-:*result {$gcloud-dns-req request}}:gcloud-dns     ::  response mark, req
::                                                      ::
++  move  {bone card}                                   ::  output
::                                                      ::
++  card                                                ::  output body
  $%  {$hiss wire {$~ $~} api-call}                     ::  web request
      {$diff result:gcloud-dns}                         ::  peek response
  ==                                                    ::
++  axle  {$1 sav/(map ship host)}                      ::  app state
--
::                                                      ::::
::::                                                    ::  XX constants
  ::                                                    ::::
|% 
++  project  %tonal-griffin-853                         ::  app remote identity
++  zone     %urbit-one                                 ::  dns scope name
++  zone-host  `path`/one/urbit                         ::  dns scope domain
++  ttl  300  :: XX configure at all                    ::  cache longevity
--
::                                                      ::::
::::                                                    ::  state<->rrset coding
  ::                                                    ::::
|%
++  parse-name                                          ::  'me.com.' -> /com/me
  |=  a/name:gcloud-dns  ^-  (list @t)
  (flop `path`(rash a (plus ;~(sfix dlab:urlp dot))))
::
++  record-to-host                                      ::  ip or domain
  |=  a/record:gcloud-dns  ^-  (unit host)
  ?+  -.a  ~
    $cname  `&+(parse-name p.a)
    $a      ?+(p.a ~ {@ $~} `|+i.p.a)  :: XX handle multiple ips
  ==
::
++  records-to-map                                      ::  read ship.zone.host.
  |=  a/(list record-set):gcloud-dns  ^-  (map ship host)
  %-  ~(gas by *(map ship host))
  %+  murn  a
  |=  {host/@t @u rec/record:gcloud-dns}
  =/  dom/path  (parse-name host)
  ?>  =(zone-host (scag (lent zone-host) dom))
  =.  dom  (slag (lent zone-host) dom)
  ?.  ?=({@t $~} dom)  ~
  %+  both  (rush i.dom fed:ag)
  (record-to-host rec)
::
::
++  print-name                                          ::  /com/me -> 'me.com.'
  |=  a/(list @t)  ^-  name:gcloud-dns
  (rap 3 (turn (flop a) |=(a/@t (cat 3 a '.'))))
::
++  host-to-record                                      ::  ip or domain
  |=  a/host  ^-  record:gcloud-dns
  ?-  -.a
    $|  a+[p.a]~
    $&  cname+(print-name p.a)
  ==
::
++  map-to-records                                      ::  bind ship.zone.host.
  |=  a/(map ship host)  ^-  (list record-set):gcloud-dns
  =-  (sort - aor)
  %+  turn  (~(tap by a))
  |=  {ship/ship host/host}  ^-  record-set:gcloud-dns
  =/  name  (welp zone-host /(crip +:<ship>))
  [(print-name name) ttl (host-to-record host)]
--
::                                                      ::::
::::                                                    ::  app core
  ::                                                    ::::
=|  mow/(list move)
::
::  mow: outbound events
::
|_  {bowl axle}
++  abet  [(flop mow) .(mow ~)]                         ::  finish transaction
++  emit  |=(a/card +>(mow :_(mow [ost a])))            ::  add output
++  emit-req                                            ::  add output request
  |=  {a/wire b/request:gcloud-dns}
  =/  mar  (response-mark:gcloud-dns &2.b)
  (emit %hiss a `~ mar gcloud-dns-req+b)
::
::
++  test-zone  `term`(cat 3 zone '--test')              ::  secondary ++zone
++  poke-noun                                           ::  test zone management
  |=  *  =<  abet
  =/  zon  [test-zone (print-name zone-host) 'Test']
  =.  emit-req  (emit-req /test project %zone-create zon)
  .
::
++  sigh-tang  |=({wire a/tang} (mean a))               ::  propogate errors
++  sigh-gcloud-dns-zone-test                           ::  display and clean up
  |=  {wire a/managed-zone:gcloud-dns}  =<  abet
  ~&  created+a
  (emit-req /test project %zone-delete test-zone)
::
++  sigh-gcloud-dns-ack-test                            ::  zone finished
  |=  {wire $~}  =<  abet
  ~&  deleted+test-zone
  .
::
::
++  peek  |=(* `(unit (unit (cask)))`~)                 ::  default block
++  peer-scry-x-records                                 ::  get current DNS
  |=  a/path  =<  abet
  ?^  a  !!
  (emit-req /peer project %records-list zone)
::
++  sigh-gcloud-dns-records-list-peer                   ::  give data
  |=  {wire a/(list record-set):gcloud-dns}  =<  abet
  (emit %diff gcloud-dns-records-list+a)
::
::
++  peek-x-config                                       ::  inpsect state
  |=  a/path
  ?^  a  [~ ~]
  [~ ~ [%gcloud-ships sav]]
::
++  poke-gcloud-ships                                   ::  set ship.foo mapping
  |=  a/(map ship host)  =<  abet
  =.  sav  a
  update-records
::
::  add requesting ship by ames IP
::
++  poke-gcloud-dns-me                                  ::^
  |=  $~  =<  abet
  =/  lun  ;;((unit lane) (ames-grab %lun src +<-.abet))
  ?~  lun  ~|(%no-lane !!)                              :: should never happen
  ?.  ?=($if -.u.lun)
    ::
    ::  insufficient data in ames to configure
    ::
    ~|(bad-lane+u.lun !!)
  =.  sav  (~(put by sav) src %| r.u.lun)
  =.  +>.$  update-records
  .
::
++  poke-gcloud-dns-me-not                              ::  request DNS removal
  |=  $~  =<  abet
  update-records(sav (~(del by sav) src))
::
::
++  update-records                                      ::  sync and push
  (emit-req /update project %records-list zone)
::
::  Send change based on differences 
::
++  sigh-gcloud-dns-records-list-update                 ::^
  |=  {wire a/(list record-set):gcloud-dns}  =<  abet
  ::
  ::  rec: state implied by gcloud resource record sets
  ::
  =/  rec  (records-to-map a)
  =+  [add=(~(dif in sav) rec) del=(~(dif in rec) sav)]
  ~&  update+-
  ::
  ::  update complete if no changes necessary
  ::
  ?:  =([~ ~] -)  +>.$
  =/  change  [| (map-to-records add) (map-to-records del)]
  ~&  change
  (emit-req /do-update project %changes-create zone change)
::
++  sigh-gcloud-dns-change                              ::  update confirmation
  |=  {wire a/change:gcloud-dns}  =<  abet
  ~&  a
  .
::
:: ++  sigh-gcloud-dns-changes-list                     ::  unused
::   |=  {wire a/(list change:gcloud-dns)}  =<  abet
::   ~&  a
::   .
--
