http = require 'http'

server = http.createServer (req, res) ->
  res.writeHeader 200, 'Content-Type': 'text/plain'
  res.write 'Hello, World!'
  res.end()

port = 3000
server.listen port
console.log "Server running at http://localhost:#{port}/"