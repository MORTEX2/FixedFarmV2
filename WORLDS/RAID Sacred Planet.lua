repeat wait() until game:IsLoaded() -- Ensure game is fully loaded

-- Wait for player character & GUI to load
repeat wait() until game:GetService("Players").LocalPlayer.Character
repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
wait(5)
local gui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
local path = gui and gui:FindFirstChild("BattlePass") and gui.BattlePass.Main.Shop1.gift_premium_pass.BlackedOut

if not path or path:FindFirstChild("80085") then return end

Instance.new("Frame", path).Name = "80085"

-- Your main script logic here
--print("Script is running because '80085' did not exist!")


--print("spawn_units and island are now available, waited 5 seconds!")

-- Detect whether you're in the lobby or in a match
local placeID = game.PlaceId
--print("Place ID:", placeID)

if placeID == 8304191830 then
    -- LOBBY: Perform pre-match checks (items check)

local args = {
    [1] = "kai_planet_level_5"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))
wait(1.5)
local args = {
    [1] = "kai_planet_level_4"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))
wait(1.5)
local args = {
    [1] = "kai_planet_level_3"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))
wait(1.5)
local args = {
    [1] = "kai_planet_level_2"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))
wait(1.5)
local args = {
    [1] = "kai_planet_level_1"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))
wait(1.5)


else
    -- IN MATCH: AutoFarm should start here
  --  print("In-game: AutoFarm should begin now!")
    -- Insert AutoFarm logic here
loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/FARMS/Vegita%20V5.lua", true))()
    
end

-- Ensure script persists across teleports
if queue_on_teleport then
    queue_on_teleport([[ 
loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/RAID%20Sacred%20Planet.lua", true))()
    ]])


 
end

-- Run AutoFarm script after teleporting into a match
loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/RAID%20Sacred%20Planet.lua", true))()
