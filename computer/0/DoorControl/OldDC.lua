local pollRatePerSecond = 20
local detectRange = 7
local playerDetector = peripheral.find("playerDetector")
local rs = peripheral.find("redstoneIntegrator")
local tickrate = 20

function getPollRate()
  local a = tickrate  / pollRatePerSecond
  return a
end

function checkDoor()
  while playerDetector.isPlayersInRange(detectRange) == false do
       closeDoor()
       os.sleep(getPollRate())
  end
  openDoor()
end  
      

function openDoor()
  rs.setOutput("up", true) 
  checkDoor()
end

function closeDoor()
  rs.setOutput("up", false)
end

 checkDoor()
