-- lists sms in memory
-- if "-s" is provided as argument, also prints the number to which sms's were sent 

local socket = require "socket"
local ip, port = "127.0.0.1", 23000
local server, err = socket.connect(ip,port)

if arg[1] == "-s" then
  -- get number from SIM
  server:send('AT+CNUM\r\n')
  s, status, partial = server:receive()
  s, status, partial = server:receive()
  j = string.gsub(s, '+CNUM: "","', '')
  k = string.gsub(j, '",', ' ')
  j = string.gsub(k, '145', '')
  print ('Subject: SMS for ' .. j .. '\n')
  s, status, partial = server:receive()
  s, status, partial = server:receive()
  s, status, partial = server:receive()
end

if server == nil then
  print (err)
else
  -- set SMS text mode
  server:send('AT+CMGF=1\r\n')
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
  s, status, partial = server:receive()

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
