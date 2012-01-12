# NOTE! This code is borrowed from https://github.com/thejh/nodebot, and it 
# used here only for the example of line number mapping.


coffee = require 'coffee-script'
coco = require 'coco'
config = JSON.parse require('fs').readFileSync __dirname+'/config.json', 'utf8'
https = require 'https'
npm = require 'npm'
Irc = require 'irc-js'
cradle = require 'cradle'
{GitHubApi} = require 'github'
request = require 'request'
gitHubApi = new GitHubApi()
githubIssueApi = gitHubApi.getIssueApi()
githubObjectApi = gitHubApi.getObjectApi()
githubCommitApi = gitHubApi.getCommitApi()
Search = require 'complex-search'
querystring = require 'querystring'

BASIC_AUTH_DATA = "Basic #{new Buffer(config.github.auth).toString 'base64'}"
BOTSAFE = /^[-_a-zA-Z0-9]+$/
NICKNAME_REGEX = /^[a-zA-Z0-9_][.a-zA-Z0-9_+-]+$/

docKeywords = {}
lastDocsUpdate = 0
docsFetching = null
updateDocs = (cb) ->
  return cb(docKeywords) if (new Date().getTime() - lastDocsUpdate) < 1000*60*5
  return docsFetching.push cb if docsFetching?
  docsFetching = [cb]
  request {
    uri: "http://nodejs.org/docs/latest/api/all.html"
  }, (error, response, body) ->
    body.split('<h2 ').slice(1).map (sectionHTML) ->
      sectionID = sectionHTML.split('"')[1]
      sectionTitle = sectionHTML.split('>')[1].split('<')[0]
      section = id: sectionID, title: sectionTitle
      sectionHTML.split(/[^a-zA-Z0-9_]/).forEach (word) ->
        word = word.toLowerCase()
        return if word.length is 0
        docKeywords[word] = [] if not docKeywords.hasOwnProperty(word)
        docKeywords[word].push section if docKeywords[word].indexOf(section) is -1
    lastDocsUpdate = new Date().getTime()
    callback(docKeywords) for callback in docsFetching
    docsFetching = null

npmData = {}
lastNpmUpdate = 0
lastNpmUpdateLocaltime = 0
npmFetching = null
updateNpm = (cb) ->
  return cb(npmData) if (new Date().getTime() - lastNpmUpdateLocaltime) < 1000*60*5
  return npmFetching.push cb if npmFetching?
  npmFetching = [cb]
  request {
    uri: "http://registry.npmjs.org/-/all/since?startkey=#{lastNpmUpdate}"
  }, (error, response, body) ->
    npmData[key] = value for key, value of JSON.parse body
    lastNpmUpdate = Date.parse response.headers.date
    lastNpmUpdateLocaltime = new Date().getTime()
    callback(npmData) for callback in npmFetching
    npmFetching = null

github =
  # description: string
  # public: boolean
  # files: {string: content: string}
  postGist: (description, public, files, callback) ->
    request {
      uri: 'https://api.github.com/gists'
      method: 'POST'
      headers:
        'Authorization': BASIC_AUTH_DATA
      body: JSON.stringify {description, public, files}
    }, (error, response, body) ->
      if error
        return callback error
      try
        responseJson = JSON.parse body.toString()
      catch e
        return callback e
      return callback "didn't get a gist back" if not responseJson.id?
      callback null, responseJson.id
  
  getGist: (id, callback) ->
    if not id? or not /^[0-9a-f]+$/.exec id
      return callback 'invalid id'
    request {
      uri: "https://api.github.com/gists/#{id}"
    }, (error, response, body) ->
      if error
        return callback error
      try
        responseJson = JSON.parse body.toString()
      catch e
        return callback e
      if not responseJson.id?
        console.log body.toString()
        return callback "didn't get a gist back"
      callback null, responseJson

database = new (cradle.Connection)(
  'https://thejh.cloudant.com'
  443
  auth:
    username: config.couch.user
    password: config.couch.pass
).database 'ircbot'

