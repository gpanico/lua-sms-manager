-- converts the pointed sms from hex to ascii

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

  server:send('AT+CMGR='..arg[1]..'\r\n')
  s, status, partial = server:receive()
  s, status, partial = server:receive()

  while true do
    s, status, partial = server:receive()
    if status == "closed" then
      break
    end
    if s == "OK" then
      break
    end

    for i=1, #s do
     local c=s:sub(i,i+1)
     if math.mod(i,2) == 1 then
       io.write(string.char(tonumber(c, 16)))
     end
    end

  end
end
