Openers = {}

if rednet.isOpen(DC_ModemSide) then
    print("RedNet is connected on " .. DC_ModemSide .. " side.")
else
    print("Connecting RedNet on " .. DC_ModemSide .. " side.")
    rednet.open(DC_ModemSide)
end

print("Hosting self as Controller on protocol Doors")
rednet.host(DC_Protocol, DC_Hostname)

function registration(id, message)
    table.insert(Openers, {[message.register]=id})
    
    newDetector(message.register, message.desc)
    local range = encodeRange(message.p1, message.p2)
    setDetector(message.register, range)
    WaitForMessage()
end

function WaitForMessage()
    local id,message
    repeat
         id, message = rednet.receive(DC_Protocol, nil)
    until message.register
    registration(id, message)
end
    
    
--print("recieved message from Computer #" .. id)

--table.insert(Openers, {[message.register]=id})

--newDetector(message.register, "None For Now")
--local range = encodeRange(message.p1, message.p2)
--setDetector(message.register, range)
  


-- register door openers
-- -- door opener asks to be registered with controller
-- -- says its name, and a parsable for a player detector range

