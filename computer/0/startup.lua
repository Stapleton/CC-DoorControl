dofile(".env")

--ccexpect = require("cc.expect")
--expect, field = ccexpect.expect, ccexpect.field

function Init()
    print("Hello! I am a Controller Computer :)")
    print("")
    print("Starting Door Control Program")
    dofile("DoorControl/start.lua")
end

function Setup()
    print("Setting up working environment!")
    fs.makeDir("/config")
end    
    

if not fs.exists("/config") then
    Setup()
end        
Init()
