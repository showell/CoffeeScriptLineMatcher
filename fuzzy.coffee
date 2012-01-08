fs = require 'fs'

blacklist = (word) ->
  return true if word.length <= 2
  return true if word in ['for', 'when', 'require', 'true', 'false', 'var']
  false
  
parse_tokens = (line) ->
  line = line.split('#')[0]
  re = /([A-Za-z0-9_]+)/g
  matches = line.match(re) or []
  (word for word in matches when !blacklist word)

parse_js_tokens = (line) ->
  return [] if ~line.indexOf(" var ")
  parse_tokens line

file_lines = (fn) ->
  fs.readFileSync(fn).toString().split '\n'

fuzzy_match = (coffee_lines, js_lines) ->
  js_tokens = (parse_js_tokens(line) for line in js_lines)
  j = 0
  
  find_js_match = (token) ->
    for k in [j...js_tokens.length]
      return k if token in js_tokens[k]
    js_tokens.length
  
  seen = {}
  for line, i in coffee_lines
    tokens = parse_tokens line
    tokens = (token for token in tokens when !seen[token])
    if tokens.length > 0
      for token in tokens
        seen[token] = true
      next_js_line = js_tokens.length
      for token in tokens
        ln = find_js_match(token)
        if ln < next_js_line
          next_js_line = ln
          clue_token = token
      if next_js_line < js_tokens.length
        j = next_js_line
        console.log i+1, j+1, clue_token

fn_coffee = 'fuzzy.coffee'
fn_js = 'fuzzy.js'
fuzzy_match file_lines(fn_coffee), file_lines(fn_js)

