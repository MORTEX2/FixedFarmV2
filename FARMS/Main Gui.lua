local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") -- Ensure PlayerGui is fully loaded

-- Wait for GUIFX to load, then destroy it
local existingGUI = PlayerGui:FindFirstChild("GUIFX")
if existingGUI then
    existingGUI:Destroy()
    task.wait(0.1) -- ✅ Short delay before replacing
end

-- ✅ Only create `ScreenGui` ONCE!
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GUIFX"
ScreenGui.Parent = PlayerGui -- ✅ Places in the same location

-- Services
local Players = game:GetService("Players")
local User = Players.LocalPlayer
local UIS = game:GetService("UserInputService")



local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 300) -- Larger for full GUI
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.Parent = ScreenGui
MainFrame.ZIndex = 1



-- Dragging Functionality
local dragging, dragInput, dragStart, startPos

-- Close Button (X) (Now Visible & Above Everything!)
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -25, 0, -5) -- Moved Slightly Higher
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.TextColor3 = Color3.fromRGB(255, 0, 0)
Close.BackgroundTransparency = 1
Close.ZIndex = 10 -- Ensures It's on Top of Everything
Close.Parent = MainFrame

-- Close Function with Full GUI Fade-out Animation
Close.MouseButton1Click:Connect(function()
    -- Iterate through all GUI elements inside `ScreenGui`
    for _, element in ipairs(ScreenGui:GetDescendants()) do
        if element:IsA("Frame") or element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("ScrollingFrame") then
            -- Fade out effect
            task.spawn(function()
                for i = 1, 10 do
                    element.BackgroundTransparency = element.BackgroundTransparency + 0.1
                    if element:IsA("TextLabel") or element:IsA("TextButton") then
                        element.TextTransparency = element.TextTransparency + 0.1
                    end
                    wait(0.05)
                end
            end)
        end
    end
    
    -- Wait for fade-out to finish, then destroy
    task.wait(0.5)
    ScreenGui:Destroy()
end)





local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Close Button (X)
local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 5)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.TextColor3 = Color3.fromRGB(255, 0, 0)
Close.BackgroundTransparency = 1
Close.Parent = MainFrame

-- Tabs Holder (Now Clean & Professional)
local TabsHolder = Instance.new("Frame")
TabsHolder.Size = UDim2.new(1, -20, 0, 40) -- Slightly Taller for Better Look
TabsHolder.Position = UDim2.new(0, 10, 0, 5)
TabsHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35) -- Darker for Modern Look
TabsHolder.Parent = MainFrame
TabsHolder.ZIndex = 1

-- Rounded Tabs Holder
local TabsCorner = Instance.new("UICorner")
TabsCorner.CornerRadius = UDim.new(0, 8)
TabsCorner.Parent = TabsHolder






-- General Tab Content
local GeneralTab = Instance.new("Frame")
GeneralTab.Size = UDim2.new(1, 0, 1, -35)
GeneralTab.Position = UDim2.new(0, 0, 0, 35)
GeneralTab.BackgroundTransparency = 1
GeneralTab.Parent = MainFrame
GeneralTab.ZIndex = 1

-- SETTINGS TAB (Initially Hidden)
local SettingsTab = Instance.new("Frame")
SettingsTab.Size = UDim2.new(1, 0, 1, -40) -- Same size as GeneralTab
SettingsTab.Position = UDim2.new(0, 0, 0, 40)
SettingsTab.BackgroundTransparency = 1
SettingsTab.Visible = false -- Hidden by default
SettingsTab.Parent = MainFrame

-- Webhook Input Box (Matches Key System)
local WebhookInput = Instance.new("TextBox")
WebhookInput.Size = UDim2.new(0.75, -20, 0, 30) -- Same size as key system
WebhookInput.Position = UDim2.new(0.1, 0, 0.15, 0)
WebhookInput.PlaceholderText = "Enter Webhook URL"
WebhookInput.Font = Enum.Font.GothamBold -- Normal, clean font
WebhookInput.TextSize = 14
WebhookInput.TextColor3 = Color3.fromRGB(0, 0, 0) -- Black text like key system
WebhookInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- White background
WebhookInput.Text = "" -- Clears textbox
WebhookInput.ClearTextOnFocus = false -- Keeps entered text
WebhookInput.TextWrapped = true -- Prevents overflow
WebhookInput.ClipsDescendants = true -- Ensures no text exceeds box
WebhookInput.Parent = SettingsTab
-- Advanced Section Frame (Holds Text and Checkboxes)
local AdvancedSettingsFrame = Instance.new("Frame")
AdvancedSettingsFrame.Size = UDim2.new(1, -20, 0, 60) -- Taller to fit text + checkboxes
AdvancedSettingsFrame.Position = UDim2.new(0, 10, 0.3, 0) -- Adjusted placement
AdvancedSettingsFrame.BackgroundTransparency = 1
AdvancedSettingsFrame.Parent = SettingsTab

-- Advanced Settings Title
local AdvancedLabel = Instance.new("TextLabel")
AdvancedLabel.Size = UDim2.new(1, 0, 0, 20)
AdvancedLabel.Text = "Advanced Settings"
AdvancedLabel.Font = Enum.Font.GothamBold
AdvancedLabel.TextSize = 18
AdvancedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AdvancedLabel.BackgroundTransparency = 1
AdvancedLabel.Parent = AdvancedSettingsFrame
local checkboxes = {}

