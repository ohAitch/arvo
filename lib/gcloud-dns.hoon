|%
++  project  {id/term zones/(map term zone-contents)}
++  zone-contents  {id/@u dns-name/name records/(jug name {ttl record})}
++  managed-zone  {name/term dns-name/name description/@t}
++  record
  $%  {$a p/(list @if)}
      {$aaaa p/(list @tis)} :: XX @is
      {$cname p/name}
      {$'*' p/@t q/(list @t)}
  ==
++  record-set  {name ttl record}
++  change  {done/? additions/(list record-set) deletions/(list record-set)}
++  name  @t
++  ttl  @u
++  resource
  $%  {$record-set record-set}
      {$project p/term}  :: XX useful?
      {$change change}
      {$managed-zone managed-zone}
  ==
++  request
    $:  project/term
    $%  {$changes-create zone/@t change/change}   :: Atomically update the ResourceRecordSet collection
        {$changes-get zone/@t id/@t}              :: Fetch the representation of an existing Change.
        {$changes-list zone/@t}                   :: Enumerate Changes to a ResourceRecordSet collection.
        {$zone-create managed-zone/managed-zone}  :: Create a new ManagedZone.
        {$zone-delete zone/@t}                    :: Delete a previously created ManagedZone.
        {$zone-get zone/@t}                       :: Fetch the representation of an existing ManagedZone.
        {$zones-list $~}                           :: Enumerate ManagedZones that have been created but not yet deleted.
        {$records-list zone/@t}                   :: Enumerate ResourceRecordSets that have been created but not yet deleted.
        {$project-get $~}                         :: Fetch the representation of an existing Project.
    ==
  ==
++  result
  $%  {$gcloud-dns-change change}
      {$gcloud-dns-changes-list (list change)}
      {$gcloud-dns-zone managed-zone}
      {$gcloud-dns-zones-list (list managed-zone)}
      {$gcloud-dns-ack $~}
      {$gcloud-dns-records-list (list record-set)}
      {$gcloud-dns-project cord}
  ==
--
|%  
++  enc-record-set
  |=  {name/name ttl/ttl record/record}  ^-  json
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
++  enc-resource
  |=  a/resource  ^-  json
  ?-    -.a
      $project  ~|(%read-only !!)
      $record-set  (enc-record-set +.a)
      $change
    %-  jobe   :~
      kind+s+'dns#change'
      additions+a+(turn additions.a enc-record-set)
      deletions+a+(turn deletions.a enc-record-set)
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
++  make-req
  |=  {mef/meth pax/path bod/(unit json)}  ^-  hiss
  =/  url  (need (epur 'https://www.googleapis.com/dns/v1/projects'))
  =.  q.q.url  (welp q.q.url pax)
  :+  url  mef
  ?~  bod  [~ ~]
  :-  (my content-type+['application/json']~ ~)
  `(tact (pojo u.bod))
::
++  encode
  =>  |%
      ++  get   |=(a/path (make-req %get a ~))
      ++  delt  |=(a/path (make-req %delt a ~))
      ++  post  |=({a/path b/resource} (make-req %post a `(enc-resource b)))
      --
  |=  request  ^-  hiss
  ?-  &2.+<
    $changes-create  (post /[project]/'managedZones'/[zone]/changes change+change)
    $changes-get     (get /[project]/'managedZones'/[zone]/changes/[id])
    $changes-list    (get /[project]/'managedZones'/[zone]/changes)
    $zone-create     (post /[project]/'managedZones' managed-zone+managed-zone)
    $zone-delete     (delt /[project]/'managedZones'/[zone])
    $zone-get        (get /[project]/'managedZones'/[zone])
    $records-list    (get /[project]/'managedZones'/[zone]/rrsets)
    $zones-list       (get /[project]/'managedZones')
    $project-get     (get /[project])
  ==
::
++  response-mark
  |=  a/_&2:*request  ^+  -:*result
  ?-  a  :: XX namespacing
    $changes-create  %gcloud-dns-change
    $changes-get     %gcloud-dns-change
    $changes-list    %gcloud-dns-changes-list
    $zone-create     %gcloud-dns-zone
    $zone-delete     %gcloud-dns-ack
    $zone-get        %gcloud-dns-zone
    $records-list    %gcloud-dns-records-list
    $zones-list      %gcloud-dns-zones-list
    $project-get     %gcloud-dns-project
  ==
--
|%
++  kind
  |*  {kind/cord paz/fist:jo}
  |=  a/json
  =+  (need ((ot kind+so ~):jo a))
  ?.  =(- kind)  ~|(bad-kind+[- kind] !!)
  (paz a)
::
++  decode
  =+  jo
  |%
  ++  changes-list
    %+  kind  'dns#changesListResponse'
    (ot changes+(ar change) ~)
  ::
  ++  records-list
    %+  kind  'dns#resourceRecordSetsListResponse'
    (ot rrsets+(ar record-set) ~)
  ::
  ++  zones-list
    %+  kind  'dns#managedZonesListResponse'
    (ot 'managedZones'^(ar managed-zone) ~)
  ::
  ::
  ++  project
    %+  kind  'dns#project'
    (ot id+so ~)
  ::
  ++  managed-zone
    %+  kind  'dns#managedZone'
    (ot name+so 'dnsName'^so description+so ~)
  ::
  ++  change
    %+  kind  'dns#change'
    |=  a/json  ^-  (unit ^change)
    ?.  ?=($o -.a)  ~
    %-  some
    :+  =+  %.(a (ot status+so ~))
        ?~  -  !!
        ?+(u !! $pending |, $done &)
      %+  biff  (~(get by p.a) %additions)
      |=(a/json (need %.(a (ar record-set))))
    %+  biff  (~(get by p.a) %deletions)
    |=(a/json (need %.(a (ar record-set))))
  ::
  ++  record-set
    %+  kind  'dns#resourceRecordSet'
    %+  cu  |=({a/term b/@u c/{term wain}} [a b (parse-record c)])
    (ot name+so ttl+ni type+so rrdatas+(ar so) ~)
  ::
  ++  parse-record
    |=  {type/term rrdatas/wain}  ^-  record
    =.  type  (cass (trip type))
    ?.  ?=(_-:*record type)
      [%'*' type rrdatas]
    ?-  type
      $'*'    !! :: types are alphanumeric
      $a      [type (turn rrdatas |=(a/@t (rash a lip:ag)))]
      $aaaa   [type rrdatas]
      $cname  [type ?+(rrdatas !! {@t $~} i.rrdatas)]
    ==
  --
--
