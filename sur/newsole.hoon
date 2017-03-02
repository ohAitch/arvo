:: :talk_(A)_.       ._(C)_%dill_(E)_term.c
::            \     /        S0       S-0
::             %drum
:: :dojo_(B)__/  S2 \__(D)_%eyre_(F)_web-sole
::                           S1        S-1


:: Task: collate existing analogues to A-F S* 

:: A=B= sole-action/sole-effect

:: C=E= dill-blit/dill-belt

:: D= sole-action/sole-effect
:: F= json(sole-action/sole-effect)

:: buffer:= {position (list @c)}
:: buffer-sole:= {buffer sole-ot-stuff}
:: S2= {buffer width killring app (map app {prompt buffer-sole history})}
:: S0= {buffer width}
:: S-0= {{width height} buffer buffer-utf8}
:: S1=~ :: there's like app subscription state I suppose
:: S-1={(list row) buffer history app (map app {prompt buffer-sole})

|%
++  app  {ship term}
++  sole-action                                         ::  sole to app
  $%  ::  {$abo ~}                                      ::  reset interaction
      {$det sole-change}                                ::  command line edit
      {$ret $~}                                         ::  submit and clear
      {$clr $~}                                         ::  exit context
      {$sel {app path}}                                 ::  select agent
  ==                                                    ::
++  sole-buffer  (list @c)                              ::  command state
++  sole-change                                         ::  network change
  $:  ler/sole-clock                                    ::  destination clock
      haw/@uvH                                          ::  source hash
      ted/sole-edit                                     ::  state change
  ==                                                    ::
++  sole-clock  {own/@ud his/@ud}                       ::  vector clock
++  sole-edit                                           ::  shared state change
  $%  {$del p/@ud}                                      ::  delete one at
      {$ins p/@ud q/@c}                                 ::  insert at
      {$mor p/(list sole-edit)}                         ::  combination
      {$nop $~}                                         ::  no-op
      {$set p/sole-buffer}                              ::  discontinuity
  ==                                                    ::
++  sole-effect                                         ::  app to sole
  |^  $?  {$mor p/(list sole-effect)}
          display
          write
          prompt
      ==
  ++  display
    $%  {$clr $~}                                       ::  clear screen
        {$klr p/styx:^dill}                             ::  styled text line
        {$tan p/(list tank)}                            ::  classic tank
    ::  {$taq p/tanq}                                   ::  modern tank
        {$txt p/tape}                                   ::  text line
        {$url p/@t}                                     ::  activate url
    ==                                                  ::
  ++  write                                             ::
    $%  {$sag p/path q/*}                               ::  save to jamfile
        {$sav p/path q/@}                               ::  save to file
    ==                                                  ::
  ++  prompt                                            ::
    $%  {$bel $~}                                       ::  beep
        {$blk p/@ud q/@c}                               ::  blink+match char at
        {$clr $~}                                       ::  clear screen
        {$det sole-change}                              ::  edit command
        {$err p/@ud}                                    ::  error point
        {$pro sole-prompt}                              ::  set prompt
        {$aps p/(list {app path})}                      ::  set app list
    ==                                                  ::
  --
++  sole-command                                        ::  command state
  $:  pos/@ud                                           ::  cursor position
      say/sole-share                                    ::  cursor
  ==                                                    ::
++  sole-prompt                                         ::  prompt definition
  $:  vis/?                                             ::  command visible
      tag/term                                          ::  history mode
      cad/styx:^dill                                    ::  caption
  ==                                                    ::
++  sole-share                                          ::  symmetric state
  $:  ven/sole-clock                                    ::  our vector clock
      leg/(list sole-edit)                              ::  unmerged edits
      buf/sole-buffer                                   ::  sole state
  ==                                                    ::
::
::
++  dill-belt                                           ::  new belt
  $%  {$aro p/?($d $l $r $u)}                           ::  arrow key
      {$bac $~}                                         ::  true backspace
      {$cru p/@tas q/(list tank)}                       ::  echo error
      {$ctl p/@}                                        ::  control-key
      {$del $~}                                         ::  true delete
      {$hey $~}                                         ::  refresh
      {$met p/@}                                        ::  meta-key
      {$ret $~}                                         ::  return
      {$rez p/@ud q/@ud}                                ::  resize, cols, rows
      {$txt p/(list @c)}                                ::  utf32 text
::       {$yow p/gill:gall}                                ::  connect to app
  ==                                                    ::
++  styled-tuba  (list {* @c})
++  dill-blit                                           ::  new blit
  $%  {$bel $~}                                         ::  make a noise
      {$clr $~}                                         ::  clear the screen
      {$hop p/@ud}                                      ::  set cursor position
      {$klr p/styled-tuba}                              ::  styled text
      {$mor p/(list dill-blit)}                         ::  multiple blits
      {$pom p/styled-tuba}                              ::  styled prompt
      {$sta p/styled-tuba}                              ::  status line
      {$pro p/(list @c)}                                ::  show as cursor+line
      {$qit $~}                                         ::  close console
      {$out p/(list @c)}                                ::  send output line
      {$sag p/path q/*}                                 ::  save to jamfile
      {$sav p/path q/@}                                 ::  save to file
      {$url p/@t}                                       ::  activate url
  ==                                                    ::
--
|%
++  a-in  sole-action
++  a-out  sole-effect
++  b-in  sole-action
++  b-out  sole-effect
++  c-in  dill-belt
++  c-out  dill-blit
++  d-in  sole-action
++  d-out  sole-effect
++  e-in  dill-belt
++  e-out  dill-blit
++  f-in  json :: of sole-action
++  f-out  json :: of sole-effect
::
::
++  buffer  {position/@u (list @c)}
++  buffer-utf8  {position/@u tape}
++  buffer-sole  sole-command  :: terrible name
++  width  @u
++  height  @u
++  prompt  (list @c)
++  row  (list @c)
++  killring  {position/@ud max/_60 entries/(list (list @c))}
++  history  {position/@ud edited/(map @ud (list @c)) original/(list (list @c))}
++  unprinted  (list c-out)
++  status  styled-tuba
::
++  s2  {(map {app path} {prompt buffer-sole history unprinted}) (map duct {focus/{app path} width})}
++  s0  (map duct {buffer width (list {app path})})
++  s-0  {{width height} buffer status}
++  s1  $~ :: there's like app subscription state I suppose
++  s-1  {(list row) buffer history app (map {app path} {prompt buffer-sole})}
--
:: :talk_(A)_.       ._(C)_%dill_(E)_term.c
::            \     /        S0       S-0
::             %drum
:: :dojo_(B)__/  S2 \__(D)_%eyre_(F)_web-sole
::                           S1        S-1
