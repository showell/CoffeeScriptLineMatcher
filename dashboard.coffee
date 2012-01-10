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
  
list_files = (cb) ->
  get_files = (regex) ->
    matcher = (fn) -> fn.match regex
    files = []
    walk DIR, matcher, (fn) -> files.push fn
    files
  cs_files = get_files /\.coffee/
  js_files = get_files /\.js/
  cs_files = cs_files.concat js_files
  cells = ([file] for file in cs_files)
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