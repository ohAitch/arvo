::  All managed zones
::
::::  /hoon/zones-list/gcloud-dns/mar
  ::
/+  gcloud-dns, httr-to-json
|_  own/(list managed-zone):gcloud-dns
++  grab
  |%
  ++  noun  (list managed-zone):gcloud-dns
  ++  json  (corl need zones-list:decode:gcloud-dns)
  ++  httr  (cork httr-to-json json)  ::  XX mark translation
  --
++  grow
  |%
  ++  tank  >[own]<
  ++  tang  [tank]~
  --
--
