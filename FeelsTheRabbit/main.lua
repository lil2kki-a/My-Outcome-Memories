print("[FeelstheRabbit for 2011x] Now loading... Made by lil2kki <3")
print("[FeelstheRabbit for 2011x] Model used: https://create.roblox.com/store/asset/74680877366454")

if not game:IsLoaded() then game.Loaded:Wait() end

-- storage model template

    local tar = game.ReplicatedStorage:FindFirstChild("Characters", true):FindFirstChild("2011x", true):FindFirstChild("Skins", true).Default

    local model = game:GetObjects("rbxassetid://74680877366454")[1]
    model.Name = tar.Name
    model.Parent = tar.Parent
    tar:Destroy()

---- player update func 

    local function tryUpdatePlayer(player)
        if not player:IsA("Model") then return end
        if player:GetAttribute("Character") ~= "2011x" then return end
        if player:GetAttribute("Skin") ~= "Default" then return end

        print("[FeelstheRabbit for 2011x] Prebuild updating model for " .. player.Name .. "...")

        if player:FindFirstChild("OverlayModel") then
            warn("[FeelstheRabbit for 2011x] Player already have OverlayModel, update cancelled")
            return
        end

        -- sometimes game spam errors without it lol
        if not player:FindFirstChild("BeingChased") then
            local BeingChased = Instance.new("ObjectValue")
            BeingChased.Name = "BeingChased"
            BeingChased.Value = player
            BeingChased.Parent = player
        end
        
        player:WaitForChild("cam")

        print("[FeelstheRabbit for 2011x] Character ready! Updating " .. player:GetFullName() .. "...")
        
        -- Char Model
        local ogHRP = player:FindFirstChild("HumanoidRootPart", true)
        if not ogHRP then return end

        for _, v in ipairs(player:GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
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
                                if ov:IsA("ParticleEmitter") then ov.Enabled = (v.Transparency < 0.5) end
                            end
                        end
                    end
                end)
            end
            if v:IsA("SurfaceGui") then v.Enabled = false end
            if v:IsA("SurfaceAppearance") then v:Destroy() end
        end

        -- Overlay Model
        local OverlayModel = game.ReplicatedStorage:FindFirstChild("Characters", true):FindFirstChild("2011x", true):FindFirstChild("Skins", true).Default:Clone()
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
        local hrpY = -0.0
        local weld = Instance.new("Weld")
        weld.Part0 = ogHRP
        weld.Part1 = myHRP
        weld.C0 = CFrame.new()
        weld.C1 = CFrame.new(0, -hrpY, 0) 
        weld.Parent = myHRP
        myHRP:PivotTo(ogHRP.CFrame * CFrame.new(0, hrpY, 0))

        coroutine.wrap(function()
            local ogUpperbody = ogHRP.Parent:FindFirstChild("Upperbody", true)
            local myUpperbody = myHRP.Parent:FindFirstChild("Upperbody", true)
            while ogHRP.Parent and ogHRP.Parent.Parent and myHRP.Parent do
                myUpperbody.CFrame = ogUpperbody.CFrame
                task.wait() -- heartbeat mayb
            end
        end)()

        print("[FeelstheRabbit for 2011x] Updating finished for", player.Name .. "!")
    end

------ watch for players

    local function onPlayerAdded(player)
        -- Check if they already spawned in
        if player.Character then tryUpdatePlayer(player.Character) end
        -- Listen for the player (re)spawning
        _G.FeelsTheRabbitSkinCharacterAddedConn = _G.FeelsTheRabbitSkinCharacterAddedConn or {}
        if _G.FeelsTheRabbitSkinCharacterAddedConn[player.Name] then
            _G.FeelsTheRabbitSkinCharacterAddedConn[player.Name]:Disconnect()
            print("[FeelstheRabbit for 2011x] Previous FeelsTheRabbitSkinCharacterAddedConn disconnected for", player.Name)
        end
        _G.FeelsTheRabbitSkinCharacterAddedConn[player.Name] = player.CharacterAdded:Connect(tryUpdatePlayer) 
    end

    for _, player in game.Players:GetPlayers() do onPlayerAdded(player) end

    if _G.FeelsTheRabbitSkinPlayerAddedConn then
        _G.FeelsTheRabbitSkinPlayerAddedConn:Disconnect()
        print("[FeelstheRabbit for 2011x] Previous FeelsTheRabbitSkinPlayerAddedConn disconnected")
    end
    _G.FeelsTheRabbitSkinPlayerAddedConn = game.Players.PlayerAdded:Connect(onPlayerAdded)

    if _G.FeelsTheRabbitSkinSkinTESTINGDUMMYConn then
        _G.FeelsTheRabbitSkinSkinTESTINGDUMMYConn:Disconnect()
        print("[FeelstheRabbit for 2011x] Previous FeelsTheRabbitSkinSkinTESTINGDUMMYConn disconnected")
    end
    _G.FeelsTheRabbitSkinSkinTESTINGDUMMYConn = game.CollectionService:GetInstanceAddedSignal("TESTINGDUMMY"):Connect(tryUpdatePlayer)

-------- sounds

    local function loadCustomAsset(url, filename)
        if not isfile(filename) then writefile(filename, game:HttpGet(url)) end
        return getcustomasset(filename)
    end

    local themes = game:GetService("ReplicatedStorage"):FindFirstChild("ChaseThemes", true):FindFirstChild("2011x", true)

    themes.Default.NormalChase.SoundId = "rbxassetid://128843745965150"
    themes.Default.NormalChase.PlaybackRegion = NumberRange.new(0, 0)
    themes.Default.NormalChase.LoopRegion = NumberRange.new(0, 0)

    themes.Default.LastLifeChase.SoundId = loadCustomAsset(
        "https://static.wikia.nocookie.net/the-unofficial-outcome-memories/images/c/cc/LoonyIngameLL.mp3/revision/latest?cb=20260120100115",
        "cache/LoonyIngameLL.mp3"
    )
    themes.Default.LastLifeChase.PlaybackRegion = NumberRange.new(0, 0)
    themes.Default.LastLifeChase.LoopRegion = NumberRange.new(0, 0)
    themes.Default.LastLifeChase.PlaybackSpeed = 1 -- OM 0.1a special
    themes.Default.LastLifeChase:SetAttribute("Eliminated", 60 + 30.5)--1:30.9
