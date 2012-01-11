{source_line_mappings} = require '../cs_js_source_mapping'

file_lines = (fn) ->
  fs.readFileSync(fn).toString().split '\n'

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
  
# WORK IN PROGRESS