-- Checkbox Holder for Centered Layout
local CheckboxHolder = Instance.new("Frame")
CheckboxHolder.Size = UDim2.new(1, 0, 0, 40) -- Holds all checkboxes
CheckboxHolder.Position = UDim2.new(0, 0, 0.4, 0) -- Inside the Advanced Settings Frame
CheckboxHolder.BackgroundTransparency = 1
CheckboxHolder.Parent = AdvancedSettingsFrame

-- UI Layout for Even Spacing
local CheckboxLayout = Instance.new("UIListLayout")
CheckboxLayout.Parent = CheckboxHolder
CheckboxLayout.FillDirection = Enum.FillDirection.Horizontal -- Arrange horizontally
CheckboxLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center -- Center them
CheckboxLayout.Padding = UDim.new(0, 15) -- More spacing

for i = 1, 6 do
    -- Container for Label + Checkbox
    local CheckboxContainer = Instance.new("Frame")
    CheckboxContainer.Size = UDim2.new(0, 50, 0, 40) -- Holds both label & checkbox
    CheckboxContainer.BackgroundTransparency = 1
    CheckboxContainer.Parent = CheckboxHolder

    -- Unit Label Above Checkbox
    local UnitLabel = Instance.new("TextLabel")
    UnitLabel.Size = UDim2.new(1, 0, 0, 15)
    UnitLabel.Position = UDim2.new(0, 0, 0, 0)
    UnitLabel.Text = "Unit" .. i
    UnitLabel.Font = Enum.Font.Gotham
    UnitLabel.TextSize = 12
    UnitLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    UnitLabel.BackgroundTransparency = 1
    UnitLabel.TextWrapped = true
    UnitLabel.TextXAlignment = Enum.TextXAlignment.Center
    UnitLabel.Parent = CheckboxContainer

    -- Checkbox Button
    local Checkbox = Instance.new("TextButton")
    Checkbox.Size = UDim2.new(1, 0, 0, 25) -- Smaller for cleaner look
    Checkbox.Position = UDim2.new(0, 0, 0.5, 0)
    Checkbox.Text = ""
    Checkbox.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black (Unselected)
    Checkbox.BorderColor3 = Color3.fromRGB(255, 255, 255) -- White border
    Checkbox.BorderSizePixel = 2
    Checkbox.Parent = CheckboxContainer

    -- Checkmark Icon (Hidden by Default)
    local Checkmark = Instance.new("TextLabel")
    Checkmark.Size = UDim2.new(1, 0, 1, 0)
    Checkmark.Text = "✔"
    Checkmark.Font = Enum.Font.GothamBold
    Checkmark.TextSize = 18
    Checkmark.TextColor3 = Color3.fromRGB(0, 255, 0) -- ✅ Green checkmark
    Checkmark.BackgroundTransparency = 1
    Checkmark.Visible = false -- Hidden by default
    Checkmark.Parent = Checkbox


_G.unitsArray = _G.unitsArray or {}
_G.itemsArray = _G.itemsArray or {}
_G.skinsArray = _G.skinsArray or {}


-- Toggle Checkmark and Background on Click
Checkbox.MouseButton1Click:Connect(function()
    if Checkmark.Visible then
        -- Unselected state
        Checkmark.Visible = false
        Checkbox.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Back to black (unselected)
        
        -- Remove from array
        for index, value in ipairs(_G.unitsArray) do
            if value == i then
                table.remove(_G.unitsArray, index)
                break
            end
        end

        print("Unit" .. i .. " unclicked")
    else
        -- Selected state
        Checkmark.Visible = true
        Checkbox.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Fully Green Background
        
        -- Add to array if not already present
        table.insert(_G.unitsArray, i)

        print("Unit" .. i .. " clicked")
    end
end)

table.insert(checkboxes, Checkbox) -- Store checkboxes if needed later
end



local AdvancedDescription = Instance.new("TextLabel")
AdvancedDescription.Size = UDim2.new(1, -20, 0, 30)
AdvancedDescription.Position = UDim2.new(0, 10, 0.6, 0) -- Below the checkboxes
AdvancedDescription.Text = "(Makes a hybrid behave as if it were a ground unit. Recommended, but don't use if unsure!)"
AdvancedDescription.Font = Enum.Font.Gotham
AdvancedDescription.TextSize = 12
AdvancedDescription.TextColor3 = Color3.fromRGB(200, 200, 200) -- Light gray
AdvancedDescription.BackgroundTransparency = 1
AdvancedDescription.TextWrapped = true
AdvancedDescription.TextXAlignment = Enum.TextXAlignment.Center
AdvancedDescription.Parent = SettingsTab

-- Border around input box (Tiny stroke, matches key system)
local InputBorder = Instance.new("UIStroke")
InputBorder.Thickness = 1
InputBorder.Color = Color3.fromRGB(255, 255, 255) -- White outline
InputBorder.Parent = WebhookInput

