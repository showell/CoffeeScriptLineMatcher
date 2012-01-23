fs = require 'fs'
{source_line_mappings} = require './cs_js_source_mapping'

file_lines = (fn) ->
  fs.readFileSync(fn).toString().split '\n'

list = (cs_lines, js_lines) ->
  matches = source_line_mappings cs_lines, js_lines
  
  snippet = (lines, start, end, prefix) ->
    for ln in [start...end]
      line = lines[ln]
      console.log "#{prefix}:#{ln+1} #{line}"
    null
     
  s_start = 0
  d_start = 0
  for match in matches
    [s_end, d_end] = match
    snippet cs_lines, s_start, s_end, 'cs'
    console.log '-----'
    snippet js_lines, d_start, d_end, 'js'
    console.log '=============================================================='
    s_start = s_end
    d_start = d_end

do ->
  [ignore, ignore, cs_file, js_file] = process.argv
  cs_lines = file_lines(cs_file)
  
  if js_file == '-'
    data = ''
    stdin = process.openStdin()
    stdin.on 'data', (buffer) ->
      data += buffer.toString() if buffer
    stdin.on 'end', ->
      js_lines = data.split '\n'
      list cs_lines, js_lines
  else
    js_lines = file_lines(js_file)
    list cs_lines, js_lines