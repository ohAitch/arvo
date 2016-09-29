::  Managed zone
::
::::  /hoon/zone/gcloud-dns/mar
  ::
/+  gcloud-dns, httr-to-json
|_  own/managed-zone:gcloud-dns
++  grab
  |%
  ++  noun  managed-zone:gcloud-dns
  ++  json  (corl need managed-zone:decode:gcloud-dns)
  ++  httr  (cork httr-to-json json)  ::  XX mark translation
  --
++  grow
  |%
  ++  tank  >[own]<
  ++  tang  [tank]~
  --
--