-- Arrow Button (Matches Key System)
local ArrowButton = Instance.new("TextButton")
ArrowButton.Size = UDim2.new(0, 30, 0, 30) -- Matches key system button
ArrowButton.Position = UDim2.new(0.85, 0, 0.15, 0)
ArrowButton.Text = "→" -- Proper arrow
ArrowButton.Font = Enum.Font.GothamBold -- Normal, clean font
ArrowButton.TextSize = 20
ArrowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ArrowButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Darker gray like key system
ArrowButton.Parent = SettingsTab

-- Border around arrow button (Tiny stroke, matches key system)
local ButtonBorder = Instance.new("UIStroke")
ButtonBorder.Thickness = 1
ButtonBorder.Color = Color3.fromRGB(255, 255, 255)
ButtonBorder.Parent = ArrowButton

-- Store webhook in a variable
local savedWebhook = ""

-- Function to validate Discord webhook
local function isValidWebhook(url)
    return string.match(url, "^https://discord.com/api/webhooks/%d+/.+$")
end

-- Function to send test message to webhook
local function sendTestMessage(webhookURL)
    local http = http_request or syn.request or request

    if not http then
       -- print("Exploit does not support HTTP requests!")
        return
    end

    local data = {
        ["content"] = "✅ Webhook Set Successfully!"
    }

    local body = game:GetService("HttpService"):JSONEncode(data)

    local headers = {
        ["Content-Type"] = "application/json"
    }

    http({
        Url = webhookURL,
        Method = "POST",
        Headers = headers,
        Body = body
    })
  --  print("Test message sent to Discord webhook!")
end

-- Function to handle webhook input
local function processWebhookInput()
    local url = WebhookInput.Text

    if isValidWebhook(url) then
        savedWebhook = url
        WebhookInput.Text = "✅ Saved!"
        WebhookInput.TextColor3 = Color3.fromRGB(0, 255, 0) -- Green
        task.wait(1.5)
        WebhookInput.Text = savedWebhook
        WebhookInput.TextColor3 = Color3.fromRGB(0, 0, 0) -- Back to black

        -- Send test message
        sendTestMessage(savedWebhook)
    else
        WebhookInput.Text = "❌ Invalid Webhook"
        WebhookInput.TextColor3 = Color3.fromRGB(255, 0, 0) -- Red
        task.wait(1.5)
        WebhookInput.Text = ""
        WebhookInput.TextColor3 = Color3.fromRGB(0, 0, 0) -- Back to black
    end
end

-- Enter Key Event (For PC Users)
WebhookInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        processWebhookInput()
    end
end)

-- Arrow Button Click (For Mobile Users)
ArrowButton.MouseButton1Click:Connect(function()
    processWebhookInput()
end)





local SettingsLabel = Instance.new("TextLabel")
SettingsLabel.Size = UDim2.new(1, 0, 0, 40)
SettingsLabel.Text = "⚙️ Settings Panel"
SettingsLabel.Font = Enum.Font.GothamBold
SettingsLabel.TextSize = 18
SettingsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsLabel.BackgroundTransparency = 1
SettingsLabel.Parent = SettingsTab

-- CREDITS TAB (Initially Hidden)
local CreditsTab = Instance.new("Frame")
CreditsTab.Size = UDim2.new(1, 0, 1, -40)
CreditsTab.Position = UDim2.new(0, 0, 0, 40)
CreditsTab.BackgroundTransparency = 1
CreditsTab.Visible = false -- Hidden by default
CreditsTab.Parent = MainFrame


-- ABOUT SECTIONE
-- ABOUT SECTION 📖
local AboutFrame = Instance.new("Frame")
AboutFrame.Size = UDim2.new(1, -20, 0, 50) -- Small window
AboutFrame.Position = UDim2.new(0, 10, 0, 40) -- Lowered down
AboutFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Matches UI
AboutFrame.BorderSizePixel = 1
AboutFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
AboutFrame.Parent = CreditsTab

-- Discord Button (Left)
local DiscordButton = Instance.new("TextButton")
DiscordButton.Size = UDim2.new(0.3, -5, 0, 25)
DiscordButton.Position = UDim2.new(0, 5, 0, 20)
DiscordButton.Text = "Discord"
DiscordButton.Font = Enum.Font.SourceSansBold
DiscordButton.TextSize = 14
DiscordButton.TextColor3 = Color3.fromRGB(114, 137, 218) -- Discord Blue
DiscordButton.BackgroundTransparency = 1 -- Transparent background
DiscordButton.Parent = AboutFrame

-- About Text (Middle)
local AboutText = Instance.new("TextLabel")
AboutText.Size = UDim2.new(0.4, 0, 0, 25)
AboutText.Position = UDim2.new(0.3, 0, 0, 20)
AboutText.Text = "Made by Mortex | FixedFarm V2"
AboutText.Font = Enum.Font.SourceSans
AboutText.TextSize = 14
AboutText.TextColor3 = Color3.fromRGB(200, 200, 200)
AboutText.BackgroundTransparency = 1
AboutText.TextWrapped = true
AboutText.Parent = AboutFrame

