http = require 'http'
fs = require 'fs'
url = require 'url'

{side_by_side} = require './side_by_side'
{source_line_mappings} = require './cs_js_source_mapping'

DIR = null # will be cmd-line arg
GIT_REPO = "https://github.com/showell/CoffeeScriptLineMatcher"

file_lines = (fn) ->
  fs.readFileSync(fn).toString().split '\n'

get_num_lines_in_file = (fn) ->
  (fs.readFileSync(fn).toString().split '\n').length

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
    return
  _walk(dir)
  
relative_path = (fn) ->
  fn.substring(DIR.length + 1, fn.length)
  
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
        align = "right"
      else
        align = "left"
      "<td align='#{align}'>#{cell}</td>"
    html += (td cell for cell in row).join ''
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

score_path_similarity = (path1, path2) ->
  # find out how many common directories there are, to
  # help us determine the likelihood of path2 being an
  # output directory for path1
  score = 0
  for part in path1
    score += 1 if part in path2
  score 

js_file_for = (cs_file, js_files) ->
  [cs_path, cs_root] = split_file cs_file
  match = null
  score = 0
  for js_file in js_files
    [js_path, js_root] = split_file js_file
    if js_root == cs_root
      new_score = score_path_similarity(cs_path, js_path)
      if new_score > score
        match = js_file
        score = new_score
  if match
    cs_time = fs.statSync(cs_file).mtime.toISOString()
    js_time = fs.statSync(match).mtime.toISOString()
    return null if cs_time > js_time
  match
      
list_files = (cb) ->
  cs_files = get_files /\.coffee/
  js_files = get_files /\.js/

  html = """
    <head>
      <title> CS/JS Code Browser</title>
    </head>
    <h2>CS/JS Files in #{DIR}</h2>
    <a href="about">About</a>
    """
  headers = ['line count for CS', 'coffee', 'JS file']

  curr_cs_path = null
  rows = []
  for cs_file in cs_files
    [cs_path, cs_root] = split_file cs_file
    cs_path = cs_path.join '/'
    if cs_path != curr_cs_path
      curr_cs_path = cs_path
      if rows.length > 0
        html += table headers, rows
      html += "<h3>#{relative_path cs_path}</h3>"
      rows = []
    view_link = "<a href='view?FILE=#{encodeURI cs_file}'>#{cs_root}</a>"
    row = [get_num_lines_in_file(cs_file), view_link]
    js_file = js_file_for cs_file, js_files
    if js_file
      row.push relative_path js_file
    rows.push row
  html += table headers, rows
  cb html
  
worst_match = (matches) ->
  # debugging code
  last = 0
  max = 0
  worst = null
  for match in matches
    [cs, js] = match
    if js - last > max
      max = js - last
      worst = js - max + 1
    last = js
  "The longest JS section starts at line #{worst} (#{max} lines)."
    
view_file = (fn, cb) ->
  html = """
    <head>
      <title>#{relative_path fn}</title>
      <link rel="stylesheet" href="dashboard.css" />
    </head>
    <h4>#{relative_path fn}</h4>
    <a href="/">View files</a> (#{DIR})
    <br>
    <a href="about">About</a>
    <hr>
    """
  
  cs_files = get_files /\.coffee/
  js_files = get_files /\.js/
  throw "illegal file #{fn}" unless fn in cs_files
  js_fn = js_file_for fn, js_files
  if js_fn is null
    return cb "No current JS file was found for #{fn}"
    
  coffee_lines = file_lines(fn)
  js_lines = file_lines(js_fn)
  matches = source_line_mappings coffee_lines, js_lines
  html += worst_match(matches)
  html += side_by_side matches, coffee_lines, js_lines
  cb html
  
about = (cb) ->
  cb """
    <head>
      <title>About CoffeeScriptLineMatcher</title>
      <link rel="stylesheet" href="dashboard.css" />
    </head>
    <h2>About</h2>
    <a href="/">View files</a>
    
    <p>
      GIT Repository: <a href="#{GIT_REPO}">CoffeeScriptLineMatcher</a>.
    </p>
    <p>
      This tool lets you view CS and JS code side by side.
    </p>
    <p>
      The algorithm for matching up CS lines to JS lines is 
      independent of the compiler itself.  I've tested the
      algorithm on several CS examples, but unorthodox coding
      styles will likely confuse the algorithm.  (Long term,
      CS itself will have line number support, so this tool
      can eventually be patched to use native mappings.)
    </p>
    """
    
    
run_dashboard = (port) ->
  server = http.createServer (req, res) ->
    serve_page = (html) ->
      res.writeHeader 200, 'Content-Type': 'text/html'
      res.write html
      res.end()
  
    parts = url.parse(req.url, true)
    
    try
      if parts.pathname == '/view'
        view_file parts.query.FILE, serve_page
      else if parts.pathname == '/about'
        about serve_page
      else if parts.pathname == '/dashboard.css'
        serve_page fs.readFileSync './dashboard.css'
      list_files serve_page
    catch e
      # Right now our code is mostly synchronous, but this won't
      # catch async exceptions, so it's just a band-aid for now.
      serve_page "Exception: #{e}"

  server.listen port
  console.log "Server running at http://localhost:#{port}/"
  
[ignore, ignore, DIR, port] = process.argv
run_dashboard(port)
