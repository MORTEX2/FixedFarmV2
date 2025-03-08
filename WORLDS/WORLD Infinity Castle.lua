if queue_on_teleport then
    queue_on_teleport([[ 
        repeat wait() until game:IsLoaded()
        repeat wait() until game:GetService("Players") and game:GetService("Players").LocalPlayer
        repeat wait() until game:GetService("Players").LocalPlayer.Character
        repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
        repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
        while not game.PlaceId do wait() end -- ✅ Ensure PlaceId is loaded

        loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/WORLD%20Infinity%20Castle.lua", true))()
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

local furthestRoomValue = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.InfiniteTowerUI.InfiniteLeaderboard.Ranking.Wrapper.Frame.FurthestRoom.V.Text) or 1
game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower:InvokeServer(furthestRoomValue, "Hard")


    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/FARMS/Vegita%20V5.lua", true))()
    end
end)