-- YouTube Button (Right)
local YouTubeButton = Instance.new("TextButton")
YouTubeButton.Size = UDim2.new(0.3, -5, 0, 25)
YouTubeButton.Position = UDim2.new(0.7, 0, 0, 20)
YouTubeButton.Text = "YouTube"
YouTubeButton.Font = Enum.Font.SourceSansBold
YouTubeButton.TextSize = 14
YouTubeButton.TextColor3 = Color3.fromRGB(255, 0, 0) -- YouTube Red
YouTubeButton.BackgroundTransparency = 1 -- Transparent background
YouTubeButton.Parent = AboutFrame

-- About Title
local AboutTitle = Instance.new("TextLabel")
AboutTitle.Size = UDim2.new(1, 0, 0, 20)
AboutTitle.Text = "About 📖"
AboutTitle.Font = Enum.Font.SourceSansBold
AboutTitle.TextSize = 16
AboutTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
AboutTitle.BackgroundTransparency = 1
AboutTitle.Parent = AboutFrame

-- Small Red "?" Button (Next to About 📖)
local AboutButton = Instance.new("TextButton")
AboutButton.Size = UDim2.new(0, 20, 0, 20)
AboutButton.Position = UDim2.new(1, -25, 0, 0) -- Most right, next to About 📖
AboutButton.Text = "?"
AboutButton.Font = Enum.Font.GothamBold
AboutButton.TextSize = 16
AboutButton.TextColor3 = Color3.fromRGB(255, 0, 0) -- Bright Red
AboutButton.BackgroundTransparency = 1
AboutButton.Parent = AboutTitle


-- Copy function
local function copyText(button, text, color)
    setclipboard(text) -- Copies text
    local oldText = button.Text
    local oldColor = button.TextColor3
    button.Text = "Copied!"
    button.TextColor3 = Color3.fromRGB(0, 255, 0) -- Green to show success
    task.wait(2)
    button.Text = oldText
    button.TextColor3 = oldColor
end

-- Button Click Events
DiscordButton.MouseButton1Click:Connect(function()
    copyText(DiscordButton, "https://discord.gg/C7bH8KhHPe", Color3.fromRGB(114, 137, 218))
end)

YouTubeButton.MouseButton1Click:Connect(function()
    copyText(YouTubeButton, "https://www.youtube.com/@Mr._Stone", Color3.fromRGB(255, 0, 0))
end)



-- CHANGELOG SECTION 📜
local ChangeLogFrame = Instance.new("Frame")
ChangeLogFrame.Size = UDim2.new(1, -20, 0, 150) -- Larger scrollable window
ChangeLogFrame.Position = UDim2.new(0, 10, 0, 100) -- Moved down more
ChangeLogFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Matches UI
ChangeLogFrame.BorderSizePixel = 1
ChangeLogFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
ChangeLogFrame.Parent = CreditsTab

local ChangeLogTitle = Instance.new("TextLabel")
ChangeLogTitle.Size = UDim2.new(1, 0, 0, 20)
ChangeLogTitle.Text = "ChangeLog 📜"
ChangeLogTitle.Font = Enum.Font.SourceSansBold
ChangeLogTitle.TextSize = 16
ChangeLogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangeLogTitle.BackgroundTransparency = 1
ChangeLogTitle.Parent = ChangeLogFrame

-- Scrollable Content
local ChangeLogScroll = Instance.new("ScrollingFrame")
ChangeLogScroll.Size = UDim2.new(1, 0, 1, -25)
ChangeLogScroll.Position = UDim2.new(0, 0, 0, 25)
ChangeLogScroll.CanvasSize = UDim2.new(0, 0, 0, 0) -- Auto-adjusts later
ChangeLogScroll.ScrollBarThickness = 6
ChangeLogScroll.BackgroundTransparency = 1
ChangeLogScroll.Parent = ChangeLogFrame

local UIList = Instance.new("UIListLayout")
UIList.Parent = ChangeLogScroll
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 5)

-- FUNCTION TO ADD CHANGELOG UPDATES AUTOMATICALLY
local function AddChangeLog(version, date, updates)
    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, 0, 0, 20)
    Header.Text = "* " .. version .. " (" .. date .. ")"
    Header.Font = Enum.Font.SourceSansBold
    Header.TextSize = 14
    Header.TextColor3 = Color3.fromRGB(255, 255, 0) -- Yellow for version
    Header.BackgroundTransparency = 1
    Header.Parent = ChangeLogScroll

    for _, update in pairs(updates) do
        local UpdateText = Instance.new("TextLabel")
        UpdateText.Size = UDim2.new(1, -10, 0, 18)
        UpdateText.Position = UDim2.new(0, 5, 0, 0)
        UpdateText.Text = "- " .. update
        UpdateText.Font = Enum.Font.SourceSans
        UpdateText.TextSize = 13
        UpdateText.TextColor3 = Color3.fromRGB(200, 200, 200)
        UpdateText.BackgroundTransparency = 1
        UpdateText.TextWrapped = true
        UpdateText.Parent = ChangeLogScroll
    end

    -- Update Scroll Size
    task.wait(0.1) -- Short delay for UI update
    ChangeLogScroll.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
end

AddChangeLog("V2.1.1 - BUGS FIXED!", "2025/03/08", {
    "On slow devices or android it wouldn't reexecute itself",
    "added tons of save fail features",
    "Note: Different approach on certain game modes",
})

AddChangeLog("V2.1 - ADDED RAIDS!", "2025/03/07", {
    "Strange Town",
    "Sacred Planet",
    "Note: The script is smart enough to understand which level raid you are",


})

