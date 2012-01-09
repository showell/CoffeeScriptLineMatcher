(function() {
  var file_lines, fs, fuzzy_match, parse_tokens, side_by_side;
  fs = require('fs');
  side_by_side = require('./side_by_side').side_by_side;
  parse_tokens = function(line) {
    var lhs, matches, re;
    line = line.split('#')[0];
    re = /([A-Za-z0-9_]+)\s+=/g;
    matches = line.match(re);
    if (!matches) {
      return [];
    }
    lhs = matches[0];
    lhs = lhs.slice(0, lhs.length - 1).trim();
    return [lhs + " ="];
  };
  file_lines = function(fn) {
    return fs.readFileSync(fn).toString().split('\n');
  };
  fuzzy_match = function(coffee_lines, js_lines) {
    var clue_token, find_js_match, i, j, line, ln, matches, next_js_line, token, tokens, _i, _len, _len2;
    j = 0;
    matches = [];
    find_js_match = function(token) {
      var k, _ref;
      for (k = j, _ref = js_lines.length; j <= _ref ? k < _ref : k > _ref; j <= _ref ? k++ : k--) {
        if (~js_lines[k].indexOf(token)) {
          return k;
        }
      }
      return js_lines.length;
    };
    for (i = 0, _len = coffee_lines.length; i < _len; i++) {
      line = coffee_lines[i];
      tokens = parse_tokens(line);
      if (tokens.length > 0) {
        next_js_line = js_lines.length;
        for (_i = 0, _len2 = tokens.length; _i < _len2; _i++) {
          token = tokens[_i];
          ln = find_js_match(token);
          if ((j < ln && ln < next_js_line)) {
            next_js_line = ln;
            clue_token = token;
          }
        }
        if ((j < next_js_line && next_js_line < js_lines.length)) {
          j = next_js_line;
          matches.push([i, j, clue_token]);
        }
      }
    }
    matches.push([coffee_lines.length, js_lines.length, "EOF"]);
    return matches;
  };
  (function() {
    var coffee_lines, fn_coffee, fn_js, js_lines, matches;
    fn_coffee = process.argv[2];
    fn_js = fn_coffee.replace(/\.coffee$/, '.js');
    coffee_lines = file_lines(fn_coffee);
    js_lines = file_lines(fn_js);
    matches = fuzzy_match(coffee_lines, js_lines);
    return side_by_side(matches, coffee_lines, js_lines);
  })();
}).call(this);
