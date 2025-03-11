repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Players") and game:GetService("Players").LocalPlayer
repeat wait() until game:GetService("Players").LocalPlayer.Character
repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
while not game.PlaceId do wait() end
wait(3)

_G.unitsArray = _G.unitsArray or {}
_G.itemsArray = _G.itemsArray or {}
_G.skinsArray = _G.skinsArray or {}

local HttpService = game:GetService("HttpService")
local unitsArrayString = HttpService:JSONEncode(_G.unitsArray)
local itemsArrayString = HttpService:JSONEncode(_G.itemsArray)
local skinsArrayString = HttpService:JSONEncode(_G.skinsArray)

if queue_on_teleport then
    queue_on_teleport([[ 
        local HttpService = game:GetService("HttpService")
        _G.unitsArray = HttpService:JSONDecode("]] .. unitsArrayString .. [[")
        _G.itemsArray = HttpService:JSONDecode("]] .. itemsArrayString .. [[")
        _G.skinsArray = HttpService:JSONDecode("]] .. skinsArrayString .. [[")

        repeat wait() until game:IsLoaded()
        repeat wait() until game:GetService("Players") and game:GetService("Players").LocalPlayer
        repeat wait() until game:GetService("Players").LocalPlayer.Character
        repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
        repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
        while not game.PlaceId do wait() end -- ✅ Ensure PlaceId is loaded
        wait(3)

        loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/WORLD%20Ainzen.lua", true))()
    ]])
end

task.spawn(function()
    repeat wait() until game:IsLoaded()
    repeat wait() until game:GetService("Players").LocalPlayer.Character
    repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
    repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
    while not game.PlaceId do wait() end -- ✅ Ensure PlaceId is loaded

    wait(5)

    local gui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    local path = gui and gui:FindFirstChild("BattlePass") and gui.BattlePass.Main.Shop1.gift_premium_pass.BlackedOut

    if not path or path:FindFirstChild("80085") then return end
    Instance.new("Frame", path).Name = "80085"

    local placeID = game.PlaceId

    if placeID == 8304191830 then



local function getAmount(path)
    local item = path and path:FindFirstChild("OwnedAmount")
    local amount = item and item.Text:match("%d+") or "0" -- Extract number or default to 0
    return tonumber(amount) or 0
end

local fxCache = game:GetService("ReplicatedStorage"):FindFirstChild("_FX_CACHE")

if fxCache then
    local blue = getAmount(fxCache:FindFirstChild("overlord_ring_blue"))
    local red = getAmount(fxCache:FindFirstChild("overlord_ring_red"))
    local yellow = getAmount(fxCache:FindFirstChild("overlord_ring_yellow"))

    if blue < 40 then
--        print("Blue: less than 40")
        
    local args = {
      [1] = "overlord_legend_3"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))

        
        
    elseif red < 40 then
--        print("Red: less than 40")
        
  
  local args = {
    [1] = "overlord_legend_2"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))

        
    elseif yellow < 40 then
--        print("Yellow: less than 40")
        
        
    local args = {
        [1] = "overlord_legend_1"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))

        
        
    else
        
local args = {
    [1] = "christmas_event"
}

game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))
    
    end
end


    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/FARMS/Vegita%20V5.lua", true))()
    end
end)