AddChangeLog("Fixed Farm V2.0 (EXPLOIT)", "2025/03/05", {
    "Fixed Farm V2 RELEASE!",
    "No longer waiting for line!"
})

AddChangeLog("V1.1", "2025/03/01", {
    "Fixed Farm V1 added unique support",
    "Enable auto ability",
    "Fixed Unique not getting detected bug"
})

AddChangeLog("Fixed Farm V1.0 (AHK)", "2025/02/25", {
    "First release of FixedFarm, made using Autohotkey, only supports Infinity Caslte",
})



















-- Tabs Setup
local TabNames = {"General", "Settings", "Credits"}
local Tabs = {}

for i, name in ipairs(TabNames) do
    local Tab = Instance.new("TextButton")
    Tab.Size = UDim2.new(0.3, -10, 0.8, -5) -- Proper sizing
    Tab.Position = UDim2.new((i - 1) * 0.33 + 0.01, 0, 0.1, 0) -- Adjusted for spacing
    Tab.Text = name
    Tab.Font = Enum.Font.GothamBold -- Using Gotham Font as requested
    Tab.TextSize = 16
    Tab.TextColor3 = Color3.fromRGB(240, 240, 240) -- Clean white text
    Tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Darker background for premium look

    -- White Border Around Tabs
    local Border = Instance.new("UIStroke")
    Border.Thickness = 2
    Border.Color = Color3.fromRGB(255, 255, 255) -- White outline
    Border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Border.Parent = Tab

    -- Rounded Corners
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10) -- Smooth rounded edges
    TabCorner.Parent = Tab

    -- Hover Effect
    Tab.MouseEnter:Connect(function()
        Tab.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- Lighter when hovered
    end)
    Tab.MouseLeave:Connect(function()
        if Tab:GetAttribute("Active") ~= true then
            Tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Reset to default
        end
    end)

    -- Click Function (SWITCHING TABS)
    Tab.MouseButton1Click:Connect(function()
        -- Reset all tabs first
        for _, t in pairs(Tabs) do
            t:SetAttribute("Active", false)
            t.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Reset tab color
        end

        -- Activate the clicked tab
        Tab:SetAttribute("Active", true)
        Tab.BackgroundColor3 = Color3.fromRGB(80, 80, 80) -- Clicked effect (Glowing Look)

        -- Hide all tab content first
        GeneralTab.Visible = false
        SettingsTab.Visible = false
        CreditsTab.Visible = false

        -- Show the correct tab based on the clicked button
        if Tab.Text == "General" then
            GeneralTab.Visible = true
        elseif Tab.Text == "Settings" then
            SettingsTab.Visible = true
        elseif Tab.Text == "Credits" then
            CreditsTab.Visible = true
        end
    end)

    Tab.Parent = TabsHolder
    Tabs[name] = Tab
end



local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Size = UDim2.new(1, 0, 0, 40)
CreditsLabel.Text = "🎖 Credits"
CreditsLabel.Font = Enum.Font.GothamBold
CreditsLabel.TextSize = 18
CreditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Parent = CreditsTab

-- ABOUT PAGE (Hidden by Default)
local AboutPage = Instance.new("Frame")
AboutPage.Size = UDim2.new(0.5, 0, 1, -20) -- Takes up 50% of CreditsTab height
AboutPage.Position = UDim2.new(1, 10, 0, 10) -- Appears to the right
AboutPage.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AboutPage.BorderSizePixel = 1
AboutPage.BorderColor3 = Color3.fromRGB(255, 255, 255)
AboutPage.Visible = false
AboutPage.Parent = CreditsTab

-- Smooth Rounded Corners
local AboutCorner = Instance.new("UICorner")
AboutCorner.CornerRadius = UDim.new(0, 10)
AboutCorner.Parent = AboutPage

-- Close Button for About Page (❌)
local CloseAbout = Instance.new("TextButton")
CloseAbout.Size = UDim2.new(0, 25, 0, 25)
CloseAbout.Position = UDim2.new(1, -30, 0, 5)
CloseAbout.Text = "X"
CloseAbout.Font = Enum.Font.GothamBold
CloseAbout.TextSize = 16
CloseAbout.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseAbout.BackgroundTransparency = 1
CloseAbout.Parent = AboutPage

-- Title "About 📜"
local AboutHeader = Instance.new("TextLabel")
AboutHeader.Size = UDim2.new(1, -40, 0, 30)
AboutHeader.Position = UDim2.new(0, 10, 0, 5)
AboutHeader.Text = "About 📜"
AboutHeader.Font = Enum.Font.GothamBold
AboutHeader.TextSize = 18
AboutHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
AboutHeader.BackgroundTransparency = 1
AboutHeader.Parent = AboutPage

-- SPECIAL THANKS Title
local SpecialThanks = Instance.new("TextLabel")
SpecialThanks.Size = UDim2.new(1, -20, 0, 20)
SpecialThanks.Position = UDim2.new(0, 10, 0, 40)
SpecialThanks.Text = "💖 Special Thanks: @Ghoul"
SpecialThanks.Font = Enum.Font.GothamBold
SpecialThanks.TextSize = 14
SpecialThanks.TextColor3 = Color3.fromRGB(255, 215, 0) -- Gold Color
SpecialThanks.BackgroundTransparency = 1
SpecialThanks.Parent = AboutPage

