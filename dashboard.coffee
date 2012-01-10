http = require 'http'
fs = require 'fs'
url = require 'url'

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

get_files = (regex) ->
  # HACK: just exclude node_modules for now
  matcher = (fn) ->
    fn.match(regex) and !fn.match(/node_modules/)
  files = []
  walk DIR, matcher, (fn) -> files.push fn
  files

js_file_for = (cs_file, js_files) ->
  [cs_path, cs_root] = split_file cs_file
  match = null
  for js_file in js_files
    [js_path, js_root] = split_file js_file
    match = js_file if js_root == cs_root
  match
      
list_files = (cb) ->
  # TODO: clean up file paths, find best match, add ignore facility
  cs_files = get_files /\.coffee/
  js_files = get_files /\.js/

  rows = []
  for cs_file in cs_files
    js_file = js_file_for cs_file, js_files
    [cs_path, cs_root] = split_file cs_file
    cs_path = cs_path.join '/'
    view_link = "<a href='view?FILE=#{encodeURI cs_file}'>#{cs_root}</a>"
    row = [cs_path, view_link]
    if js_file
      [js_path, js_root] = split_file js_file
      js_path = js_path.join '/'
      row.push js_path
    rows.push row
  cb table rows
  
view_file = (fn, cb) ->
  cs_files = get_files /\.coffee/
  js_files = get_files /\.js/
  throw "illegal file #{fn}" unless fn in cs_files
  js_file = js_file_for fn, js_files
  if js_file is null
    return cb "No JS file for #{fn}"
  cb fn
  
run_dashboard = (port) ->
  server = http.createServer (req, res) ->
    serve_page = (html) ->
      res.writeHeader 200, 'Content-Type': 'text/html'
      res.write html
      res.end()
  
    parts = url.parse(req.url, true)
    if parts.pathname == '/view'
      view_file parts.query.FILE, serve_page
    list_files serve_page

  server.listen port
  console.log "Server running at http://localhost:#{port}/"
  
[ignore, ignore, DIR, port] = process.argv
run_dashboard(port)
