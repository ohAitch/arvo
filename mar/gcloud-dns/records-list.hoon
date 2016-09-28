::  DNS changes
::
::::  /hoon/changes-list/gcloud-dns/mar
  ::
/+  gcloud-dns, httr-to-json
|_  own/(list record-set):gcloud-dns
++  grab
  |%
  ++  noun  (list change):gcloud-dns
  ++  json  (corl need records-list:decode:gcloud-dns)
  ++  httr  (cork httr-to-json json)  ::  XX mark translation
  --
++  grow
  |%
  ++  tank  >[own]<
  ++  tang  ~[tank]
  --
--