-- Scrollable Section for About Content
local AboutScroll = Instance.new("ScrollingFrame")
AboutScroll.Size = UDim2.new(1, -10, 1, -80)
AboutScroll.Position = UDim2.new(0, 5, 0, 70)
AboutScroll.CanvasSize = UDim2.new(0, 0, 0, 0) -- Auto-adjusts later
AboutScroll.ScrollBarThickness = 6
AboutScroll.BackgroundTransparency = 1
AboutScroll.Parent = AboutPage

-- UI List Layout for proper ordering
local AboutList = Instance.new("UIListLayout")
AboutList.Parent = AboutScroll
AboutList.SortOrder = Enum.SortOrder.LayoutOrder
AboutList.Padding = UDim.new(0, 5)

-- Function to Add About Sections
local function AddAboutSection(title, description)
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -10, 0, 20)
    TitleLabel.Text = title
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 14
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Parent = AboutScroll

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -10, 0, 35)
    DescLabel.Text = "- " .. description
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 12
    DescLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    DescLabel.BackgroundTransparency = 1
    DescLabel.TextWrapped = true
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = AboutScroll

    task.wait(0.1)
    AboutScroll.CanvasSize = UDim2.new(0, 0, 0, AboutList.AbsoluteContentSize.Y + 10)
end

-- Add Details to About Page
AddAboutSection("🛠 Farming", "placing hill/hybrid units first, than it places ground at last")
AddAboutSection("", "when Ainz farm is done, moves on to Aybss")
AddAboutSection("", "automatically adjust strategy based on your farm(s) and units")
AddAboutSection("", "supports Bulma, Ceo or both")
AddAboutSection("FAQ", "Is the script free? Yes, but only for a VERY short time")
AddAboutSection("", "Where can I get some help? \nJoin our Discord, click the Discord txt")
AddAboutSection("", "I want to report a bug! \nJoin our Discord")
AddAboutSection("", "I got a briliant idea! \nJoin our Discord")
AddAboutSection("", "What is Fixed Farm V1? First Fixed Farm project, using ahkv1.37")




-- Title
local WorldTitle = Instance.new("TextLabel")
WorldTitle.Size = UDim2.new(1, 0, 0, 40)
WorldTitle.Text = "Fixed Farm V2.1.1" -- MAIN TITLE CHANGE THIS ONE 
WorldTitle.Font = Enum.Font.GothamBold
WorldTitle.TextSize = 20
WorldTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
WorldTitle.BackgroundTransparency = 1
WorldTitle.Parent = GeneralTab


-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Position = UDim2.new(0, 0, 0, 40)
Subtitle.Text = "Choose your farming mode"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 14
Subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
Subtitle.BackgroundTransparency = 1
Subtitle.Parent = GeneralTab


-- Scrollable Worlds Frame (Now has padding to prevent clipping)
local WorldsFrame = Instance.new("ScrollingFrame")
WorldsFrame.Size = UDim2.new(1, -20, 1, -70)
WorldsFrame.Position = UDim2.new(0, 10, 0, 70)
WorldsFrame.ClipsDescendants = true
WorldsFrame.ScrollBarThickness = 6
WorldsFrame.BackgroundTransparency = 1
WorldsFrame.Parent = GeneralTab

-- UI Grid Layout (Now properly centered with padding)
local GridLayout = Instance.new("UIGridLayout")
GridLayout.CellSize = UDim2.new(0.45, 0, 0, 90) -- Same world size
GridLayout.CellPadding = UDim2.new(0, 10, 0, 15) -- More vertical spacing
GridLayout.FillDirectionMaxCells = 2 -- Two per row
GridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center -- Centers them!
GridLayout.Parent = WorldsFrame

-- Fixes the cut-off issue by adding padding inside the frame
local Padding = Instance.new("UIPadding")
Padding.PaddingTop = UDim.new(0, 10)
Padding.PaddingBottom = UDim.new(0, 10)
Padding.PaddingLeft = UDim.new(0, 10)
Padding.PaddingRight = UDim.new(0, 10)
Padding.Parent = WorldsFrame


-- Worlds

local LockedWorlds = {} -- Worlds that should be locked

