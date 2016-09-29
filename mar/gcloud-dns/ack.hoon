::  Ackgnowledgement
::
::::  /hoon/ack/gcloud-dns/mar
  ::
/+  gcloud-dns, httr-to-json
|_  $~
++  grab
  |%
  ++  noun  $~
  ++  httr
    |=  a/^httr  ^+  ~
    ?-  a
      {$204 * $~}  ~
      ^  ~|(any-content+a !!)
    ==
  --
++  grow
  |%
  ++  tank  >[~]<
  --
--
