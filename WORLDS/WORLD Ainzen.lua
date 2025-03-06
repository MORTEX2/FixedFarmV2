repeat wait() until game:IsLoaded() -- Ensure game is fully loaded

-- Wait for player character & GUI to load
repeat wait() until game:GetService("Players").LocalPlayer.Character
repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
wait(5)

--print("spawn_units and island are now available, waited 5 seconds!")

local gui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
local path = gui and gui:FindFirstChild("BattlePass") and gui.BattlePass.Main.Shop1.gift_premium_pass.BlackedOut

if not path or path:FindFirstChild("80085") then return end

Instance.new("Frame", path).Name = "80085"

-- Your main script logic here
--print("Script is running because '80085' did not exist!")



-- Detect whether you're in the lobby or in a match
local placeID = game.PlaceId
--print("Place ID:", placeID)

if placeID == 8304191830 then



    -- LOBBY: Perform pre-match checks (items check)
    local function checkItemAmount(itemName)
        local itemFrame = game:GetService("ReplicatedStorage")._FX_CACHE:FindFirstChild(itemName)

        if itemFrame and itemFrame:FindFirstChild("OwnedAmount") then
            local amountStr = itemFrame.OwnedAmount.Text:gsub("x", "") -- Remove "x"
            local amountNum = tonumber(amountStr) -- Convert to number
            
            if amountNum and amountNum >= 40 then
                return 1 -- Enough items
            else
                return 0 -- Not enough items
            end
        end
        return 0 -- Item does not exist
    end

    -- Check required items
    if checkItemAmount("overlord_ring_red") == 0 then
   --     print("You don't have enough overlord_ring_red")

local args = {
    [1] = "overlord_legend_1"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))

    end

    if checkItemAmount("overlord_ring_blue") == 0 then
     --   print("You don't have enough overlord_ring_blue")

local args = {
    [1] = "overlord_legend_2"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))


    end

    if checkItemAmount("overlord_ring_yellow") == 0 then
    --    print("You don't have enough overlord_ring_yellow")

local args = {
    [1] = "overlord_legend_3"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))


    end

   -- print("All parts been received, playing chrismas event")


 
local args = {
    [1] = "christmas_event"
}
 
game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))
 

else
  -- IN MATCH: AutoFarm should start here
  --  print("In-game: AutoFarm should begin now!")
  -- Insert AutoFarm logic here
loadstring(game:HttpGet("https://pastebin.com/raw/ExPqyhT0"))()
    
end

-- Ensure script persists across teleports
if queue_on_teleport then
    queue_on_teleport([[ 
        loadstring(game:HttpGet("https://pastebin.com/raw/uaX7pQsY"))()
    ]])
end

-- Run AutoFarm script after teleporting into a match
loadstring(game:HttpGet("https://pastebin.com/raw/uaX7pQsY"))()
