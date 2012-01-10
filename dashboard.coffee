http = require 'http'
fs = require 'fs'

DIR = '.'

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
  get_files = (regex) ->
    matcher = (fn) -> fn.match regex
    files = []
    walk DIR, matcher, (fn) -> files.push fn
    files
  cs_files = get_files /\.coffee/
  js_files = get_files /\.js/

  js_file_for = (cs_file) ->
    [cs_path, cs_root] = split_file cs_file
    for js_file in js_files
      [js_path, js_root] = split_file js_file
      return js_file if js_root == cs_root
    ''
      
  cells = ([cs_file, js_file_for cs_file] for cs_file in cs_files)
  cb table cells
  
run_dashboard = ->
  server = http.createServer (req, res) ->
    serve_page = (html) ->
      res.writeHeader 200, 'Content-Type': 'text/html'
      res.write html
      res.end()
  
    list_files serve_page

  port = 3000
  server.listen port
  console.log "Server running at http://localhost:#{port}/"
  
run_dashboard()