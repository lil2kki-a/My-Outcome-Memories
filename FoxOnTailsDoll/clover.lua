print("[FoxOnTailsDoll] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end

game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.Skins.Default:Destroy()
game.ReplicatedStorage.ClientAssets.Characters.Survivors.Tails.Skins.Default:Clone().Parent = 
game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.Skins

game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.scriptstuff.Animate:Destroy()
game.ReplicatedStorage.ClientAssets.Characters.Survivors.Tails.scriptstuff.Animate:Clone().Parent = 
game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.scriptstuff

game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.scriptstuff.Animate.Anims.Canon.Walk:Clone().Parent = 
game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.scriptstuff.Animate.Anims.Canon
game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.scriptstuff.Animate.Anims.Canon.Walk.Name = "Run"

while game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.scriptstuff.Animate.Anims:FindFirstChild("SelectPose")
do game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.scriptstuff.Animate.Anims:FindFirstChild("SelectPose"):Destroy() end
game.ReplicatedStorage.ClientAssets.Characters.Survivors.Tails.scriptstuff.Animate.Anims.Canon.Walk:Clone().Parent = 
game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.scriptstuff.Animate.Anims
game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.scriptstuff.Animate.Anims.Walk.Name = "SelectPose"

game.ReplicatedStorage.ClientAssets.WinScreens.TailsDoll.WinAnim.AnimationId = "rbxassetid://92259033776440" -- tails sit

local model = game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.Skins.Default

local function find(name) return model:FindFirstChild(name, true) end

while find("Tails") do find("Tails").Name = "bruh. ability input script brokes so i had to rename it" end

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
for _, v in ipairs(find("canon"):GetDescendants()) do
    if v.Name == "Union" then continue end -- black parts
    if v:IsA("BasePart") then addDecalAllFaces(v, "7276344647") end
    if v:IsA("BasePart") and (math.random() < 0.5) then addDecalAllFaces(v, "1694131993") end
end
for _, v in ipairs(find("Arm 1"):GetDescendants()) do
    if v:IsA("BasePart") then addDecalAllFaces(v, "7276344647") end
    if v:IsA("BasePart") and (math.random() < 0.5) then addDecalAllFaces(v, "1694131993") end
end
addDecal(model.Body, Enum.NormalId.Right, 10833044827)
addDecal(model.Body, Enum.NormalId.Right, 1694131993, 0, Vector2.new(0.1, 0.25))
addDecal(model.Body, Enum.NormalId.Top, 1694131993, 0,  Vector2.new(0.3, 0.1))
addDecal(model.bellyfur, Enum.NormalId.Right, 70687582477902)
addDecal(model.bellyfur, Enum.NormalId.Front, 14799183802, 0, Vector2.new(0.6, 0), Vector2.new(2, 0.7))
addDecal(model.bellyfur, Enum.NormalId.Bottom, 70687582477902)
addDecal(model.muzzle, Enum.NormalId.Front, 70687582477902)
addDecal(model.muzzle, Enum.NormalId.Right, 70687582477902)

-- details
for _, v in ipairs(model.Head:GetChildren()) do
    if v:IsA("BasePart") and v.Name == "MAD_HEAD" then v.Name = v.Name.."_PART" v.Transparency = 0 end
    if v:IsA("BasePart") and v.Name == "SAD_HEAD" then v.Name = v.Name.."_PART" end
end

local applycomestic = loadstring(game:HttpGet("https://github.com/lil2kki-a/My-Outcome-Memories/raw/HEAD/applycomestic.lua"))()
model:SetAttribute("EquippedCosmetics", "CLOVER,CLOVERHAT,BlueShoes,Watch,")
model:SetAttribute("Character", "Tails")
applycomestic(model)

if find("hair") then find("hair").Transparency = 1 end

-- custom animmmm
local function playSwing(model)
	local body = model:FindFirstChild("Body", true)
	local waist = model:FindFirstChild("waist", true)
	if not body or not waist then return end

	local rArm = body:FindFirstChild("Cylinder.010", true)
	local lArm = body:FindFirstChild("Left Arm", true)
	local head = body:FindFirstChild("Head", true)
	local torso = waist:FindFirstChild("Body", true)
	if not rArm or not lArm or not head or not torso then return end

    if model:GetAttribute("playSwing") then return end
    model:SetAttribute("playSwing", true)

	-- base C0 positionsss (originals have identity rotation)
	local rb = CFrame.new(0.3922, 0.5312, 0.1235)
	local lb = CFrame.new(-0.4071, 0.5312, 0.1235)
	local hb = CFrame.new(0, 0.8754, 0.1455)
	local wb = CFrame.new(0.0003, 0.0453, -0.0847)

	-- rest pose
	local oR, oL, oH, oW = rArm.C0, lArm.C0, head.C0, torso.C0

    local rad = math.rad
    local Ang = CFrame.Angles
	local kfs = {
		-- windup
		{0.06, rb*Ang(rad(-130),rad(-25),rad(15)), lb*Ang(rad(40),rad(-15),0), hb*Ang(rad(-10),rad(-20),0), wb*Ang(0,rad(-15),0)},
		-- strike
		{0.05, rb*Ang(rad(20),rad(50),rad(-15)), lb*Ang(rad(-10),rad(35),0), hb*Ang(rad(5),rad(20),0), wb*Ang(0,rad(25),0)},
		-- impact
		{0.04, rb*Ang(rad(55),rad(70),rad(-25)), lb*Ang(rad(-30),rad(50),0), hb*Ang(rad(10),rad(30),0), wb*Ang(0,rad(35),0)},
		-- follow through
		{0.06, rb*Ang(rad(85),rad(90),rad(-35)), lb*Ang(rad(-45),rad(55),0), hb*Ang(rad(15),rad(35),0), wb*Ang(0,rad(40),0)},
		-- recovery
		{0.12, oR, oL, oH, oW},
	}

	local cur = {rArm.C0, lArm.C0, head.C0, torso.C0}

	for _, kf in ipairs(kfs) do
		local dur, tR, tL, tH, tW = kf[1], kf[2], kf[3], kf[4], kf[5]
		local steps = math.max(1, math.floor(dur / 0.015))
		local st = dur / steps
		for i = 1, steps do
			local a = i / steps
			rArm.C0 = cur[1]:Lerp(tR, a)
			lArm.C0 = cur[2]:Lerp(tL, a)
			head.C0 = cur[3]:Lerp(tH, a)
			torso.C0 = cur[4]:Lerp(tW, a)
			task.wait(st)
		end
		rArm.C0, lArm.C0, head.C0, torso.C0 = tR, tL, tH, tW
		cur = {tR, tL, tH, tW}
	end

    model:SetAttribute("playSwing", nil)
end

-- player upd

local function tryUpdatePlayer(player)
    if not player:IsA("Model") then return end
    if player:GetAttribute("Character") ~= "TailsDoll" then return end
    if player:GetAttribute("Skin") ~= "Default" then return end

    print("[FoxOnTailsDoll] Prebuild updating model for " .. player.Name .. "...")

    if player:FindFirstChild("OverlayModel") then
        warn("[FoxOnTailsDoll] Player already have OverlayModel, update cancelled")
        return
    end
    
    if player:WaitForChild("Animate") and player:WaitForChild("Humanoid") then
    
        local Animate = game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.scriptstuff.Animate:Clone()
        Animate.Name = "Tails"..Animate.Name
        Animate.Parent = player
        Animate.Enabled = true

        function loadTrack(id)
            local anim = Instance.new("Animation")
            anim.AnimationId = id
            local track = player.Humanoid.Animator:LoadAnimation(anim)
            return track
        end
        function playWhileTrack(track, myTrack)
            myTrack:Play(0.1)
            track.Stopped:Once(function() myTrack:Stop(0.1) end)
            return myTrack
        end

        local ServerBrustHit = loadTrack("rbxassetid://75852355428865")

        local ForReachout = loadTrack("rbxassetid://75852355428865")
        
        local Strangled = player.Humanoid.Animator:LoadAnimation(Animate.Anims.Strangled)
        local StrangledR = player.Humanoid.Animator:LoadAnimation(Animate.Anims.StrangledR)
        local CanonIdle = player.Humanoid.Animator:LoadAnimation(Animate.Anims.Canon.Idle)
        local Glide = player.Humanoid.Animator:LoadAnimation(Animate.Anims.Glide)
        local Jump = player.Humanoid.Animator:LoadAnimation(Animate.Anims.Jump)
        local Revive = player.Humanoid.Animator:LoadAnimation(Animate.Anims.Revive)

        local SitTails = loadTrack("rbxassetid://132926716277265")
        local Pipebomb = loadTrack("rbxassetid://137946742808216")
        local Cory = loadTrack("rbxassetid://118810363050448")

        player.Humanoid.Animator.AnimationPlayed:Connect(function(track)
            --            print("PLAYED: "..track.Name.." - "..track.Animation.AnimationId)
            local id = track.Animation.AnimationId
            if id == "rbxassetid://92259033776440" then playWhileTrack(track, SitTails) end
            if id == "rbxassetid://112656139256072" then playWhileTrack(track, Cory) end
            if id == "rbxassetid://100732265533480" then playWhileTrack(track, Pipebomb):AdjustSpeed(0.815) end
            if track.Name == "DoubleJump" then 
                Jump:Play(0.1)
                Jump:AdjustSpeed(2)
            end
            if (track.Name == "Glide" or id == player.Glide.ANIMS.Glide.AnimationId) and Glide.Animation.AnimationId ~= track.Animation.AnimationId then -- Glide
                local Flying = game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Flying:Clone()
                Flying.Parent = player.HumanoidRootPart
                Flying:Play()
                Glide:Play(0.1)
                Glide:AdjustSpeed(1.5)
                track.Stopped:Once(function() 
                    Glide:Stop(1)
                    Flying.PlaybackSpeed = 0.75
                    task.wait(0.25)
                    Flying.PlaybackSpeed = 0.5
                    task.wait(0.25)
                    Flying.PlaybackSpeed = 0.35
                    task.wait(0.25)
                    Flying:Destroy() 
                end)
            end
            if id == "rbxassetid://138468646867674" or id == "rbxassetid://101931899083669" then -- swings
                if math.random() < 0.2 then
                    ServerBrustHit:Play(0.1)
                    ServerBrustHit:AdjustSpeed(2)
                --elseif math.random() > 0.3 then
                else 
                    playSwing(player)
                    player:FindFirstChild("MAD_HEAD_PART", true).Transparency = 0
                    return 
                end -- keep MAD_HEAD_PART
            end
            if id == "rbxassetid://107665101569245" then -- kill
                Strangled:Play(0.1)
                Strangled:AdjustSpeed(0.1)
                track.Stopped:Once(function() Strangled:Stop(0.1) end)
                return -- keep MAD_HEAD_PART
            end
            if id == "rbxassetid://85130598698132" then -- reachout step1
                --huh
                ForReachout:Play(0.1)
                task.wait(1)
                ForReachout:AdjustSpeed(0)
            end
            if id == "rbxassetid://87184553255122" then -- reachout step2
                track.Stopped:Once(function() ForReachout:Stop(0.1) end)
                task.wait(0.5)
                if not track.IsPlaying then ForReachout:Stop(0.1) end
            end
            if track.Name == "Walk" or track.Name == "Run" then ForReachout:Stop(0.1) end
            if track.Name == "Animation" then
                -- try to sync server anims
                if game.Players.LocalPlayer.Name ~= player.Name then
                    for _, Anim in ipairs(player.Animate.Anims:GetDescendants()) do
                        if not Anim:IsA("Animation") then continue end
                        if id ~= Anim.AnimationId then continue end
                        -- print("^ Thats", Anim:GetFullName())
                        local MyAnim = Animate:FindFirstChild(Anim.Parent.Name, true):FindFirstChild(Anim.Name)
                        local TempTrack = player.Humanoid.Animator:LoadAnimation(MyAnim)
                        TempTrack:Play(0.1)
                        TempTrack:AdjustSpeed(track.Speed)
                        track.Stopped:Once(function() TempTrack:Stop(0.1) end)
                        return
                    end
                end
                -- handle MAD_HEAD_PART Transparency
                track.Stopped:Once(function()
                    task.wait(0.1)
                    player:FindFirstChild("MAD_HEAD_PART", true).Transparency = 0
                end)
                player:FindFirstChild("MAD_HEAD_PART", true).Transparency = 1
            end
        end)

        local StrangledR = player.Humanoid.Animator:LoadAnimation(Animate.Anims.StrangledR)
        player.AttributeChanged:Connect(function(attr)
            if attr == "StunDur" or attr == "BurnDur" then
                local val = player:GetAttribute(attr)
                if val and val > 0 then
                	if player:GetAttribute("State") == "default" then task.spawn(function()
                        StrangledR:Play(0.1)
                        StrangledR:AdjustSpeed(1.51)
                        task.wait(0.9)
                        StrangledR:Stop(0.3)
                	end) end
                    player:SetAttribute("State", "alt")
                elseif not val or val <= 0 then
                    player:SetAttribute("State", "default")
                end
            end
        end)

        print("[FoxOnTailsDoll] Tails animatior added!")
    end

    print("[FoxOnTailsDoll] Character ready! Updating " .. player:GetFullName() .. "...")
    
    -- Char Model
    local ogHRP = player:FindFirstChild("HumanoidRootPart", true)
    if not ogHRP then return end

    for _, v in ipairs(player:GetDescendants()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v:SetAttribute("HiddenAway", "FOR TAILS")
            v:SetAttribute("doesntcount", true)
            v.Color = Color3.new(0/255, 0/255, 0/255)
            v.Material = Enum.Material.Neon
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
            end)
        end
        if v:IsA("SurfaceGui") then v.Enabled = false end
        if v:IsA("SurfaceAppearance") then v:Destroy() end
    end

    -- Overlay Model
    local OverlayModel = game.ReplicatedStorage.ClientAssets.Characters.EXE.TailsDoll.Skins.Default:Clone()
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
    local hrpY = -1.4
    local weld = Instance.new("Weld")
    weld.Part0 = ogHRP
    weld.Part1 = myHRP
    weld.C0 = CFrame.new()
    weld.C1 = CFrame.new(0, -hrpY, 0) 
    weld.Parent = myHRP
    myHRP:PivotTo(ogHRP.CFrame * CFrame.new(0, hrpY, 0))

    pcall(function()
    	-- retarget camera
        player.Waist.MainBody.Part0 = OverlayModel.waist
        player.MainBody.Head.Part0 = OverlayModel.Head
    	-- effects pos
        player:FindFirstChild("DiamondPOS", true).Parent = OverlayModel.canon.Cylinder
        player:FindFirstChild("ReachOutVFXA", true).Parent = OverlayModel.canon.Cylinder
        player:FindFirstChild("RootAttachment", true).Parent = OverlayModel.canon.Cylinder
    end)

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
        if desc.ClassName == "Attachment" then desc.Parent = OverlayModel.canon.Cylinder end
        if desc.ClassName == "ParticleEmitter" then desc.Parent = OverlayModel.canon.Cylinder end

        if not desc:IsA("Sound") then return end
        if not desc.Parent or not desc.Parent.Parent then return end
        if desc:GetAttribute("IsMyCloneToIgnore") then return end

        --print(desc.ClassName, desc:GetFullName())

        local path = desc:GetFullName()
        
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine1:Play() -- get out of here
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine2:Play() -- back off
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine3:Play() -- careful!
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine4:Play() -- move!
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine5:Play() -- burn
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.ChargeLine:Play() -- stand by
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.GetAway.DefaultLine1:Play() -- cut in a close idk
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.GetAway.DefaultLine2:Play() -- im otta here!
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.LaserLine1:Play() -- hit 'em
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.LaserLine2:Play() -- impact
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.LaserLine3:Play() -- derict hit
        -- game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.LaserLine4:Play() -- got it

        if path:find(".Swings") then
            desc.SoundId = game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.EXE.Swing.SoundId
            return
        end
        
        if path:find(".Hurt") then
            if desc.Parent:FindFirstChild("CustomSpeech") then desc:Destroy() return end
            local Sounds = {
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine2,--:Play() -- back off
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine2,--:Play() -- back off
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine4,-- move!
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine1,--:Play() -- get out of here
            }
            local sound = Sounds[math.random(1, #Sounds)]:Clone()
            sound:SetAttribute("IsMyCloneToIgnore", true)
            sound.Name = "CustomSpeech"
            sound.Parent = desc.Parent
            sound.Volume = 0.25 + desc.Volume
            sound:Play()
            sound.Ended:Once(function() sound:Destroy() end)
            game.Debris:AddItem(sound, 3)
            desc:Destroy()
            return
        end

        if path:find(".Downed") or (path:find(".Default") and path:find("Line")) then
            if desc.Parent:FindFirstChild("CustomSpeech") then desc:Destroy() return end
            local Sounds = {
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.ChargeLine, -- stand by
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine1, --:Play() -- get out of here
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine1, --:Play() -- get out of here
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine2, --:Play() -- back off
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.ChargeLine, -- stand by
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine4, -- move!
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine1, --:Play() -- get out of here
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.BurstLine5, -- burn
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.ChargeLine, -- stand by
                game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.ChargeLine, -- stand by
            }
            local sound = Sounds[math.random(1, #Sounds)]:Clone()
            sound:SetAttribute("IsMyCloneToIgnore", true)
            sound:SetAttribute("Subtitle", "wha")
            sound.Name = "CustomSpeech"
            sound.Parent = desc.Parent
            sound.Volume = 0.25 + desc.Volume
            sound:Play()
            sound.Ended:Once(function() sound:Destroy() end)
            game.Debris:AddItem(sound, 3)
            desc:Destroy()
            return
        end

        if desc.Name:find("Retract") then
            if desc.Parent:FindFirstChild("CustomSpeech") then desc:Destroy() return end
            local sound = game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.ChargeLine:Clone()
            sound:SetAttribute("IsMyCloneToIgnore", true)
            sound.Parent = desc.Parent
            sound.Volume = 0.5 + desc.Volume
            sound:Play()
            sound.Ended:Once(function() sound:Destroy() end)
            game.Debris:AddItem(sound, 3)
            desc:Destroy()
        end

        if desc.Name:find("Unleashed") then
            if desc.Parent:FindFirstChild("CustomSpeech") then desc:Destroy() return end
            local sound = game.ReplicatedStorage.ClientAssets.Sounds.sfx.Game.Survivors.Tails.Lines.GetAway.DefaultLine1:Clone()
            sound:SetAttribute("IsMyCloneToIgnore", true)
            sound.Parent = desc.Parent
            sound.Volume = 0.5 + desc.Volume
            sound:Play()
            sound.Ended:Once(function() sound:Destroy() end)
            game.Debris:AddItem(sound, 3)
            desc:Destroy()
        end
    end)

    print("[FoxOnTailsDoll] Updating finished for", player.Name .. "!")
end


local function onPlayerAdded(player)
    -- Check if they already spawned in
    if player.Character then tryUpdatePlayer(player.Character) end
    -- Listen for the player (re)spawning
    _G.FoxOnTailsDollCharacterAddedConn = _G.FoxOnTailsDollCharacterAddedConn or {}
    if _G.FoxOnTailsDollCharacterAddedConn[player.Name] then
        _G.FoxOnTailsDollCharacterAddedConn[player.Name]:Disconnect()
        print("[FoxOnTailsDoll] Previous FoxOnTailsDollCharacterAddedConn disconnected for", player.Name)
    end
    _G.FoxOnTailsDollCharacterAddedConn[player.Name] = player.CharacterAdded:Connect(tryUpdatePlayer) 
end

for _, player in game.Players:GetPlayers() do onPlayerAdded(player) end

if _G.FoxOnTailsDollPlayerAddedConn then
    _G.FoxOnTailsDollPlayerAddedConn:Disconnect()
    print("[FoxOnTailsDoll] Previous FoxOnTailsDollPlayerAddedConn disconnected")
end
_G.FoxOnTailsDollPlayerAddedConn = game.Players.PlayerAdded:Connect(onPlayerAdded)


-- load custom assets
local function loadCustomAsset(url, filename)
    if not isfile(filename) then
        print("[FoxOnTailsDoll] Downloading", filename.."...")
        writefile(filename, game:HttpGet(url))
    end
    return getcustomasset(filename)
end
game.ReplicatedStorage.ClientAssets.Sounds.mus.Game.Round.ChaseThemes.TailsDoll.Default.NormalChase.SoundId = loadCustomAsset(
    "https://github.com/lil2kki-a/My-Outcome-Memories/raw/refs/heads/main/FoxOnTailsDoll/SECRET%20HISTORY%20TAILS-%20OUTCOME%20MEMORIES%20UST%20(Music%20Only).mp3", 
    "cache/lil2kki/FoxOnTailsDoll/SECRET HISTORY TAILS- OUTCOME MEMORIES UST (Music Only).mp3"
)
game.ReplicatedStorage.ClientAssets.Sounds.mus.Game.Round.ChaseThemes.TailsDoll.Default.NormalChase.LoopRegion = NumberRange.new(0, 0)

game.ReplicatedStorage.ClientAssets.Sounds.mus.Game.Round.ChaseThemes.TailsDoll.Default.LastLifeChase:Destroy()
local FeelstheRabbit = game.ReplicatedStorage.ClientAssets.Sounds.mus.Game.Round.ChaseThemes["2011x"].FeelstheRabbit.NormalChase:Clone()
FeelstheRabbit.Name = "LastLifeChase"
FeelstheRabbit.Parent = game.ReplicatedStorage.ClientAssets.Sounds.mus.Game.Round.ChaseThemes.TailsDoll.Default