npmDatabase = new (cradle.Connection)(
  ''
  80
).database 'registry'

MYNICK = 'jhbot'

npmLoaded = false
npm.load {}, (err) ->
  throw err if err?
  npmLoaded = true


irc = new Irc {
  server: 'irc.freenode.net'
  nick: MYNICK
  flood_protection: true
  user: {
    username: 'jhbot'
    realname: 'TheJHs Bot'
  }
}

process.on 'uncaughtException', (err) ->
  console.log err.stack||err
  try
    irc.privmsg 'thejh', "EXCEPTION: "+err
  catch e

_cachedIssueList = null
_cachedIssueListUpdated = 0

lastCsGist = null

min = (a, b) -> if a<b then a else b
max = (a, b) -> if a>b then a else b
contains = (arr, el) -> -1 isnt arr.indexOf el
arrayMax = (arr) ->
  n = -1/0
  n = val for val in arr when val > n
  n
zeropad = (num, maxnum) ->
  padlen = (maxnum+"").length - (num+"").length
  ("0" for [0...padlen]).join('') + num
spacepadEnd = (str, paddedLength) ->
  padlen = paddedLength - str.length
  str + (" " for [0...padlen]).join('')

getIssueList = (cb) ->
  # time in ms
  time = new Date().getTime()
  # assume five minutes fresh cache
  if _cachedIssueList? and time-_cachedIssueListUpdated < 1000*60*5
    return cb null, _cachedIssueList
  githubIssueApi.getList 'joyent', 'node', 'open', (err, issues) ->
    unless err?
      _cachedIssueList = issues
      _cachedIssueListUpdated = time
    console.log "fetched issue list in #{new Date().getTime()-time}ms"
    cb err, issues

wpheaders =
  'User-Agent': 'jhbot by Jann Horn, contact: jannhorn@googlemail.com'

