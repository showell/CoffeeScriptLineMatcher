# This code renders the main part of the main page, where you list all
# the coffeescript files, broken out by directory.  

render = (dirs) ->
  # Uncomment the next line if you want to see a raw view of the data.
  # return "<pre>#{JSON.stringify dirs, null, '  '}</pre>"
  html = ''
  for dir in dirs
    html += dir_header dir.path
    rows = (row_for_file data for data in dir.rows)
    html += render_dir_files rows
  html    

row_for_file = (data) ->
  view_link = "<a href='#{data.cs_href}'>#{data.cs_root}</a>"
  row = [data.cs_num_lines, view_link]
  if data.js_path
    row.push data.js_path
  row

dir_header = (path) ->
  """
  <hr>
  <h3>#{path}</h3>
  """

render_dir_files = (rows) ->
  headers = ['line count for CS', 'coffee', 'JS file']    
  table headers, rows

table = (headers, rows) ->
  html = '<table>'
  html += '<tr>'
  ths = ("<th>#{th}</th>" for th in headers)
  html += ths.join ''
  html += '</tr>'
  for row in rows
    html += '<tr>'
    td = (cell) ->
      if cell.toString().match /^\d+$/
        align = "center"
      else
        align = "left"
      "<td align='#{align}' class='view_files'>#{cell}</td>"
    html += (td cell for cell in row).join ''
    html += '</tr>'
  html += '</table>'
  html

exports.render = render