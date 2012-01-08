fs = require 'fs'

blacklist = (word) ->
  return true if word.length <= 2
  return true if word in ['for', 'when', 'require', 'true', 'false']
  false
  
parse_tokens = (line) ->
  re = /([A-Za-z0-9_]+)/g
  matches = line.match(re) or []
  (word for word in matches when !blacklist word)

file_lines = (fn) ->
  fs.readFileSync(fn).toString().split '\n'

fuzzy_match = (coffee_lines, js_lines) ->
  js_tokens = (parse_tokens(line) for line in js_lines)
  j = 0
  seen = {}
  for line, i in coffee_lines
    tokens = parse_tokens line
    tokens = (token for token in tokens when !seen[token])
    if tokens.length > 0
      next_js_line = j
      for token in tokens
        console.log i, token
        seen[token] = true

fn_coffee = 'hanoi.coffee'
fn_js = 'hanoi.js'
fuzzy_match file_lines(fn_coffee), file_lines(fn_js)