commands =
  remember: (message, [name, value...], reply) ->
    if value.length is 0
      return reply "you need to specify name and definition", error: true
    value = value.join ' '
    unless BOTSAFE.exec name
      return reply "that name doesn't match #{BOTSAFE}"
    unless BOTSAFE.exec value[0]
      return reply "that value starts with a non-alphanumeric character, I don't want to store bot commands", error: true
    docid = "definitions:#{name}"
    database.get docid, (err, oldData) ->
      savedCb = (err, doc) ->
        reply if err?
          console.error err
          "something went wrong"
        else
          "saved definition of '#{name}'"
      if err?
        database.save docid, {data: value}, savedCb
      else
        database.save docid, oldData._rev, {data: value}, savedCb
  
  git:
    context: (message, [project, file, line], reply) ->
      SAFE_STRING_REGEX = /^[a-zA-Z0-9_-]+$/
      if not line?
        return reply "you must specify project, file and line", error: true
      if not /^[0-9]+$/.exec line
        return reply "line must be numeric", error: true
      # we start from 0, humans start from 1
      line -= 1
      [user, project] = project.split '/'
      if not SAFE_STRING_REGEX.exec user
        return reply "that user name looks weird", error: true
      if not SAFE_STRING_REGEX.exec project
        return reply "that project name looks weird", error: true
      githubCommitApi.getFileCommits user, project, 'master', file, (err, commits) ->
        if err? or commits.length is 0
          return reply "error, getFileCommits() failed, are you sure that the data is correct?", error: true
        githubObjectApi.showBlob user, project, commits[0].tree, file, (err, fileData) ->
          if err?
            return reply "error, showBlob() failed", error: true
          fileData = fileData.data
          fileLines = fileData.split '\n'
          if line >= fileLines.length
            return reply "that file only has #{fileLines.length} lines", error: true
          console.log "base line #{line}"
          fromLine = max 0, line-1
          toLine = min fileLines.length-1, line+1
          console.log "extracting lines #{fromLine}...#{toLine}"
          showedLines = for lineData, i in fileLines.slice fromLine, toLine+1
            "#{zeropad(i+fromLine+1, toLine+1)} #{lineData}"
          console.log "ME HAZ TEH BLOB! #{showedLines.length} shown (out of #{fileLines.length})"
          for lineData in showedLines
            reply lineData

  issue:
    search: (message, keywords, reply) ->
      MAX_ISSUES_COUNT = 3
      if keywords.length is 0
        return reply "please specify at least one keyword", error: true
      keywords = (keyword.toLowerCase() for keyword in keywords)
      getIssueList (err, issues) ->
        if err?
          return reply "something went wrong", error: true
        foundIssues = for issue in issues
          continue unless (do ->
            issueTitle = issue.title.toLowerCase()
            for keyword in keywords
              if -1 is issueTitle.indexOf keyword
                return false
            true
          )
          issue
        
        secondHitIssues = for issue in issues
          continue if -1 isnt foundIssues.indexOf issue
          issuestr = (issue.title + " " + issue.body).toLowerCase()
          continue unless (do ->
            for keyword in keywords
              if -1 is issuestr.indexOf keyword
                return false
            true
          )
          issue
        foundIssues = foundIssues.concat secondHitIssues
        
        foundIssueCount = foundIssues.length
        foundIssues = foundIssues.slice 0, MAX_ISSUES_COUNT
        if foundIssues.length is 0
          return reply "no issues found"
        reply "found issues: #{foundIssueCount}#{[if foundIssueCount > MAX_ISSUES_COUNT then ", showing the first #{MAX_ISSUES_COUNT}"]}"
        for {number, title} in foundIssues
          reply "Issue: https://github.com/joyent/node/issues/#{number} : #{title}"
        return
  mem: (message, [name, substitutions...], reply) ->
    if not name?
      return reply "you need to specify a name", error: true
    unless BOTSAFE.exec name
      return reply "that name doesn't match #{BOTSAFE}"
    database.get "definitions:#{name}", (err, doc) ->
      if err?
        reply "i don't know what a #{name} is", error: true
      else
        data = doc.data
        if substitutions?
          for subst in substitutions
            data = data.replace '$', subst
        reply data
  coco:
    compile: (message, code, reply) ->
      code = code.join " "
      try
        compiled = coco.compile code, bare: true
        compiled = compiled.replace /\n/g, ' '
        compiled = compiled.replace /\s+/g, ' '
        reply compiled
      catch e
        reply "failed: #{(e+'').split('\n')[0]}", error: true
  coffee:
    compile: (message, code, reply) ->
      code = code.join " "
      try
        compiled = coffee.compile code, bare: true
        compiled = compiled.replace /\n/g, ' '
        compiled = compiled.replace /\s+/g, ' '
        reply compiled
      catch e
        reply "failed: #{(e+'').split('\n')[0]}", error: true
    compilegist: (message, [gistid], reply) ->
      if not gistid?
        if lastCsGist? and message.params[0] is '#coffeescript'
          gistid = lastCsGist
        else
          return reply "please specify a gist by id or url", error: true
      gistid = gistid.split('/').pop()
      github.getGist gistid, (err, gist) ->
        if err?
          console.log err.stack or err
          return reply "couldn't fetch the gist", error: true
        coffeeFiles = {}
        for filename, {content} of gist.files
          coffeeFiles[filename] = content: try
            coffee.compile content, bare: true
          catch compileErr
            if compileErr.stack?
              compileErr.stack
            else
              compileErr+""
        github.postGist "COMPILED"+gist.description, gist.public, coffeeFiles, (err, id) ->
          if err?
            console.log err.stack or err
            return reply "couldn't publish the gist", error: true
          reply "https://gist.github.com/#{id}"
  admin:
    join: (message, [channel], reply) ->
      if isChannel channel
        irc.join channel
        reply 'ok'
    say: (message, [target, what...]) ->
      irc.privmsg target, what.join ' '
    testAccountLookup: (message, [nick], reply) ->
      getNicksAccount nick, (account) ->
        reply "account name of #{nick} is #{account}"
    eval: (message, code, reply) ->
      code = code.join ' '
      reply eval code
  docs:
    search: (message, keywords, reply) ->
      NAMESLIMIT = 3
      if keywords.length is 0
        return reply "you must specify at least one keyword", error: true
      updateDocs (docKeywords) ->
        try
          search = new Search keywords.join(' ').toLowerCase(), (results) ->
            return reply "no results" if results.length is 0
            if results.length > NAMESLIMIT
              truncated = true
              results = results.slice 0, NAMESLIMIT
            reply "truncated list:" if truncated
            for result in results
              reply "section \"#{result.title}\": http://nodejs.org/docs/latest/api/all.html##{result.id}"
            return
          for keyword in search.keywords
            search.provideKeywordData keyword, docKeywords[keyword] or []
        catch err
          if err.stack?
            console.log err.stack
            return reply "internal error", error: true
          else
            return reply "error: #{err}", error: true
  npm:
    owner: (message, [package], reply) ->
      if not package?
        return reply "package name missing", error: true
      npm.commands.owner ['ls', package], (err, owners) ->
        if err?
          reply "error", error: true
        else
          if not owners?.length
            msg = "admin party!"
          else
            msg = "owners: " + ("#{o.name} <#{o.email}>" for o in owners).join ', '
          reply msg
    info: (message, [package], reply) ->
      if not package?
        return reply "package name missing", error: true
      updateNpm (npmData) ->
        if not npmData[package]?
          return reply "couldn't find that package"
        package = npmData[package]
        reply "#{package.name} by #{package.author.name}, version #{package['dist-tags'].latest}: #{package.description}"
    prop: (message, [package, propertyName], reply) ->
      if not package
        return reply "no package name specified", error: true
      if not propertyName
        return reply "no property specified", error: true
      updateNpm (npmData) ->
        if not npmData.hasOwnProperty package
          return reply "package not found", error: true
        if not npmData[package].hasOwnProperty propertyName
          return reply "property is not defined", error: true
        propertyValue = npmData[package][propertyName]
        if typeof propertyValue is 'object'
          propertyValue = JSON.stringify propertyValue
        reply "#{npmData[package].name} has #{propertyName} #{propertyValue}"
    search: (message, keywords, reply) ->
      NAMESLIMIT = 20
      if keywords.length == 0
        return reply "you must specify at least one keyword", error: true
      updateNpm (npmData) ->
        try
          search = new Search keywords.join(' '), (results) ->
            return reply "no results" if results.length is 0
            if results.length > NAMESLIMIT
              truncated = true
              results = results.slice 0, NAMESLIMIT
            if results.length > 5 and isChannel message.params[0]
              reply "packages (short format#{[if truncated then ', truncated']}): #{results.join ', '}"
            else
              reply "truncated list:" if truncated
              for result in results
                reply "package #{result}: #{npmData[result].description or '<no description>'}"
              return
          for keyword in search.keywords
            ids = for id, entry of npmData
              continue unless (
                entry.keywords? and contains entry.keywords, keyword
              ) or (
                contains entry.name, keyword
              ) or (
                entry.description? and contains entry.description, keyword
              )
              id
            search.provideKeywordData keyword, ids
            #do (keyword) ->
            #  npmDatabase.view 'app/search', startkey: keyword, endkey: keyword+'ZZZZZZZZ', (err, rows) ->
            #    if err?
            #      console.log err.stack||err
            #      return reply "internal error", error: true
            #    for row in rows
            #      searchResultModules[row.id] = row
            #    search.provideKeywordData keyword, (id for {id} in rows)
        catch err
          if err.stack?
            console.log err.stack
            return reply "internal error", error: true
          else
            return reply "error: #{err}", error: true
  translate: (message, [srclang, dstlang, word], reply) ->
    return (reply "that srclang (#{srclang}) isnt supported", error: true) if srclang isnt 'de' and srclang isnt 'en' and srclang isnt 'fi'
    reqopts =
      uri: "http://#{srclang}.wiktionary.org/w/index.php?action=raw&title=#{encodeURIComponent word}"
      headers: wpheaders
    request reqopts, (err, response, body) ->
      console.log "TRANSLATE ERR <<<"+err+">>>" if err
      return (reply 'error in "translate"', error: true) if err or not body
      hits = []
      translateRegex = if srclang is 'fi'
        /\*({{)([^}]+)}}: \[\[([^\]]+)]/g
      else
        /{{(Ü|t|t\+|t-)\|([^|]+)\|([^}]+)}}/g
      body.replace translateRegex, (_, _, curDst, translation) ->
        return unless curDst is dstlang
        return if -1 isnt translation.indexOf '\n'
        return if -1 isnt translation.indexOf '\r'
        hits.push translation
      hits = hits.join ', '
      hits = '<not found>' if hits.length is 0
      hits = (hits.slice 0, 400) + ' <truncated>' if hits.length > 400
      reply "translations #{srclang}->#{dstlang}: #{hits}"
  help: (message, [botname]) ->
    if not botname
      if message.params[0] isnt '#nodejitsu'
        reply message.person.nick, "For help with this bot (a minute of one line per 2 seconds), type `!help jhbot`."
      return
    return if botname isnt 'jhbot'
    syntaxes =
      "remember": "<keyword> <string>"
      "git context": "<user>/<repo> <file> <line>"
      "mem": "<keyword> [<placeholderReplacement1> [...]]"
      "coffee compile": "<code>"
      "coffee compilegist": "<url or id>"
      "admin join": "<channel>"
      "admin say": "<target> <what>"
      "npm owner": "<project>"
    descriptions =
      "npm search": """
        search for stuff on npm. you can use '&', '|', parens, keywords. default op is '&'.
        no operator precedence, just parens first. will show a maximum of 20 results, one per line.
        in channels, if there are more than 5 results, they will be printed in short format.
                    """
      "remember": "store a string, $ is a placeholder"
      "git context": "get three lines from the specified position in a file on github"
      "mem": "print a stored string, replace placeholders with given parameters"
      "coffee compile": "compile a given line of coffeescript"
      "coffee compilegist": "compile the given coffee-gist into another js-gist"
      "help": "print this help"
    lines = []
    addHelp = (prefix, obj) ->
      for subkey, value of obj
        fullname = if prefix then "#{prefix} #{subkey}" else subkey
        switch typeof value
          when 'object'
            addHelp fullname, value
          when 'function'
            lines.push fullname
    addHelp null, commands
    longestLine = 2 + arrayMax (length for {length} in lines)
    outputLines = []
    for line in lines
      syntax = syntaxes[line]
      description = descriptions[line]
      line += ' ' + syntax if syntax?
      outputLines.push 'command: '+line
      outputLines.push '   ' + descriptionLine for descriptionLine in description.split('\n') if description?
    reply message.person.nick, line for line in outputLines
  #time: (message, [location]) ->
  #  if not location?
  #    zone = 0
  #  else
  #    if /^[+-]?[0-9]+$/.exec location
  #      zone = parseInt location, 10
  #    else
  #      return reply message, "unknown zone (try +/-5)"
  #  reply message, new Date(new Date().getTime() + 1000*60*60*zone).toGMTString()

