(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var Matr, Prompt, Share, TreeStore, buffer, div, noPad, pre, recl, ref, ref1, registerComponent, rele, span, str, u,
  slice = [].slice,
  indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

ref = [React.createClass, React.createElement], recl = ref[0], rele = ref[1];

ref1 = React.DOM, div = ref1.div, u = ref1.u, pre = ref1.pre, span = ref1.span;

TreeStore = window.tree.util.store;

registerComponent = window.tree.util.actions.registerComponent;

str = JSON.stringify;

Share = require("./share.coffee");

buffer = {
  "": new Share("")
};

noPad = {
  padding: 0
};

Prompt = recl({
  displayName: "Prompt",
  render: function() {
    var buf, cur, pro, ref2, ref3;
    pro = (ref2 = this.props.prompt[this.props.app]) != null ? ref2 : "X";
    cur = this.props.cursor - pro.length;
    buf = this.props.input + " ";
    return pre({
      style: noPad
    }, pro, span({
      style: {
        background: 'lightgray'
      }
    }, buf.slice(0, cur), u({}, (ref3 = buf[cur]) != null ? ref3 : " "), buf.slice(cur + 1)));
  }
});

Matr = recl({
  displayName: "Matr",
  render: function() {
    var lines;
    lines = this.props.rows.map(function(lin, key) {
      return pre({
        key: key,
        style: noPad
      }, lin, " ");
    });
    lines.push(rele(Prompt, {
      key: "prompt",
      app: this.props.app,
      prompt: this.props.prompt,
      input: this.props.input,
      cursor: this.props.cursor
    }));
    return div({}, lines);
  }
});

TreeStore.dispatch(registerComponent("sole", recl({
  displayName: "Sole",
  getInitialState: function() {
    return {
      rows: [],
      app: this.props["data-app"],
      prompt: {
        "": "# "
      },
      input: "",
      cursor: 0,
      history: [],
      offset: 0,
      error: ""
    };
  },
  render: function() {
    return div({}, div({
      id: "err"
    }, this.state.error), rele(Matr, this.state));
  },
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
  choose: function(app) {
    if (buffer[app] == null) {
      buffer[app] = new Share("");
    }
    this.updPrompt('', null);
    return this.setState({
      app: app,
      cursor: 0,
      input: buffer[app].buf
    });
  },
  print: function(txt) {
    return this.setState({
      rows: slice.call(this.state.rows).concat([txt])
    });
  },
  sync: function(ted, app) {
    var b;
    if (app == null) {
      app = this.state.app;
    }
    if (app === this.state.app) {
      b = buffer[app];
      return this.setState({
        input: b.buf,
        cursor: b.transpose(ted, this.state.cursor)
      });
    }
  },
  updPrompt: function(app, pro) {
    var prompt;
    prompt = $.extend({}, this.state.prompt);
    if (pro != null) {
      prompt[app] = pro;
    } else {
      delete prompt[app];
    }
    return this.setState({
      prompt: prompt
    });
  },
  sysStatus: function() {
    var app, k, pro, ref2, v;
    return this.updPrompt('', ((ref2 = [
      this.state.app, (function() {
        var ref2, results;
        ref2 = this.state.prompt;
        results = [];
        for (k in ref2) {
          v = ref2[k];
          if (k !== '') {
            results.push(k);
          }
        }
        return results;
      }).call(this)
    ], app = ref2[0], pro = ref2[1], ref2), app === '' ? (pro.join(', ')) + '# ' : null));
  },
  exec: function(action) {
    var type;
    if (action.map) {
      return action.map((function(_this) {
        return function(act) {
          return _this.exec(act);
        };
      })(this));
    } else {
      type = Object.keys(action)[0];
      return this[type](action[type]);
    }
  },
  peer: function(ruh, app) {
    var mapr, v;
    if (app == null) {
      app = this.state.app;
    }
    if (ruh.map) {
      return ruh.map((function(_this) {
        return function(rul) {
          return _this.peer(rul, app);
        };
      })(this));
    }
    mapr = this.state;
    switch (Object.keys(ruh)[0]) {
      case 'out':
        return this.print(ruh.out);
      case 'txt':
        return this.print(ruh.txt);
      case 'tan':
        return ruh.tan.trim().split("\n").map(this.print);
      case 'pro':
        return this.updPrompt(app, ruh.pro.cad);
      case 'pom':
        return this.updPrompt(app, _.map(ruh.pom, function(arg) {
          var text;
          text = arg.text;
          return text;
        }));
      case 'hop':
        return this.setState({
          cursor: ruh.hop
        });
      case 'blk':
        return console.log("Stub " + (str(ruh)));
      case 'det':
        buffer[app].receive(ruh.det);
        return this.sync(ruh.det.ted, app);
      case 'act':
        switch (ruh.act) {
          case 'clr':
            return this.setState({
              rows: []
            });
          case 'bel':
            return this.bell();
          case 'nex':
            return this.setState({
              input: "",
              cursor: 0,
              history: !mapr.input ? mapr.history : [mapr.input].concat(slice.call(mapr.history)),
              offset: 0
            });
        }
        break;
      default:
        v = Object.keys(ruh);
        return console.log(v, ruh[v[0]]);
    }
  },
  join: function(app) {
    if (this.state.prompt[app] != null) {
      return this.print('# already-joined: ' + app);
    }
    this.choose(app);
    return urb.bind("/drum", {
      app: this.state.app,
      responseKey: "/"
    }, (function(_this) {
      return function(err, d) {
        if (err) {
          return console.log(err);
        } else if (d.data) {
          return _this.peer(d.data, app);
        }
      };
    })(this));
  },
  cycle: function() {
    var apps, ref2;
    apps = Object.keys(this.state.prompt);
    if (apps.length < 2) {
      return;
    }
    return this.choose((ref2 = apps[1 + apps.indexOf(this.state.app)]) != null ? ref2 : apps[0]);
  },
  part: function(app) {
    var mapr;
    mapr = this.state;
    if (mapr.prompt[app] == null) {
      return this.print('# not-joined: ' + app);
    }
    urb.drop("/drum", {
      app: app,
      responseKey: "/"
    });
    if (app === mapr.app) {
      this.cycle();
    }
    this.updPrompt(app, null);
    return this.sysStatus();
  },
  componentWillUnmount: function() {
    return this.mousetrapStop();
  },
  componentDidMount: function() {
    this.mousetrapInit();
    return this.join(this.state.app);
  },
  sendAction: function(data) {
    var app;
    app = this.state.app;
    if (app) {
      return urb.send(data, {
        app: app,
        mark: 'sole-action'
      }, (function(_this) {
        return function(e, res) {
          if (res.status !== 200) {
            return _this.setState({
              error: res.data.mess
            });
          }
        };
      })(this));
    } else if (data === 'ret') {
      app = /^[a-z-]+$/.exec(buffer[""].buf.slice(1));
      if (!((app != null) && (app[0] != null))) {
        return this.bell();
      } else {
        switch (buffer[""].buf[0]) {
          case '+':
            this.doEdit({
              set: ""
            });
            return this.join(app[0]);
          case '-':
            this.doEdit({
              set: ""
            });
            return this.part(app[0]);
          default:
            return this.bell();
        }
      }
    }
  },
  doEdit: function(ted) {
    var det;
    det = buffer[this.state.app].transmit(ted);
    this.sync(ted);
    return this.sendAction({
      det: det
    });
  },
  sendKyev: function(mod, key) {
    var app;
    app = this.state.app;
    return urb.send({
      mod: mod,
      key: key
    }, {
      app: app,
      mark: 'dill-belt'
    });
  },
  eatKyev: function(mod, key) {
    var history, input, mapr, offset, ref2, ref3;
    mapr = this.state;
    switch (mod.sort().join('-')) {
      case '':
      case 'shift':
        if (key.str) {
          this.doEdit({
            ins: {
              cha: key.str,
              at: mapr.cursor
            }
          });
          this.setState({
            cursor: mapr.cursor + 1
          });
        }
        switch (key.act) {
          case 'entr':
            return this.sendKyev(mod, key);
          case 'up':
            history = mapr.history.slice();
            offset = mapr.offset;
            if (history[offset] === void 0) {
              return;
            }
            ref2 = [history[offset], mapr.input], input = ref2[0], history[offset] = ref2[1];
            offset++;
            this.doEdit({
              set: input
            });
            return this.setState({
              offset: offset,
              history: history,
              cursor: input.length
            });
          case 'down':
            history = mapr.history.slice();
            offset = mapr.offset;
            offset--;
            if (history[offset] === void 0) {
              return;
            }
            ref3 = [history[offset], mapr.input], input = ref3[0], history[offset] = ref3[1];
            this.doEdit({
              set: input
            });
            return this.setState({
              offset: offset,
              history: history,
              cursor: input.length
            });
          case 'left':
            if (mapr.cursor > 0) {
              return this.setState({
                cursor: mapr.cursor - 1
              });
            }
            break;
          case 'right':
            if (mapr.cursor < mapr.input.length) {
              return this.setState({
                cursor: mapr.cursor + 1
              });
            }
            break;
          case 'baxp':
            if (mapr.cursor > 0) {
              return this.doEdit({
                del: mapr.cursor - 1
              });
            }
        }
        break;
      case 'meta':
        return console.log(mod, key);
      default:
        return this.sendKyev(mod, key);
    }
  },
  mousetrapStop: function() {
    return Mousetrap.handleKey = this._defaultHandleKey;
  },
  mousetrapInit: function() {
    this._defaultHandleKey = Mousetrap.handleKey;
    return Mousetrap.handleKey = (function(_this) {
      return function(char, mod, e) {
        var chac, key, norm, ref2;
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
              if (e.type === 'keypress') {
                chac = char.charCodeAt(0);
                if (chac < 32) {
                  char = String.fromCharCode(chac | 96);
                }
                return {
                  str: char
                };
              }
              break;
            case e.type !== 'keydown':
              if (char !== 'space') {
                return {
                  act: (ref2 = norm[char]) != null ? ref2 : char
                };
              }
              break;
            case !(e.type === 'keyup' && norm[key] === 'caps'):
              return {
                act: 'uncap'
              };
          }
        })();
        if (!key) {
          return;
        }
        if (key.act && (ref2 = key.act, indexOf.call(mod, ref2) >= 0)) {
          return;
        }
        e.preventDefault();
        return _this.eatKyev(mod, key);
      };
    })(this);
  }
})));


},{"./share.coffee":2}],2:[function(require,module,exports){
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


},{}]},{},[1]);
