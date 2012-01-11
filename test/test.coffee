fs = require 'fs'

{source_line_mappings} = require '../cs_js_source_mapping'
file_utils = require '../file_utils'

dir = '../examples'
cs_files = file_utils.get_files dir, /\.coffee/
js_files = file_utils.get_files dir, /\.js/

results = {}
for fn in cs_files
  js_fn = file_utils.js_file_for fn, js_files
  if js_fn is null
    throw Error "need to compile js"
    
  coffee_lines = file_utils.file_lines(fn)
  js_lines = file_utils.file_lines(js_fn)
  matches = source_line_mappings coffee_lines, js_lines
  map = {}
  for match in matches
    [cs, js] = match
    map[cs] = js
  results[file_utils.relative_path dir, fn] = map
data = JSON.stringify results, null, ' '
fs.writeFileSync 'test.json', data