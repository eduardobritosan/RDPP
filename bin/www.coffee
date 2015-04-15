
app = require('../app.coffee')
debug = require('debug')('coffeepress:server')
http = require('http')

normalizePort = (val) ->
  portl = parseInt(val, 10)
  if isNaN(portl)
    # named pipe
    return val
  if portl >= 0
    # port number
    return portl
  false

port = normalizePort(process.env.PORT or '3000')


onError = (error) ->
  if error.syscall != 'listen'
    throw error
  bind = if typeof port == 'string' then 'Pipe ' + port else 'Port ' + port
  # handle specific listen errors with friendly messages
  switch error.code
    when 'EACCES'
      console.error bind + ' requires elevated privileges'
      process.exit 1
    when 'EADDRINUSE'
      console.error bind + ' is already in use'
      process.exit 1
    else
      throw error
  return


onListening = ->
  addr = server.address()
  bind = if typeof addr == 'string' then 'pipe ' + addr else 'port ' + addr.port
  debug 'Listening on ' + bind
  return

app.set 'port', port


server = http.createServer(app)

server.listen port
server.on 'error', onError
server.on 'listening', onListening
