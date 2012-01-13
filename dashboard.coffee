http = require 'http'
fs = require 'fs'
url = require 'url'

{side_by_side} = require './side_by_side'
{source_line_mappings} = require './cs_js_source_mapping'
file_utils = require './file_utils'

DIR = null # will be cmd-line arg
GIT_REPO = "https://github.com/showell/CoffeeScriptLineMatcher"
JQUERY_CDN = """
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
  """
COFFEE_FILE_REGEX = /\.(coffee|cof)$/


relative_path = (fn) -> file_utils.relative_path DIR, fn
get_files = (regex) -> file_utils.get_files DIR, regex

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

list_files = (cb) ->
  cs_files = get_files COFFEE_FILE_REGEX
  js_files = get_files /\.js$/

  html = """
    <head>
      <link rel="stylesheet" href="./dashboard.css" />
      <title>CS/JS Code Browser</title>
    </head>
    <h2>CS/JS Files in #{DIR}</h2>
    <a href="./about">About</a>
    """
  headers = ['line count for CS', 'coffee', 'JS file']

  curr_cs_path = null
  rows = []
  for cs_file in cs_files
    [cs_path, cs_root] = file_utils.split_file cs_file
    cs_path = cs_path.join '/'
    if cs_path != curr_cs_path
      curr_cs_path = cs_path
      if rows.length > 0
        html += table headers, rows
      html += """
        <hr>
        <h3>#{relative_path cs_path}</h3>
        """
      rows = []
    view_link = "<a href='./view?FILE=#{encodeURI cs_file}'>#{cs_root}</a>"
    row = [file_utils.get_num_lines_in_file(cs_file), view_link]
    js_file = file_utils.js_file_for cs_file, js_files
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
    if cs - last > max
      max = cs - last
      worst = cs - max + 1
    last = cs
  "The longest CS section starts at cs:#{worst} (#{max} lines)."
 
timestamps = (cs_fn, cb) ->
  # Return timestamps of our files.  Mostly used by AJAX calls to avoid
  # unnecessary page refreshes.
  cs_files = get_files COFFEE_FILE_REGEX
  ts = (fn) -> fs.statSync(fn).mtime.toISOString()
  js_files = get_files /\.js$/
  js_fn = file_utils.js_file_for cs_fn, js_files
  cb get_fingerprint cs_fn, js_fn
  
get_fingerprint = (cs_fn, js_fn) ->
  ts = (fn) -> fs.statSync(fn).mtime.toISOString()
  data =
    cs: ts cs_fn
  if js_fn
    data.js = ts js_fn
  data
   
view_file = (cs_fn, cb) ->
  html = """
    <head>
      <title>#{relative_path cs_fn}</title>
      <link rel="stylesheet" href="./dashboard.css" />
      #{JQUERY_CDN}
      <script type="text/javascript" src="view_file.js"></script>
    </head>
    <h4>#{relative_path cs_fn}</h4>
    <a href="./">View files</a> (#{DIR})
    <br>
    <a href="./about">About</a>
    <hr>
    """
  
  cs_files = get_files COFFEE_FILE_REGEX
  js_files = get_files /\.js$/
  throw "illegal file #{cs_fn}" unless cs_fn in cs_files
  js_fn = file_utils.js_file_for cs_fn, js_files

  add_metadata = ->
    finger_print = get_fingerprint cs_fn, js_fn
    finger_print = JSON.stringify finger_print, null, " "
    html += """
      <script>
      CS_FN = #{JSON.stringify cs_fn};
      FINGERPRINT = #{finger_print};
      </script>
      """

  if js_fn is null
    html += "<b>No current JS file was found for #{cs_fn}</b>"
    add_metadata()
    return cb html
   
  html += "<b>JS file</b>: #{relative_path js_fn}<br>" 
  coffee_lines = file_utils.file_lines(cs_fn)
  js_lines = file_utils.file_lines(js_fn)
  matches = source_line_mappings coffee_lines, js_lines
  html += worst_match(matches)
  html += side_by_side matches, coffee_lines, js_lines
  add_metadata()

  cb html
  
about = (cb) ->
  cb """
    <head>
      <title>About CoffeeScriptLineMatcher</title>
      <link rel="stylesheet" href="./dashboard.css" />
    </head>
    <h2>About</h2>
    <a href="./">View files</a>
    
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
      
    serve_css = (fn) ->
      res.writeHeader 200, 'Content-Type': 'text/css'
      res.write fs.readFileSync fn
      res.end()
      
    serve_js = (fn) ->
      res.writeHeader 200, 'Content-Type': 'text/javascript'
      res.write fs.readFileSync fn
      res.end()
      
    serve_json = (data) ->
      res.writeHeader 200, 'Content-Type': 'text/json'
      res.write JSON.stringify data, null, '  '
      res.end()
      
    parts = url.parse(req.url, true)
    
    console.log "Serving #{parts.pathname} #{JSON.stringify parts.query}"
    try
      if parts.pathname == '/view'
        view_file parts.query.FILE, serve_page
      else if parts.pathname == '/timestamps'
        timestamps parts.query.FILE, serve_json
      else if parts.pathname == '/about'
        about serve_page
      else if parts.pathname == '/dashboard.css'
        serve_css './assets/dashboard.css'
      else if parts.pathname == '/view_file.js'
        serve_js './assets/view_file.js'
      else if parts.pathname == '/'
        list_files serve_page
      else
        res.end()
    catch e
      # Right now our code is mostly synchronous, but this won't
      # catch async exceptions, so it's just a band-aid for now.
      serve_page "Exception: #{e}"

  server.listen port
  console.log "Server running at http://localhost:#{port}/"
  
do ->
  if process.argv.length <= 2
    DIR = '.'
    port = '10798'
  else
    [ignore, ignore, DIR, port] = process.argv
  unless port? and port.match /^\d+/
    console.warn "You must supply a port number as the second argument"
    return
  run_dashboard(port)
