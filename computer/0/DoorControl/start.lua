dofile("/DoorControl/Controller.lua")
dofile("/DoorControl/DetectPlayers.lua")

print(table.concat(AllDetectors, ", "))
print(table.concat(settings.getNames(), ", " ))