local Worlds = {
    {Name = "Ainz", Desc = "Farm till you have 40 of each ring", Tag = "DUNGEON Throne", BorderColor = Color3.fromRGB(255, 40, 25), ID = 1}, -- red
    {Name = "Xmas", Desc = "Frozen Aybss farming", Tag = "HOLLIDAY", BorderColor = Color3.fromRGB(198,225,215), ID = 2}, -- white
    {Name = "Current Challenge", Desc = "Plays the current challenge (resets every 30m)", Tag = "CHALLENGE", BorderColor = Color3.fromRGB(10,191,255), ID = 3}, -- blue
    {Name = "Infinity Castle", Desc = "Auto farming strategy accordingly", Tag = "CASTLE", BorderColor = Color3.fromRGB(249,249,249), ID = 4}, -- white

    {Name = "Sacred Planet", Desc = "Farms Sacret Planet inside of raid", Tag = "RAID", BorderColor = Color3.fromRGB(255, 40, 20), ID = 5}, -- Red
    {Name = "Strange Town", Desc = "Farms Strange Town inside of raid", Tag = "RAID", BorderColor = Color3.fromRGB(255, 40, 20), ID = 6}, -- Gold

--[[
    {Name = "7", Desc = "Collects all loot instantly", Tag = "Loot", BorderColor = Color3.fromRGB(0, 150, 255), ID = 7}, -- Blue
    {Name = "8", Desc = "A fastest farm in the world", Tag = "Speed", BorderColor = Color3.fromRGB(0, 255, 0), ID = 8}, -- Green
    {Name = "9", Desc = "A farm that prioritizes safety", Tag = "Safe", BorderColor = Color3.fromRGB(255, 0, 0), ID = 9}, -- Red
    {Name = "10", Desc = "An automated farming method", Tag = "Passive", BorderColor = Color3.fromRGB(255, 215, 0), ID = 10}, -- Gold
    {Name = "11", Desc = "Collects all loot instantly", Tag = "Loot", BorderColor = Color3.fromRGB(0, 150, 255), ID = 11}, -- Blue
    {Name = "12", Desc = "A farm that prioritizes safety", Tag = "Safe", BorderColor = Color3.fromRGB(255, 0, 0), ID = 12}, -- Red
    {Name = "13", Desc = "An automated farming method", Tag = "Passive", BorderColor = Color3.fromRGB(255, 215, 0), ID = 13}, -- Gold
    {Name = "14", Desc = "Collects all loot instantly", Tag = "Loot", BorderColor = Color3.fromRGB(0, 150, 255), ID = 14}, -- Blue
    {Name = "15", Desc = "Collects all loot instantly", Tag = "Loot", BorderColor = Color3.fromRGB(0, 150, 255), ID = 15}, -- Blue
    {Name = "16", Desc = "Collects all loot instantly", Tag = "Loot", BorderColor = Color3.fromRGB(0, 150, 255), ID = 16}, -- Blue
    {Name = "17", Desc = "Collects all loot instantly", Tag = "Loot", BorderColor = Color3.fromRGB(0, 150, 255), ID = 17}, -- Blue
    {Name = "18", Desc = "Collects all loot instantly", Tag = "Loot", BorderColor = Color3.fromRGB(0, 150, 255), ID = 18}, -- Blue
]]
    
}


for _, world in ipairs(Worlds) do
    local WorldFrame = Instance.new("Frame")
    WorldFrame.Size = UDim2.new(0, 160, 0, 90)
    WorldFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    WorldFrame.BorderSizePixel = 0
    WorldFrame.Parent = WorldsFrame

    -- Check if the world should be locked
    local isLocked = table.find(LockedWorlds, world.ID) ~= nil

    -- Darken Background if Locked
    if isLocked then
        WorldFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Darker gray for locked
    end

    -- Colored Border (Per World)
    local Border = Instance.new("UIStroke")
    Border.Thickness = 3
    Border.Color = world.BorderColor
    Border.Parent = WorldFrame

    -- Rounded Corners
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = WorldFrame

    -- World Title
    local WorldTitle = Instance.new("TextLabel")
    WorldTitle.Size = UDim2.new(1, -10, 0, 25)
    WorldTitle.Position = UDim2.new(0, 5, 0, 5)
    WorldTitle.Text = world.Name
    WorldTitle.Font = Enum.Font.GothamBold
    WorldTitle.TextSize = 14
    WorldTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    WorldTitle.BackgroundTransparency = 1
    WorldTitle.TextWrapped = true
    WorldTitle.Parent = WorldFrame
-- LOCKED TEXT (Now Rotated with Correct Bounding Box)
if isLocked then
    local LockText = Instance.new("TextLabel")
    LockText.Size = UDim2.new(1.1, 0, 0.2, 0) -- Shrinks hitbox so it aligns better
    LockText.Position = UDim2.new(-0.05, 0, 0.4, 0) -- Moves slightly down & inward
    LockText.Text = "LOCKED 🔒"
    LockText.Font = Enum.Font.GothamBold
    LockText.TextSize = 18
    LockText.TextColor3 = Color3.fromRGB(255, 0, 0) -- Bright red for visibility
    LockText.BackgroundTransparency = 1
    LockText.TextTransparency = 0.3 -- Slightly faded for effect
    LockText.TextXAlignment = Enum.TextXAlignment.Center
    LockText.TextYAlignment = Enum.TextYAlignment.Center
    LockText.Rotation = -25 -- ROTATED!
    LockText.ZIndex = 2 -- Ensures it's layered correctly
    LockText.ClipsDescendants = true -- Prevents text from spilling out of the world box
    LockText.Parent = WorldFrame
