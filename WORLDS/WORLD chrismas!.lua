repeat wait() until game:IsLoaded()
repeat wait() until game:GetService("Players") and game:GetService("Players").LocalPlayer
repeat wait() until game:GetService("Players").LocalPlayer.Character
repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
while not game.PlaceId do wait() end -- ✅ Ensure PlaceId is loaded
wait(3)

-- ✅ Read the existing global and reassign it to keep persistence
_G.unitsArray = _G.unitsArray or {}
local savedUnits = _G.unitsArray -- Store the reference

if queue_on_teleport then
    queue_on_teleport([[ 
        repeat wait() until game:IsLoaded()
        repeat wait() until game:GetService("Players") and game:GetService("Players").LocalPlayer
        repeat wait() until game:GetService("Players").LocalPlayer.Character
        repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
        repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
        while not game.PlaceId do wait() end -- ✅ Ensure PlaceId is loaded
        wait(3)

        -- ✅ Ensure it remains global after teleporting
        _G.unitsArray = _G.unitsArray or {}

        print("Restored Units:", table.concat(_G.unitsArray, ", ")) -- ✅ Debugging to check persistence

        loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/WORLD%20chrismas!.lua", true))()
    ]])
end

-- ✅ Keep making it global every time the script re-executes
task.spawn(function()
    repeat wait() until game:IsLoaded()
    repeat wait() until game:GetService("Players").LocalPlayer.Character
    repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
    repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
    while not game.PlaceId do wait() end -- ✅ Ensure PlaceId is loaded

    wait(5)

    -- ✅ Reassign _G.unitsArray from savedUnits every execution
    _G.unitsArray = savedUnits

    if _G.unitsArray then
        for _, unit in ipairs(_G.unitsArray) do
            print("Restored Unit: " .. unit)
        end
    else
        print("No units restored.")
    end
end)
