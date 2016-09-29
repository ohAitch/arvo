::  /hoon/gcloud-dns/lib
::
::::  Types, encodes, are decoders for interacting with Google DNS
  ::
/?    310
::                                                      ::::
::::                                                    ::  base types
  ::                                                    ::::
  ::  ~fyr
|%
++  record                                              ::  type and data
  $%  {$a p/(list @if)}                                 ::  IPv4 addresses
      {$aaaa p/(list @tis)} :: XX @is                   ::  IPv6 addresses
      {$cname p/name}                                   ::  domain alias
      {$'*' p/@t q/(list @t)}                           ::  "freeform" fallback
  ==
::
::  ResourceRecordSet: domain name, time to live, and records of one type
::
++  record-set  {name ttl record}                       ::
++  change                                              ::  modify rrsets
  $:  done/?                                            ::  change completed
      additions/(list record-set)                       ::  add records
      deletions/(list record-set)                       ::  del records
  ==
++  name  @t                                            ::  domain name
++  ttl  @u                                             ::  expiry in seconds
++  managed-zone                                        ::  top domain config
  $:  name/term                                         ::  identifier
      dns-name/name                                     ::  domain
      description/@t                                    ::  human-readable info
  ==
++  project  term                                       ::  project id
--
::                                                      ::::
::::                                                    ::  mark types
  ::                                                    ::::
|%
++  resource                                            ::  remote datum
  $%  {$record-set record-set}                          ::  resource record set
      {$project p/term}  :: XX useful?                  ::  gcloud api scope-set
      {$change change}                                  ::  rrset modifications
      {$managed-zone managed-zone}                      ::  dns domain
  ==
++  request                                             ::  api endpoints
    $:  project/term                                    ::  project id
    ::
    $%  ::  Atomically update the ResourceRecordSet collection
        {$changes-create zone/term change/change}   
        ::  Fetch the representation of an existing Change.
        {$changes-get zone/term id/@t}              
        ::  Enumerate Changes to a ResourceRecordSet collection.
        {$changes-list zone/term}                   
        ::  Create a new ManagedZone.
        {$zone-create managed-zone/managed-zone}  
        ::  Delete a previously created ManagedZone.
        {$zone-delete zone/term}                    
        ::  Fetch the representation of an existing ManagedZone.
        {$zone-get zone/term}                       
        ::  Enumerate ManagedZones that have been created but not yet deleted.
        {$zones-list $~}                          
        ::  Enumerate ResourceRecordSets that have been created but not yet
        ::  deleted.
        {$records-list zone/term}                   
        ::  Fetch the representation of an existing Project.
        {$project-get $~}                         
    ==
  ==
++  result                                              ::  api resources
  $%  {$gcloud-dns-ack $~}                              ::  deletion success
      {$gcloud-dns-change change}                       ::  rrset change
      {$gcloud-dns-changes-list (list change)}          ::  zone rrset changes
      {$gcloud-dns-zone managed-zone}                   ::  domain config
      {$gcloud-dns-zones-list (list managed-zone)}      ::  all config'd domains
      {$gcloud-dns-records-list (list record-set)}      ::  zone resource records
      {$gcloud-dns-project project}                     ::  project name
  ==
::
:: ::
:: ::::  /hoon/{{name}}/gcloud-dns/mar
::   ::
:: /+  gcloud-dns
:: |_  own/{{type}}:gcloud-dns
:: ++  grab
::   |%
::   ++  noun  {{type}}:gcloud-dns
::   ++  json  (corl need {{name}}:decode:gcloud-dns)
::   --
:: --
::
++  response-mark                                       ::  expected response
  |=  a/_&2:*request  ^+  -:*result
  ?-  a  :: XX namespacing
    $changes-create  %gcloud-dns-change                 ::  change accepted
    $changes-get     %gcloud-dns-change                 ::  change retrieved
    $changes-list    %gcloud-dns-changes-list           ::  changes retrieved
    $zone-create     %gcloud-dns-zone                   ::  zone accepted
    $zone-delete     %gcloud-dns-ack                    ::  zone del succesful
    $zone-get        %gcloud-dns-zone                   ::  zone retrieved
    $records-list    %gcloud-dns-records-list           ::  records retrieved
    $zones-list      %gcloud-dns-zones-list             ::  zones retrieved
    $project-get     %gcloud-dns-project                ::  project retrieved
  ==
--
::                                                      ::::
::::                                                    ::  json handling
  ::                                                    ::::
