_G.OMAnon_Name         = _G.OMAnon_Name or "LocalPlayer.Name"
_G.OMAnon_DisplayName  = _G.OMAnon_DisplayName or "LocalPlayer.DisplayName"
_G.OMAnon_AdditionalTargetNames = _G.OMAnon_AdditionalTargetNames or {}
_G.OMAnon_MyTeamnameSetup = _G.OMAnon_MyTeamnameSetup or function(label) label.Text = _G.OMAnon_Name end

print("[OMAnon] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local textConnections = {}

local function safe(func, ...)
    local args = {...}
    local success, err = pcall(function()
        func(unpack(args))
    end)
    if not success then
        warn("[OMAnon] Error:", err)
    end
    return success
end

local function filter(label)
    if not label:IsA("TextLabel") and not label:IsA("TextButton") then return false end
    if not label.Parent then return false end
    local path = label:GetFullName()
    if path:find("skibidi board") then return true end
    if path:find("FUNPanel.Frame.ScrollingFrame.EX.TextButton") then return true end
    if path:find("FUNPanel.Frame.targ") then return true end
    if path:find(".Teamname") then return true end
    if path:find(".user") then return true end
    if path:find(".selected") then return true end
    return false
end

local function repl(label)
    if not filter(label) then return end
    local text = label.Text
    
    local names = {LocalPlayer.Name, LocalPlayer.DisplayName}
    for _, v in ipairs(_G.OMAnon_AdditionalTargetNames) do table.insert(names, v) end
    
    local should = false
    for _, v in ipairs(names) do
        if string.find(text, v) then should = true break end
    end
    
    if not should then return end
    
    if not string.find(label:GetFullName(), "skibidi board") then warn("OMAnon repl at", label:GetFullName()) end

    for _, v in ipairs(names) do text = text:gsub(v, _G.OMAnon_Name) end
    text = text:gsub(LocalPlayer.DisplayName, _G.OMAnon_DisplayName)

    safe(function() label.Text = text end)
    
    if label:GetFullName():find(".Teamname") then
    	task.wait(0.5)
    	warn("OMAnon MyTeamnameSetup call at", label:GetFullName()) 
        safe(_G.OMAnon_MyTeamnameSetup, label) 
        return 
    end
end

local function cleanup(label)
    local conn = textConnections[label]
    if conn then
        safe(conn.Disconnect, conn)
        textConnections[label] = nil
    end
end

local function onDescendantAdded(label)
    if not filter(label) then return end
    safe(repl, label)
    if textConnections[label] then 
        safe(function() textConnections[label]:Disconnect() end)
    end
    safe(function()
        textConnections[label] = label:GetPropertyChangedSignal("Text"):Connect(function() safe(repl, label) end)
        label.Destroying:Connect(function() safe(cleanup, label) end)
    end)
end

safe(function()
    for _, v in ipairs(LocalPlayer.PlayerGui:GetDescendants()) do
        safe(onDescendantAdded, v)
    end
    LocalPlayer.PlayerGui.DescendantAdded:Connect(function(v)
        safe(onDescendantAdded, v)
    end)
end)

safe(function()
    for _, v in ipairs(workspace.Lobby:GetDescendants()) do
        if v.Name == "skibidi board" then
            v.DescendantAdded:Connect(function(a)
                safe(repl, a)
            end)
            for _, a in ipairs(v:GetDescendants()) do
                safe(repl, a)
            end
        end
    end
end)

print("[OMAnon] Working on all texts for you! ~")
