/+  gcloud-dns
|%
++  goog-req  _!!
++  move  {bone card}
++  sigh-mark
  $?  :: $gcloud-dns-ack
      :: $gcloud-dns-change
      $gcloud-dns-changes-list
      :: $gcloud-dns-project
      :: $gcloud-dns-records-list
      :: $gcloud-dns-zone
      :: $gcloud-dns-zone-list
  ==
::
++  card
  $%  {$hiss wire {$~ $~} sigh-mark {$gcloud-dns-req request:gcloud-dns}}
  ==
--
::
::::
  ::
|%  :: XX constants
++  project  %tonal-griffin-853
++  zone     %urbit-one
--
::
::::
  ::
=|  mow/(list move)
|_  {bowl $~}
++  abet  [mow .(mow ~)]
++  emit  |=(a/card +>(mow :_(mow [ost a])))
++  emit-req  
  |=  {a/wire b/request:gcloud-dns}
  =/  mar  (response-mark:gcloud-dns &2.b)
  ?.  ?=(sigh-mark mar)  ~|(not-supported+&2.b !!)
  (emit %hiss a `~ mar gcloud-dns-req+b)
::
++  poke-noun
  |=  *  =<  abet
  =.  emit-req  (emit-req / project %changes-list zone)
  .
++  sigh-tang  |=({wire a/tang} (mean a))
++  sigh-gcloud-dns-changes-list
  |=  {wire a/(list change:gcloud-dns)}  =<  abet
  ~&  a
  .
:: ++  peer-scry-y
  
--