|%  
++  type  +                                             ::  context anchor
++  encode                                              ::  $-(* json)
  |%
  ++  record-set                                        ::  ++record-set:encode
    |=  {name/name ttl/ttl record/record}  ^-  json     ::  trivial
    %-  jobe  :~
       kind+s+'dns#resourceRecordSet'
       name+s+name
       ttl+(jone ttl)
       type+s+(cuss (trip ?+(-.record -.record $'*' p.record)))
       :+  %rrdatas  %a  ^-  (list json)
       ?-  -.record
         $a  (turn p.record |=(b/@if (jape +:<b>)))
       ::   $aaaa  (turn p.record |=(b/@is (jape +:<b>)))
         $aaaa  (turn p.record |=(b/@t s+b))
         $cname  [s+p.record]~
         $'*'  (turn q.record |=(b/@t s+b))
       ==
    ==
  ::
  ++  resource                                          ::  ++resource:encode                       
    |=  a/resource.type  ^-  json                       ::  trivial
    ?-    -.a
        $project  ~|(%read-only !!)
        $record-set  (record-set +.a)
        $change
      %-  jobe   :~
        kind+s+'dns#change'
        additions+a+(turn additions.a record-set)
        deletions+a+(turn deletions.a record-set)
      ==
    ::
        $managed-zone
      %-  jobe  :~
        kind+s+'dns#managedZone'
        name+s+name.a
        'dnsName'^s+dns-name.a
        description+s+description.a
      ==
    ==
  ::
  ++  api-call                                          ::  ++api-call:encode
    |=  {mef/meth pax/path bod/(unit json)}  ^-  hiss   ::  construct http req
    =/  url
      (need (epur 'https://www.googleapis.com/dns/v1/projects'))
    =.  q.q.url  (welp q.q.url pax)
    :+  url  mef
    ?~  bod  [~ ~]
    :-  (my content-type+['application/json']~ ~)
    `(tact (pojo u.bod))
  ::
  ++  request                                          ::  ++request:encode
    =>  |%                                             ::  $-(request json)
        ++  get   |=(a/path (api-call %get a ~))
        ++  delt  |=(a/path (api-call %delt a ~))
        ++  post  |=({a/path b/resource.type} (api-call %post a `(resource b)))
        --
    |=  request.type  ^-  hiss
    ?-  &2.+<
      $changes-create  (post /[project]/'managedZones'/[zone]/changes change+change)
      $changes-get     (get /[project]/'managedZones'/[zone]/changes/[id])
      $changes-list    (get /[project]/'managedZones'/[zone]/changes)
      $zone-create     (post /[project]/'managedZones' managed-zone+managed-zone)
      $zone-delete     (delt /[project]/'managedZones'/[zone])
      $zone-get        (get /[project]/'managedZones'/[zone])
      $records-list    (get /[project]/'managedZones'/[zone]/rrsets)
      $zones-list      (get /[project]/'managedZones')
      $project-get     (get /[project])
    ==
  --
::
++  decode                                              ::  $-(json (unit))
  =+  jo
  |%
  ++  kind                                              ::  ++kind:decode
    |*  {kind/cord paz/fist:jo}                         ::  check .kind prop
    |=  a/json
    =+  (need ((ot kind+so ~):jo a))
    ?.  =(- kind)  ~|(bad-kind+[- kind] !!)
    (paz a)
  ::
  ::
  ++  changes-list                                      ::  ++changes-list:de
    %+  kind  'dns#changesListResponse'                 ::  (list change)
    (ot changes+(ar change) ~)
  ::
  ++  records-list                                      ::  ++records-list:de
    %+  kind  'dns#resourceRecordSetsListResponse'      ::  (list record-set)
    (ot rrsets+(ar record-set) ~)
  ::
  ++  zones-list                                        ::  ++zones-list:de
    %+  kind  'dns#managedZonesListResponse'            ::  (list managed-zone)
    (ot 'managedZones'^(ar managed-zone) ~)
  ::
  ::
  ++  project                                           ::  ++project:decode
    %+  kind  'dns#project'                             ::  trivial
    (ot id+so ~)
  ::
  ++  managed-zone                                      ::  ++managed-zone:de
    %+  kind  'dns#managedZone'                         ::  trivial
    (ot name+so 'dnsName'^so description+so ~)
  ::
  ++  parse-status  ~(get by (my pending+| done+& ~))   ::  ++parse-status:de
  ++  status  (ci parse-status so)                      ::  ++status:decode
  ++  change                                            ::  ++change:decode
    %+  kind  'dns#change'                              ::  handles opt props
    ::  (ot status+status additions+(ar record-set) deletions+(ar record-set) ~)
    |=  a/json  ^-  (unit change.type)
    ?.  ?=($o -.a)  ~
    %+  both  %.(a (ot status+status ~))
    %-  some
    :-  %+  biff  (~(get by p.a) %additions)            ::  optional .additions
        |=(a/json (need %.(a (ar record-set))))
    %+  biff  (~(get by p.a) %deletions)                ::  optional .deletions
    |=(a/json (need %.(a (ar record-set))))
  ::
  ++  record-set                                        ::  ++record-set:decode
    %+  kind  'dns#resourceRecordSet'                   ::  mostly trivial
    %+  cu  |=({a/term b/@u c/{term wain}} [a b (parse-record c)])
    (ot name+so ttl+ni type+so rrdatas+(ar so) ~)
  ::
  ++  parse-record                                      ::  ++parse-record:decode
    |=  {type/term rrdatas/wain}  ^-  record            ::  decode by type
    =.  type  (cass (trip type))
    ?.  ?=(_-:*record type)
      [%'*' type rrdatas]                               ::  wrap unknown types
    ?-  type
      $'*'    !! :: types are alphanumeric
      $a      [type (turn rrdatas parse-record-a)]      ::  A ipv4 addresses
      $aaaa   [type rrdatas]                            ::  AAAA ipv6 addresses
      $cname  [type ?+(rrdatas !! {@t $~} i.rrdatas)]   ::  CNAME domain alias
    ==
  ++  parse-record-a  |=(a/@t `@if`(rash a lip:ag))     ::  x.x.x.x
  --
--
