dofile(".env")

if rednet.isOpen(DC_ModemSide) then
    print("RedNet connected on " .. DC_ModemSide .. " side.")
else
    print("Connecting RedNet on " .. DC_ModemSide .. " side.")
    rednet.open(DC_ModemSide)
end

print("Looking up Controllers on protocol Doors...")
local conID = rednet.lookup(DC_Protocol, "Controller")

if conID then
    print("Found Door Controller at ID " .. conID .. "!")
else
    print("Failed to find Door Controller")
    print("Does it exist and/or is it on?")
end

while true do
    print("Sending Register")
    rednet.send(conID, {register=DC_Hostname,p1=Pos1,p2=Pos2}, DC_Protocol)
    sleep(20)
end

dofile("Actions.lua")

function DoAction(message)
    Actions[message.action](WaitForAction)
end

function WaitForAction()
    local id, message
        repeat
        id, message = rednet.receive(DC_Protocol)
    until id == conID
    
    DoAction(message)         
end

WaitForAction()
