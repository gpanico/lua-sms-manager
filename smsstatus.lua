--checks if the GSM network is on

local socket = require "socket"
local ip, port = "127.0.0.1", 23000
local server, err = socket.connect(ip,port)

if server == nil then
  print (err)
else
  server:send('AT+CGREG?\r\n')
  s, status, partial = server:receive()
  s, status, partial = server:receive()
  if s == "+CGREG: 0,5" then
   print "Network registered for SMS"
  else
   print(s or partial)
  end
end
