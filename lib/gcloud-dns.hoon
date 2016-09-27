|%
++  project  {id/term zones/(map term managed-zone)}
++  managed-zone  {id/@u dns-name/name records/(jug name {ttl record})}
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
      {$managed-zone id/@u name/term dns-name/name description/@t}
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
++  encode
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
++  request
  |=  {mef/meth pax/path bod/(unit json)}  ^-  hiss
  =/  url  (need (epur 'https://www.googleapis.com/dns/v1/projects'))
  =.  q.q.url  (welp q.q.url pax)
  :+  url  mef
  ?~  bod  [~ ~]
  :-  (my content-type+['application/json']~ ~)
  `(tact (pojo u.bod))
::
++  proj
  =>  |%
      ++  get   |=(a/path (request %get a ~))
      ++  delt  |=(a/path (request %delt a ~))
      ++  post  |=(a/path |=(b/resource (request %post a `(encode b))))
      --
  |_  {project/@t zone/@t}
  :: Atomically update the ResourceRecordSet collection.
  ++  changes-create        (post /[project]/'managedZones'/[zone]/changes)
  :: Fetch the representation of an existing Change.
  ++  changes-get  |=(id/@t (get /[project]/'managedZones'/[zone]/changes/[id]))
  :: Enumerate Changes to a ResourceRecordSet collection.
  ++  changes-list          (get /[project]/'managedZones'/[zone]/changes)
  :: Create a new ManagedZone.
  ++  zone-create           (post /[project]/'managedZones')
  :: Delete a previously created ManagedZone.
  ++  zone-delete           (delt /[project]/'managedZones'/[zone])
  :: Fetch the representation of an existing ManagedZone.
  ++  zone-get              (get /[project]/'managedZones'/[zone])
  :: Enumerate ResourceRecordSets that have been created but not yet deleted.
  ++  records-list          (get /[project]/'managedZones'/[zone]/rrsets)
  :: Enumerate ManagedZones that have been created but not yet deleted.
  ++  zone-list             (get /[project]/'managedZones')  :: ignores zone
  :: Fetch the representation of an existing Project.
  ++  project-get           (get /[project])                 :: ignores zone
  --
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
  ::
  ++  project
    %+  kind  'dns#project'
    (ot id+so ~)
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
