print("[Honey On Blaze] Now loading... Made by lil2kki <3")
print("[Honey On Blaze] Model used: https://create.roblox.com/store/asset/109641302875796")

if not game:IsLoaded() then game.Loaded:Wait() end

-- storage model template

local tar = game.ReplicatedStorage:FindFirstChild("Characters", true):FindFirstChild("Blaze", true):FindFirstChild("Skins", true).Default

local model = game:GetObjects("rbxassetid://109641302875796")[1]
model.Name = tar.Name
model.Parent = tar.Parent
tar:Destroy()

local function setupHairStrand(hairMesh, boneRootName)
    if not hairMesh or not hairMesh:IsA("MeshPart") then return end
    
    game:GetService("CollectionService"):AddTag(hairMesh, "SmartBone")
    
    hairMesh:SetAttribute("Roots", boneRootName)
    
    hairMesh:SetAttribute("Damping", 2)
    hairMesh:SetAttribute("Stiffness", 0.7)
    hairMesh:SetAttribute("Elasticity", 2)
    hairMesh:SetAttribute("Inertia", 122)
    hairMesh:SetAttribute("Gravity", Vector3.new(0, -222, 0))
    hairMesh:SetAttribute("AnchorsRotate", true)
    hairMesh:SetAttribute("AnchorDepth", 1)
    
    game:GetService("CollectionService"):AddTag(model:FindFirstChild("Head", true), "SmartCollider")
end
setupHairStrand(model:FindFirstChild("Hair1", true), "Hair.R")
setupHairStrand(model:FindFirstChild("Hair2", true), "Hair.L")

local tailm = model:FindFirstChild("TailEnd", true)
if tailm then
    game:GetService("CollectionService"):AddTag(tailm, "SmartBone")
    
    tailm:SetAttribute("Roots", "Tail")
    
    tailm:SetAttribute("Damping", 1)
    tailm:SetAttribute("Stiffness", 0.5)
    tailm:SetAttribute("Elasticity", 1)
    tailm:SetAttribute("Inertia", 666)
    tailm:SetAttribute("Gravity", Vector3.new(0, -22, 0))
    tailm:SetAttribute("AnchorsRotate", true)
    tailm:SetAttribute("AnchorDepth", 1)
    
    game:GetService("CollectionService"):AddTag(model:FindFirstChild("Waist", true), "SmartCollider")
end

---- player update func 

local function tryUpdatePlayer(player)
    if not player:IsA("Model") then return end
    if player:GetAttribute("Character") ~= "Blaze" then return end
    if player:GetAttribute("Skin") ~= "Default" then return end

    print("[Honey On Blaze] Prebuild updating model for " .. player.Name .. "...")

    if player:FindFirstChild("OverlayModel") then
        warn("[Honey On Blaze] Player already have OverlayModel, update cancelled")
        return
    end
    
    player:WaitForChild("BeingChased")

    print("[Honey On Blaze] Character ready! Updating " .. player:GetFullName() .. "...")
    
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
                        end
                    end
                end
            end)
        end
        if v:IsA("SurfaceGui") then v.Enabled = false end
        if v:IsA("SurfaceAppearance") then v:Destroy() end
    end

    -- Overlay Model
    local OverlayModel = game.ReplicatedStorage:FindFirstChild("Characters", true):FindFirstChild("Blaze", true):FindFirstChild("Skins", true).Default:Clone()
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
    local hrpY = -0.3
    local weld = Instance.new("Weld")
    weld.Part0 = ogHRP
    weld.Part1 = myHRP
    weld.C0 = CFrame.new()
    weld.C1 = CFrame.new(0, -hrpY, 0) 
    weld.Parent = myHRP
    myHRP:PivotTo(ogHRP.CFrame * CFrame.new(0, hrpY, 0))

    print("[Honey On Blaze] Updating finished for", player.Name .. "!")
end

game.Players.LocalPlayer.CharacterAdded:Connect(tryUpdatePlayer)
