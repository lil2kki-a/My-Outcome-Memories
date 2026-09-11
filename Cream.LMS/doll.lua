print("[Cream.LMS for TailsDoll] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end

-- MODEL SETUP IN ReplicatedStorage (for UI and overlay ref)

    -- Add Icons
    while game.ReplicatedStorage.ClientAssets.Icons:FindFirstChild("TailsDoll") do
        game.ReplicatedStorage.ClientAssets.Icons.TailsDoll:Destroy()
        warn("[Cream.LMS for TailsDoll] Old icons removed")
    end
    local icons = game.ReplicatedStorage.ClientAssets.Icons.Cream:Clone()
    icons.Parent = game.ReplicatedStorage.ClientAssets.Icons
    icons.Name = "TailsDoll"
    icons.Eyes:Destroy()

    local tar = game:GetService("ReplicatedStorage")
    tar = tar:FindFirstChild("Characters", true)
    tar = tar:FindFirstChild("TailsDoll", true)
    tar = tar:FindFirstChild("Skins", true)

    local old = tar:FindFirstChild("_OLD", true)
    if OLD_THERE_ALR then
        warn("[Cream.LMS for TailsDoll] Restoring original skin")
        tar:FindFirstChild("Default", true):Destroy()
        OLD_THERE_ALR.Name = "Default"
    end

    tar = tar:FindFirstChild("Default", true)

    local src = game:GetService("ReplicatedStorage")
    src = src:FindFirstChild("Characters", true)
    src = src:FindFirstChild("Cream", true)
    src = src:FindFirstChild("Skins", true)
    src = src:FindFirstChild("Default", true)

    if not tar or not src then warn("[Cream.LMS for TailsDoll] Models not found!") return end

    -- clone cream
    local model = src:Clone()

    model.Name = tar.Name
    model.Parent = tar.Parent

    tar.Name = "_OLD"

    for _, v in ipairs(model:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Slate
        end
    end

    local function find(name)
        return model:FindFirstChild(name, true)
    end

    -- red dots :3
    local thatslikeevilandscary = game:GetObjects("rbxassetid://120086931957772")[1]
    local eyeNames = {{"Eye1","eye1"}, {"Eye2","eye2"}}
    for _, pair in ipairs(eyeNames) do
        local srcPart = thatslikeevilandscary:FindFirstChild(pair[1], true)
        local dstPart = model:FindFirstChild(pair[2], true)
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

    -- rename parts
    local function rename(oldName, newName)
        local obj = find(oldName)
        while obj do
            -- print("renaming: "..obj.Name.." -> "..newName.." //"..obj.ClassName)
            obj.Name = newName
            obj:SetAttribute("rename_oldName", oldName)
            obj:SetAttribute("rename_newName", newName)
            obj = find(oldName)
        end 
    end

        rename("waist", "Waist")
        rename("Body", "MainBody")

        rename("eye1", "REye")
        rename("eye2", "LEye")

        rename("Right Sleeve", "RArm1")
        rename("Cylinder.013", "RArm2")
        rename("Cylinder.014", "RArm3")
        rename("Cylinder.017", "RArm4")
        rename("Right Hand", "RHand")

        rename("Left Sleeve", "LArm1")
        rename("Cylinder.023", "LArm2")
        rename("Cylinder.022", "LArm3")
        rename("Left Hand", "LHand")

        rename("Right Leg", "RLeg1")
        rename("Cylinder.001", "RLeg2")
        rename("Cylinder", "RLeg3")
        rename("Right Shoe", "RShoe")

        rename("Left Leg", "LLeg1")
        rename("Cylinder.034", "LLeg2")
        rename("Cylinder.035", "LLeg3")
        rename("Left Shoe", "LShoe")

        rename("tail", "RTail")

        rename("REar", "RTail")
        rename("LEar", "LTail")
    --

    -- blood on muzzle :3
    local muzzle = model:FindFirstChild("muzzle", true)
    local drip = game:GetObjects("rbxassetid://84762690015926")[1]
    drip.Parent = muzzle
    drip.UVScale = Vector2.new(1.5, 1)

    -- dress..
    local dress = model:FindFirstChild("dress", true)
    dress.Material = Enum.Material.Sandstone

    print("[Cream.LMS for TailsDoll] Model setup done...")
--

local function tryUpdatePlayer(player)
    if not player:IsA("Model") then return end

    if player:GetAttribute("Character") ~= "TailsDoll" then return end

    print("[Cream.LMS for TailsDoll] Updating model for " .. player.Name .. "...")

    if player:FindFirstChild("OverlayModel") then
        warn("[Cream.LMS for TailsDoll] Player already have OverlayModel, update cancelled")
        return
    end

    -- first prebuild setup
        local healthxd = Instance.new("NumberValue")
        healthxd.Name = "Health"
        healthxd.Parent = player
        coroutine.wrap(function()
            task.wait(1) -- breaks health bar :3
            healthxd.Value = 100
        end)()
    --

    -- wait server build..
    player:WaitForChild("cam")
    local lastCamCFrame = workspace.CurrentCamera.CFrame
    repeat task.wait() until workspace.CurrentCamera.CFrame ~= lastCamCFrame
    
    local ogHRP = player:FindFirstChild("HumanoidRootPart", true)
    if not ogHRP then return end

    local ogHead = player:FindFirstChildOfClass("Motor6D", true)

    for _, v in ipairs(player:GetDescendants()) do
        if v:IsA("Motor6D") and v.Name == "Head" then ogHead = v end
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            if string.find(v.Name, "Claw") then v:Destroy() end
            v.Transparency = 1
            v.LocalTransparencyModifier = 1
            v.Material = Enum.Material.Neon
            v.Color = Color3.new(0/255, 0/255, 0/255)
            v:SetAttribute("HiddenAway", "FOR CREAM")
        end
        if v:IsA("SurfaceGui") then v.Enabled = false end
        if v:IsA("SurfaceAppearance") then v:Destroy() end
        if v:IsA("ParticleEmitter") then v:Destroy() end -- soul diamond
        if v:IsA("PointLight") then v:Destroy() end -- soul diamond
    end
    
    local src = game:GetService("ReplicatedStorage")
    src = src:FindFirstChild("Characters", true)
    src = src:FindFirstChild("TailsDoll", true)
    src = src:FindFirstChild("Skins", true)
    src = src:FindFirstChild("Default", true)

    local OverlayModel = src:Clone()
    OverlayModel.Parent = player
    OverlayModel.Name = "OverlayModel"

    local myHRP = OverlayModel:FindFirstChild("HumanoidRootPart", true)
    if not myHRP then OverlayModel:Destroy() return end

    local myHead = OverlayModel:FindFirstChildOfClass("Motor6D", true)

    for _, v in ipairs(OverlayModel:GetDescendants()) do
        if v:IsA("Motor6D") and v.Name == "Head" then myHead = v end
        if v:IsA("Humanoid") then v:Destroy() end
        if v:IsA("Animator") then v:Destroy() end
        if v:IsA("BasePart") then
            v.CanCollide = false
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

    -- cam script is horror
    coroutine.wrap(function()
        while true do
            if not myHRP or not myHRP.Parent then return end
            myHead.C0 = CFrame.new(myHead.C0.Position) * (ogHead.C0 - ogHead.C0.Position)
            task.wait()
        end
    end)()

    -- gods
    local LHand = player:FindFirstChild("LHand")
    LHand:GetPropertyChangedSignal("Transparency"):Connect(function() 
        -- warn(LHand:GetFullName().." as "..LHand.Transparency)
        for _, v in ipairs(player.OverlayModel:GetDescendants()) do 
            if v.Name ~= "HumanoidRootPart" then
                pcall(function() v.Transparency = LHand.Transparency end)
                if v:IsA("ParticleEmitter") then v.Enabled = (LHand.Transparency < 0.5) end
            end
        end
    end)

    -- glide anim repl
        local function renameByAttribute(attrName)
            for _, obj in ipairs(player:GetDescendants()) do
                local targetName = obj:GetAttribute(attrName)
                if targetName then obj.Name = targetName end
            end
        end

        local isGilding = false
        local CreamGlideTrack = player.Humanoid.Animator:LoadAnimation(
            game:GetService("ReplicatedStorage"):FindFirstChild("Characters", true)
            :FindFirstChild("Cream", true):FindFirstChild("Glide", true)
        )
        CreamGlideTrack.Name = "CreamGlide"

        player.Humanoid.Animator.AnimationPlayed:Connect(function(track)
            if track.Name ~= CreamGlideTrack.Name then 
                if CreamGlideTrack then CreamGlideTrack:Stop() end
                renameByAttribute("rename_newName") 
                track.Stopped:Once(function() if isGilding and CreamGlideTrack then
                    renameByAttribute("rename_oldName")
                    CreamGlideTrack:Play(0.1)
                end end)
            end
            if track.Name == "Glide" then
                isGilding = true
                track.Stopped:Once(function()
                    isGilding = false
                    if CreamGlideTrack then CreamGlideTrack:Stop(0.1) end
                    renameByAttribute("rename_newName")
                end)
                renameByAttribute("rename_oldName")
                if CreamGlideTrack then CreamGlideTrack:Play(0.1) end
            end
        end)
    --
	
    player.DescendantAdded:Connect(function(desc)
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
    end)

end

local function onPlayerAdded(player)
    -- Check if they already spawned in
    if player.Character then tryUpdatePlayer(player.Character) end
    -- Listen for the player (re)spawning
    _G.CreamTailsDollCharacterAddedConn = _G.CreamTailsDollCharacterAddedConn or {}
    if _G.CreamTailsDollCharacterAddedConn[player.Name] then
        _G.CreamTailsDollCharacterAddedConn[player.Name]:Disconnect()
        print("[Cream.LMS for TailsDoll] Previous CreamTailsDollCharacterAddedConn disconnected for", player.Name)
    end
    _G.CreamTailsDollCharacterAddedConn[player.Name] = player.CharacterAdded:Connect(tryUpdatePlayer) 
end

for _, player in game.Players:GetPlayers() do onPlayerAdded(player) end

if _G.CreamTailsDollPlayerAddedConn then
    _G.CreamTailsDollPlayerAddedConn:Disconnect()
    print("[Cream.LMS for TailsDoll] Previous CreamTailsDollPlayerAddedConn disconnected")
end
_G.CreamTailsDollPlayerAddedConn = game.Players.PlayerAdded:Connect(onPlayerAdded)


-- if game then return end

-- CUSTOM TEXT
    local textReplacements = {
        ["S.T.E.P."] = "FUN",
        ["Reach Out"] = " Tag ~",
        ["Brighter Day"] = "Laser thingy",
        ["Tripwire"] = " [CORRUPTED] ",
        ["TailsDoll"] = "TailsDoll (2)",
        ["Can you feel the sunshine?"] = "[Info] Instance copied successfully.\n"
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
    }
    local function hookLabel(desc)
        if not desc or not desc.Parent then return end
        if not desc:IsA("TextLabel") then return end
        if not TextLabelNames[desc.Name] then return end
        -- warn("[Cream.LMS for TailsDoll] Watching TextLabel: "..desc.Name)
        coroutine.wrap(function()
            while true do
                if not desc or not desc.Parent then 
                    -- warn("[Cream.LMS for TailsDoll] Lost TextLabel to watch: "..desc:GetFullName()) 
                    return 
                end
                if textReplacements[desc.Text] then desc.Text = textReplacements[desc.Text] end
                task.wait() -- heartbeat mayb
            end
        end)()
    end
    _G.CreamOnTailsDollGUIConn = _G.CreamOnTailsDollGUIConn or nil
    if _G.CreamOnTailsDollGUIConn then
        _G.CreamOnTailsDollGUIConn:Disconnect()
        _G.CreamOnTailsDollGUIConn = nil
    end
    _G.CreamOnTailsDollGUIConn = game.Players.LocalPlayer:WaitForChild("PlayerGui").DescendantAdded:Connect(hookLabel)
    for _, desc in ipairs(game.Players.LocalPlayer:WaitForChild("PlayerGui"):GetDescendants()) do hookLabel(desc) end
    print("[Cream.LMS for TailsDoll] Listening for your GUI...")
--

-- CUSTOM SOUNDS
    local assigns = { ["rbxassetid://97101227703333"] = "rbxassetid://139116822099909" }
    local StunSounds = {}
    local DownedSounds = {}
    local AttackSounds = {}
    local lastBloodHitPlayerRef = nil

    _G.CreamOnTailsDollSkinSoundConn = _G.CreamOnTailsDollSkinSoundConn or nil
    if _G.CreamOnTailsDollSkinSoundConn then
        _G.CreamOnTailsDollSkinSoundConn:Disconnect()
        _G.CreamOnTailsDollSkinSoundConn = nil
        print("[Cream.LMS for TailsDoll] Previous sound desc conn destroyed")
    end
    _G.CreamOnTailsDollSkinSoundConn = workspace.DescendantAdded:Connect(function(desc)
        if not desc or not desc:IsA("Sound") then return end
        if not desc.Parent or not desc.Parent.Parent then return end

        if desc.SoundId == "rbxassetid://131820864449998" then
            local Retracts = { 
                assigns[desc.SoundId]
                , DownedSounds[8] -- other giggle
                , DownedSounds[1] -- be careful
            }
            desc.SoundId = Retracts[math.random(1, #Retracts)]
        end

        if assigns[desc.SoundId] then desc.SoundId = assigns[desc.SoundId] end
        
        local player = desc.Parent.Parent
        if player and player:IsA("Model") and player:FindFirstChild("HumanoidRootPart") then
            local isTailsDoll = player:GetAttribute("Character") == "TailsDoll"

            local path = desc:GetFullName()

            if path:find(".Blood Hit") then lastBloodHitPlayerRef = player end

            if isTailsDoll and (desc.Name:find("Retract") or desc.Name:find("Unleashed")) then
                desc.RollOffMaxDistance = desc.RollOffMaxDistance * 4
                desc.RollOffMinDistance = desc.RollOffMinDistance * 2
                desc.Volume = 1
                for _, child in ipairs(player.Waist:GetChildren()) do
                    if child.Name:find("CreamSpeech") then 
                        desc.Volume = 0
                        desc:Stop()
                        break
                    end
                end
            end

            if isTailsDoll then

                if desc.SoundId == "rbxassetid://77110140707717" then
                    local clone = desc:Clone()
                    clone.SoundId = AttackSounds[math.random(1, #AttackSounds)]
                    clone.Name = clone.SoundId
                    clone.Parent = desc.Parent
                    clone:Play()
                    local endedconn = clone.Ended:Once(function() clone:Destroy() end)
                    task.delay(10, function()
                        if clone.Parent then clone:Destroy() end
                        if endedconn then endedconn:Disconnect() end
                    end)
                end

                local isDefLine = (path:find(".Default") and path:find("Line")) -- .Default1Line wth

                if isDefLine or path:find(".Downed") then desc.SoundId = DownedSounds[math.random(1, #DownedSounds)] end
                if path:find(".Hurt") then desc.SoundId = StunSounds[math.random(1, #StunSounds)] end

                if isDefLine or path:find(".Downed") or path:find(".Hurt") then

                    for _, child in ipairs(player.Waist:GetChildren()) do
                        if child.Name:find("CreamSpeech") then child:Stop() child:Destroy() end
                    end

                    if isDefLine then
                        local lastPlayer = lastBloodHitPlayerRef
                        if lastPlayer then
                            local c = lastPlayer:GetAttribute("Character")
                            if KillLines[c] then desc.SoundId = KillLines[c][math.random(1, #KillLines[c])] end
                        end
                    end

                    local sound = Instance.new("Sound")
                    sound.Name = "CreamSpeech - " .. desc.SoundId
                    sound.SoundId = desc.SoundId
                    sound.Volume = desc.Volume
                    sound.RollOffMaxDistance = desc.RollOffMaxDistance
                    sound.RollOffMinDistance = desc.RollOffMinDistance
                    sound.SoundGroup = desc.SoundGroup
                    sound.Parent = player.Waist
                    sound:Play()
                    local endedconn = sound.Ended:Once(function() sound:Destroy() end)
                    task.delay(10, function()
                        if sound.Parent then sound:Destroy() end
                        if endedconn then endedconn:Disconnect() end
                    end)

                    desc.Volume = 0

                end
            end
        end
        
    end)
    print("[Cream.LMS for TailsDoll] Listening for new dynamuc sounds in workspace...")

    print("[Cream.LMS for TailsDoll] Loading custom sounds...")
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
            warn("[Cream.LMS for TailsDoll] failed to load " .. fileName)
            return nil
        end
    end
    assigns = {
        ["rbxassetid://117478513053834"] = myAsset("WinScreen.mp3"),
	
        ["rbxassetid://80901931085615"] = myAsset("NormalChaseFix.mp3"),
        ["rbxassetid://129416111545242"] = myAsset("TerrorRadius.mp3"),
        ["rbxassetid://112879248941055"] = myAsset("LastLifeChase3.mp3"),
        
        ["rbxassetid://112976135484851"] = myAsset("Unleashed1.mp3"),
        ["rbxassetid://106071428647005"]  = myAsset("Unleashed2.mp3"),
        ["rbxassetid://87302988643016"]  = myAsset("Unleashed3.mp3"),
        ["rbxassetid://131820864449998"] = myAsset("Retract.mp3"), -- giggle or smth here ~

        ["rbxassetid://97101227703333"] = "rbxassetid://139116822099909",  -- .Hit1]  2O11x Hit2
        ["rbxassetid://93465914238963"] = "rbxassetid://88164444698409",  -- Lilith.Hit2] 
        ["rbxassetid://113251186335660"] = "rbxassetid://5507830073",  -- Lilith.Hit3] 
        
        ["rbxassetid://73636680793269"] = "rbxassetid://77110140707717",  -- basic Swing
        ["rbxassetid://108753423324802"] = "rbxassetid://77110140707717",  -- basic Swing
        ["rbxassetid://134998846301914"] = "rbxassetid://77110140707717",  -- basic Swing
    }
    KillLines = {
        ["Sonic"] = { myAsset("Sonic.mp3"), myAsset("Sonic2.mp3") },
        ["Tails"] = { myAsset("Tails.mp3"),  myAsset("Tails2.mp3"),  myAsset("Tails3.mp3") },
        ["MetalSonic"] = { myAsset("MetalSonic.mp3"),  myAsset("MetalSonic2.mp3") },
        ["Amy"] = { myAsset("Amy.mp3"),  myAsset("Amy2.mp3"),  myAsset("Amy3.mp3"),  myAsset("Amy4.mp3") },
        ["Silver"] = { myAsset("Silver.mp3") },
        ["Blaze"] = { myAsset("Blaze.mp3") },
        ["Eggman"] = { myAsset("Eggman.mp3") },
        ["Cream"] = { myAsset("Cream.mp3"),  myAsset("Cream2.mp3") },
        ["Knuckles"] = { myAsset("Knuckles.mp3") }
    }
    for i = 1, 28 do table.insert(StunSounds, myAsset("Stun" .. i .. ".mp3")) end
    for i = 1, 14 do table.insert(DownedSounds, myAsset("Down" .. i .. ".mp3")) end
    for i = 1, 8 do table.insert(AttackSounds, myAsset("Attack" .. i .. ".mp3")) end
    print("[Cream.LMS for TailsDoll] Finished downloading custom sounds...")
--

print("[Cream.LMS for TailsDoll] Ready!")
