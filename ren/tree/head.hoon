::
::::  /hoon/head/tree/ren
  ::
::
/?    310
/=    tub    /$  |=({bem/beam *} (flop s.bem))
/=    aut
  /$  %+  cork  fuel:url:eyre                           :: after parsing params,
      =,  title
      |=  gas/epic:^eyre  ^-  ?                         :: check that the fcgi
      %+  lien  (~(tap in (~(get ju aut.ced.gas) %$)))  :: has an identity
      |=(a/knot !=(%pawn (clan (slav %p a))))           :: which isn't a comet
/=    dbg
  /^  {nopack/? nomin/?}
  /$  %+  cork  fuel:url:eyre                           :: after parsing params,
      |=  gas/epic:^eyre  ^-  {? ?}                     :: check if the query
      :-  (~(has by qix.gas) 'dbg.nopack')              :: dictates separate files
      (~(has by qix.gas) 'dbg.nomin')                   :: and/or unminified assets
|%
++  cdnjs
  |=(a/tape "//cdnjs.cloudflare.com/ajax/libs/{a}{?:(nomin.dbg "" ".min")}.js")
++  maxcdn
  |=(a/tape "//maxcdn.bootstrapcdn.com/{a}{?:(nomin.dbg "" ".min")}.js")
--
::
::::
  ::
^-  marl
;=  ;title: Urbit - A personal server
    ;meta(name "viewport", content "width=device-width, initial-scale=1");
::     ;link(type "text/css", rel "stylesheet", href "//cdnjs.cloudflare.com/ajax/libs/codemirror/4.3.0/codemirror.min.css");
    ;*  ?.  nopack.dbg
          :_  ~
          ;link(type "text/css", rel "stylesheet", href "/_css/===/web/pack/css/codemirror-fonts-bootstrap-tree");
        ;=
          ;link(type "text/css", rel "stylesheet", href "/===/web/lib/css/fonts.css");
          ;link(type "text/css", rel "stylesheet", href "/===/web/lib/css/bootstrap.css");
          ;link(type "text/css", rel "stylesheet", href "/===/web/lib/css/codemirror.css");
          ;link(type "text/css", rel "stylesheet", href "/===/web/tree/main.css");
        ==
    ::;link(type "text/css", rel "stylesheet", href "http://localhost:8000/docs/pub/tree/main.css");
    ;script(type "text/javascript", src "{(cdnjs "jquery/2.1.3/jquery")}");
    ;script(type "text/javascript", src "{(maxcdn "bootstrap/3.3.6/js/bootstrap")}");
    ;script(type "text/javascript", src "{(cdnjs "lodash.js/2.4.1/lodash")}");
    ;script(type "text/javascript", src "https://unpkg.com/react@15/dist/react.js");
    ;script(type "text/javascript", src "https://unpkg.com/react-dom@15/dist/react-dom.js");
    ;script(type "text/javascript", src "https://unpkg.com/redux@3.6.0/dist/redux.min.js");
    ;script(type "text/javascript", src "https://unpkg.com/react-redux@5.0.3/dist/react-redux.min.js");
    ;script(type "text/javascript", src "https://unpkg.com/redux-thunk@2.2.0/dist/redux-thunk.min.js");
    ;script(type "text/javascript", src "{(cdnjs "flux/2.1.1/Flux")}");
::     ;script(type "text/javascript", src "//cdnjs.cloudflare.com/ajax/libs/codemirror/4.3.0/codemirror.js");
::     ;script(type "text/javascript", src "//cdnjs.cloudflare.com/ajax/libs/".
::       "codemirror/4.3.0/mode/markdown/markdown.min.js");
    ;*  ?.  nopack.dbg
          :_  ~
          ;script(type "text/javascript", src "{?.(aut "" "/~~/~/at")}".
                                            "/_js/===/web/pack/js/tree-urb");
::                                             "/_js/===/web/pack/js/tree-hoon-urb");
        ;=
::           ;script(type "text/javascript", src "/===/web/lib/js/hoon.js");
          ;script(type "text/javascript", src "/===/web/tree/bundle.js");
          ;script(type "text/javascript", src "{?.(aut "" "/~~/~/at")}".
                                              "/===/web/lib/js/urb.js");
        ==
    ;link(type "application/rss+xml", rel "alternate", href "{(spud tub)}.rss-xml");
==
