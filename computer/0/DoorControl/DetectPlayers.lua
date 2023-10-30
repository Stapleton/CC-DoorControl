local Cfg = "/config/detectors"
settings.load(Cfg)

--expect = require "cc.expect"
--expect, field = expect.expect, expect.field

function save()
    settings.save(Cfg)
end

function id(name)
    return "detector." .. name
end

function newDetector(name, desc)
--    expect(1, name, "string")
--    expect(2, desc, "string" )
    
    settings.define(id(name), {
        description = desc,
        type = "table",
    })
    save()
end

function validator(test_range)
--    expect(1, test_range, "table")
--    local range = decodeRange(test_range)
    -- { P1 = { x = number, y = number, z = number},
    --   P2 = { x = number, y = number, z = number), )
--    field(range, "P1", "table")
--    field(range, "P2", "table")
--    field(range.P1, "x", "number")
--    field(range.P1, "y", "number")
--    field(range.P1, "z", "number")
--    field(range.P2, "x", "number")
--    field(range.P2, "y", "number")
--    field(range.P2, "z", "number")
    return true
end

function validateRange(range)
    if (pcall(validator, range)) then
--        print("Range is Valid.")
        return true
    else 
        print("Range is Invalid. Re-executing for error stack.")
        validator(range)
        return false
    end
end
    
function getDetector(name)
    local val = settings.get(id(name))
    return decodeRange(val)
end

function setDetector(name, range)
--    expect(1, name, "string")
--    expect(2, range, "table")
    
    if validateRange(range) then 
        settings.set(id(name), range)
        save()
    else
        print("Cant update with an invalid range")
    end
end

function newRange(x,y,z)
    return {x,y,z}
end

function encodeRange(PosOne, PosTwo)
--    expect(1, PosOne, "table")
--    expect(2, PosTwo, "table")
    
    local range = {PosOne,PosTwo}
    
    if validateRange(range) then
        return range
    else
        print("Won't encode invalid range.")
        return nil
    end 
end

function decodeRange(range)
  --   print(table.unpack(range[2]))
   local one = range[1]
   local two = range[2]

    local p1 = {
        ["x"] = one[1],
        ["y"] = one[2],
        ["z"] = one[3],
    }
    
    local p2 = {
        ["x"] = two[1],
        ["y"] = two[2],
        ["z"] = two[3],
    }
    
    local decoded = {
        ["P1"] = p1,
        ["P2"] = p2,
    }

    return decoded
end

-- Begin Detector Actions

local _detector = peripheral.find("playerDetector")

function BuildDetectorLoop()
    local detList = {}
    for k,v in pairs(settings.getNames()) do
        if string.match(k, "detector") then
            table.insert(detList, k:gsub("detector.", ""))
        end
    end
    return detList
end

AllDetectors = BuildDetectorLoop()

function CheckDetectorForPlayers(name)
    local Range = getDetector(name)
    local R1 = Range.P1
    local R2 = Range.P2
    
    if _detector.isPlayersInCoords(R1, R2) then
    
    end
end    



--local SE_Factory_1 = Detector
--PosOne(2683, 58, 667).PosTwo(2683, 61, 667)

--while SE_Factory_1().Check() == false do
--    print(SE_Factory_1().Check())
--    if SE_Factory_1().Check() == true then
--        break
--    end
--end 

local r1 = newRange(2683,58,667)
local r2 = newRange(2683,61,667)
local r = encodeRange(r1, r2)

newDetector("test", "Testing Detector Zone")
if validateRange(r) then
    setDetector("test", r)
end 

--CheckDetectorForPlayers("test")

 
