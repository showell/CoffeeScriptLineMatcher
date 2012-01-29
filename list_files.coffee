file_utils = require './file_utils'

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

list_files = (top_level_dir, get_files, coffee_file_regex, cb) ->

  html = """
    <head>
      <link rel="stylesheet" href="./dashboard.css" />
      <title>CS/JS Code Browser</title>
    </head>
    <h2>CS/JS Files in #{top_level_dir}</h2>
    <a href="./about">About</a>
    """
  html += list_files_body top_level_dir, get_files, coffee_file_regex
  cb html
  
list_files_body = (top_level_dir, get_files, coffee_file_regex) ->
  cs_files = get_files coffee_file_regex
  js_files = get_files /\.js$/

  curr_cs_path = null
  dirs = []
  for cs_file in cs_files
    [cs_path, cs_root] = file_utils.split_file cs_file
    cs_path = cs_path.join '/'
    if cs_path != curr_cs_path
      curr_cs_path = cs_path
      dir =
        path: file_utils.relative_path top_level_dir, cs_path
        rows: []
      dirs.push dir
    row = row_for_file cs_file, cs_root, js_files, top_level_dir
    dir.rows.push row
  render dirs

row_for_file = (cs_file, cs_root, js_files, top_level_dir) ->
  view_link = "<a href='./view?FILE=#{encodeURI cs_file}'>#{cs_root}</a>"
  row = [file_utils.get_num_lines_in_file(cs_file), view_link]
  js_file = file_utils.js_file_for cs_file, js_files
  if js_file
    row.push file_utils.relative_path top_level_dir, js_file
  row

render = (dirs) ->
  html = ''
  for dir in dirs
    html += dir_header dir.path
    html += render_dir_files dir.rows
  html    

dir_header = (path) ->
  """
  <hr>
  <h3>#{path}</h3>
  """
    
render_dir_files = (rows) ->
  headers = ['line count for CS', 'coffee', 'JS file']    
  table headers, rows
  
exports.list_files = list_files