end




    -- World Description
    local WorldDesc = Instance.new("TextLabel")
    WorldDesc.Size = UDim2.new(1, -10, 0, 30)
    WorldDesc.Position = UDim2.new(0, 5, 0, 30)
    WorldDesc.Text = world.Desc
    WorldDesc.Font = Enum.Font.Gotham
    WorldDesc.TextSize = 12
    WorldDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
    WorldDesc.BackgroundTransparency = 1
    WorldDesc.TextWrapped = true
    WorldDesc.Parent = WorldFrame

    -- Tiny Tag
    local Tag = Instance.new("TextLabel")
    Tag.Size = UDim2.new(0, 55, 0, 18)
    Tag.Position = UDim2.new(1, -60, 1, -22)
    Tag.Text = world.Tag
    Tag.Font = Enum.Font.GothamBold
    Tag.TextSize = 10
    Tag.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tag.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Tag.BackgroundTransparency = 0.3
    Tag.TextWrapped = true
    Tag.Parent = WorldFrame






    -- Click Function (Only Works If NOT Locked)
-- Click Button for Worlds (Only if NOT locked)
local ClickButton = Instance.new("TextButton")
ClickButton.Size = UDim2.new(1, 0, 1, 0)
ClickButton.Position = UDim2.new(0, 0, 0, 0)
ClickButton.BackgroundTransparency = 1
ClickButton.Text = ""
ClickButton.Parent = WorldFrame

if not isLocked then
    ClickButton.MouseButton1Click:Connect(function()
        -- Destroy the GUI
        ScreenGui:Destroy()

        -- ✅ Run the first loadstring separately to prevent infinite execution
        task.spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/FARMS/EYE%20LINER%20ANIMATION.txt", true))()
        end)

        -- ✅ Check the world's name and run the corresponding script separately
        task.spawn(function()
            
            if world.Name == "Ainz" then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/WORLD%20Ainzen.lua", true))()
            elseif world.Name == "Xmas" then
               loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/WORLD%20chrismas!.lua", true))()
            elseif world.Name == "Current Challenge" then
                loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/WORLD%20Current%20Challenge.lua", true))()
            elseif world.Name == "Infinity Castle" then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/WORLD%20Infinity%20Castle.lua", true))()
            
            elseif world.Name == "Sacred Planet" then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/RAID%20Sacred%20Planet.lua", true))()
            
            elseif world.Name == "Strange Town" then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/WORLDS/RAID%20Strange%20Town.lua", true))()
            end
        end)
     end)
    end
end 







task.spawn(function()
    -- First, collect all world frames in the order they were created
    local worldFrames = {}
    for _, worldFrame in ipairs(WorldsFrame:GetChildren()) do
        if worldFrame:IsA("Frame") then
            table.insert(worldFrames, worldFrame)
        end
    end

    -- Now, force absolute order BEFORE refreshing UI
    for i, worldFrame in ipairs(worldFrames) do
        worldFrame.LayoutOrder = i -- Forces worlds to be ordered correctly
    end

    -- Add extra padding to ensure last world is fully visible
    local extraPadding = 30 -- Adjust if needed
    WorldsFrame.CanvasSize = UDim2.new(0, 0, 0, GridLayout.AbsoluteContentSize.Y + extraPadding)

    -- Force UI Refresh (Now order is locked in)
    GridLayout.Parent = nil
    wait(0.1)
    GridLayout.Parent = WorldsFrame
end)


-- Open About Page with Bounce & Fade-in Effect (Moves in from the RIGHT!)
local function OpenAboutPage()
    AboutPage.Visible = true
    AboutPage.Position = UDim2.new(1.5, 0, 0, 10) -- Start further to the right
    AboutPage.BackgroundTransparency = 1 -- Fully invisible at start

    -- Gradient Effect (For Animated Color Change)
    local Gradient = Instance.new("UIGradient")
    Gradient.Parent = AboutPage
    Gradient.Rotation = 90
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))
    }

    -- Slide-in with Bounce + Fade-in Effect (Moves LEFT to Attach Properly)
    for i = 1, 20 do
        AboutPage.Position = UDim2.new(1.5 - (i * 0.025), 0, 0, 10) -- Moves in from RIGHT ✅
        AboutPage.BackgroundTransparency = AboutPage.BackgroundTransparency - 0.05
        task.wait(0.01)
    end

    -- Bounce Effect (Tiny Shake to Look Smooth)
    for i = 1, 4 do
        AboutPage.Position = UDim2.new(1, 10 + (i % 2 == 0 and 3 or -3), 0, 10) -- Small bounce
        task.wait(0.05)
    end
    AboutPage.Position = UDim2.new(1, 10, 0, 10) -- Final Position ✅

    -- Gradient Animation (Dynamic Color Changing)
    task.spawn(function()
        while AboutPage.Visible do
            for i = 0, 1, 0.01 do
                Gradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromHSV(i, 0.6, 0.5)),
                    ColorSequenceKeypoint.new(1, Color3.fromHSV(i, 0.8, 0.8))
                }
                task.wait(0.05)
            end
        end
    end)
end


-- Close About Page (Slides Back to the RIGHT + Fade Out)
local function CloseAboutPage()
    for i = 1, 10 do
        AboutPage.Position = UDim2.new(1 + (i * 0.05), 0, 0, 10) -- Moves to the RIGHT ✅
        AboutPage.BackgroundTransparency = AboutPage.BackgroundTransparency + 0.1
        task.wait(0.01)
    end
    AboutPage.Visible = false
end


-- "?" Button Click Event
AboutButton.MouseButton1Click:Connect(OpenAboutPage)

-- "X" Close Button Click Event
CloseAbout.MouseButton1Click:Connect(CloseAboutPage)
