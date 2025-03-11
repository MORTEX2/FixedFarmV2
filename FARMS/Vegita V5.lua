repeat wait() until game:GetService("Players").LocalPlayer.Character
repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid")
repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("spawn_units")
wait(5)
--print("spawn_units and island are now available, waited 5 seconds!")


   --[[ task.spawn(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MORTEX2/FixedFarmV2/main/FARMS/FAKE%20GUI%20LOG.lua", true))()
fake gui 
    end)
]]



-- anti afk script
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Vim = game:GetService("VirtualInputManager")

-- Track current lane for cycling through them
local laneIndex = 1

-- Get available lanes
local function getLanes()
    local lanes = workspace._BASES.pve.LANES:GetChildren()
    table.sort(lanes, function(a, b) return tonumber(a.Name) < tonumber(b.Name) end) -- Sort numerically
    return lanes
end

local lanes = getLanes()


local function getHillParts()
    local hillParts = {}

    local function findParts(parent)
        for _, obj in pairs(parent:GetChildren()) do
            if obj:IsA("BasePart") and obj.Name:match("^80085%d+$") then
                table.insert(hillParts, obj)
            elseif obj:IsA("Model") or obj:IsA("Folder") then
                findParts(obj) -- Recursively find all BaseParts inside models/folders
            end
        end
    end

    -- Search both direct & nested parts
    findParts(workspace._terrain.hill)

    table.sort(hillParts, function(a, b)
        return tonumber(a.Name:match("%d+")) < tonumber(b.Name:match("%d+"))
    end)

    return hillParts
end





