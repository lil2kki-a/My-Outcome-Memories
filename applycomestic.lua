--[[
local applycomestic = loadstring(game:HttpGet("https://pastebin.com/raw/qHzmXnbm"))()
-- for loaded player in round
applycomestic(player, player.OverlayModel)
-- for template model
model:SetAttribute("EquippedCosmetics", "FAKETAILSDOLL,")
model:SetAttribute("Character", "Tails")
applycomestic(model)
]]

if not UnlockModule then function UnlockModule(a) return 1 end end
if not LockModule then function LockModule(a) return 1 end end

function applycomestic(player, primaryModel)

    print("[module by lil2kki] called applycomestic for", player:GetFullName())

    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local EquippedCosmetics = {}
    for item in string.gmatch(player:GetAttribute("EquippedCosmetics"), "[^,]+") do
        if player:FindFirstChild(item, true) then player:FindFirstChild(item, true):Destroy() end
        for a, Folder in pairs(ReplicatedStorage.ClientAssets.Cosmetics:GetChildren()) do
            if not Folder:FindFirstChild(item) then continue end
            EquippedCosmetics[Folder.Name] = item
        end
    end
    local p1 = primaryModel or player
    local p2 = EquippedCosmetics
    local v5 = player:GetAttribute("Character")

    local function weld(p1, p2)
        local v1 = p1.CFrame:toObjectSpace(p2.CFrame)
        local Weld = Instance.new("Weld")

        Weld.Name = p2.Name
        Weld.Part0 = p1
        Weld.Part1 = p2
        Weld.C0 = v1
        Weld.Parent = p1
    end
    
    local function RequireUnlockedModule(Module)
        UnlockModule(Module)
        local rtn = require(Module)
        LockModule(Module)
        return rtn
    end

    if not p2 then
        return
    end

    local v1 = false
    local v2 = nil
    local v3 = nil

    for v4, v52 in p2 do
        if v4 ~= "Emotes" then
            if v4 == "Colors" then
                v1 = true
                v2 = v4
                v3 = v52

                continue
            end

            if ReplicatedStorage.ClientAssets.Cosmetics[v4]:FindFirstChild(v52) then
                local v6 = ReplicatedStorage.ClientAssets.Cosmetics[v4]:FindFirstChild(v52):Clone()
                local v7 = {v5, v5}-- tostring(v6:GetAttribute("Belongs")):split(",")
                local Unique = v6:FindFirstChild("Unique")

                if table.find(v7, v5) then
                    if Unique then
                        RequireUnlockedModule(Unique).load(p1)
                        print("loaded", Unique:GetFullName())
                    end

                    if v6:FindFirstChild("Anims") then
                        v9 = v6.Anims
                        v6.Anims:Destroy()
                    end

                    if v6:HasTag("ComesticGroup") then
                        for v8, v92 in v6:GetChildren() do
                            if v92.Name ~= "Unique" then
                                local v10 = tostring(v92:GetAttribute("WeldTo"))

                                for v11, v12 in v92:GetDescendants() do
                                    if v12:IsA("BasePart") then
                                        v12.CanCollide = false
                                        v12.Anchored = false
                                        v12.CanTouch = false
                                        v12.CanQuery = false
                                        v12.Massless = true
                                    end
                                end

                                if v92:FindFirstChild("Weld") then
                                    v92.PrimaryPart = v92.Weld

                                    if p1:FindFirstChild(v10, true) then
                                        local v13 = p1:FindFirstChild(v10, true)

                                        if not v13:IsA("BasePart") then
                                            for v14, v15 in p1:GetDescendants() do
                                                if v15:IsA("BasePart") and v15.Name == v10 then
                                                    v13 = v15

                                                    break
                                                end
                                            end
                                        end

                                        if v10 == "Cheese" then
                                            v13 = p1.cheese.HumanoidRootPart
                                        end

                                        v92:PivotTo(v13.CFrame)
                                        v92.Parent = p1

                                        local PrimaryPart = v92.PrimaryPart
                                        local v16 = PrimaryPart.CFrame:toObjectSpace(v13.CFrame)
                                        local Weld = Instance.new("Weld")

                                        Weld.Name = v13.Name
                                        Weld.Part0 = PrimaryPart
                                        Weld.Part1 = v13
                                        Weld.C0 = v16
                                        Weld.Parent = PrimaryPart
                                    end

                                    continue
                                end

                                warn("invaild", v92)
                            end
                        end

                        continue
                    end

                    local v17 = tostring(v6:GetAttribute("WeldTo"))

                    for v18, v19 in v6:GetDescendants() do
                        if v19:IsA("BasePart") then
                            v19.CanCollide = false
                            v19.Anchored = false
                            v19.CanTouch = false
                            v19.CanQuery = false
                            v19.Massless = true
                        end
                    end

                    v6.PrimaryPart = v6.Weld

                    if p1:FindFirstChild(v17, true) then
                        local v20 = p1:FindFirstChild(v17, true)

                        if not v20:IsA("BasePart") then
                            for v21, v22 in p1:GetDescendants() do
                                if v22:IsA("BasePart") and v22.Name == v17 then
                                    v20 = v22

                                    break
                                end
                            end
                        end

                        if v17 == "Cheese" then
                            v20 = p1.cheese.HumanoidRootPart
                        end

                        v6:PivotTo(v20.CFrame)
                        v6.Parent = p1

                        local PrimaryPart = v6.PrimaryPart
                        local v23 = PrimaryPart.CFrame:toObjectSpace(v20.CFrame)
                        local Weld = Instance.new("Weld")

                        Weld.Name = v20.Name
                        Weld.Part0 = PrimaryPart
                        Weld.Part1 = v20
                        Weld.C0 = v23
                        Weld.Parent = PrimaryPart
                    end

                    continue
                end

                warn("invaild",v7,v5)
            end
        end
    end

    if not (v1 and ReplicatedStorage.ClientAssets.Cosmetics[v2]:FindFirstChild(v3)) then
        return
    end

    -- if not table.find(tostring(ReplicatedStorage.ClientAssets.Cosmetics[v2]:FindFirstChild(v3):GetAttribute("Belongs")):split(","), v5) then return end

    local v26 = RequireUnlockedModule(ReplicatedStorage.ClientAssets.Cosmetics[v2]:FindFirstChild(v3))

    if ReplicatedStorage.ClientAssets.Cosmetics[v2]:FindFirstChild(v3):FindFirstChild("Anims") then
        print("CUSTOM ANIM")
        v9 = ReplicatedStorage.ClientAssets.Cosmetics[v2]:FindFirstChild(v3).Anims
    end

    if v26.Unique then v26.Unique(p1) end

    if v26.Types == "ColorBased" then
        print("yeah ColorBased")

        for v27, v28 in p1:GetDescendants() do
            if v28:IsA("BasePart") and v26.Color[tostring(v28.Color)] then
                v28.Color = v26.Color[tostring(v28.Color)]
            end
        end
    elseif v26.Types == "SpecficPart" then
        for v29, v30 in p1:GetDescendants() do
            if v30:IsA("BasePart") and table.find(v26.Find, v30.Name) then
                v30.Color = v26.Color
            end
        end
    end

    warn("color", v3)
end
return applycomestic -- applycomestic(game.Players.LocalPlayer.Character,game.Players.LocalPlayer.Character.OverlayModel)