isChannel = (chanOrNick) ->
  chanOrNick[0] == '#'

isOwner = (person) ->
  {host} = person
  host is 'wikipedia/TheJH'

reply = (do ->
  replyQueue = []
  lastTime = 0
  WAIT_TIME = 2000
  
  doReply = (originalMessage, message) ->
    if typeof originalMessage is 'string'
      target = originalMessage
    else
      {person: {nick: senderNick}, params: [originalTarget]} = originalMessage
      target = if isChannel originalTarget
        originalTarget
      else
        senderNick
    irc.privmsg target, message
    lastTime = new Date().getTime()
  
  canReplyHandler = ->
    {originalMessage, message} = replyQueue.shift()
    doReply originalMessage, message
    if replyQueue.length > 0
      setTimeout canReplyHandler, WAIT_TIME
  
  (originalMessage, message) ->
    time = new Date().getTime()
    if replyQueue.length is 0 and time - lastTime > WAIT_TIME
      doReply originalMessage, message
    else
      if replyQueue.length is 0
        setTimeout canReplyHandler, WAIT_TIME - (time - lastTime)
      replyQueue.push {originalMessage, message}
)

handleCommand = (message, commandParts) ->
  obj = commands
  i = 0
  if commandParts[0]?[0] is '@'
    answerTargetNick = commandParts[0].substring 1
    unless NICKNAME_REGEX.exec answerTargetNick
      return reply message, "That nick looks weird. I refuse."
    commandParts.shift()
  while typeof obj is 'object'
    if i is commandParts.length
      return
    nextPart = commandParts[i++]
    if nextPart is "admin" and not isOwner message.person
      console.log i
      return reply message, "you're not my admin"
    if nextPart is "admin"
      console.log "valid admin command from #{JSON.stringify message.person}"
    if obj.hasOwnProperty(nextPart) and not {}.hasOwnProperty(nextPart)
      obj = obj[nextPart]
    else
      return
  if typeof obj is 'function'
    obj message, commandParts.slice(i), (answer, options = {}) ->
      reply message, [if not options.error and answerTargetNick? then "#{answerTargetNick}, "] + answer

