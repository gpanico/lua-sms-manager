local socket = require "socket"
local ip, port = "127.0.0.1", 23000
local server, err = socket.connect(ip,port)

if server == nil then
  print (err)
else
  -- set SMS text mode
  server:send("AT+CMGF=1\r\n") 
  s, status, partial = server:receive()
  s, status, partial = server:receive()

  -- select internal MEmory store
  server:send('AT+CPMS="ME"\r\n')
  s, status, partial = server:receive()
  s, status, partial = server:receive()
  s, status, partial = server:receive()
  s, status, partial = server:receive()

  -- list all messages
  server:send('AT+CMGL="ALL"\r\n')
  while true do
    s, status, partial = server:receive()
    if status == "closed" then
      break
    end
    if s == "OK" then
      break
    end
    print(s or partial)
  end
end
