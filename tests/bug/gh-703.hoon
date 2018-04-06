:: List addressing bugs: &33:~ bails out
/+  new-hoon, tester
=,  myb:new-hoon
|_  _tester:tester
::
++  test-hang  
  ~&  [`path`% running-unsafe+"hangs urbit"]
  %-  expect-fail  |.
  &33:~[[%leaf p="syntax error"] [%leaf p="\{1 11}"]]
::
++  test-vere-bail
  ~&  [`path`% running-unsafe+"bails out with out of loom error"]
  %-  expect-fail  |.
  &33:~  
--