autoLint = (original, nick, message) ->
  nick = " #{nick}" if not NICKNAME_REGEX.exec nick
  GIST_REGEX = /https:\/\/gist\.github\.com\/([0-9a-f]+)/
  gist_match = GIST_REGEX.exec message
  lintWarn = (warning) ->
    reply original, "#{nick}, #{warning}"
  if gist_match
    lastCsGist = gist_id = gist_match[1]
    github.getGist gist_id, (err, gist) ->
      return if err?
      for filename, {content} of gist.files
        lines = content.split "\n"
        hasTabIndent = hasSpaceIndent = false
        levels = [0]
        indents = for line in lines
          [indent, contentStart] = line.split /[^\t\s]/
          continue if not contentStart?
          hasSpaceIndent = true if -1 < indent.indexOf " "
          hasTabIndent = true if -1 < indent.indexOf "\t"
          indentLevel = indent.length
          lastIndentLevel = levels[levels.length-1]
          levels.push indentLevel if indentLevel > lastIndentLevel
          if indentLevel < lastIndentLevel
            newLevelIndex = levels.indexOf indentLevel
            if newLevelIndex is -1
              badOutdent = true
              break
            levels = levels.slice 0, newLevelIndex+1
        try
          coffee.compile content, bare: true
          valid_coffee = true
        catch compileErr
        if valid_coffee and hasTabIndent and hasSpaceIndent
          lintWarn "you're using both spaces and tabs for indentation. "+
                    "coffee treats one tab as one space, therefore the meaning of your code is messed up."
        if badOutdent
          lintWarn "you seem to have an outdent in your code that doesn't match the indents"

