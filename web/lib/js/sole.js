(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var Persistence, str;

str = JSON.stringify;

Persistence = {
  listen: function(app, cb) {
    return urb.bind("/sole/" + app, {
      app: "drumming",
      responseKey: "/" + app
    }, (function(_this) {
      return function(err, d) {
        if (err) {
          return console.log(err);
        } else if (d.data) {
          return cb(d.data);
        }
      };
    })(this));
  },
  drop: function(app) {
    return urb.drop("/sole/" + app, {
      app: "drumming",
      responseKey: "/" + app
    });
  },
  sendAct: function(app, data, _, cbErr) {
    return urb.send(data, {
      app: "drumming",
      mark: 'sole-action',
      responseKey: "/" + app
    }, (function(_this) {
      return function(e, res) {
        if (res.status !== 200) {
          return cbErr(res.data);
        }
      };
    })(this));
  },
  sendKey: function(app, arg) {
    var key, mod;
    mod = arg.mod, key = arg.key;
    return urb.send({
      mod: mod,
      key: key
    }, {
      app: "drumming",
      mark: 'dill-belt',
      responseKey: "/" + app
    });
  }
};

module.exports = {
  flash: function($el, background) {
    $el.css({
      background: background
    });
    if (background) {
      return setTimeout(((function(_this) {
        return function() {
          return _this.flash($el, '');
        };
      })(this)), 50);
    }
  },
  bell: function() {
    return this.flash($('body'), 'black');
  },
  getState: function(app) {
    var apps, cursor, drum, error, history, input, k, nextApp, ref, ref1, ref2, ref3, rows, share, state, yank;
    ref = this._getState(), drum = ref.drum, yank = ref.yank, rows = ref.rows, state = ref.state;
    ref1 = state[app], (ref2 = ref1.buffer, share = ref2.share, cursor = ref2.cursor), history = ref1.history, error = ref1.error;
    input = history.offset >= 0 ? history.log[history.offset] : share.buf;
    apps = (function() {
      var results;
      results = [];
      for (k in state) {
        if (k !== "") {
          results.push(k);
        }
      }
      return results;
    })();
    nextApp = (ref3 = apps[1 + apps.indexOf(app)]) != null ? ref3 : apps[0];
    return {
      yank: yank,
      rows: rows,
      app: app,
      nextApp: nextApp,
      state: state,
      prompt: prompt,
      share: share,
      cursor: cursor,
      input: input,
      error: error
    };
  },
  dispatch: function(action) {
    var k, type;
    type = ((function() {
      var results;
      results = [];
      for (k in action) {
        results.push(k);
      }
      return results;
    })()).join(" ");
    return this._dispatch({
      type: type,
      payload: action[type]
    });
  },
  dispatchTo: function(app, action) {
    var k, type;
    type = ((function() {
      var results;
      results = [];
      for (k in action) {
        results.push(k);
      }
      return results;
    })()).join(" ");
    return this._dispatch({
      type: type,
      app: app,
      payload: action[type]
    });
  },
  choose: function(app) {
    return this.dispatchTo(app, {
      "choose": "choose"
    });
  },
  print: function(row) {
    return this.dispatch({
      row: row
    });
  },
  peer: function(ruh, app) {
    var input, v;
    if (ruh.map) {
      return ruh.map((function(_this) {
        return function(rul) {
          return _this.peer(rul, app);
        };
      })(this));
    }
    switch (Object.keys(ruh)[0]) {
      case 'out':
        return this.print(ruh.out);
      case 'txt':
        return this.print(ruh.txt);
      case 'tan':
        return ruh.tan.trim().split("\n").map((function(_this) {
          return function(s) {
            return _this.print(s);
          };
        })(this));
      case 'pro':
        return this.dispatchTo(app, {
          prompt: ruh.pro.cad
        });
      case 'pom':
        if (ruh.pom.length) {
          return this.dispatchTo(app, {
            prompt: ruh.pom[0].text
          });
        }
        break;
      case 'hop':
        break;
      case 'blk':
        return console.log("Stub " + (str(ruh)));
      case 'det':
        return this.dispatchTo(app, {
          receive: ruh.det
        });
      case 'act':
        switch (ruh.act) {
          case 'clr':
            return this.dispatch({
              'clear': 'clear'
            });
          case 'bel':
            return this.bell();
          case 'nex':
            this.dispatch({
              'line': 'line'
            });
            input = this.getState(app).input;
            if (input) {
              return this.dispatchTo(app, {
                historyAdd: input
              });
            }
        }
        break;
      default:
        v = Object.keys(ruh);
        return console.log(v, ruh[v[0]]);
    }
  },
  join: function(app, state) {
    return (function(_this) {
      return function(_dispatch) {
        _this._dispatch = _dispatch;
        return _this._join(app, state);
      };
    })(this);
  },
  _join: function(app, state) {
    this.choose(app);
    return Persistence.listen(app, (function(_this) {
      return function(data) {
        return _this.peer(data, app);
      };
    })(this));
  },
  part: function(app, state) {
    Persistence.drop(app);
    this.cycle(app, state);
    return this.dispatchTo(app, {
      "part": "part"
    });
  },
  sendAction: function(app, share, data) {
    if (app) {
      return Persistence.sendAct(app, data, null, (function(_this) {
        return function(err) {
          return _this.dispatch({
            error: err.mess
          });
        };
      })(this));
    } else if (data === 'ret') {
      app = /^[a-z-]+$/.exec(share.buf.slice(1));
      if (!((app != null) && (app[0] != null))) {
        return this.bell();
      } else {
        switch (share.buf[0]) {
          case '+':
            this.doEdit('', {
              share: share
            }, {
              set: ""
            });
            return this._join(app[0]);
          case '-':
            this.doEdit('', {
              share: share
            }, {
              set: ""
            });
            return this.part(app[0]);
          default:
            return this.bell();
        }
      }
    }
  },
  doEdit: function(app, arg, ted) {
    var cursor, det, share;
    share = arg.share, cursor = arg.cursor;
    det = share.transmit(ted);
    cursor = share.transpose(ted, cursor);
    this.dispatchTo(app, {
      edit: {
        share: share,
        cursor: cursor
      }
    });
    return this.sendAction(app, share, {
      det: det
    });
  },
  eatKyev: function(mod, key) {
    return (function(_this) {
      return function(_dispatch, _getState) {
        var _, app, buffer, cha, cursor, drum, input, n, nextApp, prev, ref, ref1, rest, rows, share, state, yank;
        _this._dispatch = _dispatch;
        _this._getState = _getState;
        ref = _this._getState(), drum = ref.drum, app = ref.app;
        if (drum) {
          app = "";
        }
        ref1 = _this.getState(app), yank = ref1.yank, rows = ref1.rows, app = ref1.app, nextApp = ref1.nextApp, state = ref1.state, share = ref1.share, cursor = ref1.cursor, input = ref1.input;
        buffer = {
          share: share,
          cursor: cursor
        };
        switch (mod.sort().join('-')) {
          case '':
          case 'shift':
            if (key.str) {
              _this.doEdit(app, buffer, {
                ins: {
                  cha: key.str,
                  at: cursor
                }
              });
              _this.dispatchTo(app, {
                cursor: cursor + 1
              });
            }
            switch (key.act) {
              case 'entr':
                return _this.sendAction(app, share, 'ret');
              case 'up':
                return _this.dispatchTo(app, {
                  'historyPrevious': 'historyPrevious'
                });
              case 'down':
                return _this.dispatchTo(app, {
                  'historyNext': 'historyNext'
                });
              case 'left':
                if (cursor > 0) {
                  return _this.dispatchTo(app, {
                    cursor: cursor - 1
                  });
                }
                break;
              case 'right':
                if (cursor < input.length) {
                  return _this.dispatchTo(app, {
                    cursor: cursor + 1
                  });
                }
                break;
              case 'baxp':
                if (cursor > 0) {
                  return _this.doEdit(app, buffer, {
                    del: cursor - 1
                  });
                }
            }
            break;
          case 'ctrl':
            switch (key.str || key.act) {
              case 'a':
              case 'left':
                return _this.dispatchTo(app, {
                  cursor: 0
                });
              case 'e':
              case 'right':
                return _this.dispatchTo(app, {
                  cursor: input.length
                });
              case 'l':
                return _this.dispatch({
                  'clear': 'clear'
                });
              case 'entr':
                return _this.bell();
              case 'w':
                return _this.eatKyev(['alt'], {
                  act: 'baxp'
                });
              case 'p':
                return _this.eatKyev([], {
                  act: 'up'
                });
              case 'n':
                return _this.eatKyev([], {
                  act: 'down'
                });
              case 'b':
                return _this.eatKyev([], {
                  act: 'left'
                });
              case 'f':
                return _this.eatKyev([], {
                  act: 'right'
                });
              case 'g':
                return _this.bell();
              case 'x':
                return Persistence.sendKey(app, {
                  mod: mod,
                  key: key
                });
              case 'v':
                return _this.dispatch({
                  "toggleDrum": "toggleDrum"
                });
              case 't':
                if (cursor === 0 || input.length < 2) {
                  return _this.bell();
                }
                if (cursor < input.length) {
                  cursor++;
                }
                _this.doEdit(app, buffer, [
                  {
                    del: cursor - 1
                  }, {
                    ins: {
                      at: cursor - 2,
                      cha: input[cursor - 1]
                    }
                  }
                ]);
                return _this.dispatchTo(app, {
                  cursor: cursor
                });
              case 'u':
                _this.dispatch({
                  yank: input.slice(0, cursor)
                });
                return _this.doEdit(app, buffer, (function() {
                  var i, ref2, results;
                  results = [];
                  for (n = i = 1, ref2 = cursor; 1 <= ref2 ? i <= ref2 : i >= ref2; n = 1 <= ref2 ? ++i : --i) {
                    results.push({
                      del: cursor - n
                    });
                  }
                  return results;
                })());
              case 'k':
                _this.dispatch({
                  yank: input.slice(cursor)
                });
                return _this.doEdit(app, buffer, (function() {
                  var i, ref2, ref3, results;
                  results = [];
                  for (_ = i = ref2 = cursor, ref3 = input.length; ref2 <= ref3 ? i < ref3 : i > ref3; _ = ref2 <= ref3 ? ++i : --i) {
                    results.push({
                      del: cursor
                    });
                  }
                  return results;
                })());
              case 'y':
                return _this.doEdit(app, buffer, (function() {
                  var i, len, ref2, results;
                  ref2 = yank != null ? yank : '';
                  results = [];
                  for (n = i = 0, len = ref2.length; i < len; n = ++i) {
                    cha = ref2[n];
                    results.push({
                      ins: {
                        cha: cha,
                        at: cursor + n
                      }
                    });
                  }
                  return results;
                })());
              default:
                return console.log(mod, str(key));
            }
            break;
          case 'alt':
            switch (key.str || key.act) {
              case 'f':
              case 'right':
                rest = input.slice(cursor);
                rest = rest.match(/\W*\w*/)[0];
                return _this.dispatchTo(app, {
                  cursor: cursor + rest.length
                });
              case 'b':
              case 'left':
                prev = input.slice(0, cursor);
                prev = prev.split('').reverse().join('');
                prev = prev.match(/\W*\w*/)[0];
                return _this.dispatchTo(app, {
                  cursor: cursor - prev.length
                });
              case 'baxp':
                prev = input.slice(0, cursor);
                prev = prev.split('').reverse().join('');
                prev = prev.match(/\W*\w*/)[0];
                _this.dispatch({
                  yank: prev
                });
                return _this.doEdit(app, buffer, (function() {
                  var i, len, results;
                  results = [];
                  for (n = i = 0, len = prev.length; i < len; n = ++i) {
                    _ = prev[n];
                    results.push({
                      del: cursor - 1 - n
                    });
                  }
                  return results;
                })());
            }
            break;
          default:
            return console.log(mod, str(key));
        }
      };
    })(this);
  }
};


},{}],2:[function(require,module,exports){
var Actions, IO, Matr, Prompt, Provider, Reducer, Sole, TreeStore, applyMiddleware, connect, createStore, div, noPad, pre, recl, ref, ref1, registerComponent, rele, span, stateToProps, thunk, toKyev, u,
  indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

ref = [React.createClass, React.createElement], recl = ref[0], rele = ref[1];

ref1 = React.DOM, div = ref1.div, u = ref1.u, pre = ref1.pre, span = ref1.span;

TreeStore = window.tree.util.store;

registerComponent = window.tree.util.actions.registerComponent;

createStore = Redux.createStore, applyMiddleware = Redux.applyMiddleware;

Provider = ReactRedux.Provider, connect = ReactRedux.connect;

thunk = ReduxThunk["default"];

Reducer = require("./reducer.coffee");

Actions = require("./actions.coffee");

noPad = {
  padding: 0
};

stateToProps = function(arg) {
  var app, cursor, drum, history, input, k, prompt, ref2, ref3, ref4, ref5, share, state, v;
  drum = arg.drum, app = arg.app, state = arg.state;
  if (drum) {
    ref2 = state[""], prompt = ref2.prompt, (ref3 = ref2.buffer, share = ref3.share, cursor = ref3.cursor), history = ref2.history;
    prompt = ((function() {
      var results;
      results = [];
      for (k in state) {
        v = state[k];
        if (k !== '') {
          results.push(k);
        }
      }
      return results;
    })()).join(', ') + '# ';
  } else {
    ref4 = state[app], prompt = ref4.prompt, (ref5 = ref4.buffer, share = ref5.share, cursor = ref5.cursor), history = ref4.history;
  }
  input = history.offset >= 0 ? history.log[history.offset] : share.buf;
  return {
    prompt: prompt,
    cursor: cursor,
    offset: history.offset,
    input: input
  };
};

Prompt = connect(stateToProps)(function(arg) {
  var buf, cur, cursor, input, offset, prompt, ref2;
  prompt = arg.prompt, cursor = arg.cursor, offset = arg.offset, input = arg.input;
  cur = cursor;
  buf = input + " ";
  return pre({
    style: noPad
  }, prompt, span({
    style: {
      background: 'lightgray'
    }
  }, buf.slice(0, cur), u({}, (ref2 = buf[cur]) != null ? ref2 : " "), buf.slice(cur + 1)), offset >= 0 ? " ⧖" + offset : void 0);
});

Matr = connect(function(s) {
  return s;
})(function(arg) {
  var key, lin, rows;
  rows = arg.rows;
  return div({}, (function() {
    var i, len, results;
    results = [];
    for (key = i = 0, len = rows.length; i < len; key = ++i) {
      lin = rows[key];
      results.push(pre({
        key: key,
        style: noPad
      }, lin, " "));
    }
    return results;
  })(), rele(Prompt));
});

Sole = connect(function(s) {
  return s;
})(function(arg) {
  var error;
  error = arg.error;
  return div({}, div({
    id: "err"
  }, error), rele(Matr));
});

IO = connect()(recl({
  render: function() {
    return div({});
  },
  componentWillUnmount: function() {
    return Mousetrap.handleKey = this._defaultHandleKey;
  },
  componentDidMount: function() {
    this._defaultHandleKey = Mousetrap.handleKey;
    return Mousetrap.handleKey = (function(_this) {
      return function(char, mod, e) {
        var key, ref2;
        ref2 = toKyev({
          char: char,
          mod: mod,
          type: e.type
        }), mod = ref2.mod, key = ref2.key;
        if (key) {
          e.preventDefault();
          return _this.props.dispatch(Actions.eatKyev(mod, key));
        }
      };
    })(this);
  }
}));

setTimeout(function() {
  return TreeStore.dispatch(registerComponent("sole", recl({
    getInitialState: function() {
      var store;
      store = createStore(Reducer, (window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || function(s) {
        return s;
      })(applyMiddleware(thunk)));
      store.dispatch(Actions.join(this.props["data-app"]));
      return {
        store: store
      };
    },
    render: function() {
      return rele(Provider, {
        store: this.state.store
      }, div({}, rele(IO), rele(Sole, this.props)));
    }
  })));
});

toKyev = function(arg) {
  var chac, char, key, mod, norm, ref2, type;
  char = arg.char, mod = arg.mod, type = arg.type;
  norm = {
    capslock: 'caps',
    pageup: 'pgup',
    pagedown: 'pgdn',
    backspace: 'baxp',
    enter: 'entr'
  };
  key = (function() {
    var ref2;
    switch (false) {
      case char.length !== 1:
        if (type === 'keypress') {
          chac = char.charCodeAt(0);
          if (chac < 32) {
            char = String.fromCharCode(chac | 96);
          }
          return {
            str: char
          };
        }
        break;
      case type !== 'keydown':
        if (char !== 'space') {
          return {
            act: (ref2 = norm[char]) != null ? ref2 : char
          };
        }
        break;
      case !(type === 'keyup' && norm[key] === 'caps'):
        return {
          act: 'uncap'
        };
    }
  })();
  if ((ref2 = key != null ? key.act : void 0, indexOf.call(mod, ref2) >= 0)) {
    return {};
  } else {
    return {
      mod: mod,
      key: key
    };
  }
};


},{"./actions.coffee":1,"./reducer.coffee":3}],3:[function(require,module,exports){
var Share, app, buffer, byApp, combineReducers, drum, error, history, prompt, rows, yank,
  slice = [].slice;

combineReducers = Redux.combineReducers;

Share = require("./share.coffee");

rows = function(state, arg) {
  var payload, type;
  if (state == null) {
    state = [];
  }
  type = arg.type, payload = arg.payload;
  switch (type) {
    case "row":
      return slice.call(state).concat([payload]);
    case "clear":
      return [];
    default:
      return state;
  }
};

yank = function(state, arg) {
  var payload, type;
  if (state == null) {
    state = '';
  }
  type = arg.type, payload = arg.payload;
  switch (type) {
    case "yank":
      return payload;
    default:
      return state;
  }
};

app = function(state, arg) {
  var app, payload, type;
  if (state == null) {
    state = '';
  }
  type = arg.type, app = arg.app, payload = arg.payload;
  switch (type) {
    case "choose":
      return app;
    default:
      return state;
  }
};

byApp = function(reducer) {
  return function(state, action) {
    if (state == null) {
      state = {
        "": reducer(void 0, {})
      };
    }
    if (action.app != null) {
      state = $.extend({}, state);
      state[action.app] = reducer(state[action.app], action);
    }
    return state;
  };
};

buffer = function(state, arg) {
  var cursor, payload, share, type;
  if (state == null) {
    state = {
      cursor: 0,
      share: new Share("")
    };
  }
  type = arg.type, payload = arg.payload;
  cursor = state.cursor, share = state.share;
  switch (type) {
    case "edit":
      return payload;
    case "receive":
      share.receive(payload);
      cursor = share.transpose(payload.ted, cursor);
      return {
        cursor: cursor,
        share: share
      };
    case "choose":
      return state;
    case "cursor":
      return {
        cursor: payload,
        share: share
      };
    case "line":
      return {
        cursor: 0,
        share: share
      };
    default:
      return state;
  }
};

prompt = function(state, arg) {
  var payload, type;
  if (state == null) {
    state = "X";
  }
  type = arg.type, payload = arg.payload;
  switch (type) {
    case "prompt":
      return payload;
    default:
      return state;
  }
};

history = function(state, arg) {
  var active, log, offset, payload, type;
  if (state == null) {
    state = {
      offset: -1,
      log: []
    };
  }
  type = arg.type, payload = arg.payload;
  offset = state.offset, active = state.active, log = state.log;
  switch (type) {
    case "historyAdd":
      log = [payload].concat(slice.call(log));
      return {
        offset: -1,
        log: log
      };
    case "edit":
      return {
        offset: -1,
        log: log
      };
    case "line":
      return {
        offset: -1,
        log: log
      };
    case "historyPrevious":
      if (offset < log.length - 1) {
        offset++;
      }
      return {
        offset: offset,
        log: log
      };
    case "historyNext":
      if (offset < 0) {
        return {
          offset: offset,
          log: log
        };
      } else {
        offset--;
        return {
          offset: offset,
          log: log
        };
      }
      break;
    default:
      return state;
  }
};

error = function(state, arg) {
  var payload, type;
  if (state == null) {
    state = "";
  }
  type = arg.type, payload = arg.payload;
  switch (type) {
    case "error":
      return payload;
    default:
      return state;
  }
};

drum = function(state, arg) {
  var payload, type;
  if (state == null) {
    state = false;
  }
  type = arg.type, payload = arg.payload;
  switch (type) {
    case "toggleDrum":
      return !state;
    default:
      return state;
  }
};

module.exports = combineReducers({
  error: error,
  rows: rows,
  yank: yank,
  drum: drum,
  app: app,
  state: byApp(combineReducers({
    prompt: prompt,
    buffer: buffer,
    history: history,
    error: error
  }))
});


},{"./share.coffee":4}],4:[function(require,module,exports){
var clog, str;

str = JSON.stringify;

clog = function(a) {
  return console.log(a);
};

module.exports = (function() {
  function exports(buf, ven, leg) {
    this.buf = buf != null ? buf : "";
    this.ven = ven != null ? ven : [0, 0];
    this.leg = leg != null ? leg : [];
  }

  exports.prototype.abet = function() {
    return {
      buf: this.buf,
      leg: this.leg.slice(),
      ven: this.ven.slice()
    };
  };

  exports.prototype.apply = function(ted) {
    var at, cha, ref;
    switch (false) {
      case 'nop' !== ted:
        break;
      case !ted.map:
        return ted.map(this.apply, this);
      default:
        switch (Object.keys(ted)[0]) {
          case 'set':
            return this.buf = ted.set;
          case 'del':
            return this.buf = this.buf.slice(0, ted.del) + this.buf.slice(ted.del + 1);
          case 'ins':
            ref = ted.ins, at = ref.at, cha = ref.cha;
            return this.buf = this.buf.slice(0, at) + cha + this.buf.slice(at);
          default:
            throw "%sole-edit -lost." + (str(ted));
        }
    }
  };

  exports.prototype.transmute = function(sin, dex) {
    var at, cha, ref;
    switch (false) {
      case !(sin === 'nop' || dex === 'nop'):
        return dex;
      case !sin.reduce:
        return sin.reduce(((function(_this) {
          return function(dex, syn) {
            return _this.transmute(syn, dex);
          };
        })(this)), dex);
      case !dex.map:
        return dex.map((function(_this) {
          return function(dax) {
            return _this.transmute(sin, dax);
          };
        })(this));
      case dex.set === void 0:
        return dex;
      default:
        switch (Object.keys(sin)[0]) {
          case 'set':
            return 'nop';
          case 'del':
            if (sin.del === dex.del) {
              return 'nop';
            }
            dex = $.extend(true, {}, dex);
            switch (Object.keys(dex)[0]) {
              case 'del':
                if (sin.del < dex.del) {
                  dex.del--;
                }
                break;
              case 'ins':
                if (sin.del < dex.ins.at) {
                  dex.ins.at--;
                }
            }
            return dex;
          case 'ins':
            dex = $.extend(true, {}, dex);
            ref = sin.ins, at = ref.at, cha = ref.cha;
            switch (Object.keys(dex)[0]) {
              case 'del':
                if (at < dex.del) {
                  dex.del++;
                }
                break;
              case 'ins':
                if (at < dex.ins.at || (at === dex.ins.at && !(cha <= dex.ins.cha))) {
                  dex.ins.at++;
                }
            }
            return dex;
          default:
            throw "%sole-edit -lost." + (str(sin));
        }
    }
  };

  exports.prototype.commit = function(ted) {
    this.ven[0]++;
    this.leg.push(ted);
    return this.apply(ted);
  };

  exports.prototype.inverse = function(ted) {
    switch (false) {
      case 'nop' !== ted:
        return ted;
      case !ted.map:
        return ted.map((function(_this) {
          return function(tad) {
            var res;
            res = _this.inverse(tad);
            _this.apply(tad);
            return res;
          };
        })(this)).reverse();
      default:
        switch (Object.keys(ted)[0]) {
          case 'set':
            return {
              set: this.buf
            };
          case 'ins':
            return {
              del: ted.ins
            };
          case 'del':
            return {
              ins: {
                at: ted.del,
                cha: this.buf[ted.del]
              }
            };
          default:
            throw "%sole-edit -lost." + (str(ted));
        }
    }
  };

  exports.prototype.receive = function(arg) {
    var dat, ler, ted;
    ler = arg.ler, ted = arg.ted;
    if (!(ler[1] === this.ven[1])) {
      throw "-out-of-sync.[" + (str(ler)) + " " + (str(this.ven)) + "]";
    }
    this.leg = this.leg.slice(this.leg.length + ler[0] - this.ven[0]);
    dat = this.transmute(this.leg, ted);
    this.ven[1]++;
    this.apply(dat);
    return dat;
  };

  exports.prototype.remit = function() {
    throw 'stub';
  };

  exports.prototype.transmit = function(ted) {
    var act;
    act = {
      ted: ted,
      ler: [this.ven[1], this.ven[0]]
    };
    this.commit(ted);
    return act;
  };

  exports.prototype.transceive = function(arg) {
    var dat, ler, old, ted;
    ler = arg.ler, ted = arg.ted;
    old = new Share(this.buf);
    dat = this.receive({
      ler: ler,
      ted: ted
    });
    return old.inverse(dat);
  };

  exports.prototype.transpose = function(ted, pos) {
    var ref;
    if (pos === void 0) {
      return this.transpose(this.leg, ted);
    } else {
      return ((ref = (this.transmute(ted, {
        ins: {
          at: pos
        }
      })).ins) != null ? ref : {
        at: 0
      }).at;
    }
  };

  return exports;

})();


},{}]},{},[2]);
