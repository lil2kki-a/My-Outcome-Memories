print("[Cream.LMS for 2011x] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end

-- storage animator set
local Animate = game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE["2011x"]:FindFirstChild("Animate", true)
local CreamAnimate = game.ReplicatedStorage:FindFirstChild("Characters", true):FindFirstChild("Cream", true):FindFirstChild("Animate", true):Clone()
CreamAnimate.Parent = Animate.Parent
Animate:Destroy()

CreamAnimate.Anims.Default.Walk:Clone().Parent = CreamAnimate.Anims
CreamAnimate.Anims.Walk.Name = "SelectPose" -- rename clone

CreamAnimate.Anims.Canon.Idle:Clone().Parent = CreamAnimate.Anims
CreamAnimate.Anims.Idle.AnimationId = "rbxassetid://101475077691415"
CreamAnimate.Anims.Idle.Name = "ResultPose" -- rename clone

CreamAnimate.Anims.Canon.Name = "Invis"

CreamAnimate.Anims.Fall:Clone().Parent = CreamAnimate.Anims.Invis
CreamAnimate.Anims.Invis.Fall.Name = "Run"-- rename clone

CreamAnimate.Anims.Invis.Walk:Destroy()
CreamAnimate.Anims.Fall:Clone().Parent = CreamAnimate.Anims.Invis
CreamAnimate.Anims.Invis.Fall.Name = "Walk"-- rename clone

CreamAnimate.Anims.Invis.Idle:Destroy()
CreamAnimate.Anims.HealLoop:Clone().Parent = CreamAnimate.Anims.Invis
CreamAnimate.Anims.Invis.HealLoop.Name = "Idle"-- rename clone

CreamAnimate.Anims.alt:Clone().Parent = CreamAnimate.Anims
CreamAnimate.Anims.alt.Name = "Rage" -- rename clone

CreamAnimate.Anims.Summon:Clone().Parent = CreamAnimate.Anims
CreamAnimate.Anims.Summon.Name = "TeleportAttack" -- rename clone

-- RES_Screen winscreen anim 
if not isfile("cache/lil2kki/Cream.LMS/WinScreen.mp3") then writefile("cache/lil2kki/Cream.LMS/WinScreen.mp3", game:HttpGet(
    "https://github.com/lil2kki-a/My-Outcome-Memories/raw/refs/heads/main/Cream.LMS/assets/WinScreen.mp3"
)) end
local RES_ScreenTheme = getcustomasset("cache/lil2kki/Cream.LMS/WinScreen.mp3")
if _G.Cream2011xRESScreenAddedConn then _G.Cream2011xRESScreenAddedConn:Disconnect() print("[Cream.LMS for 2011x] Previous Cream2011xRESScreenAddedConn disconnected") end
_G.Cream2011xRESScreenAddedConn = workspace.ChildAdded:Connect(function(child)
	print(child)
	if child.Name ~= "RES_Screen" then warn("Name") return end
    local EXE = workspace.GameProperties.EXE
    if EXE:GetAttribute("Character") ~= "2011x" then return end
    if (EXE:GetAttribute("Skin") ~= "Default") and (EXE:GetAttribute("Skin") ~= "miku") then return end
    local map = child:WaitForChild("2011x", 30) -- wait TVs part
	if not map then warn("map") return end
    game:GetService("Lighting").Atmosphere.Color = Color3.new(0, 0, 0)
    game:GetService("Lighting").Atmosphere.Decay = Color3.new(0, 0, 0)
    map.Theme.SoundId = RES_ScreenTheme
    map.Map:Destroy()
    local exe = child:WaitForChild("", 30) -- yea just empty name
    exe.Humanoid.Animator:LoadAnimation(CreamAnimate.Anims.Revive):Play()
    local track = exe.Humanoid.Animator:LoadAnimation(CreamAnimate.Anims.HealLoop)
    track:Play(3)
    track:AdjustSpeed(0.25)
end)

-- storage Cream template
local Default = game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE["2011x"]:FindFirstChild("Skins", true).Default

local Cream = --game:GetObjects("rbxassetid://130430011241692")[1]--
game.ReplicatedStorage.ClientAssets.Characters.Survivors.Cream.Skins.Default:Clone()
Cream.Name = Default.Name
Cream.Parent = Default.Parent
Default:Destroy()

if Cream then -- setup creammm
    local function find(name) return Cream:FindFirstChild(name, true) end
    -- Material.Slate
    for _, v in ipairs(Cream:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Slate
        end
    end
    -- red dots :3
    local thatslikeevilandscary = game:GetObjects("rbxassetid://120086931957772")[1]
    local eyeNames = {{"Eye1","eye1"}, {"Eye2","eye2"}}
    for _, pair in ipairs(eyeNames) do
        local srcPart = thatslikeevilandscary:FindFirstChild(pair[1], true)
        local dstPart = Cream:FindFirstChild(pair[2], true)
        if srcPart and dstPart then
            dstPart.Material = Enum.Material.Neon
            dstPart.Color = Color3.fromRGB(0,0,0)
            dstPart.Transparency = 1
            dstPart.Size = dstPart.Size / 3
            for _, child in ipairs(srcPart:GetChildren()) do
                if child:IsA("ParticleEmitter") or child:IsA("Attachment") then
                    child.Parent = dstPart
                    if child.Name == "YiSang" then child:Destroy() end
                end
            end
            for _, child in ipairs(dstPart:GetDescendants()) do
                if child:IsA("ParticleEmitter") then
                    child.LockedToPart = true
                    if child.Name == "bubble" then 
                        child.LightEmission = 0.1
                        child.LightInfluence = 0.1
                    end
                end
            end
            srcPart.Part.ParticleEmitter.Parent = dstPart.Attachment
            dstPart.Attachment.ParticleEmitter.LockedToPart = true
        end
    end
    thatslikeevilandscary:Destroy()
    -- eyes
    local eyes = find("eyes")
    if eyes and eyes:IsA("BasePart") then
        eyes.Material = Enum.Material.Neon
        eyes.Color = Color3.new(0, 0, 0)
    end
    -- dress..
    local dress = find("dress")
    dress.Material = Enum.Material.Sandstone
    -- blood on muzzle :3
    local muzzle = find("muzzle")
    local drip = game:GetObjects("rbxassetid://84762690015926")[1]
    drip.Parent = muzzle
    drip.UVScale = Vector2.new(1.5, 1)
    drip.Color3 = Color3.new(163, 163, 163)
    --- blooooddd all the mess
    local function addDecal(parent, face, textureId, rotation, uvOffset, uvScale)
        local decal = Instance.new("Decal")
        decal.Face = face
        decal.Texture = "rbxassetid://" .. textureId
        decal.Rotation = rotation or 0
        decal.UVOffset = uvOffset or Vector2.new(0, 0)
        decal.UVScale = uvScale or Vector2.new(1, 1)
        decal.Parent = parent
        return decal
    end
    local function addDecalAllFaces(parent, textureId)
        addDecal(parent, Enum.NormalId.Front, textureId)--"107953383542820")
        addDecal(parent, Enum.NormalId.Bottom, textureId)-- "107953383542820")
        addDecal(parent, Enum.NormalId.Top, textureId)-- "107953383542820")
        addDecal(parent, Enum.NormalId.Back, textureId)-- "107953383542820")
        addDecal(parent, Enum.NormalId.Left, textureId)-- "107953383542820")
        addDecal(parent, Enum.NormalId.Right, textureId)-- "107953383542820")
    end
    if find("Sphere.036") then addDecal(find("Sphere.036"), Enum.NormalId.Front, "107953383542820") end
    addDecal(dress, Enum.NormalId.Front, "70687582477902")
    addDecal(dress, Enum.NormalId.Left, "70687582477902")-- )
    addDecal(dress, Enum.NormalId.Right, "70687582477902")-- "107953383542820")
    --addDecalAllFaces(dress, "70687582477902")
    if find("rs") then for _, v in ipairs(find("rs"):GetDescendants()) do
        if v:IsA("BasePart") then addDecalAllFaces(v, "7276344647") end
        if v:IsA("BasePart") then addDecalAllFaces(v, "107953383542820") end
        if v:IsA("BasePart") and (math.random() < 0.3) then addDecalAllFaces(v, "1694131993") end
    end end
    if find("ls") then for _, v in ipairs(find("ls"):GetDescendants()) do
        if v:IsA("BasePart") then addDecalAllFaces(v, "7276344647") end
        if v:IsA("BasePart") then addDecalAllFaces(v, "107953383542820") end
        if v:IsA("BasePart") and (math.random() < 0.3) then addDecalAllFaces(v, "1694131993") end
    end end
    if find("LEar2") then addDecalAllFaces(find("LEar2"), "7276344647") end
    if find("REar2") then addDecalAllFaces(find("REar2"), "70687582477902") end
    -- old cream
    if find("head") then for _, v in ipairs(find("head"):GetDescendants()) do
        if v:IsA("BasePart") then
            if v.Name == ("Sphere.017") then 
                addDecal(v, Enum.NormalId.Back, "9893625715")
                addDecal(v, Enum.NormalId.Back, "14799161405")
                addDecal(v, Enum.NormalId.Back, "1694131993")
            end
            if v.Name == ("Sphere.004") then 
                addDecal(v, Enum.NormalId.Back, "9893625715") 
                addDecal(v, Enum.NormalId.Back, "14799161405") 
            end
        end
    end end
        
