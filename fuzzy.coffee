fs = require 'fs'

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
