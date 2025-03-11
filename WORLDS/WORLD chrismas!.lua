repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Players") and game:GetService("Players").LocalPlayer
repeat wait() until game:GetService("Players").LocalPlayer.Character
repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
while not game.PlaceId do wait() end
wait(3)

_G.unitsArray = _G.unitsArray or {} 
_G.skinsArray = _G.skinsArray or {} 
_G.itemsArray = _G.itemsArray or {} 

local HttpService = game:GetService("HttpService")
local savedData = {
    unitsArray = _G.unitsArray,
    skinsArray = _G.skinsArray,
    itemsArray = _G.itemsArray
}
local savedDataString = HttpService:JSONEncode(savedData)

if queue_on_teleport then
    queue_on_teleport([[ 
        local HttpService = game:GetService("HttpService")
        local savedData = HttpService:JSONDecode("]] .. savedDataString:gsub('"', '\\"') .. [[") 

        _G.unitsArray = savedData.unitsArray or {}
        _G.skinsArray = savedData.skinsArray or {}
        _G.itemsArray = savedData.itemsArray or {}

        repeat wait() until game:IsLoaded()
        repeat wait() until game:GetService("Players") and game:GetService("Players").LocalPlayer
        repeat wait() until game:GetService("Players").LocalPlayer.Character
        repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
        repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
        while not game.PlaceId do wait() end
        wait(3)

        print("Restored Units:", next(_G.unitsArray) and table.concat(_G.unitsArray, ", ") or "None")
     --   print("Restored Skins:", next(_G.skinsArray) and table.concat(_G.skinsArray, ", ") or "None")
    --    print("Restored Items:", next(_G.itemsArray) and table.concat(_G.itemsArray, ", ") or "None")

        loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/WORLD%20chrismas!.lua", true))()
    ]])
end
