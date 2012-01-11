# DEPRECATED: see dashboard.coffee for more functionality
#
# This tool lets you create an HTML side-by-side mapping
# of CoffeeScript and JavaScript.  Most of the heavy lifting
# is done in other modules.

fs = require 'fs'
{side_by_side} = require './side_by_side'
{source_line_mappings} = require './cs_js_source_mapping'

file_lines = (fn) ->
  fs.readFileSync(fn).toString().split '\n'

do ->
  # line = '_.breakLoop() unless (result = result and iterator.call'
  # console.log parse_tokens line
  # return
  fn_coffee = process.argv[2]
  fn_js = fn_coffee.replace /\.coffee$/, '.js'
  coffee_lines = file_lines(fn_coffee)
  js_lines = file_lines(fn_js)
  matches = source_line_mappings coffee_lines, js_lines
  console.log side_by_side matches, coffee_lines, js_lines
