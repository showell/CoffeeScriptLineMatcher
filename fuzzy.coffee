fs = require 'fs'

blacklist = (word) ->
  return true if word.length <= 2
  return true if word in ['for', 'when', 'require', 'true', 'false', 'var', 'class', 'call', 'this', 'return', 'else', 'null', 'loop', 'unless']
  false
  
parse_tokens = (line) ->
  line = line.split('#')[0]
  re = /([A-Za-z0-9_]+)/g
  matches = line.match(re) or []
  (word for word in matches when !blacklist word)

parse_js_tokens = (line) ->
  line = line.replace "\\n", " "
  return [] if ~line.indexOf(" var ")
  parse_tokens line

file_lines = (fn) ->
  fs.readFileSync(fn).toString().split '\n'

fuzzy_match = (coffee_lines, js_lines) ->
  js_tokens = (parse_js_tokens(line) for line in js_lines)
  j = 0
  matches = []
  
  find_js_match = (token) ->
    for k in [j...js_tokens.length]
      return k if token in js_tokens[k]
    js_tokens.length
  
  for line, i in coffee_lines
    tokens = parse_tokens line
    if tokens.length > 0
      next_js_line = js_tokens.length
      for token in tokens
        ln = find_js_match(token)
        if j < ln < next_js_line
          next_js_line = ln
          clue_token = token
      if j < next_js_line < js_tokens.length
        j = next_js_line
        matches.push [i, j, clue_token]
  matches.push [coffee_lines.length, js_lines.length, "EOF"]
  matches

html_escape = (text) ->
  text = text.replace /&/g, "&amp;"
  text = text.replace /</g, "&lt;"
  text = text.replace />/g, "&gt;"
  text

pre = (s) ->
  "<pre>#{html_escape s}</pre>"
  

side_by_side = (matches, source_lines, dest_lines) ->
  s_start = d_start = 0
  html = """
    <style>
    pre {
      font-size: 11px;
      padding: 4px;
    }
    </style>
    <p>
    This is a proof-of-concept of matching CS line numbers to JS
    line numbers WITHOUT ANY COMPILER SUPPORT!
    </p>
    <p>
    Line numbers are matched up by looking for matching tokens, with
    a few heuristics for avoiding false matches between CS and JS, such
    as ignoring JS var statements.
    </p>
    See code <a href="https://github.com/showell/CoffeeScriptLineMatcher/blob/master/fuzzy.coffee">here</a>.
    <table border=1>
  """
  row = (cells) ->
    html += '<tr valign="top">'
    html += ("<td>#{pre cell}</td>" for cell in cells).join ''
    html += '</tr>'
    
  text = (lines, start, end) ->
    lines = (line.substring(0, 85) for line in lines)
    lines[start...end].join '\n'
   
  line_numbers = (start, end, prefix) ->
    ("#{prefix}:#{ln+1}" for ln in [start...end]).join '\n'
     
  last_match = ''
  for match in matches
    [s_end, d_end] = match
    s_line_numbers = line_numbers s_start, s_end, 'cs'
    s_snippet = text source_lines, s_start, s_end
    d_line_numbers = line_numbers d_start, d_end, 'js'
    d_snippet = text dest_lines, d_start, d_end
    row [s_line_numbers, s_snippet, d_line_numbers, d_snippet]
    s_start = s_end
    d_start = d_end
    last_match = match
  
  html += '</table>'
  console.log html  

root = "underscore"
fn_coffee = "#{root}.coffee"
fn_js = "#{root}.js"
coffee_lines = file_lines(fn_coffee)
js_lines = file_lines(fn_js)
matches = fuzzy_match coffee_lines, js_lines
side_by_side matches, coffee_lines, js_lines
