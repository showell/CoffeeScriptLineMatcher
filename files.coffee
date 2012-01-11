fs = require 'fs'

file_lines = (fn) ->
  fs.readFileSync(fn).toString().split '\n'

get_num_lines_in_file = (fn) ->
  (fs.readFileSync(fn).toString().split '\n').length

relative_path = (dir, fn) ->
  fn.substring(dir.length + 1, fn.length)

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

split_file = (fn) ->
  parts = fn.split '/'
  short_fn = parts.pop()
  [root, ext] = short_fn.split '.'
  [parts, root, ext]

get_files = (dir, regex) ->
  # HACK: just exclude node_modules for now
  matcher = (fn) ->
    fn.match(regex) and !fn.match(/node_modules/)
  files = []
  walk dir, matcher, (fn) -> files.push fn
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
  
exports.file_lines = file_lines
exports.get_num_lines_in_file = get_num_lines_in_file
exports.relative_path = relative_path
exports.split_file = split_file
exports.get_files = get_files
exports.js_file_for = js_file_for


