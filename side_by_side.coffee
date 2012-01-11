html_escape = (text) ->
  text = text.replace /&/g, "&amp;"
  text = text.replace /</g, "&lt;"
  text = text.replace />/g, "&gt;"
  text

pre = (s) ->
  "<pre>#{html_escape s}</pre>"
  

exports.side_by_side = (matches, source_lines, dest_lines) ->
  s_start = d_start = 0
  html = """
    <style>
    pre {
      font-size: 11px;
      padding: 4px;
    }
    </style>
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
  html  
