repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Players") and game:GetService("Players").LocalPlayer
repeat wait() until game:GetService("Players").LocalPlayer.Character
repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
while not game.PlaceId do wait() end
wait(3)

_G.unitsArray = _G.unitsArray or {} 
_G.otherArray = _G.otherArray or {} 
_G.alsoArray = _G.alsoArray or {} 

local HttpService = game:GetService("HttpService")
local savedData = {
    unitsArray = type(_G.unitsArray) == "table" and _G.unitsArray or {value = _G.unitsArray},
    otherArray = type(_G.otherArray) == "table" and _G.otherArray or {value = _G.otherArray},
    alsoArray = type(_G.alsoArray) == "table" and _G.alsoArray or {value = _G.alsoArray}
}
local savedDataString = HttpService:JSONEncode(savedData)

if queue_on_teleport then
    queue_on_teleport([[ 
        local HttpService = game:GetService("HttpService")
        local savedData = HttpService:JSONDecode("]] .. savedDataString .. [[") 

        _G.unitsArray = savedData.unitsArray.value or savedData.unitsArray
        _G.otherArray = savedData.otherArray.value or savedData.otherArray
        _G.alsoArray = savedData.alsoArray.value or savedData.alsoArray

        repeat wait() until game:IsLoaded()
        repeat wait() until game:GetService("Players") and game:GetService("Players").LocalPlayer
        repeat wait() until game:GetService("Players").LocalPlayer.Character
        repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
        repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
        while not game.PlaceId do wait() end
        wait(3)

        print("Restored Units:", _G.unitsArray)
        print("Restored OtherArray:", _G.otherArray)
        print("Restored AlsoArray:", _G.alsoArray)

        loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/WORLD%20chrismas!.lua", true))()
    ]])
end


task.spawn(function()
    repeat wait() until game:IsLoaded()
    repeat wait() until game:GetService("Players").LocalPlayer.Character
    repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
    repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
    while not game.PlaceId do wait() end

    wait(5)

    local gui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
    local path = gui and gui:FindFirstChild("BattlePass") and gui.BattlePass.Main.Shop1.gift_premium_pass.BlackedOut

    if not path or path:FindFirstChild("80085") then return end
    Instance.new("Frame", path).Name = "80085"

    local placeID = game.PlaceId

    if placeID == 8304191830 then
        local worlds = {
            "christmas_event",
        }

        for _, world in ipairs(worlds) do
            local args = { [1] = world }
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("request_matchmaking"):InvokeServer(unpack(args))
            wait(1.5)
        end

    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/FARMS/Vegita%20V5.lua", true))()
    end
end)
