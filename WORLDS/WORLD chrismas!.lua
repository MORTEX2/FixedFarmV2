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
local unitsArrayString = HttpService:JSONEncode(_G.unitsArray)
local skinsArrayString = HttpService:JSONEncode(_G.skinsArray)
local itemsArrayString = HttpService:JSONEncode(_G.itemsArray)

if queue_on_teleport then
    queue_on_teleport([[ 
        local HttpService = game:GetService("HttpService")
        _G.unitsArray = HttpService:JSONDecode("]] .. unitsArrayString .. [[") 
        _G.skinsArray = HttpService:JSONDecode("]] .. skinsArrayString .. [[")
        _G.itemsArray = HttpService:JSONDecode("]] .. itemsArrayString .. [[") 

        repeat wait() until game:IsLoaded()
        repeat wait() until game:GetService("Players") and game:GetService("Players").LocalPlayer
        repeat wait() until game:GetService("Players").LocalPlayer.Character
        repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
        repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
        while not game.PlaceId do wait() end
        wait(3)

        print("Restored Units:", next(_G.unitsArray) and table.concat(_G.unitsArray, ", ") or "None")
        print("Restored Skins:", next(_G.skinsArray) and table.concat(_G.skinsArray, ", ") or "None")
        print("Restored Items:", next(_G.itemsArray) and table.concat(_G.itemsArray, ", ") or "None")

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



            _G.itemsArray = _G.itemsArray or {} -- ✅ Ensure global storage for regular items
_G.skinsArray = _G.skinsArray or {} -- ✅ Ensure global storage for skins


local function AddAllItemsToArray()
    local FXCache = game:GetService("ReplicatedStorage"):FindFirstChild("_FX_CACHE")
    if not FXCache then return end

    _G.itemsArray = {} -- ✅ Reset items array
    _G.skinsArray = {} -- ✅ Reset skins array

    for _, item in pairs(FXCache:GetChildren()) do
        if item.Name ~= "CollectionUnitFrame" then  
            local ownedAmountObj = item:FindFirstChild("OwnedAmount")
            local displayNameObj = item:FindFirstChild("name") -- ✅ Get visible name
            
            if ownedAmountObj and ownedAmountObj:IsA("TextLabel") and displayNameObj and displayNameObj:IsA("TextLabel") then
                local ownedAmountText = ownedAmountObj.Text -- ✅ e.g., "x5"
                local displayName = displayNameObj.Text -- ✅ UI name
                local originalName = item.Name -- ✅ Folder name (for tooltip)

                -- ✅ Determine if it's a skin
                local isSkin = string.match(originalName:lower(), "_skin") ~= nil

                -- ✅ Store the item in the appropriate global array
                if isSkin then
                    table.insert(_G.skinsArray, {
                        displayName = displayName,
                        ownedAmount = ownedAmountText,
                        originalName = originalName
                    })
                else
                    table.insert(_G.itemsArray, {
                        displayName = displayName,
                        ownedAmount = ownedAmountText,
                        originalName = originalName
                    })
                end
            end
        end
    end
end

AddAllItemsToArray()

            
            
            
            
            
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
