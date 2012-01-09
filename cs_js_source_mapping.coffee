# This module attempts to find source line mappings between CS code
# and JS code.

parse_tokens = (line) ->
  # For now, the only token we use for matching between
  # CS and JS code is simple variable assignments.
  line = line.split('#')[0]
  re = /([A-Za-z0-9_]+)\s+=/g
  matches = line.match(re)
  return [] unless matches
  lhs = matches[0]
  lhs = lhs[0...lhs.length-1].trim()
  return [lhs + " ="]

exports.source_line_mappings = (coffee_lines, js_lines) ->
  # Return an array of source line mappings, where each mapping
  # is an array with these elements:
  #    CS line number (zero-based)
  #    JS line number (zero-based)
  #    metadata (e.g. token that was matched between CS/JS)
  #
  # Not every CS line gets a mapping, but ideally enough lines get
  # mapped to help out downstream tools.
  j = 0
  matches = []

  find_js_match = (token) ->
    for k in [j...js_lines.length]
      return k if ~js_lines[k].indexOf(token)
    js_lines.length

  for line, i in coffee_lines
    tokens = parse_tokens line
    if tokens.length > 0
      next_js_line = js_lines.length
      for token in tokens
        ln = find_js_match(token)
        if j < ln < next_js_line
          next_js_line = ln
          clue_token = token
      if j < next_js_line < js_lines.length
        j = next_js_line
        matches.push [i, j, clue_token]
  matches.push [coffee_lines.length, js_lines.length, "EOF"]
  matches

