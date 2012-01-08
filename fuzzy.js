(function() {
  var blacklist, coffee_lines, file_lines, fn_coffee, fn_js, fs, fuzzy_match, html_escape, js_lines, matches, parse_js_tokens, parse_tokens, root, side_by_side;
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
    if (word === 'for' || word === 'when' || word === 'require' || word === 'true' || word === 'false' || word === 'var' || word === 'class' || word === 'call' || word === 'this' || word === 'return') {
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
    var clue_token, find_js_match, i, j, js_tokens, line, ln, matches, next_js_line, seen, token, tokens, _i, _j, _len, _len2, _len3;
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
    matches = [];
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
    for (i = 0, _len = coffee_lines.length; i < _len; i++) {
      line = coffee_lines[i];
      tokens = parse_tokens(line);
      tokens = (function() {
        var _i, _len2, _results;
        _results = [];
        for (_i = 0, _len2 = tokens.length; _i < _len2; _i++) {
          token = tokens[_i];
          if (!seen[token]) {
            _results.push(token);
          }
        }
        return _results;
      })();
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
        if ((j < next_js_line && next_js_line < js_tokens.length)) {
          j = next_js_line;
          matches.push([i, j, clue_token]);
        }
      }
    }
    matches.push([coffee_lines.length, js_lines.length, "EOF"]);
    return matches;
  };
  html_escape = function(text) {
    text = text.replace(/&/g, "&amp;");
    text = text.replace(/</g, "&lt;");
    text = text.replace(/>/g, "&gt;");
    return text;
  };
  side_by_side = function(matches, source_lines, dest_lines) {
    var d_end, d_snippet, d_start, html, last_match, match, row, s_end, s_snippet, s_start, _i, _len;
    s_start = d_start = 0;
    html = '<table border=1>';
    row = function(cells) {
      var cell;
      html += '<tr valign="top">';
      html += ((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = cells.length; _i < _len; _i++) {
          cell = cells[_i];
          _results.push("<td><pre>" + (html_escape(cell)) + "</pre></td>");
        }
        return _results;
      })()).join('');
      return html += '</tr>';
    };
    last_match = '';
    for (_i = 0, _len = matches.length; _i < _len; _i++) {
      match = matches[_i];
      s_end = match[0], d_end = match[1];
      s_snippet = source_lines.slice(s_start, s_end).join('\n');
      d_snippet = dest_lines.slice(d_start, d_end).join('\n');
      row(["" + last_match, s_snippet, d_snippet]);
      s_start = s_end;
      d_start = d_end;
      last_match = match;
    }
    html += '</table>';
    return console.log(html);
  };
  root = "rosetta_crawl";
  root = "lru";
  fn_coffee = "" + root + ".coffee";
  fn_js = "" + root + ".js";
  coffee_lines = file_lines(fn_coffee);
  js_lines = file_lines(fn_js);
  matches = fuzzy_match(coffee_lines, js_lines);
  side_by_side(matches, coffee_lines, js_lines);
}).call(this);
