# use npm install for below modules:
soupselect = require 'soupselect'
htmlparser = require 'htmlparser'

# configure these for your language
LANGUAGE = 'CoffeeScript'
LANGUAGE_WEBSITE = "http://coffeescript.org"
LANG_SELECTOR = 'pre.coffeescript.highlighted_source'
BLACKLIST = (title) ->
  # These are programs that just don't add a lot of value out of context,
  # or that have distracting style issues.
  return true if title in [
    '24 game' # whitespace
    '100 doors'
    'A+B'
    'Comments'
    'CSV to HTML translation'
    'Empty program'
    'First-class functions' # for now
    'Infinity'
    'Permutations' # whitespace
    'Quine'
  ]
  return true if title.match /Hello world/
  return true if title.match /Loops\//
  return true if title.match /Vigen.* cipher/ # unicode
  false
  
ROSETTA_INTRO = """
  <p>
  This site aggregates some content from <a href="http://rosettacode.org">Rosetta Code</a>, which is a website
  that presents solutions to programming tasks in many different languages.
  </p>
  
  <p>
  In particular, we focus on the <a href="#{LANGUAGE_WEBSITE}">#{LANGUAGE}</a> programming language.  
  Most of the content here was originally posted on Rosetta Code, and this content remains licensed under the 
  <a href="http://www.gnu.org/licenses/fdl-1.2.html">GNU Free Documentation Licence version 1.2</a>.
  </p>
  
  <p>
  You can see the code used for crawling Rosetta by
  following <a href="https://github.com/showell/InterviewPrep/blob/master/rosetta_crawl.coffee">this link</a>.
  </p>
  
  <p>
  Be a contributor!  You can enhance the Rosetta Code site by 
  <a href="http://rosettacode.org/wiki/Reports:Tasks_not_implemented_in_#{LANGUAGE}">
  implementing new tasks for #{LANGUAGE}</a>.
  </p>
"""


####
PAGE_INTRO = """
  <head>
  <title>#{LANGUAGE} Examples from Rosetta Code</title>
  <link rel="stylesheet" media="all" href="docco.css" />
  <style>
    body {
      margin-left: 50px;
    }
    p {
      width: 500px;
    }
    pre.code {
      margin-left: 30px;
    }
  </style>
  </head>
  #{ROSETTA_INTRO}
  """
LANGUAGE_PAGES_SELECTOR = "#mw-pages li a"
HOST = 'rosettacode.org'

http = require 'http'

process_task_page = (link_info, done) ->
  path = link_info.href
  page_link = "http://#{HOST}#{link_info.href}"
  lang_link = "#{page_link}##{LANGUAGE}"
  html = """
    <hr>
    <a name="#{link_info.title}" />
    <h2><a href=#{page_link}>#{link_info.title}</a></h2>
    <a href=#{lang_link}>#{LANGUAGE} section on Rosetta Code</a>
    <br>
    <a href="##{link_info.title}">(local link)</a><br />
    """

  process_page path, (err, dom) ->
    snippets = soupselect.select dom, LANG_SELECTOR

    i = 0
    process_snippet = (snippet, done) ->
      source = fix_tabs dom_to_text snippet
      color_syntax source, (code) ->
        if snippets.length > 1
          i += 1
          html += """
            <h5>Example #{i}</h5>
            """
        html += """
          <pre class="code">
          #{code}
          </pre>
          """
        done()

    process_list snippets, process_snippet, ->
      done("<div class='task'>#{html}</div>")

process_language_page = (done) -> 
  html = PAGE_INTRO
  handler = (err, dom) ->
    links = soupselect.select dom, LANGUAGE_PAGES_SELECTOR
    link_info = (link) ->
      href: link.attribs.href
      title: link.attribs.title
    links = (link_info(link) for link in links)
    links = (link for link in links when !BLACKLIST link.title)
    task_page_handler = (link_info, done) ->
      process_task_page link_info, (new_html) ->
        html += new_html
        done()
    process_list links, task_page_handler, ->
      console.log html
      done()

  process_page "/wiki/Category:#{LANGUAGE}", handler

process_page = (path, cb) -> 
  wget path, (body) ->
    handler = new htmlparser.DefaultHandler(cb)
    parser = new htmlparser.Parser(handler)
    parser.parseComplete body

process_list = (list, f, done_cb) ->
  # WOO HOO! async complexity, hopefully somewhat encapsulated here
  # This serializes callback-based invocations of f for each element of our list.
  i = 0
  _process = ->
    if i < list.length
      f list[i], ->
        i += 1
        # return done_cb() if i == 3
        _process()
    else
      done_cb()
  _process()

wget = (path, cb) ->
  options =
    host: HOST
    path: path
    headers:
      "Cache-Control": "max-age=0"
  
  req = http.request options, (res) ->
    s = ''
    res.on 'data', (chunk) ->
      s += chunk
    res.on 'end', ->
      cb s
  req.end()

color_syntax = (source, callback) ->
  {spawn} = require 'child_process'
  pygments = spawn 'pygmentize', ['-l', LANGUAGE.toLowerCase(), '-f', 'html', '-O', 'encoding=utf-8']
  output   = ''
  pygments.stderr.addListener 'data',  (error)  ->
    console.error error if error
  pygments.stdout.addListener 'data', (result) ->
    output += result if result
  pygments.addListener 'exit', ->
    callback(output)
  pygments.stdin.write(source)
  pygments.stdin.end()

dom_to_text = (dom) ->
  if dom.name == 'br'
    return '\n'
  s = ''
  if dom.type == 'text'
    s += dom.data
  if dom.children
    for child in dom.children
      s += dom_to_text child
  html_decode(s)

fix_tabs = (s) ->
  s.replace "\t", "TABS, REALLY?"
  
html_decode = (s) ->
  s = s.replace /&#(\d+);/g, (a, b) ->
    return ' ' if b == '160' # npbsp
    String.fromCharCode(b)
  s = s.replace /&(.*?);/g, (a, b) ->
    map =
      amp: '&'
      gt: '>'
      lt: '<'
      quot: '"'
    map[b] || "UNKNOWN CHAR #{b}"
    
process_language_page -> # do nothing