genericWarnings = (original, nick, message, channel) ->
  nick = " #{nick}" if not NICKNAME_REGEX.exec nick
  GIST_REGEX = /https:\/\/gist\.github\.com\/([0-9a-f]+)/
  gist_match = GIST_REGEX.exec message
  warn = (warning) -> reply original, "#{nick}, my almighty, artificially created brain says that #{warning.replace(/\n/g, ' ')}"
  if channel == '#node.js' and message.indexOf('graceful-fs') != -1 and message.indexOf('npm') != -1
    nick = " #{nick}" if not NICKNAME_REGEX.exec nick
    reply args, "#{nick}, if you have problems installing npm because of some 'graceful-fs not found' error, your node.js version is outdated."
  if gist_match
    github.getGist gist_match[1], (err, gist) ->
      return if err?
      for filename, {content} of gist.files
        if content.indexOf('info using npm@0.') != -1
          warn "that version of npm (0.x) is ancient. update npm with `curl http://npmjs.org/install.sh | sudo sh`."
        if content.indexOf("Error: Cannot find module 'graceful-fs'") != -1 and content.indexOf("fetching: http://registry.npmjs.org/") != -1
          warn "that version of nodejs is ancient, use 0.4.x or newer"
        if content.indexOf("ERR! TypeError: Cannot call method 'filter' of undefined") != -1
          warn "that version of npm doesn't cleanly self-update, use `curl http://npmjs.org/install.sh | sudo sh`"
        if content.indexOf("ERR! tar") != -1 and content.indexOf("Ignoring unknown extended header") != -1
          warn "your 'tar' program is broken/outdated, install a new one"
        if /npm info using node@v[0-9]+\.[0-9]+\.[0-9]+-pre/.test(content)
          warn """you're using a very unstable version of node (git master/HEAD). If you don't want to run into problems like this one,
                use a stable version (in x.y.z, y is an even number and there's no -pre at the end of the version). Of course, you should
                report problems anyway - after all, what's unstable now is supposed to become stable soon."""