end

local mikuAnims = game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE["2011x"].CustomAnimation.miku
local CreamAnims = CreamAnimate.Anims:Clone()
CreamAnims.Parent = mikuAnims.Parent
CreamAnims.Name = mikuAnims.Name
mikuAnims:Destroy()

local miku = game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE["2011x"]:FindFirstChild("Skins", true).miku

local ModernMinonCream = game:GetObjects("rbxassetid://107766817063342")[1]
ModernMinonCream.Name = miku.Name
ModernMinonCream.Parent = miku.Parent
miku:Destroy()

-- Cream Icons
while game.ReplicatedStorage.ClientAssets.Icons:FindFirstChild("2011x") do
    game.ReplicatedStorage.ClientAssets.Icons["2011x"]:Destroy()
    warn("[Cream.LMS for 2011x] Old icons removed")
end
local icons = game.ReplicatedStorage.ClientAssets.Icons.Cream:Clone()
icons.Parent = game.ReplicatedStorage.ClientAssets.Icons
icons.Name = "2011x"
icons.Eyes:Destroy()

_G.Cream2011xSkin_SoundIDs = {}
_G.Cream2011xSkin_StunSounds = {}
_G.Cream2011xSkin_DownedSounds = {}
_G.Cream2011xSkin_AttackSounds = {}
_G.Cream2011xSkin_UnleashedSounds = {}

