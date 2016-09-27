|%
++  record
  $%  {$a p/(list @if)}
::       {$aaaa p/(list @is)}
      {$cname p/name}
  ==
++  name  @t
++  ttl  @u
--
|%
++  record-data
  |=  a/record  ^-  (list json)
  ?-  -.a
    $a  (turn p.a |=(b/@if (jape +:<b>)))
::    $aaaa  (turn p.a |=(b/@is (jape +:<b>)))
    $cname  [s+p.a]~
  ==
::
++  resourse-record-set
  |=  {name/name ttl/ttl record/record}
  %-  jobe  :~
     kind+s+'dns#resourceRecordSet'
     name+s+name
     ttl+(jone ttl)
     type+s+(cuss (trip -.record))
     rrdatas+a+(record-data record)
  ==
::
++  add-record
  |=  a/{name ttl record}  ^-  json
  (dns-change [(resourse-record-set a)]~ ~)
::  
++  del-record
  |=  a/{name ttl record}  ^-  json
  (dns-change ~ [(resourse-record-set a)]~)
::  
++  dns-change
  |=  {additions/(list json) deletions/(list json)}
  %-  jobe   :~
    kind+s+'dns#change'
    additions+a+additions
    deletions+a+deletions
  ==
::
::
++  managed-zone
  |=  {name/name dns-name/name}
  %-  jobe  :~
    kind+s+'dns#managedZone'
    name+s+name
    'dnsName'^s+dns-name
    description+s+''
  ==
--


:: {
::  "additions": [
::   {
::    "kind": "dns#resourceRecordSet",
::    "name": "fyr2.urbit.one.",
::    "type": "A",
::    "rrdatas": [
::     "54.67.74.72"
::    ],
::    "ttl": 300
::   }
::  ],
::  "kind": "dns#change"
:: }
