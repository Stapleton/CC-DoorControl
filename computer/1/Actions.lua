local rs = peripheral.find("redstoneIntegrator")

function OpenDoor(callback)
    rs.setOutput(RSOutput, true)
    callback()
end

function CloseDoor(callback)
    rs.setOutput(RSOutput, false)
    callback()
end

Actions = {
    ["open"] = OpenDoor,
    ["close"] = CloseDoor,
}