irc.on 'privmsg', (args) ->
  BOTS = ['jhbot', 'v8bot', 'v8bot_', 'catbot', 'kohai']
  {person: {nick, user, host}, params: [chanOrNick, message]} = args
  return if -1 isnt BOTS.indexOf nick
  if chanOrNick is '#coffeescript'
    autoLint args, nick, message
  genericWarnings args, nick, message, chanOrNick.toLowerCase()
  if message[0] isnt '!' and isChannel chanOrNick
    return
  if message[0] is '!'
    message = message.substring 1
  messageparts = message.split ' '
  handleCommand args, messageparts

nickInfoListeners = {}

getNicksAccount = (usersNick, cb) ->
  if not nickInfoListeners[usersNick]
    nickInfoListeners[usersNick] = []
    irc.privmsg 'NickServ', "info =#{usersNick}"
  nickInfoListeners[usersNick].push cb

_handleNicksAccount = (nick, account) ->
  if nickInfoListeners[nick]?
    for listener in nickInfoListeners[nick]
      listener account
    delete nickInfoListeners[nick]

# Information on \2TheJH\2 (account \2TheJH\2):
NICKSERV_USERINFO_REGEX = /^Information on \x02([^\x02]*)\x02 \(account \x02([^\x02]*)\x02\)/
NICKSERV_HASNOUSER_REGEX = /^\x02=([^\x02]*)\x02 is not registered.$/

irc.on 'notice', (args) ->
  # server notices aren't interesting
  return if not args.person?
  {person: {nick, user, host}, params: [_, message]} = args
  if nick == 'NickServ'
    if 0 == message.indexOf 'You are now identified'
      console.log 'alright, were identified, go on'
      setTimeout (->
        irc.join "##{chan}" for chan in ['node.js', 'coffeescript', 'nodejitsu', 'relief1', '#deutsch']
      ), 10000
    userinfoMatch = NICKSERV_USERINFO_REGEX.exec message
    if userinfoMatch?
      console.log "userinfo match"
      _handleNicksAccount userinfoMatch[1], userinfoMatch[2]
    hasNoUserMatch = NICKSERV_HASNOUSER_REGEX.exec message
    if hasNoUserMatch?
      _handleNicksAccount hasNoUserMatch[1], null

updateNpm (npmData) ->
  console.log "NPM ready with #{Object.keys(npmData).length} entries"

irc.connect ->
  irc.privmsg 'NickServ', "IDENTIFY #{config.irc.user} #{config.irc.pass}"
  Sof = require './stackoverflow'
  
  new Sof (line) ->
    reply '#node.js', line