(function() {
  var blacklist, file_lines, fn_coffee, fn_js, fs, fuzzy_match, parse_js_tokens, parse_tokens;
  var __indexOf = Array.prototype.indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (this[i] === item) return i;
    }
    return -1;
  };
  fs = require('fs');
  blacklist = function(word) {
    if (word.length <= 2) {
      return true;
    }
    if (word === 'for' || word === 'when' || word === 'require' || word === 'true' || word === 'false' || word === 'var') {
      return true;
    }
    return false;
  };
  parse_tokens = function(line) {
    var matches, re, word, _i, _len, _results;
    line = line.split('#')[0];
    re = /([A-Za-z0-9_]+)/g;
    matches = line.match(re) || [];
    _results = [];
    for (_i = 0, _len = matches.length; _i < _len; _i++) {
      word = matches[_i];
      if (!blacklist(word)) {
        _results.push(word);
      }
    }
    return _results;
  };
  parse_js_tokens = function(line) {
    if (~line.indexOf(" var ")) {
      return [];
    }
    return parse_tokens(line);
  };
  file_lines = function(fn) {
    return fs.readFileSync(fn).toString().split('\n');
  };
  fuzzy_match = function(coffee_lines, js_lines) {
    var clue_token, find_js_match, i, j, js_tokens, line, ln, next_js_line, seen, token, tokens, _len, _results;
    js_tokens = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = js_lines.length; _i < _len; _i++) {
        line = js_lines[_i];
        _results.push(parse_js_tokens(line));
      }
      return _results;
    })();
    j = 0;
    find_js_match = function(token) {
      var k, _ref;
      for (k = j, _ref = js_tokens.length; j <= _ref ? k < _ref : k > _ref; j <= _ref ? k++ : k--) {
        if (__indexOf.call(js_tokens[k], token) >= 0) {
          return k;
        }
      }
      return js_tokens.length;
    };
    seen = {};
    _results = [];
    for (i = 0, _len = coffee_lines.length; i < _len; i++) {
      line = coffee_lines[i];
      tokens = parse_tokens(line);
      tokens = (function() {
        var _i, _len2, _results2;
        _results2 = [];
        for (_i = 0, _len2 = tokens.length; _i < _len2; _i++) {
          token = tokens[_i];
          if (!seen[token]) {
            _results2.push(token);
          }
        }
        return _results2;
      })();
      _results.push((function() {
        var _i, _j, _len2, _len3;
        if (tokens.length > 0) {
          for (_i = 0, _len2 = tokens.length; _i < _len2; _i++) {
            token = tokens[_i];
            seen[token] = true;
          }
          next_js_line = js_tokens.length;
          for (_j = 0, _len3 = tokens.length; _j < _len3; _j++) {
            token = tokens[_j];
            ln = find_js_match(token);
            if (ln < next_js_line) {
              next_js_line = ln;
              clue_token = token;
            }
          }
          if (next_js_line < js_tokens.length) {
            j = next_js_line;
            return console.log(i + 1, j + 1, clue_token);
          }
        }
      })());
    }
    return _results;
  };
  fn_coffee = 'fuzzy.coffee';
  fn_js = 'fuzzy.js';
  fuzzy_match(file_lines(fn_coffee), file_lines(fn_js));
}).call(this);
