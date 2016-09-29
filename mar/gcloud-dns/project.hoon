::  Project id
::
::::  /hoon/project/gcloud-dns/mar
  ::
/+  gcloud-dns, httr-to-json
|_  own/project:gcloud-dns
++  grab
  |%
  ++  noun  project:gcloud-dns
  ++  json  (corl need project:decode:gcloud-dns)
  ++  httr  (cork httr-to-json json)  ::  XX mark translation
  --
++  grow
  |%
  ++  tank  >[own]<
  ++  tang  [tank]~
  --
--