local function tryUpdatePlayer(player)
    if not player:IsA("Model") then return end
    
    if player:GetAttribute("Team") == "EXE" then 
        workspace.GameProperties.EXE:SetAttribute("Character", player:GetAttribute("Character"))
        workspace.GameProperties.EXE:SetAttribute("Skin", player:GetAttribute("Skin"))
    end

    if player:GetAttribute("Character") ~= "2011x" then return end
    if (player:GetAttribute("Skin") ~= "Default") and (player:GetAttribute("Skin") ~= "miku") then return end

    print("[Cream.LMS for 2011x] Prebuild updating Cream for " .. player.Name .. "...")

    if player:FindFirstChild("OverlayModel") then
        warn("[Cream.LMS for 2011x] Player already have OverlayModel, update cancelled")
        return
    end

    -- destroy bones
    pcall(function() player:WaitForChild("RootPart"):WaitForChild("waist", 3):Destroy() end)

    -- xd
    if not player:FindFirstChild("Health") then
        local Health = Instance.new("NumberValue")
        Health.Name = "Health"
        Health.Value = 100
        Health.Parent = player
        player.AttributeChanged:Connect(function(attr)
            if attr == "StunDur" or attr == "BurnDur" then
                local val = player:GetAttribute(attr)
                if val and val > 0 then
                    player.Health.Value = 100 - (val * 10)
                    if player:GetAttribute("State") ~= "rage" then player:SetAttribute("State", "alt") end
                elseif not val or val <= 0 then
                    player.Health.Value = 100
                    if not player:GetAttribute("State") ~= "rage" then player:SetAttribute("State", "default") end
                end
            end
        end)
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
    
    if player:WaitForChild("Animate") and player:WaitForChild("Humanoid") then
    
        if cheese then cheese:Destroy() end
        cheese = --game.ReplicatedStorage:FindFirstChild("Characters", true):FindFirstChild("Cream", true):FindFirstChild("cheese", true):Clone()
                    game:GetObjects("rbxassetid://123043898753438")[1]
        cheese.Parent = player
        for _, v in ipairs(cheese:GetDescendants()) do 
        	if v:IsA("BasePart") then
                v.CollisionGroup = "Players"
                v.CollisionGroupId = 3
                v.CanCollide = false
                v.CanTouch = false
            end
        end
        for _, v in ipairs(game.ReplicatedStorage:FindFirstChild("Characters", true):FindFirstChild("Cream", true):FindFirstChild("cheese", true).HumanoidRootPart:GetChildren()) do
        	v:Clone().Parent = cheese.HumanoidRootPart
        end

        local anims = game.ReplicatedStorage.ClientAssets.Characters.EXE["2011x"].scriptstuff.Animate.Anims

        local CreamAnimateModule = loadstring(game:HttpGet("https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/Cream.LMS/CreamAnimate.lua"))()
        local CreamAnimate = CreamAnimateModule.setup(player, anims)

        cheese.Parent = workspace
        
        local CrimsonSwing1 = Instance.new("Animation")
        CrimsonSwing1.AnimationId = "rbxassetid://92001844516809"
        local AttackSwing1 = player.Humanoid.Animator:LoadAnimation(CrimsonSwing1)

        local CrimsonSwing2 = Instance.new("Animation")
        CrimsonSwing2.AnimationId = "rbxassetid://97831046595914"
        local AttackSwing2 = player.Humanoid.Animator:LoadAnimation(CrimsonSwing2)
        
        local GRIDDYa = Instance.new("Animation")
        GRIDDYa.AnimationId = "rbxassetid://88275250559180"
        local GRIDDY = player.Humanoid.Animator:LoadAnimation(GRIDDYa)
        
        local DropkickA = Instance.new("Animation")
        DropkickA.AnimationId = "rbxassetid://135664457733929"
        local Dropkick = player.Humanoid.Animator:LoadAnimation(DropkickA)

        local StrangledA2 = Instance.new("Animation")
        StrangledA2.AnimationId = "rbxassetid://129100858003684"
        local Strangled2 = player.Humanoid.Animator:LoadAnimation(StrangledA2)

        local StunAnims = {} -- head animations...
        StunAnims["Stun"] = player.Humanoid.Animator:LoadAnimation(anims.Parent.Parent.Parent.CustomAnimation.RETRO.Stun)
        StunAnims["StunEnd"] = player.Humanoid.Animator:LoadAnimation(anims.Parent.Parent.Parent.CustomAnimation.RETRO.StunEnd)
        StunAnims["Stunloop"] = player.Humanoid.Animator:LoadAnimation(anims.Parent.Parent.Parent.CustomAnimation.RETRO.Stunloop)

        player.Humanoid.Animator.AnimationPlayed:Connect(function(track)
            --print("PLAYED: "..track.Name.." - "..track.Animation.AnimationId)
            local id = track.Animation.AnimationId
            if StunAnims[track.Name] then
                StunAnims[track.Name].Name = "Cream"..track.Name
                StunAnims[track.Name]:Play(0.1)
                track.Stopped:Once(function() StunAnims[track.Name]:Stop(0.1) end)
            end
            if id == "rbxassetid://139392352153071" or id == "rbxassetid://96230691728678" or id == "rbxassetid://131225817305683" then
                renameByAttribute("newName")
                local anim = math.random(1, 2) == 1 and AttackSwing1 or AttackSwing2
                anim:Play(0.2)
                anim.Stopped:Once(function()
                    local tracks = player.Humanoid.Animator:GetPlayingAnimationTracks()
                    anim:Stop(0.2)
                    task.wait(0.2)
                    for i, a in ipairs(tracks) do if a and a.IsPlaying and (a.Name ~= anim.Name) and (a.Name ~= "Animation") then 
                        a:Stop()
                        task.wait(0.02)
                        a:Play(0.2) 
                    end end
                    renameByAttribute("oldName")
                end)
            end
            if id == "rbxassetid://78545771079470" then -- hype
                GRIDDY:Play(0.1)
                track.Stopped:Once(function() GRIDDY:Stop(0.1) end)
            end
            if id == "rbxassetid://98535439009926" then -- Strangled
                renameByAttribute("oldName")
                Strangled2:Play(0.1)
                Strangled2:AdjustSpeed(0.2)
                track.Stopped:Once(function() Strangled2:Stop(0.1) end)
            end
            if id == "rbxassetid://130430187499549" then -- kill
                renameByAttribute("oldName")
                task.wait(0.25)
                Dropkick:Play(0.1)
                Dropkick:AdjustSpeed(6)
                player:SetAttribute("KillAnim", true)
                track.Stopped:Once(function() player:SetAttribute("KillAnim", nil) end)
            end
        end)

        print("[Cream.LMS for 2011x] Cream animatior added!")
    end

    print("[Cream.LMS for 2011x] Character ready! Updating " .. player:GetFullName() .. "...")
    
    -- Char Model
    local ogHRP = player:FindFirstChild("HumanoidRootPart", true)
    if not ogHRP then return end

    for _, v in ipairs(player:GetDescendants()) do
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
                            if ov:IsA("ParticleEmitter") then ov.Enabled = (v.Transparency < 0.5) end
                            if ov:IsA("Trail") then ov.Enabled = (v.Transparency < 0.5) end -- old cream
                        end
                    end
                    if cheese then cheese:SetAttribute("Pause", (v.Transparency > 0.5)) end
                end
            	task.wait(0.1)
            end)
        end
        if v:IsA("SurfaceGui") then v.Enabled = false end
        if v:IsA("SurfaceAppearance") then v:Destroy() end
        if v:IsA("Decal") then v:Destroy() end
    end

    -- Overlay Model
    local OverlayModel = game:GetService("ReplicatedStorage").ClientAssets.Characters.EXE["2011x"]["Skins"][player:GetAttribute("Skin")]:Clone()
    OverlayModel.Name = "OverlayModel"
    OverlayModel.Parent = player

    local myHRP = OverlayModel:FindFirstChild("HumanoidRootPart", true)
    if not myHRP then OverlayModel:Destroy() return end

    for _, v in ipairs(OverlayModel:GetDescendants()) do
        -- if v:IsA("Humanoid") then v.EvaluateStateMachine = false end
        if v:IsA("Humanoid") then v:Destroy() end
        if v:IsA("Animator") then v:Destroy() end
        if v:IsA("BasePart") then
            v.CollisionGroup = "Players"
            v.CollisionGroupId = 3
            v.CanCollide = false
            v.CanTouch = false
            if v.Transparency > 0 then v:SetAttribute("IgnoreTransparency", true) end 
        end
    end

    -- yooo (im stupidoo)
    local hrpY = -1.9
    local weld = Instance.new("Weld")
    weld.Part0 = ogHRP
    weld.Part1 = myHRP
    weld.C0 = CFrame.new()
    weld.C1 = CFrame.new(0, -hrpY, 0) 
    weld.Parent = myHRP
    myHRP:PivotTo(ogHRP.CFrame * CFrame.new(0, hrpY, 0))

    -- remap for steve swing anims
    rename("waist", "Waist")
    rename("Right Sleeve", "RArm1")
    rename("Cylinder.013", "RArm2")
    rename("Cylinder.014", "RArm3")
    rename("Cylinder.017", "RArm4")
    rename("Right Hand", "RHand")
    rename("Left Sleeve", "LArm1")
    rename("Cylinder.023", "LArm2")
    rename("Cylinder.022", "LArm3")
    rename("Left Hand", "LHand")
    rename("Sphere.029", "waist")
    renameByAttribute("oldName") -- keep old untill swing anim used

    -- add state (animatior needs it)
    if not player:GetAttribute("State") then 
        warn("[Cream.LMS for 2011x] Added default state attribute for", player.Name) 
        player:SetAttribute("State", "default") 
    end

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
        -- print(path..", "..desc.SoundId)
        
        local function playCopy(sound)
            local clone = sound:Clone()
            clone:SetAttribute("IsMyCloneToIgnore", true)
            clone.Parent = sound.Parent
            clone.Volume = 0.25 + sound.Volume
            clone.TimePosition = 0
            clone.PlaybackRegion = NumberRange.new(0, 0)
            clone:Play()
            clone.Ended:Once(function() clone:Destroy() end)
            game.Debris:AddItem(clone, 12)
            sound:Destroy()
        end

        if _G.Cream2011xSkin_SoundIDs[desc.SoundId] then desc.SoundId = _G.Cream2011xSkin_SoundIDs[desc.SoundId] end
        
        local player = desc.Parent.Parent
        if player and player:IsA("Model") and player:FindFirstChild("HumanoidRootPart") then
            if path:find(".Attack") then
                desc.SoundId = _G.Cream2011xSkin_AttackSounds[math.random(1, #_G.Cream2011xSkin_AttackSounds)]
                desc.Name = "CreamSpeech"
                playCopy(desc)
                return
            end
            if desc.SoundId == "rbxassetid://133207357151860" then -- Stun
                while desc.Parent:FindFirstChild("CreamSpeech") do desc.Parent:FindFirstChild("CreamSpeech"):Destroy() end
                desc.SoundId = _G.Cream2011xSkin_StunSounds[math.random(1, #_G.Cream2011xSkin_StunSounds)]
                desc.Name = "CreamSpeech"
                playCopy(desc)
                return
            end
            if path:find(".Downed") or (path:find(".Default") and path:find("Line")) then
                while desc.Parent:FindFirstChild("CreamSpeech") do desc.Parent:FindFirstChild("CreamSpeech"):Destroy() end
                desc.SoundId = _G.Cream2011xSkin_DownedSounds[math.random(1, #_G.Cream2011xSkin_DownedSounds)]
                desc.Name = "CreamSpeech"
                playCopy(desc)
                return
            end
            if path:find(".Caught") then
                while desc.Parent:FindFirstChild("CreamSpeech") do desc.Parent:FindFirstChild("CreamSpeech"):Destroy() end
                local dn = _G.Cream2011xSkin_DownedSounds
                local CaughtLines = {
                    dn[2], dn[5], dn[7], dn[8], dn[9], dn[12],
                    dn[10], dn[10],
                }
                desc.SoundId = CaughtLines[math.random(1, #CaughtLines)]
                desc.Name = "CreamSpeech"
                playCopy(desc)
                return
            end
            if path:find(".InvisLine") or desc.SoundId == "rbxassetid://79834195945787" then
                while desc.Parent:FindFirstChild("CreamSpeech") do desc.Parent:FindFirstChild("CreamSpeech"):Destroy() end
                desc.SoundId = _G.Cream2011xSkin_UnleashedSounds[math.random(1, #_G.Cream2011xSkin_UnleashedSounds)]
                desc.Name = "CreamSpeech"
                playCopy(desc)
                return
            end
            if _G.Cream2011xSkin_KillLines[desc.Name] then
                while desc.Parent:FindFirstChild("CreamSpeech") do desc.Parent:FindFirstChild("CreamSpeech"):Destroy() end
                desc.SoundId = _G.Cream2011xSkin_KillLines[desc.Name][math.random(1, #_G.Cream2011xSkin_KillLines[desc.Name])]
                desc.Name = "CreamSpeech"
                playCopy(desc)
                return
            end
        end
    end)

    if cheese then cheese.Parent = player end
    
    -- restart cam but as for Cream
    if game.Players.LocalPlayer.Name == player.Name then
        local lastCamCFrame = workspace.CurrentCamera.CFrame -- wait for camera first setup
        repeat task.wait(1) until workspace.CurrentCamera.CFrame ~= lastCamCFrame
        player.cam.Enabled = false
        player:SetAttribute("Character", "Cream") -- xd
        player.OverlayModel.Torso.Parent = player -- cam wants Torso and its inners
        player.cam.Enabled = true
        lastCamCFrame = workspace.CurrentCamera.CFrame -- wait for camera reset
        repeat task.wait(0.01) until workspace.CurrentCamera.CFrame ~= lastCamCFrame
        player:SetAttribute("Character", "2011x") -- huh
        player.Torso.Parent = OverlayModel
    end
    
    -- kill Cheese...
    if player:GetAttribute("Skin") ~= "miku" then player:AddTag("Cheeseless") end

    -- stupid detail
    local function headnervsss(player)
        local m = player:FindFirstChild("OverlayModel")
        while player.Parent and m.Parent do
            task.wait(math.random()*2+2)

            local mot = m.Torso.Body.Head
            local orig = mot.C1
            local pos = orig.Position

            local sx = orig.Rotation.X + math.deg((math.random())*-0.3)
            local sy = orig.Rotation.Y + math.deg((math.random()-0.3)*0.3)
            local sz = orig.Rotation.Z + math.deg((math.random()-0.3)*0.3)
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

    local reviveAnim = game:GetService("ReplicatedStorage").ClientAssets.Characters.Survivors.Cream.scriptstuff.Animate.Anims.Revive
    local ReviveTrack = player.Humanoid.Animator:LoadAnimation(reviveAnim)
    ReviveTrack.Priority = Enum.AnimationPriority.Core
    ReviveTrack:Play(0.5)

    print("[Cream.LMS for 2011x] Updating finished for", player.Name .. "!")
end

local function onPlayerAdded(player)
    -- Check if they already spawned in
    if player.Character then tryUpdatePlayer(player.Character) end
    -- Listen for the player (re)spawning
    _G.Cream2011xCharacterAddedConn = _G.Cream2011xCharacterAddedConn or {}
    if _G.Cream2011xCharacterAddedConn[player.Name] then
        _G.Cream2011xCharacterAddedConn[player.Name]:Disconnect()
        print("[Cream.LMS for 2011x] Previous Cream2011xCharacterAddedConn disconnected for", player.Name)
    end
    _G.Cream2011xCharacterAddedConn[player.Name] = player.CharacterAdded:Connect(tryUpdatePlayer) 
end

for _, player in game.Players:GetPlayers() do onPlayerAdded(player) end

if _G.Cream2011xPlayerAddedConn then
    _G.Cream2011xPlayerAddedConn:Disconnect()
    print("[Cream.LMS for 2011x] Previous Cream2011xPlayerAddedConn disconnected")
end
_G.Cream2011xPlayerAddedConn = game.Players.PlayerAdded:Connect(onPlayerAdded)

if _G.Cream2011xSkinTESTINGDUMMYConn then
    _G.Cream2011xSkinTESTINGDUMMYConn:Disconnect()
    print("[Cream.LMS for 2011x] Previous Cream2011xSkinTESTINGDUMMYConn disconnected")
end
_G.Cream2011xSkinTESTINGDUMMYConn = game.CollectionService:GetInstanceAddedSignal("TESTINGDUMMY"):Connect(tryUpdatePlayer)

local textReplacements = {
    ["Invisibility"] = "Hide 'N Seek",
    ["Rage Mode"] = "Playtime",
    ["2011x"] = " [CORRUPTED] ",
    ["2011x / X"] = " [CORRUPTED] ",
    ["Miku X"] = "Sark's Minion",
    ["sonic but .... bloody eyes .. fear"] = "[Info] Instance copied successfully.\n"
        .."[WARN] ReplicatedStorage missmatch!\n"
        .."[WARN] Unauthorized access!\n"
        .."> dont worry, thats just a way i can play :>\n"
        .."Syntax error."
}
local TextLabelNames = {
    CharName = true,
    CharDesc = true,
    ABName = true,
    selectedChar = true,
    char = true, -- vote screen (same names xd)
    SkinName = true,
}
local function hookLabel(desc)
    if not desc or not desc.Parent then return end
    if not desc:IsA("TextLabel") then return end
    if not TextLabelNames[desc.Name] then return end
    -- warn("[Cream.LMS for 2011x] Watching TextLabel: "..desc.Name)
    coroutine.wrap(function()
        while true do
            if not desc or not desc.Parent then 
                -- warn("[Cream.LMS for 2011x] Lost TextLabel to watch: "..desc:GetFullName()) 
                return 
            end
            if textReplacements[desc.Text] then desc.Text = textReplacements[desc.Text] end
            task.wait() -- heartbeat mayb
        end
    end)()
end
_G.CreamOn2011xGUIConn = _G.CreamOn2011xGUIConn or nil
if _G.CreamOn2011xGUIConn then  _G.CreamOn2011xGUIConn:Disconnect() _G.CreamOn2011xGUIConn = nil end
_G.CreamOn2011xGUIConn = game.Players.LocalPlayer:WaitForChild("PlayerGui").DescendantAdded:Connect(hookLabel)
for _, desc in ipairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetDescendants()) do hookLabel(desc) end
print("[Cream.LMS for 2011x] Listening for your GUI...")

local function myAsset(fileName)
    local cachePath = "cache/lil2kki/Cream.LMS///" .. fileName
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

local themes = game:GetService("ReplicatedStorage"):FindFirstChild("ChaseThemes", true):FindFirstChild("2011x", true)

themes.Default.Rage.SoundId = myAsset("RageXD.mp3")

themes.Default.TerrorRadius.SoundId = myAsset("TerrorRadius2.mp3")

themes.Default.NormalChase.SoundId = myAsset("NormalChase_alt.mp3")
themes.Default.NormalChase.PlaybackRegion = NumberRange.new(0, 0)
themes.Default.NormalChase.LoopRegion = NumberRange.new(0, 0)

themes.miku.NormalChase.SoundId = myAsset("TRIODARKMATTERS.mp3")
themes.miku.NormalChase.PlaybackRegion = NumberRange.new(0, 0)
themes.miku.NormalChase.LoopRegion = NumberRange.new(0, 0)

themes.Default.LastLifeChase.SoundId = myAsset("LastLifeChase_Overdrive.mp3")
themes.Default.LastLifeChase.PlaybackRegion = NumberRange.new(0, 0)
themes.Default.LastLifeChase.LoopRegion = NumberRange.new(0, 0)
themes.Default.LastLifeChase.PlaybackSpeed = 1 -- OM 0.1a special
themes.Default.LastLifeChase:SetAttribute("Eliminated", nil) -- no time pos jump on kill pls

_G.Cream2011xSkin_SoundIDs = {
    -- xd
}
_G.Cream2011xSkin_KillLines = {
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
_G.Cream2011xSkin_UnleashedSounds = { myAsset("Unleashed1.mp3"), myAsset("Unleashed2.mp3"), myAsset("Unleashed3.mp3"), }
for i = 1, 28 do table.insert(_G.Cream2011xSkin_StunSounds, myAsset("Stun" .. i .. ".mp3")) end
for i = 1, 14 do table.insert(_G.Cream2011xSkin_DownedSounds, myAsset("Down" .. i .. ".mp3")) end
for i = 1, 8 do table.insert(_G.Cream2011xSkin_AttackSounds, myAsset("Attack" .. i .. ".mp3")) end
