print("[Fleetway Cream] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end

local function rename(model, oldName, newName)
    local obj = model:FindFirstChild(oldName, true)
    while obj do
        -- print("renaming: "..obj.Name.." -> "..newName.." //"..obj.ClassName)
        obj.Name = newName
        if not obj:GetAttribute("oldName") then 
            obj:SetAttribute("oldName", oldName)
            obj:SetAttribute("newName", newName)
        end
        obj = model:FindFirstChild(oldName, true)
    end 
end

if game:GetService("ReplicatedStorage").ClientAssets.WinScreens:FindFirstChild("Fleetway") then 
	game:GetService("ReplicatedStorage").ClientAssets.WinScreens:FindFirstChild("Fleetway"):Destroy()
end
game:GetService("ReplicatedStorage").ClientAssets.WinScreens["2011x"]:Clone().Parent = 
game:GetService("ReplicatedStorage").ClientAssets.WinScreens
game:GetService("ReplicatedStorage").ClientAssets.WinScreens["2011x"].Name = "Fleetway"
game:GetService("ReplicatedStorage").ClientAssets.WinScreens.Fleetway.WinAnim.AnimationId =
game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE.Fleetway.scriptstuff.Animate.Anims.alt.Idle.AnimationId

game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE.Fleetway.Skins.Default:Destroy()
game:GetService("ReplicatedStorage").ClientAssets.Characters.Survivors.Cream.Skins.Default:Clone().Parent = 
game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE.Fleetway.Skins

local model = game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE.Fleetway.Skins.Default -- Cream clone
if model then
	
    for _, v in ipairs(model:GetDescendants()) do
        if v:IsA("BasePart") then
            if v.Color == Color3.fromRGB(255, 194, 148) then v.Color = Color3.fromRGB(255, 239, 202) end
            if v.Color == Color3.fromRGB(252, 144, 36) then v.Color = Color3.fromRGB(255, 92, 35) end
            if v.Color == Color3.fromRGB(40, 38, 90) then v.Color = Color3.fromRGB(40, 38, 90) end
            if v.Color == Color3.fromRGB(91, 124, 165) then v.Color = Color3.fromRGB(91, 124, 165) end
            if v.Color == Color3.fromRGB(228, 142, 0) then v.Color = Color3.fromRGB(228, 142, 0) end
            if v.Color == Color3.fromRGB(64, 64, 160) then v.Color = Color3.fromRGB(64, 64, 160) end
        end
    end

    local SuperSonic = game:GetService("ReplicatedStorage").ClientAssets.Cosmetics:FindFirstChild("SuperSonic", true)
    if SuperSonic then
    	SuperSonic.att1:Clone().Parent = model.waist
    	SuperSonic.att2:Clone().Parent = model.waist
        for k, v in pairs(model.waist:GetDescendants()) do
            if v:IsA("ParticleEmitter") then v.Enabled = true end
        end
    end
    
    local Fleetway = game:GetObjects("rbxassetid://79399719974346")[1]
    Fleetway.HED.eyes.Attachment.Parent = model.head.eye1
    Fleetway.HED.eyes.Attachment.Parent = model.head.eye2
    model.head.eye1.Size = model.head.eye1.Size * 0.0
    model.head.eye2.Size = model.head.eye2.Size * 0.0
    local huh = Fleetway.Head["Sphere.030_Sphere.043"]
    huh.Parent = model.head.eyes
    huh.Part1.Parent = model.head.eyes
    huh.Part1.LocalTransparencyModifier = 0
    huh.Part1.Size = huh.Part1.Size * Vector3.new(0.58, 0.6, 0.28)
    huh.C0 = huh.C0 * CFrame.new(0, 0.13, -0.16) * CFrame.Angles(math.rad(2), 0, 0)
    huh.Part0 = model.head.eyes
    huh.Part0.Size = huh.Part0.Size * 0.95

    local applycomestic = loadstring(game:HttpGet("https://pastebin.com/raw/qHzmXnbm"))()
    model:SetAttribute("Character", "Cream")
    model:SetAttribute("EquippedCosmetics", "TrevorGloves,") applycomestic(model)

    Fleetway.HumanoidRootPart.Parent = model
    model.PrimaryPart:Destroy()
    model.PrimaryPart = model.HumanoidRootPart
    model.HumanoidRootPart.Waist.Part1 = model.waist
    model.HumanoidRootPart.Waist.C1 = CFrame.new(0, 0, 0) * CFrame.Angles(-math.pi, 0, math.pi)

	-- main.
    rename(model, "waist", "Waist")

    -- arms (chain: Sleeve -> cyl -> cyl -> cyl -> Sleevee -> Hand)
    rename(model, "Right Sleeve", "RArm1")
    rename(model, "Right Sleevee", "RArm5")
    rename(model, "Left Sleeve", "LArm1")
    rename(model, "Left Sleevee",  "LArm5")
    rename(model, "Cylinder.013", "RArm2")
    rename(model, "Cylinder.012", "RArm3")
    rename(model, "Cylinder.014", "RArm4")
    rename(model, "Cylinder.023", "LArm2")
    rename(model, "Cylinder.024", "LArm3")
    rename(model, "Cylinder.022", "LArm4")

    -- Right Leg -> Cylinder.001 -> Cylinder -> ShoeSleeve -> Right Shoe
    rename(model, "Right Leg", "RLeg1")
    rename(model, "Cylinder.001", "RLeg2")
    rename(model, "Cylinder", "RLeg3")
    rename(model, "Right Shoe", "RFoot")

    -- Left Leg -> Cylinder.034 -> Cylinder.035 -> ShoeSleeve -> Left Shoe
    rename(model, "Left Leg", "LLeg1")
    rename(model, "Cylinder.034", "LLeg2")
    rename(model, "Cylinder.035", "LLeg3")
    rename(model, "Left Shoe", "LFoot")

    -- ShoeSleeve exists twice
    for _, d in ipairs(model:GetDescendants()) do
        if d:IsA("Motor6D") and d.Name == "ShoeSleeve" then
            if d.Part0 and d.Part0.Name == "RLeg3" then
                d.Name = "RLeg4"
                if d.Part1 then d.Part1.Name = "RLeg4" end
            elseif d.Part0 and d.Part0.Name == "LLeg3" then
                d.Name = "LLeg4"
                if d.Part1 then d.Part1.Name = "LLeg4" end
            end
        end
    end

    -- head
    rename(model, "muzzle", "Muzzle")
    rename(model, "REar", "Ear1")
    rename(model, "LEar", "Ear2")

    -- right hand fingers
    rename(model, "Cylinder.005", "RMiddle1")
    rename(model, "Cylinder.006", "RMiddle2")
    rename(model, "Cylinder.008", "RIndex1")
    rename(model, "Cylinder.007", "RIndex2")
    rename(model, "Cylinder.016", "RPinky1")
    rename(model, "Cylinder.009", "RPinky2")
    rename(model, "Cylinder.017", "RThumb1")
    rename(model, "Cylinder.018", "RThumb2")

    -- left hand fingers
    rename(model, "Cylinder.020", "LThumb1")
    rename(model, "Cylinder.019", "LThumb2")
    rename(model, "Cylinder.021", "LPinky1")
    rename(model, "Cylinder.027", "LPinky2")
    rename(model, "Cylinder.028", "LIndex1")
    rename(model, "Cylinder.029", "LIndex2")
    rename(model, "Cylinder.031", "LMiddle1")
    rename(model, "Cylinder.030", "LMiddle2")
end

game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE.Fleetway.Skins.Yourself:Destroy()
game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE.Fleetway.Skins.Default:Clone().Parent = 
game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE.Fleetway.Skins
game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE.Fleetway.Skins.Default.Name = "Yourself"

game:GetService("ReplicatedStorage").ClientAssets.Icons.Fleetway:Destroy()
game:GetService("ReplicatedStorage").ClientAssets.Icons.Cream:Clone().Parent = 
game:GetService("ReplicatedStorage").ClientAssets.Icons
game:GetService("ReplicatedStorage").ClientAssets.Icons.Cream.Name = "Fleetway"
game:GetService("ReplicatedStorage").ClientAssets.Icons.Fleetway:FindFirstChild("Pattern", true).ImageColor3 = Color3.fromRGB(255, 136, 136)
for _, v in ipairs(game.ReplicatedStorage.ClientAssets.Icons.Fleetway.Eyes:GetChildren()) do v.ImageColor3 = Color3.fromRGB(255, 30, 30) end

_G.FleetwayCreamSkin_SoundIDs = {}
_G.FleetwayCreamSkin_StunSounds = {}
_G.FleetwayCreamSkin_DownedSounds = {}
_G.FleetwayCreamSkin_AttackSounds = {}
_G.FleetwayCreamSkin_UnleashedSounds = {}

function tryUpdatePlayer(player)
    if not player:IsA("Model") then return end
    if player:GetAttribute("Character") ~= "Fleetway" then return end
    --if player:GetAttribute("Skin") ~= "Default" then return end
    
    print("[Fleetway Cream] Waiting for " .. player:GetFullName() .. "...")

    if player:FindFirstChild("OverlayModel") then
        warn("[Fleetway Cream] Player already have OverlayModel, update cancelled")
        return
    end

    local BeingChased = Instance.new("ObjectValue")
    BeingChased.Name = "BeingChased"
    BeingChased.Parent = player
    player.AttributeChanged:Connect(function(attr)
        if attr == "StunDur" or attr == "BurnDur" then
            local val = player:GetAttribute(attr)
            if val and val > 0 then BeingChased.Value = player
            elseif not val or val <= 0 then BeingChased.Value = nil end
        end
    end)

    local Glide = nil

    player.DescendantRemoving:Connect(function(desc)
        -- if desc:GetFullName():find(".FOVMultiplier") then return end
        -- print("DescendantRemoving", desc.ClassName, desc:GetFullName())
        if desc.Name == "BodyGyro" then Glide:Stop() end
        if desc.Name == "Spindash" then Glide:Stop() end
    end)

    player.DescendantAdded:Connect(function(desc)
        -- if desc:GetFullName():find(".FOVMultiplier") then return end
        -- print("DescendantAdded", desc.ClassName, desc:GetFullName())
        if desc.Name == "BodyGyro" then Glide:Play() end
        if desc.Name == "Spindash" then Glide:Play() end
        if desc.Name == "_BLOOD" then
        	desc.Name = "_BLOOD_HANDLED"
            local depth1 = {}
            local depth2 = {}
            local depth3 = {}
            for _, v in ipairs(OverlayModel:GetDescendants()) do
            	if not v:IsA("MeshPart") then continue end
                if #v:GetFullName():split(".") - #OverlayModel:GetFullName():split(".") <= 1 then table.insert(depth1, v) end
                if #v:GetFullName():split(".") - #OverlayModel:GetFullName():split(".") <= 2 then table.insert(depth2, v) end
                if #v:GetFullName():split(".") - #OverlayModel:GetFullName():split(".") <= 3 then table.insert(depth3, v) end
            end
            -- depth 1
            if #depth1 > 0 then desc.Parent = depth1[math.random(#depth1)] end -- move org and then clone it
            if #depth1 > 0 then desc:Clone().Parent = depth1[math.random(#depth1)] end
            -- depth 2
            if #depth2 > 0 then desc:Clone().Parent = depth2[math.random(#depth2)] end
            if #depth2 > 0 then desc:Clone().Parent = depth2[math.random(#depth2)] end
            if #depth2 > 0 then desc:Clone().Parent = depth2[math.random(#depth2)] end
            if #depth2 > 0 then desc:Clone().Parent = depth2[math.random(#depth2)] end
            -- depth 3
            if #depth3 > 0 then desc:Clone().Parent = depth3[math.random(#depth3)] end
            if #depth3 > 0 then desc:Clone().Parent = depth3[math.random(#depth3)] end
            if #depth3 > 0 then desc:Clone().Parent = depth3[math.random(#depth3)] end
            if #depth3 > 0 then desc:Clone().Parent = depth3[math.random(#depth3)] end
            if #depth3 > 0 then desc:Clone().Parent = depth3[math.random(#depth3)] end
            if #depth3 > 0 then desc:Clone().Parent = depth3[math.random(#depth3)] end
        end
        
        if not desc:IsA("Sound") then return end
        if desc:GetAttribute("IsMyCloneToIgnore") then return end
        local path = desc:GetFullName()
        --print(path..", "..desc.SoundId)
        
        local function playCopy(sound)
            local clone = sound:Clone()
            clone:SetAttribute("IsMyCloneToIgnore", true)
            clone.Parent = sound.Parent
            clone.Volume = 1.0 + sound.Volume
            clone.TimePosition = 0
            clone.PlaybackRegion = NumberRange.new(0, 0)
            clone:Play()
            clone.Ended:Once(function() clone:Destroy() end)
            game.Debris:AddItem(clone, 12)
            sound:Destroy()
        end

        if _G.FleetwayCreamSkin_SoundIDs[desc.SoundId] then desc.SoundId = _G.FleetwayCreamSkin_SoundIDs[desc.SoundId] end
        
        if path:find(".Attack") then
            desc.SoundId = _G.FleetwayCreamSkin_AttackSounds[math.random(1, #_G.FleetwayCreamSkin_AttackSounds)]
            desc.Name = "CreamSpeech"
            playCopy(desc)
            return
        end
        if path:find(".Stun") or path:find(".ROUNDEND") then -- Stun
            while desc.Parent:FindFirstChild("CreamSpeech") do desc.Parent:FindFirstChild("CreamSpeech"):Destroy() end
            desc.SoundId = _G.FleetwayCreamSkin_StunSounds[math.random(1, #_G.FleetwayCreamSkin_StunSounds)]
            desc.Name = "CreamSpeech"
            playCopy(desc)
            return
        end
        if path:find(".Downed") or path:find(".Laugh") then
            while desc.Parent:FindFirstChild("CreamSpeech") do desc.Parent:FindFirstChild("CreamSpeech"):Destroy() end
            desc.SoundId = _G.FleetwayCreamSkin_DownedSounds[math.random(1, #_G.FleetwayCreamSkin_DownedSounds)]
            desc.Name = "CreamSpeech"
            playCopy(desc)
            return
        end
        if path:find(".Drain") or (path:find(".Laser") and path:find("Line")) then
            while desc.Parent:FindFirstChild("CreamSpeech") do desc.Parent:FindFirstChild("CreamSpeech"):Destroy() end
            local dn = _G.FleetwayCreamSkin_DownedSounds
            local CaughtLines = { _G.FleetwayCreamSkin_UnleashedSounds[1], dn[10], dn[1]}
            desc.SoundId = CaughtLines[math.random(1, #CaughtLines)]
            desc.Name = "CreamSpeech"
            playCopy(desc)
            return
        end
        if (path:find(".Burst") and path:find("Line")) or (path:find(".Phase") and path:find("Line")) then
            while desc.Parent:FindFirstChild("CreamSpeech") do desc.Parent:FindFirstChild("CreamSpeech"):Destroy() end
            local dn = _G.FleetwayCreamSkin_DownedSounds
            local CaughtLines = {dn[6], dn[3], dn[4], dn[6], dn[6], dn[7], dn[8], dn[8]}
            desc.SoundId = CaughtLines[math.random(1, #CaughtLines)]
            desc.Name = "CreamSpeech"
            playCopy(desc)
            if path:find(".Phase") then player:SetAttribute("LastLife", true) end
            return
        end
        if path:find(".DashLine") then
            while desc.Parent:FindFirstChild("CreamSpeech") do desc.Parent:FindFirstChild("CreamSpeech"):Destroy() end
            desc.SoundId = _G.FleetwayCreamSkin_UnleashedSounds[math.random(1, #_G.FleetwayCreamSkin_UnleashedSounds)]
            desc.Name = "CreamSpeech"
            playCopy(desc)
            return
        end
        if _G.FleetwayCreamSkin_KillLines[desc.Name] then
            while desc.Parent:FindFirstChild("CreamSpeech") do desc.Parent:FindFirstChild("CreamSpeech"):Destroy() end
            desc.SoundId = _G.FleetwayCreamSkin_KillLines[desc.Name][math.random(1, #_G.FleetwayCreamSkin_KillLines[desc.Name])]
            desc.Name = "CreamSpeech"
            playCopy(desc)
            return
        end
    end)

    if not player:FindFirstChild("Animator", true) then player:WaitForChild("Humanoid"):WaitForChild("Animator") end
    Glide = player.Humanoid.Animator:LoadAnimation(game:GetService("ReplicatedStorage").ClientAssets.Characters.Survivors.Cream.scriptstuff.Animate.Anims.Glide)

    -- wait for camera first setup
    local lastCamCFrame = workspace.CurrentCamera.CFrame
    repeat task.wait() until workspace.CurrentCamera.CFrame ~= lastCamCFrame

    -- cam script is horror
    player.Body.Head:GetPropertyChangedSignal("C0"):Connect(function()
        local myHead = player.OverlayModel.Torso.Body.Head
        myHead.C0 = CFrame.new(myHead.C0.Position) * player.Body.Head.C0.Rotation
    end)
    player.cam.Name = "cam (dont touch this pizdec)"
    
    print("[Fleetway Cream] Updating " .. player:GetFullName() .. "!")

    -- Prepare Overlay Model
    local OverlayModel = game.ReplicatedStorage.ClientAssets.Characters:FindFirstChild(player:GetAttribute("Character"), true).Skins[player:GetAttribute("Skin")]:Clone()
    OverlayModel.Name = "OverlayModel"

    -- Setup Char Model
    local ogHRP = player:FindFirstChild("Waist")
    if not ogHRP then return end

    for _, v in ipairs(player:GetDescendants()) do
    	-- if v.Parent == player then print(v) end
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.LocalTransparencyModifier = 1
            v.Changed:Connect(function(property)
                if property == "LocalTransparencyModifier" then
                    v.LocalTransparencyModifier = 1
                end
                if property == "Transparency" and v.Name == "Head" then
                    --warn(v:GetFullName(), v.Transparency)
                    for _, ov in ipairs(player.OverlayModel:GetDescendants()) do 
                        if not ov:GetAttribute("IgnoreTransparency") then
                            pcall(function() ov.Transparency = v.Transparency end)
                        end
                    end
                end
                task.wait(0.1)
            end)
        end
        --if v:IsA("SurfaceGui") then v.Enabled = false end
        --if v:IsA("SurfaceAppearance") then v:Destroy() end
        if v:IsA("Decal") then v:Destroy() end
    end
    
    player.HED.eyes.Attachment.Parent = OverlayModel.head.eye1
    player.HED.eyes.Attachment.Parent = OverlayModel.head.eye2

    -- Setup Overlay Model
    OverlayModel.Parent = player

    local myHRP = OverlayModel:FindFirstChild("Waist")
    if not myHRP then OverlayModel:Destroy() return end

    for _, v in ipairs(OverlayModel:GetDescendants()) do
        if v:IsA("Humanoid") then v:Destroy() end
        if v:IsA("Animator") then v:Destroy() end
        if v:IsA("BasePart") then
            v.CanCollide = false
            v.Anchored = false
            v.CanTouch = false
            v.CanQuery = false
            v.Massless = true
            if v.Transparency > 0 then v:SetAttribute("IgnoreTransparency", true) end
        end
    end
    
    local hrpY = -1.0
    local weld = Instance.new("Weld")
    weld.Name = "OverlayModelWeld"
    weld.Part0 = ogHRP
    weld.Part1 = myHRP
    weld.C0 = CFrame.new()
    weld.C1 = CFrame.new(0, -hrpY, 0) * CFrame.Angles(0, math.rad(180), 0) * CFrame.Angles(math.rad(0), 0, 0)  -- смотрит чуть вверх
    weld.Parent = myHRP
    myHRP:PivotTo(ogHRP.CFrame * CFrame.new(0, hrpY, 0) * CFrame.Angles(math.rad(0), 0, 0))

    print("[Fleetway Cream] Updating finished for", player.Name .. "!")
end

local function onPlayerAdded(player)
    -- Check if they already spawned in
    if player.Character then tryUpdatePlayer(player.Character) end
    -- Listen for the player (re)spawning
    _G.FleetwayCreamCharacterAddedConn = _G.FleetwayCreamCharacterAddedConn or {}
    if _G.FleetwayCreamCharacterAddedConn[player.Name] then
        _G.FleetwayCreamCharacterAddedConn[player.Name]:Disconnect()
        print("[Fleetway Cream] Previous FleetwayCreamCharacterAddedConn disconnected for", player.Name)
    end
    _G.FleetwayCreamCharacterAddedConn[player.Name] = player.CharacterAdded:Connect(tryUpdatePlayer) 
end

for _, player in game.Players:GetPlayers() do onPlayerAdded(player) end

if _G.FleetwayCreamPlayerAddedConn then _G.FleetwayCreamPlayerAddedConn:Disconnect() print("[Fleetway Cream] Previous FleetwayCreamPlayerAddedConn disconnected") end
_G.FleetwayCreamPlayerAddedConn = game.Players.PlayerAdded:Connect(onPlayerAdded)


local function myAsset(fileName)
    local cachePath = "cache/lil2kki/Cream.LMS/" .. fileName
    if isfile(cachePath) then return getcustomasset(cachePath) end
    local success, result = pcall(function()
        return game:HttpGet("https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/Cream.LMS/assets/" .. fileName) 
    end)
    if success and result then
        writefile(cachePath, result)
        return getcustomasset(cachePath)
    else
        warn("[Cream.LMS for 2011x] failed to load " .. fileName)
        return nil
    end
end

local themes = game:GetService("ReplicatedStorage"):FindFirstChild("ChaseThemes", true):FindFirstChild("Fleetway", true)

themes.Default.TerrorRadius.SoundId = myAsset("TerrorRadius2.mp3")

themes.Default.NormalChase.SoundId = myAsset("flam06_Classic_Fleetway_Chase_Theme_eq.mp3")
themes.Default.NormalChase.LoopRegion = NumberRange.new(0, 0)

themes.Default.LastLifeChase.SoundId = myAsset("XaviCorraless_BETTER_THAN_YOU!_eq.mp3")
themes.Default.LastLifeChase.LoopRegion = NumberRange.new(0, 0)
themes.Default.LastLifeChase:SetAttribute("Eliminated", nil)

themes.Yourself:Destroy()
themes.Default:Clone().Parent = themes
themes.Default.Name = "Yourself"

_G.FleetwayCreamSkin_SoundIDs = {
    -- xd
}
_G.FleetwayCreamSkin_KillLines = {
    ["SonicLine"] = { myAsset("Sonic.mp3"), myAsset("Sonic2.mp3") },
    ["TailsLine"] = { myAsset("Tails.mp3"),  myAsset("Tails2.mp3") },
    ["MetalSonicLine"] = { myAsset("MetalSonic.mp3"),  myAsset("MetalSonic2.mp3") },
    ["AmyLine"] = { myAsset("Amy.mp3"),  myAsset("Amy2.mp3"),  myAsset("Amy3.mp3"),  myAsset("Amy4.mp3") },
    ["SilverLine"] = { myAsset("Silver.mp3") },
    ["BlazeLine"] = { myAsset("Blaze.mp3") },
    ["EggmanLine"] = { myAsset("Eggman.mp3") },
    ["CreamLine"] = { myAsset("Cream.mp3"),  myAsset("Cream2.mp3") },
    ["KnucklesLine"] = { myAsset("Knuckles.mp3") }
}
_G.FleetwayCreamSkin_UnleashedSounds = { myAsset("Unleashed2.mp3"), myAsset("Down1.mp3"), myAsset("Down5.mp3"), myAsset("Down5.mp3"), myAsset("Down7.mp3"), myAsset("Down8.mp3"), myAsset("Down13.mp3") }
for i = 1, 28 do table.insert(_G.FleetwayCreamSkin_StunSounds, myAsset("Stun" .. i .. ".mp3")) end
for i = 1, 14 do table.insert(_G.FleetwayCreamSkin_DownedSounds, myAsset("Down" .. i .. ".mp3")) end
for i = 1, 8 do table.insert(_G.FleetwayCreamSkin_AttackSounds, myAsset("Attack" .. i .. ".mp3")) end
