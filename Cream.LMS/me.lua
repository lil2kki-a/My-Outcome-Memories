print("[Cream.LMS] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end

local function applyToModel(model)
	if not model then return end
    
    for _, v in ipairs(model:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Slate
        end
    end

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
                    local existing = dstPart:FindFirstChild(child.Name)
                    child.Parent = dstPart
                    if child.Name == "YiSang" then child:Destroy() end
                    if child.Name == "bubble" then 
                        child.LightEmission = 1
                        child.LightInfluence = 1
                    end
                end
            end
            srcPart.Part.ParticleEmitter.Parent = dstPart.Attachment
            dstPart.Attachment.ParticleEmitter.LockedToPart = true
        end
    end
    thatslikeevilandscary:Destroy()

    local eyes = model:FindFirstChild("eyes", true)
    if eyes and eyes:IsA("BasePart") then
        eyes.Material = Enum.Material.Neon
        eyes.Color = Color3.new(0, 0, 0)
    end

    local muzzle = model:FindFirstChild("muzzle", true)
    local drip = game:GetObjects("rbxassetid://84762690015926")[1]
    drip.Parent = muzzle
    drip.UVScale = Vector2.new(1.5, 1)

    local dress = model:FindFirstChild("dress", true)
    dress.Material = Enum.Material.Sandstone
end

local src = game:GetService("ReplicatedStorage")
src = src:FindFirstChild("Characters", true)
src = src:FindFirstChild("Cream", true)
src = src:FindFirstChild("Skins", true)
src = src:FindFirstChild("Default", true)
applyToModel(src)

local function walkPlayers()
    task.wait(1)
    for _, model in ipairs(workspace:WaitForChild("Players"):GetChildren()) do
    	if not model:IsA("Model") then continue end
    	if model:GetAttribute("Character") ~= "Cream" then continue end
    	applyToModel(model)
    end
end

walkPlayers()

_G.CreamLMSSkinGameStateConnection = _G.CreamLMSSkinGameStateConnection or nil
if _G.CreamLMSSkinGameStateConnection then
	_G.CreamLMSSkinGameStateConnection:Disconnect()
	_G.CreamLMSSkinGameStateConnection = nil
	print("[Cream.LMS] Previous game state connection destroyed")
end
_G.CreamLMSSkinGameStateConnection = workspace:WaitForChild("GameProperties"):WaitForChild("State").Changed:Connect(function(newState)
    if newState ~= "ING" then return end
	walkPlayers()
end)
