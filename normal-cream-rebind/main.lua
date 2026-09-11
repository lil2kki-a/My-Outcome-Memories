-- normal-cream-rebind by lil2kki :3

if not game:IsLoaded() then game.Loaded:Wait() end

local player = game.Players.LocalPlayer
local gui    = player:WaitForChild("PlayerGui")
local uis    = game:GetService("UserInputService")
local vim    = game:GetService("VirtualInputManager")

local function log(s) print("[normal-cream-rebind] " .. s) end

local strToKeyCode = {}
for _, kc in pairs(Enum.KeyCode:GetEnumItems()) do
    strToKeyCode[kc.Name:upper()] = kc
    strToKeyCode[tostring(kc.Value)] = kc
end

local function sendKey(keyStr)
    local kc = strToKeyCode[keyStr:upper()] or strToKeyCode[keyStr]
    if not kc then return end
    vim:SendKeyEvent(true,  kc, false, game)
    task.wait(0.01)
    vim:SendKeyEvent(false, kc, false, game)
end

local function findByName(parent, name)
    for _, btn in ipairs(parent:GetChildren()) do
        local label = btn:FindFirstChild("ABName")
        if label and label.Text == name then return btn end
    end
end

local function getKey(btn)
    local num = btn:FindFirstChild("Num")
    return num and num.Text:match("^%s*(.-)%s*$") or nil
end

local aiming   = false
local bar      = nil
local altbar   = nil
local sessions = {}

local function inAltMode()
    return altbar and altbar.Visible
end

local function cleanup()
    for _, c in ipairs(sessions) do pcall(function() c:Disconnect() end) end
    sessions = {}
    bar    = nil
    altbar = nil
    aiming = false
    uis.MouseBehavior = Enum.MouseBehavior.Default
    log("session cleaned up")
end

local function onInput(input, gameProcessed)
    if gameProcessed or not bar or not altbar then return end

    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        if inAltMode() then
            if aiming then return end
            local btn = findByName(altbar, "Aim")
            if not btn then return end
            local key = getKey(btn)
            if not key then return end
            aiming = true
            pcall(sendKey, key)
        else
            local btn = findByName(bar, "Gun")
            if not btn then return end
            local key = getKey(btn)
            if not key then return end
            pcall(sendKey, key)
        end
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if not inAltMode() then return end
        local btn = findByName(altbar, "Shoot")
        if not btn then return end
        local key = getKey(btn)
        if not key then return end
        pcall(sendKey, key)
        return
    end

    if input.KeyCode == Enum.KeyCode.R then
        if not inAltMode() then return end
        local btn = findByName(altbar, "Reload")
        if not btn then return end
        local key = getKey(btn)
        if not key then return end
        pcall(sendKey, key)
    end
end

local function onInputEnded(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton2 then return end
    if not aiming then return end
    aiming = false
    if not inAltMode() then return end
    local btn = findByName(altbar, "Aim")
    if not btn then return end
    local key = getKey(btn)
    if not key then return end
    pcall(sendKey, key)
end

local function startSession(newBar, newAltBar)
    cleanup()
    bar    = newBar
    altbar = newAltBar

    sessions[#sessions+1] = altbar:GetPropertyChangedSignal("Visible"):Connect(function()
        uis.MouseBehavior = altbar.Visible
            and Enum.MouseBehavior.LockCenter
            or  Enum.MouseBehavior.Default
    end)

    sessions[#sessions+1] = bar.AncestryChanged:Connect(function()
        if not bar.Parent then cleanup() end
    end)

    sessions[#sessions+1] = uis.InputBegan:Connect(onInput)
    sessions[#sessions+1] = uis.InputEnded:Connect(onInputEnded)

    log("session started")
end

local function watchAbility(ability)
    local b  = ability:FindFirstChild("Bar")
    local ab = ability:FindFirstChild("AltBar")
    if b and ab then startSession(b, ab) return end

    local pending = {}
    local function tryStart()
        if pending.bar and pending.altbar then
            startSession(pending.bar, pending.altbar)
        end
    end
    pending.conn = ability.ChildAdded:Connect(function(child)
        if child.Name == "Bar"    then pending.bar    = child tryStart() end
        if child.Name == "AltBar" then pending.altbar = child tryStart() end
    end)
end

local function watchGame(gm)
    local ability = gm:FindFirstChild("Ability")
    if ability then watchAbility(ability) return end
    local c; c = gm.ChildAdded:Connect(function(child)
        if child.Name == "Ability" then c:Disconnect() watchAbility(child) end
    end)
end

local function watchRound(round)
    local gm = round:FindFirstChild("Game")
    if gm then watchGame(gm) return end
    local c; c = round.ChildAdded:Connect(function(child)
        if child.Name == "Game" then c:Disconnect() watchGame(child) end
    end)
end

local function watchGui()
    local round = gui:FindFirstChild("Round")
    if round then watchRound(round) end
    gui.ChildAdded:Connect(function(child)
        if child.Name == "Round" then watchRound(child) end
    end)
end

if not game:IsLoaded() then game.Loaded:Wait() end
watchGui()

log("Ready! Made by lil2kki <3")
log("  RMB hold    -> Gun then Aim")
log("  RMB release -> unaim")
log("  LMB         -> Shoot (AltBar only)")
log("  R           -> Reload (AltBar only)")
