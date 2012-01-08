fs = require 'fs'

blacklist = (word) ->
  return true if word.length <= 2
  return true if word in ['for', 'when', 'require', 'true', 'false', 'var', 'class', 'call', 'this']
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
  matches = []
  
  find_js_match = (token) ->
    for k in [j+1...js_tokens.length]
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
        matches.push [i+1, j+1, clue_token]
  matches

html_escape = (text) ->
  text = text.replace /&/g, "&amp;"
  text = text.replace /</g, "&lt;"
  text = text.replace />/g, "&gt;"
  text

side_by_side = (matches, source_lines, dest_lines) ->
  s_start = d_start = 0
  html = '<table border=1>'
  row = (cells) ->
    html += '<tr valign="top">'
    html += ("<td><pre>#{html_escape cell}</pre></td>" for cell in cells).join ''
    html += '</tr>'
    
  
  for match in matches
    [s_end, d_end] = match
    s_snippet = source_lines[s_start...s_end].join '\n'
    d_snippet = dest_lines[d_start...d_end].join '\n'
    row [s_snippet, d_snippet]
    s_start = s_end
    d_start = d_end
  
  html += '</table>'
  console.log html  

fn_coffee = 'fuzzy.coffee'
fn_js = 'fuzzy.js'
coffee_lines = file_lines(fn_coffee)
js_lines = file_lines(fn_js)
matches = fuzzy_match coffee_lines, js_lines
side_by_side matches, coffee_lines, js_lines
