fs = require 'fs'
{side_by_side} = require './side_by_side'

parse_tokens = (line) ->
  # strict mode, we just want assignments
  line = line.split('#')[0]
  re = /([A-Za-z0-9_]+)\s+=/g
  matches = line.match(re)
  return [] unless matches
  lhs = matches[0]
  lhs = lhs[0...lhs.length-1].trim()
  return [lhs + " ="]

file_lines = (fn) ->
  fs.readFileSync(fn).toString().split '\n'

fuzzy_match = (coffee_lines, js_lines) ->
  j = 0
  matches = []
  
  find_js_match = (token) ->
    for k in [j...js_lines.length]
      return k if ~js_lines[k].indexOf(token)
    js_lines.length
  
  for line, i in coffee_lines
    tokens = parse_tokens line
    if tokens.length > 0
      next_js_line = js_lines.length
      for token in tokens
        ln = find_js_match(token)
        if j < ln < next_js_line
          next_js_line = ln
          clue_token = token
      if j < next_js_line < js_lines.length
        j = next_js_line
        matches.push [i, j, clue_token]
  matches.push [coffee_lines.length, js_lines.length, "EOF"]
  matches


do ->
  # line = '_.breakLoop() unless (result = result and iterator.call'
  # console.log parse_tokens line
  # return
  fn_coffee = process.argv[2]
  fn_js = fn_coffee.replace /\.coffee$/, '.js'
  coffee_lines = file_lines(fn_coffee)
  js_lines = file_lines(fn_js)
  matches = fuzzy_match coffee_lines, js_lines
  side_by_side matches, coffee_lines, js_lines
