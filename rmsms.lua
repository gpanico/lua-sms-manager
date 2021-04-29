local socket = require "socket"
local ip, port = "127.0.0.1", 23000
local server, err = socket.connect(ip,port)

if server == nil then
  print (err)
else
  server:send('AT+CPMS="ME"\r\n')
  s, status, partial = server:receive()
  s, status, partial = server:receive()
  s, status, partial = server:receive()
  s, status, partial = server:receive()

  server:send('AT+CMGD='..arg[1]..'\r\n')
  s, status, partial = server:receive()
  print(s or partial)
end
