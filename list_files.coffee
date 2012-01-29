file_utils = require './file_utils'
{render} = require './render_file_list'

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
    row = data_for_file cs_file, cs_root, js_files, top_level_dir
    dir.rows.push row
  render dirs

data_for_file = (cs_file, cs_root, js_files, top_level_dir) ->
  data = 
    cs_href: "./view?FILE=#{encodeURI cs_file}"
    cs_root: cs_root
    cs_num_lines: file_utils.get_num_lines_in_file(cs_file)
    
  js_file = file_utils.js_file_for cs_file, js_files
  if js_file
    data.js_file = js_file
    data.js_path = file_utils.relative_path top_level_dir, js_file
  data

exports.list_files = list_files