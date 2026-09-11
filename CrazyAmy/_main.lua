print("[CrazyAmy] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end

if not UnlockModule then function UnlockModule(a) print("Executor doesn't need to unlock module", a:GetFullName()) end end
if not LockModule then function LockModule(a) print("Executor doesn't need to unlock module", a:GetFullName()) end end

-- storage animator set
local OldAnimate = game.ReplicatedStorage:FindFirstChild("Characters", true):FindFirstChild("Kolossos", true):FindFirstChild("Animate", true)
local AmyAnimate = game.ReplicatedStorage:FindFirstChild("Characters", true):FindFirstChild("Amy", true):FindFirstChild("Animate", true):Clone()
AmyAnimate.Parent = OldAnimate.Parent
OldAnimate:Destroy()

AmyAnimate.Anims.alt.Walk:Clone().Parent = AmyAnimate.Anims
AmyAnimate.Anims.Walk.Name = "SelectPose" -- rename clone

-- storage model template
local tar = game.ReplicatedStorage:FindFirstChild("Characters", true):FindFirstChild("Kolossos", true):FindFirstChild("Skins", true).Default

local model = game.ReplicatedStorage.ClientAssets.Characters.Survivors.Amy.Skins.Default:Clone()
model.Name = tar.Name
model.Parent = tar.Parent

if model then -- setup modellll
    local function find(name) return model:FindFirstChild(name, true) end

    local function weld(part0, part1)
        part1:PivotTo(part0.CFrame)
        local c0 = part0.CFrame:ToObjectSpace(part1.CFrame)
        local w = Instance.new("Weld")
        w.Name = part1.Name
        w.Part0 = part0
        w.Part1 = part1
        w.C0 = c0
        w.Parent = part0
    end

    local function applySimpleCosmetic(Cosmetic)
        UnlockModule(Cosmetic.Unique)
        require(Cosmetic.Unique).load(model)
        LockModule(Cosmetic.Unique)
        local target = model:FindFirstChild(Cosmetic:GetAttribute("WeldTo"), true)
        local weldPart = Cosmetic:FindFirstChild("Weld")
        weld(target, weldPart)
    end

    local function applyComplexCosmetic(Cosmetic)
        UnlockModule(Cosmetic.Unique)
        require(Cosmetic.Unique).load(model)
        LockModulke(Cosmetic.Unique)
        for _, child in ipairs(Cosmetic:GetChildren()) do
            if not child:IsA("Model") then continue end
            local weldToName = child:GetAttribute("WeldTo")
            if not weldToName then warn("No WeldTo Attribute in", child:GetFullName()) continue end
            --warn(child:GetFullName(), "Weld To", weldToName)
            local target = model:FindFirstChild(weldToName, true)
            local weldPart = child:FindFirstChild("Weld")
            child.PrimaryPart = weldPart
            weld(target, weldPart)
        end
        for _, v in ipairs(Cosmetic:GetDescendants()) do
            if v:IsA("BasePart") then v.Transparency = 0 end
        end
    end

    game.ReplicatedStorage.ClientAssets.Cosmetics.Top.MessyH:Clone().Parent = model
    applySimpleCosmetic(model.MessyH)

    game.ReplicatedStorage.ClientAssets.Cosmetics.Body.ModernOutfit:Clone().Parent = model
    applyComplexCosmetic(model.ModernOutfit)
    game.ReplicatedStorage.ClientAssets.Cosmetics.Bottom.TetoBoots:Clone().Parent = model
    applyComplexCosmetic(model.TetoBoots)

    local function addDecal(parent, face, textureId, rotation, uvOffset, uvScale)
        local decal = Instance.new("Decal")
        decal.Face = face
        decal.Texture = "rbxassetid://" .. textureId
        decal.Color3 = Color3.new(1, 1, 1)
        decal.Transparency = 0
        decal.ZIndex = 1
        decal.Rotation = rotation or 0
        decal.UVOffset = uvOffset or Vector2.new(0, 0)
        decal.UVScale = uvScale or Vector2.new(1, 1)
        decal.Parent = parent
        return decal
    end
    addDecal(model.Torso.MainTorso, Enum.NormalId.Left, "9893615086", 30) -- Rotation=30
    addDecal(model.Torso.Body, Enum.NormalId.Left, "9893615086")
    addDecal(model.Muzzle, Enum.NormalId.Left, "1694132441", 42, Vector2.new(0.4, 0), Vector2.new(1.3, 1.3))
    addDecal(model.Muzzle, Enum.NormalId.Left, "14280704585", 6, Vector2.new(0.04, 0.4), Vector2.new(0.6, 0.5))
    addDecal(model.Arms.LArm.Model["Left Hand"], Enum.NormalId.Front, "107953383542820")
    addDecal(model.Arms.Rarm.Model["Right Hand"], Enum.NormalId.Top, "1694131993")
    addDecal(model.Arms.Rarm.Model["Right Hand"], Enum.NormalId.Back, "107953383542820")
    addDecal(model.Arms.Rarm.Model["Right Hand"], Enum.NormalId.Front, "107953383542820")

    -- Material.Slate
    for _, v in ipairs(model:GetDescendants()) do
        if v:IsA("BasePart") and (v.Material == Enum.Material.Plastic or v.Material == Enum.Material.SmoothPlastic) then 
            v.Material = Enum.Material.Slate 
        end
        if v:IsA("BasePart") and (v.Material == Enum.Material.Metal and v.Name == "Torus") or v.Name == "Right Hand" or v.Name == "Left Hand" then
            addDecal(v, Enum.NormalId.Front, "107953383542820")
            addDecal(v, Enum.NormalId.Bottom, "107953383542820")
            addDecal(v, Enum.NormalId.Top, "107953383542820")
            addDecal(v, Enum.NormalId.Back, "107953383542820")
            addDecal(v, Enum.NormalId.Left, "107953383542820")
            addDecal(v, Enum.NormalId.Right, "107953383542820")
        end
        if v:IsA("Part") and v.Parent.Name == "Hammer" then
            addDecal(v, Enum.NormalId.Front, "52909002")
        end
    end
end

tar:Destroy()

-- Amy Icons
while game.ReplicatedStorage.ClientAssets.Icons:FindFirstChild("Kolossos") do
    game.ReplicatedStorage.ClientAssets.Icons["Kolossos"]:Destroy()
end
local icons = game.ReplicatedStorage.ClientAssets.Icons.Amy:Clone()
icons.Parent = game.ReplicatedStorage.ClientAssets.Icons
icons.Name = "Kolossos"
icons.Eyes:Destroy()

-- sounds predecl
_G.CrazyAmy_SoundsForID = {}
_G.CrazyAmy_SoundsForName = {}
_G.CrazyAmy_StunSounds = {}
_G.CrazyAmy_DownedSounds = {}
_G.CrazyAmy_AttackSounds = {}
_G.CrazyAmy_UnleashedSounds = {}

local function tryUpdatePlayer(player)
    if not player:IsA("Model") then return end
    if player:GetAttribute("Character") ~= "Kolossos" then return end
    if player:GetAttribute("Skin") ~= "Default" then return end

    print("[CrazyAmy] Prebuild updating model for " .. player.Name .. "...")

    if player:FindFirstChild("OverlayModel") then
        warn("[CrazyAmy] Player already have OverlayModel, update cancelled")
        return
    end

    -- xd
    if not player:FindFirstChild("Health") then
        local Health = Instance.new("NumberValue")
        Health.Name = "Health"
        Health.Value = 100
        Health.Parent = player
        player.AttributeChanged:Connect(function(attr)
            if attr == "StunDur" or attr == "BurnDur" or attr == "SpeedBoost" then
                local val = player:GetAttribute(attr)
                if attr == "SpeedBoost" and val ~= 0.1 then val = 0 end 
                if val and val > 0 then
                    player.Health.Value = 100 - (val * 10)
                    player:SetAttribute("State", "alt")
                elseif not val or val <= 0 then
                    player.Health.Value = 100
                    player:SetAttribute("State", "default")
                end
            end
        end)
    end

    -- sometimes game spam errors without it lol
    if not player:FindFirstChild("BeingChased") then
        local BeingChased = Instance.new("ObjectValue")
        BeingChased.Name = "BeingChased"
        BeingChased.Value = player
        BeingChased.Parent = player
    end

    local function rename(oldName, newName)
        local obj = player:FindFirstChild(oldName, true)
        while obj do
            -- print("renaming: "..obj.Name.." -> "..newName.." //"..obj.ClassName)
            obj.Name = newName
            if not obj:GetAttribute("oldName") then 
                obj:SetAttribute("oldName", oldName)
                obj:SetAttribute("newName", newName)
            end
            obj = player:FindFirstChild(oldName, true)
        end 
    end
    local function renameByAttribute(attrName)
        for _, obj in ipairs(player:GetDescendants()) do
            local targetName = obj:GetAttribute(attrName)
            if targetName then obj.Name = targetName end
        end
    end

    player:WaitForChild("RootPart")

    print("[CrazyAmy] Character ready! Updating " .. player:GetFullName() .. "...")
    
    -- Char Model
    local ogHRP = player:FindFirstChild("HumanoidRootPart", true)
    if not ogHRP then return end

    if ogHRP:FindFirstChild("Running") then ogHRP:FindFirstChild("Running"):Destroy() end

    for _, v in ipairs(player:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v:SetAttribute("HiddenAway", "FOR Amy")
            v:SetAttribute("doesntcount", true)
            v.Color = Color3.new(0/255, 0/255, 0/255)
            v.Material = Enum.Material.Neon
            v.LocalTransparencyModifier = 1
            v.Changed:Connect(function(property)
                if property == "LocalTransparencyModifier" then
                    v.LocalTransparencyModifier = 1
                end
                if property == "Transparency" and v.Name == "Cylinder.005" then
                    --warn(v:GetFullName(), v.Transparency)
                    for _, ov in ipairs(player.OverlayModel:GetDescendants()) do 
                        if not ov:GetAttribute("IgnoreTransparency") then
                            pcall(function() ov.Transparency = v.Transparency end)
                            if ov:IsA("ParticleEmitter") then ov.Enabled = (v.Transparency < 0.5) end
                        end
                    end
                end
            end)
        end
        if v:IsA("Decal") then v:Destroy() end
        if v:IsA("SurfaceGui") then v.Enabled = false end
        if v:IsA("SurfaceAppearance") then v:Destroy() end
    end

    local armr = player:WaitForChild("RootPart"):WaitForChild("Torso1"):WaitForChild("Torso2"):WaitForChild("Arm1.R");
    print(armr:GetFullName())
    armr.CFrame = armr.CFrame * CFrame.new(3, -3, -2)

    -- Overlay Model
    local OverlayModel = game.ReplicatedStorage:FindFirstChild("Characters", true):FindFirstChild("Kolossos", true):FindFirstChild("Skins", true).Default:Clone()
    OverlayModel.Name = "OverlayModel"
    OverlayModel.Parent = player

    local myHRP = OverlayModel:FindFirstChild("HumanoidRootPart", true)
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

    -- yooo (im stupidoo)
    local hrpY = -1.0
    local weld = Instance.new("Weld")
    weld.Part0 = ogHRP
    weld.Part1 = myHRP
    weld.C0 = CFrame.new()
    weld.C1 = CFrame.new(0, -hrpY, 0) 
    weld.Parent = myHRP
    myHRP:PivotTo(ogHRP.CFrame * CFrame.new(0, hrpY, 0))

    -- add state (animatior needs it)
    if not player:GetAttribute("State") then 
        warn("[CrazyAmy] Added default state attribute for", player.Name) 
        player:SetAttribute("State", "default") 
    end

    if player:WaitForChild("Animate") and player:WaitForChild("Humanoid") then

        local Animate = game.ReplicatedStorage.ClientAssets.Characters.EXE["Kolossos"].scriptstuff.Animate:Clone()
        Animate.Name = "Amy"..Animate.Name
        Animate.Parent = player
        Animate.Enabled = true
        
        if game.Players.LocalPlayer.Name ~= player.Name then -- load custom animator for not local players yea
            loadstring(game:HttpGet(
                "https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/CrazyAmy/include/AmyAnimate.lua"
            ))().setup(player, Animate.Anims)
            print("[CrazyAmy] Amy custom animatior added for", player.Name.."!")
        end

        local ServerHammerAnimA = Instance.new("Animation")                                 -- attk2
        ServerHammerAnimA.AnimationId = "rbxassetid://115372946205085"                      -- attk2
        local ServerHammerAnim = player.Humanoid.Animator:LoadAnimation(ServerHammerAnimA)  -- attk2

        local Throw = player.Humanoid.Animator:LoadAnimation(Animate.Anims.Throw)           -- attk1

        local Drop = player.Humanoid.Animator:LoadAnimation(Animate.Anims.Drop)
        
        local altIdle = player.Humanoid.Animator:LoadAnimation(Animate.Anims.alt.Idle)

        local DropClimb = player.Humanoid.Animator:LoadAnimation(Animate.Anims.Drop) -- climb
        DropClimb.Looped = true

        local DropSpeedSyncTarget = nil
        task.spawn(function()
	        while true do
                if DropSpeedSyncTarget and DropSpeedSyncTarget.IsPlaying then
                    -- print(DropSpeedSyncTarget.Speed)
                    DropClimb:AdjustSpeed(DropSpeedSyncTarget.Speed * 2.5)
                end
                task.wait()
            end
        end)

        -- damn
        if _G.CrazyAmyChargeEndDetectConn then
            _G.CrazyAmyChargeEndDetectConn:Disconnect()
            print("[CrazyAmy] Previous CrazyAmyChargeEndDetectConn disconnected")
        end
        _G.CrazyAmyChargeEndDetectConn = game.CollectionService:GetInstanceRemovedSignal("IFrame"):Connect(function(Inst)
            if Inst.Name ~= player.Name then return end
            Throw:AdjustSpeed(1)
            if Throw.IsPlaying then Throw:Stop(0.3) end
        end)

        player.Humanoid.Animator.AnimationPlayed:Connect(function(track)
            --print("PLAYED: "..track.Name.." - "..track.Animation.AnimationId)
            local id = track.Animation.AnimationId
            if track.Name == "ChargeWarn" then
                altIdle:Play(0.3)
            end
            if track.Name == "ChargeRun" then
                altIdle:Stop(0.1)
                Drop:Play(0.1)
                Drop:AdjustSpeed(2)
                task.wait(0.2) --
                Throw:Play(0.1)
                track.Stopped:Once(function() Throw:AdjustSpeed(1) Throw:Stop(0.3) end)
                task.wait(0.3) --
                if Throw.IsPlaying then Throw:AdjustSpeed(0) end
                task.wait(1) --
                Drop:AdjustSpeed(1)
            end
            if track.Name == "climb" then
                DropClimb:Play(0.1)
                DropSpeedSyncTarget = track
                track.Stopped:Once(function() DropSpeedSyncTarget = nil DropClimb:Stop(0.1) end)
            end
            if id == "rbxassetid://70986601618000" or id == "rbxassetid://107726503285204" or id == "rbxassetid://96797613203013" then
                (math.random(1, 2) == 1 and ServerHammerAnim or Throw):Play(0.1)
            end
            if id == "rbxassetid://139011230058197" then -- grab rush
                Drop:Play(0.1)
                Drop:AdjustSpeed(2)
                task.wait(0.1) --
                Throw:Play(0.1) 
                task.wait(1) --
                Drop:AdjustSpeed(1)
            end
            if id == "rbxassetid://134751042746502" or id == "rbxassetid://97281594393706" then -- grab 
                Throw:Play(0.1) 
            end
            if id == "rbxassetid://89703186757372" then -- kill
                task.wait(0.25)--
                Throw:Play(0.1)
                task.wait(0.25)--
                Throw:Play(0.1)
            end
        end)
    end

    -- stupid detail
    local function headnervsss(player)
        local m = player:FindFirstChild("OverlayModel")
        while player.Parent and m.Parent do
            task.wait(math.random()*2)

            local mot = m.MainHead.Joint
            local orig = mot.C1
            local pos = orig.Position

            local sx = orig.Rotation.X + math.deg((math.random())*-0.153)
            local sy = orig.Rotation.Y + math.deg((math.random()-0.153)*0.153)
            local sz = orig.Rotation.Z + math.deg((math.random()-0.153)*0.153)
            mot.C1 = CFrame.new(pos) * CFrame.Angles(math.rad(sx), math.rad(sy), math.rad(sz))
            task.wait(0.1)

            local t0 = tick()
            while true do
                local t = math.min((tick()-t0)/0.4, 1)
                local e = 1-(1-t)^3

                local ix = orig.Rotation.X + (sx - orig.Rotation.X) * (1-e)
                local iy = orig.Rotation.Y + (sy - orig.Rotation.Y) * (1-e)
                local iz = orig.Rotation.Z + (sz - orig.Rotation.Z) * (1-e)

                mot.C1 = CFrame.new(pos) * CFrame.Angles(math.rad(ix), math.rad(iy), math.rad(iz))

                if t>=1 then break end
                task.wait()
            end
            mot.C1 = orig
        end
    end
    task.spawn(function() headnervsss(player) end)

    -- sounds and stuff...
    player.DescendantAdded:Connect(function(desc)
        -- if desc:GetFullName():find(".FOVMultiplier") then return end
        -- print(desc.ClassName, desc:GetFullName())

        if desc.Name == "Rolling" then desc:Destroy() end -- NO ROLL VELOC
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
        if not desc.Parent or not desc.Parent.Parent then return end
        if desc:GetAttribute("IsMyCloneToIgnore") then return end
        local path = desc:GetFullName()
        --print(path..", "..desc.SoundId)
        
        local function playCopy(sound)
            local clone = sound:Clone()
            clone:SetAttribute("IsMyCloneToIgnore", true)
            clone.Parent = sound.Parent
            clone.Volume = 0.25 + sound.Volume
            clone.PlaybackSpeed = 1
            clone.TimePosition = 0
            clone.PlaybackRegion = NumberRange.new(0, 0)
            clone.LoopRegion = NumberRange.new(0, 0)
            clone:Play()
            clone.Ended:Once(function() clone:Destroy() end)
            game.Debris:AddItem(clone, 12)
        end
        
        local player = desc.Parent.Parent
        if player and player:IsA("Model") then
            if desc.SoundId == player.Climb.Audio_ground_slam.SoundId then
                -- play Audio_ground_slam
                playCopy(desc)
                -- other
                desc.SoundId = game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Amy.Uppercut.SoundId
                playCopy(desc)
                return
            end

            if path:find(".swings") or path:find(".PizzafaceLa") or path:find(".charge sound") then
                desc.SoundId = game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.EXE.Swing.SoundId
                playCopy(desc)
                desc.SoundId = game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Amy.snd_swing.SoundId
                playCopy(desc)
                desc.SoundId = _G.CrazyAmy_AttackSounds[math.random(1, #_G.CrazyAmy_AttackSounds)]
                desc.Name = "AmySpeech"
                playCopy(desc)
                task.wait() desc:Destroy()
                return
            end

            if path:find("stun") or path:find("Stun") or (desc.Name == "Sound" and player:GetAttribute("StunDur") > 0.1) then -- Stun
                while desc.Parent:FindFirstChild("AmySpeech") do desc.Parent:FindFirstChild("AmySpeech"):Destroy() end
                desc.SoundId = _G.CrazyAmy_StunSounds[math.random(1, #_G.CrazyAmy_StunSounds)]
                desc.Name = "AmySpeech"
                playCopy(desc)
                task.wait() desc:Destroy()
                return
            end
            
            if path:find(".Downed") or (path:find(".Default") and path:find("Line")) then
                while desc.Parent:FindFirstChild("AmySpeech") do desc.Parent:FindFirstChild("AmySpeech"):Destroy() end
                desc.SoundId = _G.CrazyAmy_DownedSounds[math.random(1, #_G.CrazyAmy_DownedSounds)]
                desc.Name = "AmySpeech"
                playCopy(desc)
                task.wait() desc:Destroy()
                return
            end
            
            if path:find("lmb") or path:find("LMB") then desc:Destroy() end

            if _G.CrazyAmy_SoundsForID[desc.SoundId] then 
                desc.SoundId = _G.CrazyAmy_SoundsForID[desc.SoundId]
                playCopy(desc)
                desc:Stop()
            end
            
            if _G.CrazyAmy_SoundsForName[desc.Name] then 
                desc.SoundId = _G.CrazyAmy_SoundsForName[desc.Name]
                playCopy(desc)
                desc:Stop() 
            end
        end
    end)

    print("[CrazyAmy] Updating finished for", player.Name .. "!")
end

local function onPlayerAdded(player)
    -- Check if they already spawned in
    if player.Character then tryUpdatePlayer(player.Character) end
    -- Listen for the player (re)spawning
    _G.CrazyAmyCharacterAddedConn = _G.CrazyAmyCharacterAddedConn or {}
    if _G.CrazyAmyCharacterAddedConn[player.Name] then
        _G.CrazyAmyCharacterAddedConn[player.Name]:Disconnect()
        print("[CrazyAmy] Previous CrazyAmyCharacterAddedConn disconnected for", player.Name)
    end
    _G.CrazyAmyCharacterAddedConn[player.Name] = player.CharacterAdded:Connect(tryUpdatePlayer) 
end

for _, player in game.Players:GetPlayers() do onPlayerAdded(player) end

if _G.CrazyAmyPlayerAddedConn then
    _G.CrazyAmyPlayerAddedConn:Disconnect()
    print("[CrazyAmy] Previous CrazyAmyPlayerAddedConn disconnected")
end
_G.CrazyAmyPlayerAddedConn = game.Players.PlayerAdded:Connect(onPlayerAdded)


local function myAsset(fileName)
    local cachePath = "cache/lil2kki/CrazyAmy/" .. fileName
    if isfile(cachePath) then return getcustomasset(cachePath) end
    local success, result = pcall(function()
        return game:HttpGet("https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/CrazyAmy/assets/" .. fileName) 
    end)
    if success and result then
        writefile(cachePath, result)
        print("[CrazyAmy] Downloaded " .. fileName, "into", cachePath)
        return getcustomasset(cachePath)
    else
        warn("[CrazyAmy] Failed to load " .. fileName)
        return nil
    end
end

table.insert(_G.CrazyAmy_AttackSounds, myAsset("AttackSounds" .. 2 .. ".mp3"))
table.insert(_G.CrazyAmy_AttackSounds, myAsset("AttackSounds" .. 3 .. ".mp3"))

_G.CrazyAmy_SoundsForName = {
    ["kolossos step 1"] = myAsset("DeltaruneFootsteps1.mp3"),
    ["kolossos step 2"] = myAsset("DeltaruneFootsteps2.mp3"),
    ["kolossos step 3"] = myAsset("DeltaruneFootsteps2.mp3"),
}

local themes = game:GetService("ReplicatedStorage"):FindFirstChild("ChaseThemes", true):FindFirstChild("Kolossos", true)

themes.Default.TerrorRadius.SoundId = myAsset("TerrorRadius.mp3")
themes.Default.TerrorRadius.PlaybackRegion = NumberRange.new(0, 0)
themes.Default.TerrorRadius.LoopRegion = NumberRange.new(0, 0)
themes.Default.TerrorRadius.PlaybackSpeed = 1

themes.Default.NormalChase.SoundId = myAsset("NormalChase_alt.mp3")
themes.Default.NormalChase.PlaybackRegion = NumberRange.new(0, 0)
themes.Default.NormalChase.LoopRegion = NumberRange.new(0, 0)

themes.Default.LastLifeChase.SoundId = myAsset("LastLifeChase.mp3")
themes.Default.LastLifeChase.PlaybackRegion = NumberRange.new(0, 0)
themes.Default.LastLifeChase.LoopRegion = NumberRange.new(0, 0)

for i = 1, 20 do table.insert(_G.CrazyAmy_StunSounds, myAsset("StunSounds" .. i .. ".mp3")) end
for i = 1, 15 do table.insert(_G.CrazyAmy_DownedSounds, myAsset("DownedSounds" .. i .. ".mp3")) end
