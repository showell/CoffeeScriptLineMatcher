http = require 'http'
fs = require 'fs'

DIR = null # will be cmd-line arg

walk = (dir, f_match, f_visit) ->
  _walk = (dir) ->
    fns = fs.readdirSync dir
    dirs = []
    for fn in fns
      fn = dir + '/' + fn
      if f_match fn
        f_visit fn
      if fs.statSync(fn).isDirectory()
        dirs.push fn
    for dir in dirs
        _walk dir
  _walk(dir)
  
table = (rows) ->
  html = '<table>'
  for row in rows
    html += '<tr>'
    html += ("<td>#{cell}</td>" for cell in row).join ''
    html += '</tr>'
  html += '</table>'
  html

split_file = (fn) ->
  parts = fn.split '/'
  short_fn = parts.pop()
  [root, ext] = short_fn.split '.'
  [parts, root, ext]
  
list_files = (cb) ->
  # TODO: clean up file paths, find best match, add ignore facility
  get_files = (regex) ->
    # HACK: just exclude node_modules for now
    matcher = (fn) ->
      fn.match(regex) and !fn.match(/node_modules/)
    files = []
    walk DIR, matcher, (fn) -> files.push fn
    files
  cs_files = get_files /\.coffee/
  js_files = get_files /\.js/

  js_file_for = (cs_file) ->
    [cs_path, cs_root] = split_file cs_file
    match = null
    for js_file in js_files
      [js_path, js_root] = split_file js_file
      match = js_file if js_root == cs_root
    match
      
  rows = []
  for cs_file in cs_files
    js_file = js_file_for cs_file
    [cs_path, cs_root] = split_file cs_file
    cs_path = cs_path.join '/'
    row = [cs_path, cs_root]
    if js_file
      [js_path, js_root] = split_file js_file
      js_path = js_path.join '/'
      row.push js_path
    rows.push row
  cb table rows
  
run_dashboard = (port) ->
  server = http.createServer (req, res) ->
    serve_page = (html) ->
      res.writeHeader 200, 'Content-Type': 'text/html'
      res.write html
      res.end()
  
    list_files serve_page

  server.listen port
  console.log "Server running at http://localhost:#{port}/"
  
[ignore, ignore, DIR, port] = process.argv
run_dashboard(port)
