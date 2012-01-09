(function() {
  var html_escape, pre;
  html_escape = function(text) {
    text = text.replace(/&/g, "&amp;");
    text = text.replace(/</g, "&lt;");
    text = text.replace(/>/g, "&gt;");
    return text;
  };
  pre = function(s) {
    return "<pre>" + (html_escape(s)) + "</pre>";
  };
  exports.side_by_side = function(matches, source_lines, dest_lines) {
    var d_end, d_line_numbers, d_snippet, d_start, html, last_match, line_numbers, match, row, s_end, s_line_numbers, s_snippet, s_start, text, _i, _len;
    s_start = d_start = 0;
    html = "<style>\npre {\n  font-size: 11px;\n  padding: 4px;\n}\n</style>\n<p>\nThis is a proof-of-concept of matching CS line numbers to JS\nline numbers <b>without any compiler support</b>!\n</p>\n<p>\nLine numbers are matched up by looking for matching tokens, with\na few heuristics for avoiding false matches between CS and JS, such\nas ignoring JS var statements.\n</p>\nSee code <a href=\"https://github.com/showell/CoffeeScriptLineMatcher/blob/master/fuzzy.coffee\">here</a>.\n<table border=1>";
    row = function(cells) {
      var cell;
      html += '<tr valign="top">';
      html += ((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = cells.length; _i < _len; _i++) {
          cell = cells[_i];
          _results.push("<td>" + (pre(cell)) + "</td>");
        }
        return _results;
      })()).join('');
      return html += '</tr>';
    };
    text = function(lines, start, end) {
      var line;
      lines = (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = lines.length; _i < _len; _i++) {
          line = lines[_i];
          _results.push(line.substring(0, 85));
        }
        return _results;
      })();
      return lines.slice(start, end).join('\n');
    };
    line_numbers = function(start, end, prefix) {
      var ln;
      return ((function() {
        var _results;
        _results = [];
        for (ln = start; start <= end ? ln < end : ln > end; start <= end ? ln++ : ln--) {
          _results.push("" + prefix + ":" + (ln + 1));
        }
        return _results;
      })()).join('\n');
    };
    last_match = '';
    for (_i = 0, _len = matches.length; _i < _len; _i++) {
      match = matches[_i];
      s_end = match[0], d_end = match[1];
      s_line_numbers = line_numbers(s_start, s_end, 'cs');
      s_snippet = text(source_lines, s_start, s_end);
      d_line_numbers = line_numbers(d_start, d_end, 'js');
      d_snippet = text(dest_lines, d_start, d_end);
      row([s_line_numbers, s_snippet, d_line_numbers, d_snippet]);
      s_start = s_end;
      d_start = d_end;
      last_match = match;
    }
    html += '</table>';
    return console.log(html);
  };
}).call(this);