local function getPlacementPosition(unitType, zone)
    local chosenLane = lanes[laneIndex] -- Get current lane
    laneIndex = (laneIndex % #lanes) + 1 -- Cycle lanes

    -- HILL UNIT PLACEMENT
    if unitType == 1 then 
        local hillParts = getHillParts() -- Get hill parts correctly
        if #hillParts == 0 then return nil end

        local rangeStart = 1
        local rangeEnd = math.floor(#hillParts * 0.4)

        if zone == 2 then
            rangeStart = rangeEnd + 1
            rangeEnd = rangeStart + math.floor(#hillParts * 0.3)
        elseif zone == 3 then
            rangeStart = rangeEnd + 1
            rangeEnd = #hillParts
        end

        local selectedHill = hillParts[math.random(rangeStart, rangeEnd)]
        if selectedHill then
            local newPosition = selectedHill.Position + Vector3.new(math.random(-2, 2), 2, math.random(-2, 2)) -- Adjust position
            return newPosition -- Return Vector3 instead of CFrame
        end
    end

    -- GROUND UNIT PLACEMENT (Only if no hill available)
    local pathParts = {}

    for _, obj in pairs(chosenLane:GetChildren()) do
        if tonumber(obj.Name) then
            table.insert(pathParts, obj)
        end
    end

    table.sort(pathParts, function(a, b) return tonumber(a.Name) < tonumber(b.Name) end)

    local pathSize = #pathParts
    if pathSize == 0 then return nil end

    local rangeStart = 1
    local rangeEnd = math.floor(pathSize * 0.4)

    if zone == 2 then
        rangeStart = rangeEnd + 1
        rangeEnd = rangeStart + math.floor(pathSize * 0.3)
    elseif zone == 3 then
        rangeStart = rangeEnd + 1
        rangeEnd = pathSize
    end

    local selectedPath = pathParts[math.random(rangeStart, rangeEnd)]
    return selectedPath and (selectedPath.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))) or nil
end


local function clearErrorMessage()
    local errorGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("MessageGui")
    if errorGui and errorGui:FindFirstChild("messages") then
        local errorMsg = errorGui.messages:FindFirstChild("Error")
        if errorMsg then
            errorMsg:Destroy() -- Remove error message if it exists
        end
    end
end





-- upgrade unit (now includes Bulma)
local function upgradeUnit(unitID)
    local unitFolder = workspace:WaitForChild("_UNITS")
    local allUnits = unitFolder:GetChildren()

    if workspace._DATA.GameFinished.Value then
        return
    end

    local function isMaxed(unit)
        local stats = unit:FindFirstChild("_stats")
        if stats then
            local maxUpgrade = stats:FindFirstChild("max_upgrade")
            local currentUpgrade = stats:FindFirstChild("upgrade")
            if maxUpgrade and currentUpgrade and maxUpgrade.Value == currentUpgrade.Value then
                return true
            end
        end
        return false
    end

    if unitID == nil then
        for _, unit in pairs(allUnits) do
            if unit:IsA("Model") and not unit.Name:lower():find("^ceo%d+$") then
                if not isMaxed(unit) then
                    local args = {[1] = unit}
                    game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("upgrade_unit_ingame"):InvokeServer(unpack(args))
                    wait(0.05)
					clearErrorMessage()

                end
            end
        end
        return
    end

    if tonumber(unitID) then
        unitID = tostring(800850 + tonumber(unitID))
    end

    for _, unit in pairs(allUnits) do
        if unit:IsA("Model") and (unit.Name == tostring(unitID) or unit.Name:lower():find("^bulma%d+$")) then
            if not isMaxed(unit) then
                local args = {[1] = unit}
                game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("upgrade_unit_ingame"):InvokeServer(unpack(args))
					wait(0.5)
					clearErrorMessage()

            end
            return
        end
    end
end

-- Usage Examples:
-- upgradeUnit(1)      -- Upgrades unit 800851
-- upgradeUnit(2)      -- Upgrades unit 800852
-- upgradeUnit("ceo1") -- Upgrades CEO unit ceo1
-- upgradeUnit("bulma")-- Upgrades Bulma
-- upgradeUnit()       -- Upgrades all units (except ceo & bulma), skipping maxed ones



-- Name all units (including Bulma & Speedwagon variations)
local function renameUnits()
    local player = game.Players.LocalPlayer
    local unitFolder = workspace:WaitForChild("_UNITS")

    local unitCount = 800851
    local ceoCount = 1
    local bulmaCount = 293

    -- Determine the highest existing numbers
    for _, unit in pairs(unitFolder:GetChildren()) do
        if unit:IsA("Model") and unit:FindFirstChild("_stats") then
            local stats = unit:FindFirstChild("_stats")
            local owner = stats:FindFirstChild("player")

            if owner and owner.Value == player then
                local unitName = unit.Name:lower() -- Convert to lowercase

                if unitName:find("^ceo%d+$") then
                    local num = tonumber(unit.Name:match("%d+"))
                    if num and num >= ceoCount then
                        ceoCount = num + 1
                    end
                elseif unitName:find("^bulma%d+$") then
                    local num = tonumber(unit.Name:match("%d+"))
                    if num and num >= bulmaCount then
                        bulmaCount = num + 1
                    end
                elseif tonumber(unit.Name) then
                    local num = tonumber(unit.Name)
                    if num and num >= unitCount then
                        unitCount = num + 1
                    end
                end
            end
        end
    end

    -- Rename only new units
    for _, unit in pairs(unitFolder:GetChildren()) do
        if unit:IsA("Model") and unit:FindFirstChild("_stats") then
            local stats = unit:FindFirstChild("_stats")
            local owner = stats:FindFirstChild("player")

            if owner and owner.Value == player then
                local unitName = unit.Name:lower() -- Convert to lowercase

                -- Skip already named units
                if unitName:find("^ceo%d+$") or unitName:find("^bulma%d+$") or tonumber(unit.Name) then
                    continue
                end

                -- ✅ Detect Speedwagon (including evolved, shiny, etc.)
                if unitName:find("speedwagon") then
                    unit.Name = "ceo" .. ceoCount
                    ceoCount = ceoCount + 1

                -- ✅ Detect Bulma (including evolved, shiny, etc.)
                elseif unitName:find("bulma") then
                    unit.Name = "bulma" .. bulmaCount
                    bulmaCount = bulmaCount + 1

                else
                    unit.Name = tostring(unitCount)
                    unitCount = unitCount + 1
                end
            end
        end
    end
end








-- Function to detect error messages
local function getErrorMessage()
    local errorGui = LocalPlayer.PlayerGui:FindFirstChild("MessageGui")
    if errorGui and errorGui:FindFirstChild("messages") then
        local errorMsg = errorGui.messages:FindFirstChild("Error")
        if errorMsg then
            local errorText = errorMsg:FindFirstChild("Tex")
            if errorText then
                local message = errorText.Text
                errorMsg:Destroy() -- Remove after reading
                return message
            end
        end
    end
    return nil
end



-- Function to place a unit
local function placeUnit(unitType, zone)
--[[
DONT WORK TRY AGAIN LATER
-- SELL CEO IF IT IS MAX!
if workspace:FindFirstChild("_is_last_wave") and workspace._is_last_wave.Value == true then
    local deadUnits = game:GetService("ReplicatedStorage"):WaitForChild("_DEAD_UNITS")

    for i = 1, 3 do
            task.wait(0.2)
        local ceoUnit = deadUnits:FindFirstChild("ceo" .. i)
        if ceoUnit then
            local args = {
                [1] = ceoUnit
            }
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("sell_unit_ingame"):InvokeServer(unpack(args))
        end
    end
end

]]
    local unitId = nil
    local availableSlots = {}

        if workspace._DATA.GameFinished.Value then
            return
        end

    -- SCAN FOR UNITS (PRIORITIZING HILL/HYBRID FIRST)
    for i = 1, 6 do
        local id = _G["unit_id" .. i]
        local stat = _G["unit_stat" .. i]

        if id and id ~= "" then
            if unitType == 0 then
                if stat == 1 then -- Hill/Hybrid PRIORITY
                    table.insert(availableSlots, {slot = i, id = id, stat = stat})
                elseif stat == 0 then -- Ground Fallback
                    table.insert(availableSlots, {slot = i, id = id, stat = stat})
                end
            elseif unitType == 25 and stat == 25 then
                table.insert(availableSlots, {slot = i, id = id, stat = stat})
            elseif unitType == 26 and stat == 26 then
                table.insert(availableSlots, {slot = i, id = id, stat = stat})
            end
        end
    end

    -- ALWAYS TRY HILL UNITS FIRST FOR placeUnit(0, x)
    table.sort(availableSlots, function(a, b) return a.stat > b.stat end)

    if #availableSlots == 0 then return end

    local chosenSlot = availableSlots[1]
    unitId = chosenSlot.id

    local position = getPlacementPosition(chosenSlot.stat, zone)
    if not position then return end

    -- New retry logic for HILL UNITS
    if chosenSlot.stat == 1 then
        local maxHillRetries = 10
        local maxAttemptsPerPosition = 60

        for hillRetry = 1, maxHillRetries do
            local currentPosition = position - Vector3.new(0, 10, 0) -- Start from CFrame -10 Y
            
            for attempt = 1, maxAttemptsPerPosition do
                local args = {
                    [1] = unitId,
                    [2] = CFrame.new(currentPosition) -- Convert Vector3 to CFrame
                }
                
         --       print(currentPosition)
                
                -- **NEW FIX: Run spawn_unit asynchronously to prevent freezing**
                local success, err = pcall(function()
                    task.spawn(function()
                        game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("spawn_unit"):InvokeServer(unpack(args))
                    end)
                end)

                -- **Wait a short moment to check if an error appears**
                task.wait(0.5) 

                local errorGui = LocalPlayer.PlayerGui:FindFirstChild("MessageGui")
                local messages = errorGui and errorGui:FindFirstChild("messages")
                local errorMessageObject = messages and messages:FindFirstChild("Error")

                if errorMessageObject then
                    -- **If an error appears, continue retrying**
                    local errorText = errorMessageObject:FindFirstChild("Tex")
                    local message = errorText and errorText.Text or ""

                    -- **Delete the error message to avoid buildup**
                    errorMessageObject:Destroy()
               --     print("🗑️ Deleted 'Cannot place unit here' message")

                    -- **If the error is about placement, adjust Y and retry**
                    if string.find(message, "Cannot place unit here") then
                        currentPosition = currentPosition + Vector3.new(0, 0.5, 0)
                    elseif string.find(message, "Not enough money") then
                        return
					elseif string.find(message, "Cannot place more than") or string.find(message, "Unique units may not be placed with others of its kind...") then
                        _G["unit_id" .. chosenSlot.slot] = "" -- Remove unit ID so it is skipped later
                        return placeUnit(unitType, zone) -- Retry with another unit
                    end
                else
                    -- **If NO error appears, assume placement succeeded and exit**
                    renameUnits()
           --         print("✅ Placement successful!")
                    return
                end
            end

            -- Move to the next hill position if all attempts at this one fail
            position = getPlacementPosition(chosenSlot.stat, zone)
            if not position then return end
        end

        return -- Stop if all hill placements fail
    end

    -- ORIGINAL GROUND UNIT PLACEMENT (unchanged)
    local attempts = 0
    while attempts < 10 do
        local args = {
            [1] = unitId,
            [2] = CFrame.new(position) -- Convert Vector3 to CFrame
        }

        -- **NEW FIX: Run spawn_unit asynchronously to prevent freezing**
        local success, err = pcall(function()
            task.spawn(function()
                game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("spawn_unit"):InvokeServer(unpack(args))
            end)
        end)

        -- **Wait a short moment to check if an error appears**
        task.wait(0.5)

        local errorGui = LocalPlayer.PlayerGui:FindFirstChild("MessageGui")
        local messages = errorGui and errorGui:FindFirstChild("messages")
        local errorMessageObject = messages and messages:FindFirstChild("Error")

        if errorMessageObject then
            -- **If an error appears, continue retrying**
            local errorText = errorMessageObject:FindFirstChild("Tex")
            local message = errorText and errorText.Text or ""

            -- **Delete the error message to avoid buildup**
            errorMessageObject:Destroy()
     --       print("🗑️ Deleted 'Cannot place unit here' message")

            -- **If the error is about placement, adjust position and retry**
            if string.find(message, "Cannot place unit here") then
                position = position + Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))
                attempts = attempts + 1
            elseif string.find(message, "Not enough money") then
                return
            elseif string.find(message, "Cannot place more than") then
                _G["unit_id" .. chosenSlot.slot] = "" -- Remove unit ID so it is skipped later
                return placeUnit(unitType, zone) -- Retry with another unit
            end
        else
            -- **If NO error appears, assume placement succeeded and exit**
            renameUnits()
      --      print("✅ Placement successful!")
            return
        end
    end
