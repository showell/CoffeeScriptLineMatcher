html_escape = (text) ->
  text = text.replace /&/g, "&amp;"
  text = text.replace /</g, "&lt;"
  text = text.replace />/g, "&gt;"
  text

pre = (s, klass) ->
  "<pre class='#{klass}'>#{html_escape s}</pre>"

exports.side_by_side = (matches, source_lines, dest_lines) ->
  html = """
    <style>
    pre {
      font-size: 11px;
      padding: 4px;
    }
    .numbers {
      color: blue;
    }
    .code {
      width: 610px;
      overflow: auto;
    }
    </style>
    <table border=1>
    <tr>
      <th>CS</th>
      <th>CoffeeScript</th>
      <th>JS</th>
      <th>JavaScript</th>
    </tr>
  """
  
  row = (cells) ->
    html += '<tr valign="top">'
    html += ("<td>#{cell}</td>" for cell in cells).join ''
    html += '</tr>'
    
  text = (lines, start, end) ->
    code = lines[start...end].join '\n'
    pre code, "code"

  line_numbers = (start, end, prefix) ->
    numbers = ("#{prefix}:#{ln+1}" for ln in [start...end])
    pre numbers.join('\n'), "numbers"
     
  last_match = ''
  s_start = 0
  d_start = 0
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
  html  
