(function() {
  var file_lines, fs, side_by_side, source_line_mappings;
  fs = require('fs');
  side_by_side = require('./side_by_side').side_by_side;
  source_line_mappings = require('./cs_js_source_mapping').source_line_mappings;
  file_lines = function(fn) {
    return fs.readFileSync(fn).toString().split('\n');
  };
  (function() {
    var coffee_lines, fn_coffee, fn_js, js_lines, matches;
    fn_coffee = process.argv[2];
    fn_js = fn_coffee.replace(/\.coffee$/, '.js');
    coffee_lines = file_lines(fn_coffee);
    js_lines = file_lines(fn_js);
    matches = source_line_mappings(coffee_lines, js_lines);
    return side_by_side(matches, coffee_lines, js_lines);
  })();
}).call(this);