end


-- place unit works like this
-- first type, 25 = bulma, 26 = ceo, 0 = unit (hill or hybrid gets placed first, moving on to ground)
-- second argument, is the location, 1 = 0 to 40% of the map, 2 = 40 - 70 % of the map, 3 = 70 - 100% of the map































-- Hill Detection and Sorting
local function setupHills()
    local finalObject = workspace._BASES.player.LANES["1"].final
    local terrainGroup = workspace._terrain.hill:GetChildren()

    if not finalObject or not terrainGroup then return end

    local parts = {}

    local function findParts(parent)
        for _, obj in pairs(parent:GetChildren()) do
            if obj:IsA("BasePart") then
                obj.Name = "Temp_" .. tostring(#parts + 1)
                table.insert(parts, { part = obj, distance = 0 })
            elseif obj:IsA("Model") or obj:IsA("Folder") then
                findParts(obj)
            end
        end
    end

    findParts(workspace._terrain.hill)

    for _, data in ipairs(parts) do
        local part = data.part
        data.distance = (part.Position - finalObject.Position).Magnitude
    end

    table.sort(parts, function(a, b)
        return a.distance < b.distance
    end)

    for index, data in ipairs(parts) do
        data.part.Name = "80085" .. tostring(index)
    end
end

setupHills()





-- Money Wait Function
function waitForMoney(x)
    task.wait(0.5)
    while LocalPlayer._stats.resource.Value < x do
        if workspace._DATA.GameFinished.Value then
            return
        end
        task.wait(0.5)
    end
    task.wait(1)
end


-- Set EVERY part name from hill to 80085X to n, this ENSURES the script should WORK ON ALL MAPS, the script will rename all hills to 1 to n, n is the closest to the final object which is spawn, located at: workspace._BASES.player.LANES["1"].final
-- This basically allows us to identify each part of hill, just like we can do with the path, the thing with path is, it starts with 1, and climbs it way to up n, I did the same for the hills
local finalObject = workspace._BASES.player.LANES["1"].final
local terrainGroup = workspace._terrain.hill:GetChildren() -- Get all children in "hill"

if not finalObject or not terrainGroup then
    warn("Required objects not found!")
    return
end

local parts = {}

-- Function to recursively find BaseParts inside models
local function findParts(parent)
    for _, obj in pairs(parent:GetChildren()) do
        if obj:IsA("BasePart") then
            obj.Name = "Temp_" .. tostring(#parts + 1) -- Unique temporary name
            table.insert(parts, { part = obj, distance = 0 }) -- Store for sorting
        elseif obj:IsA("Model") or obj:IsA("Folder") then
            findParts(obj) -- Recursively search inside models/folders
        end
    end
end

-- Step 1: Find all parts inside hill (including nested ones)
findParts(workspace._terrain.hill)

-- Step 2: Calculate distances from .final
for _, data in ipairs(parts) do
    local part = data.part
    data.distance = (part.Position - finalObject.Position).Magnitude
end

-- Step 3: Sort the parts by distance (closest first)
table.sort(parts, function(a, b)
    return a.distance < b.distance
end)

-- Step 4: Assign final names with "80085" prefix based on proximity
for index, data in ipairs(parts) do
    data.part.Name = "80085" .. tostring(index) -- Final numbering with identifier
end

function teleportToLanePart(positionType)
    local lane = workspace._BASES.pve.LANES["1"]
    local numberedParts = {}

    -- Gather numbered children
    for _, child in pairs(lane:GetChildren()) do
        if tonumber(child.Name) then
            table.insert(numberedParts, child)
        end
    end

    -- Sort parts by numerical value
    table.sort(numberedParts, function(a, b)
        return tonumber(a.Name) < tonumber(b.Name)
    end)

    if #numberedParts == 0 then
        warn("No numbered parts found in the lane.")
        return
    end

    -- Find the middle index
    local middleIndex = math.ceil(#numberedParts / 2)

    -- Ensure positionType is a valid number (default to 1 if nil)
    if not positionType then
        warn("positionType is nil, setting to default (1)")
        positionType = 1
    end

    -- Adjust index based on positionType
    local targetIndex = middleIndex + (positionType - 1)

    -- Ensure the target index stays within valid bounds
    targetIndex = math.clamp(targetIndex, 1, #numberedParts)

    local targetPart = numberedParts[targetIndex]

    -- Teleport player just above the target part
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = player.Character.HumanoidRootPart
        humanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 5, 0) -- Offset so player doesn't fall through
    else
        warn("Player or HumanoidRootPart not found.")
    end
end
-- teleportToLane, (0( = middle part - 1), 1 = middle, 2 = middle + 1. Got it?

-- GET UNIT STATS, 25 = Bulba, 26 = CEO, 0 = GROUND, 1 = HILL OR HYRBID

local Vim = game:GetService("VirtualInputManager")
local LocalPlayer = game:GetService("Players").LocalPlayer
local spawn_units = LocalPlayer.PlayerGui.spawn_units.Lives.Frame.Units

-- Get unit IDs
unit_id1 = spawn_units["1"]:GetAttribute("_equipped_frame_unit_uuid")
unit_id2 = spawn_units["2"]:GetAttribute("_equipped_frame_unit_uuid")
unit_id3 = spawn_units["3"]:GetAttribute("_equipped_frame_unit_uuid")
unit_id4 = spawn_units["4"]:GetAttribute("_equipped_frame_unit_uuid")
unit_id5 = spawn_units["5"]:GetAttribute("_equipped_frame_unit_uuid")
unit_id6 = spawn_units["6"]:GetAttribute("_equipped_frame_unit_uuid")



function checkUnit(unit_id, unit_index)
    -- Start timing for debugging
    local startTime = tick() 

    -- If no unit ID, return instantly
    if not unit_id or unit_id == "" then 
        return nil 
    end 

    local unitFrame = spawn_units:FindFirstChild(tostring(unit_index))
    if not unitFrame then 
        return nil 
    end 

    local unitModel = unitFrame.Main.View.WorldModel

    -- ✅ Check if any child contains "bulma" or "speedwagon" in its name
    for _, child in pairs(unitModel:GetChildren()) do
        local nameLower = child.Name:lower() -- Convert to lowercase for case-insensitive matching
        if nameLower:find("bulma") then 
            return 25 
        end
        if nameLower:find("speedwagon") then 
            return 26 
        end
    end

    -- Select the unit
    local keyCode = Enum.KeyCode["One"]
    if unit_index == 2 then keyCode = Enum.KeyCode.Two end
    if unit_index == 3 then keyCode = Enum.KeyCode.Three end
    if unit_index == 4 then keyCode = Enum.KeyCode.Four end
    if unit_index == 5 then keyCode = Enum.KeyCode.Five end
    if unit_index == 6 then keyCode = Enum.KeyCode.Six end

    Vim:SendKeyEvent(true, keyCode, false, game)
    task.wait(0.5)
    Vim:SendKeyEvent(false, keyCode, false, game)

    -- **Step 1: Check for terrain parts in `workspace.ignore`**
    local ignore = workspace:FindFirstChild("ignore")
    if not ignore then
        return nil
    end

    local RED_COLOR = Color3.fromRGB(255, 0, 0)
    local GREEN_COLOR = Color3.fromRGB(0, 255, 0)

    local greenFound = false -- Track if a green part is found
    local skippedParts = 0
    local partGroups = {}

    local skipNames = {
        _bounds = true,
        _item_drops = true,
        houses = true,
        orbs = true,
        presistent = true,
        unit = true
    }

    -- Process all direct children of `workspace.ignore`
    for _, obj in pairs(ignore:GetChildren()) do
        if obj:IsA("BasePart") and not skipNames[obj.Name] then
            if not partGroups[obj.Name] then
                partGroups[obj.Name] = {}
            end
            table.insert(partGroups[obj.Name], obj)
        else
            skippedParts = skippedParts + 1
        end
    end

    -- Process each part group
    for partName, parts in pairs(partGroups) do
        for _, part in ipairs(parts) do
            if part.Color == GREEN_COLOR then
                greenFound = true
            end
        end
    end

    -- **Step 2: Determine Unit Type**
    local terrainType = greenFound and 1 or 0 -- 1 = Hill, 0 = Ground

    -- **Step 3: Unselect the unit**
    Vim:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
    task.wait(0.5)
    Vim:SendKeyEvent(false, Enum.KeyCode.Q, false, game)

    -- Debug time taken
    local elapsedTime = tick() - startTime

    return terrainType -- Return 1 (Hill) if green found, else return 0 (Ground)
end






-- Assign unit stats to global variables
unit_stat1 = checkUnit(unit_id1, 1)
unit_stat2 = checkUnit(unit_id2, 2)
unit_stat3 = checkUnit(unit_id3, 3)
unit_stat4 = checkUnit(unit_id4, 4)
unit_stat5 = checkUnit(unit_id5, 5)
unit_stat6 = checkUnit(unit_id6, 6)

-- Send 'Q' key after last unit check
Vim:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
task.wait(0.2)
Vim:SendKeyEvent(false, Enum.KeyCode.Q, false, game)





_G["unit_id1"] = unit_id1
_G["unit_id2"] = unit_id2
_G["unit_id3"] = unit_id3
_G["unit_id4"] = unit_id4
_G["unit_id5"] = unit_id5
_G["unit_id6"] = unit_id6

_G["unit_stat1"] = unit_stat1
_G["unit_stat2"] = unit_stat2
_G["unit_stat3"] = unit_stat3
_G["unit_stat4"] = unit_stat4
_G["unit_stat5"] = unit_stat5
_G["unit_stat6"] = unit_stat6


for _, unitIndex in ipairs(_G.unitsArray) do
    local statVar = "unit_stat" .. unitIndex
  --  print("Checking:", statVar, "Current Value:", _G[statVar])

    if _G[statVar] == 1 then
  --      print("Changing", statVar, "to 0")
        _G[statVar] = 0
    end
end

--print(unit_stat1, unit_stat2, unit_stat3, unit_stat4, unit_stat5, unit_stat6) OUTDATED PRINT

--print(
 --   _G["unit_stat1"], _G["unit_stat2"], _G["unit_stat3"], 
 --   _G["unit_stat4"], _G["unit_stat5"], _G["unit_stat6"]
--)





-- detect which units it has and which strat to use

-- Check for unit types
local has_25, has_26 = false, false

if unit_stat1 == 25 or unit_stat2 == 25 or unit_stat3 == 25 or unit_stat4 == 25 or unit_stat5 == 25 or unit_stat6 == 25 then
    has_25 = true
end

if unit_stat1 == 26 or unit_stat2 == 26 or unit_stat3 == 26 or unit_stat4 == 26 or unit_stat5 == 26 or unit_stat6 == 26 then
    has_26 = true
end

function waitForMatch()
    while not workspace._waves_started.Value do
        game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("vote_start"):InvokeServer()
        -- CRACH MAYBE
        if (workspace._DATA.GameFinished.Value == true) then
            return
        end

        

        task.wait(2)

    end
end



-- Execute based on conditions
-- Version 1: Check if player is not alone in server before running any condition
if #game.Players:GetPlayers() ~= 1 then 

-- Execute based on conditions
if has_25 and has_26 then
 --   teleportToLanePart(2)
    wait(1)
    waitForMatch()

    -- place ceo1,2,3 and bulma
    waitForMoney(550)
    placeUnit(26,3)
    waitForMoney(550)
    placeUnit(26,3)
    waitForMoney(550)
    placeUnit(26,3)
    waitForMoney(800)
    placeUnit(25,3)

    -- upgrade ceo and bulma
    waitForMoney(1000)
    upgradeUnit("ceo1") 
    waitForMoney(1000)
    upgradeUnit("ceo2")
    waitForMoney(1000)
    upgradeUnit("ceo3")
    
    waitForMoney(1500)
    upgradeUnit("bulma")
    
    waitForMoney(3000)
    upgradeUnit("bulma")
    
    waitForMoney(1750)
    upgradeUnit("ceo1")
    waitForMoney(1750)
    upgradeUnit("ceo2")
    waitForMoney(1750)
    upgradeUnit("ceo3")
    
    -- placing unit and farming again ~ round 5
    waitForMoney(3000)
    placeUnit(0,2)
    
    waitForMoney(2500)
    upgradeUnit("ceo1")
    waitForMoney(2500)
    upgradeUnit("ceo2")
    waitForMoney(2500)
    upgradeUnit("ceo3")
    
    waitForMoney(3000)
    placeUnit(0,2)

    waitForMoney(4500)
    upgradeUnit("bulma")
    waitForMoney(7500)
    upgradeUnit("bulma")
    waitForMoney(10000)
    upgradeUnit("bulma")

    waitForMoney(3000)
    upgradeUnit("ceo1")
    waitForMoney(3000)
    upgradeUnit("ceo2")
    waitForMoney(3000)
    upgradeUnit("ceo3")

elseif has_26 then
  --  teleportToLanePart(1)
    wait(1)
    waitForMatch()

    -- place ceo1,2,3
    waitForMoney(550)
    placeUnit(26,3)
    waitForMoney(550)
    placeUnit(26,3)
    waitForMoney(550)
    placeUnit(26,3)

    -- upgrade ceo
    waitForMoney(1000)
    upgradeUnit("ceo1") 
    waitForMoney(1000)
    upgradeUnit("ceo2")
    waitForMoney(1000)
    upgradeUnit("ceo3")
    
    waitForMoney(1750)
    upgradeUnit("ceo1")
    waitForMoney(1750)
    upgradeUnit("ceo2")
    waitForMoney(1750)
    upgradeUnit("ceo3")
    
    waitForMoney(3000)
    placeUnit(0,2)
    
    waitForMoney(2500)
    upgradeUnit("ceo1")
    waitForMoney(2500)
    upgradeUnit("ceo2")
    waitForMoney(2500)
    upgradeUnit("ceo3")
    
    waitForMoney(3000)
    placeUnit(0,2)

    waitForMoney(3000)
    upgradeUnit("ceo1")
    waitForMoney(3000)
    upgradeUnit("ceo2")
    waitForMoney(3000)
    upgradeUnit("ceo3")

elseif has_25 then
  -- teleportToLanePart(0)
    wait(1)
    waitForMatch()

    -- place bulma
    waitForMoney(800)
    placeUnit(25,3)

    waitForMoney(1500)
    upgradeUnit("bulma")
    waitForMoney(3000)
    upgradeUnit("bulma")

    waitForMoney(3000)
    placeUnit(0,2)

    waitForMoney(4500)
    upgradeUnit("bulma")
    waitForMoney(7500)
    upgradeUnit("bulma")
    waitForMoney(10000)
    upgradeUnit("bulma")

else
   -- teleportToLanePart()
    wait(1)
    waitForMatch()
	end
end

-- Version 2: Only Case Handling (Fixed if-elseif structure)
if #game.Players:GetPlayers() == 1 then 
    if has_25 and has_26 then
   --     teleportToLanePart(2)
        wait(1)
        waitForMatch()
        -- place ceo1,2,3 and bulma
        waitForMoney(550)
        placeUnit(26,2)
        waitForMoney(550)
        placeUnit(26,2)
        waitForMoney(550)
        placeUnit(26,2)
        waitForMoney(800)
        placeUnit(25,2)
        
        waitForMoney(1000)
        upgradeUnit("ceo1")
        waitForMoney(1000)
        upgradeUnit("ceo2")
    
        waitForMoney(2500)
        placeUnit(0,2)
    
        waitForMoney(1000)
        upgradeUnit("ceo3")
    
        waitForMoney(1500)
        upgradeUnit("bulma")
    
        waitForMoney(2500)
        placeUnit(0,2)
    
        waitForMoney(1750)
        upgradeUnit("ceo1")
        waitForMoney(1750)
        upgradeUnit("ceo2")
    
        waitForMoney(2500)
        upgradeUnit("ceo1")
        waitForMoney(2500)
        upgradeUnit("ceo2")
        waitForMoney(2500)
        upgradeUnit("ceo3")
    
        waitForMoney(2500)
        placeUnit(0,2)
    
        waitForMoney(3000)
        upgradeUnit("bulma")
        waitForMoney(4500)
        upgradeUnit("bulma")
    
        waitForMoney(2500)
        placeUnit(0,2)
    
        waitForMoney(7500)
        upgradeUnit("bulma")
    
        waitForMoney(10000)
        upgradeUnit("bulma")
        
        waitForMoney(3000)
        upgradeUnit("ceo1")
    
        waitForMoney(3000)
        upgradeUnit("ceo2")
        
        waitForMoney(2500)
        upgradeUnit("ceo3")
        
        waitForMoney(3000)
        upgradeUnit("ceo3")
        
    elseif has_26 then
     --   teleportToLanePart(1)
        wait(1)
        waitForMatch()
        
        waitForMoney(550)
        placeUnit(26,1)
        waitForMoney(550)
        placeUnit(26,1)
        waitForMoney(550)
        placeUnit(26,1)
        waitForMoney(1000)
        upgradeUnit("ceo1")
        waitForMoney(1000)
        upgradeUnit("ceo2")
        waitForMoney(1000)
        upgradeUnit("ceo3")
        
        waitForMoney(2500)
        placeUnit(0,3)
        
        waitForMoney(1750)
        upgradeUnit("ceo1")
        waitForMoney(1750)
        upgradeUnit("ceo2")
        waitForMoney(1750)
        upgradeUnit("ceo3")
        
        waitForMoney(2500)
        placeUnit(0,3)
        
        waitForMoney(2500)
        upgradeUnit("ceo1")
        waitForMoney(2500)
        upgradeUnit("ceo2")
        waitForMoney(2500)
        upgradeUnit("ceo3")
        
        waitForMoney(2500)
        placeUnit(0,3)
        
        waitForMoney(3000)
        upgradeUnit("ceo1")
        waitForMoney(3000)
        upgradeUnit("ceo2")
        waitForMoney(3000)
        upgradeUnit("ceo3")
        
    elseif has_25 then
      --  teleportToLanePart(0)
        wait(1)
        waitForMatch()
    
        waitForMoney(800)
        placeUnit(25,1)
        
        waitForMoney(1500)
        upgradeUnit("bulma")
    
        waitForMoney(2500)
        placeUnit(0,3)
        
        waitForMoney(3000)
        upgradeUnit("bulma")
        
        waitForMoney(2500)
        placeUnit(0,3)
        
        waitForMoney(4500)
        upgradeUnit("bulma")
        
        waitForMoney(7500)
        upgradeUnit("bulma")
        
        waitForMoney(2500)
        placeUnit(0,3)
        
        waitForMoney(10000)
        upgradeUnit("bulma")

    else
      --  teleportToLanePart()
        wait(1)
        waitForMatch()
    end
end



while ( workspace._DATA.GameFinished.Value == false ) do
    
    placeUnit(0,2)
    task.wait(5)
    upgradeUnit()
    task.wait(5)
end

--print("game is already done")

wait(2)

game:GetService("ReplicatedStorage").endpoints.client_to_server.teleport_back_to_lobby:InvokeServer()
