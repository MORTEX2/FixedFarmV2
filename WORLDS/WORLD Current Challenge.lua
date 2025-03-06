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
--print("EXECUTING!")
if placeID == 8304191830 then
    -- LOBBY: Perform pre-match checks (items check)


-- Join challenges normal
for i = 316, 319 do
    local lobbyPath = workspace:WaitForChild("_CHALLENGES"):WaitForChild("Challenges"):FindFirstChild("_lobbytemplate" .. i)

    if lobbyPath then -- Ensure the lobby exists
        local playersFolder = lobbyPath:FindFirstChild("Players") -- Check if 'Players' exists

        if playersFolder and #playersFolder:GetChildren() <= 3 then -- Ensure 'Players' exists and count its children safely
         --   print("Joining lobby:", "_lobbytemplate" .. i) -- Debugging print

            -- Enter the lobby
            local args = {
                [1] = "_lobbytemplate" .. i
            }
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_join_lobby"):InvokeServer(unpack(args))

            break -- Stop checking after finding an empty lobby
        end
    else
  --      print("Lobby not found:", "_lobbytemplate" .. i) -- Debugging print
    end
end






else
  -- IN MATCH: AutoFarm should start here
  --  print("In-game: AutoFarm should begin now!")
  -- Insert AutoFarm logic here
loadstring(game:HttpGet("https://pastebin.com/raw/ExPqyhT0"))()
    
end

-- Ensure script persists across teleports
if queue_on_teleport then
    queue_on_teleport([[ 
        loadstring(game:HttpGet("https://pastebin.com/raw/RdUZhpxV"))()
    ]])



end

-- Run AutoFarm script after teleporting into a match
loadstring(game:HttpGet("https://pastebin.com/raw/RdUZhpxV"))()
