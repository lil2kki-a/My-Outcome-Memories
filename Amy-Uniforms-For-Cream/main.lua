-- Uncomment to use black or blue maid outfit:
-- _G.CreamAmyUniformCosmeticName = "AmyOutfitBlack"
-- _G.CreamAmyUniformCosmeticName = "AmyOutfitBlue"

-- Default:
-- _G.CreamAmyUniformCosmeticName = "AmyUniform"

print("[AmyUniformOnCream] Now loading... Made by lil2kki <3")

-- Amy body part names -> Cream equivalent body part names + rotation offset
-- Amy's parts are rotated -90° on Y relative to Cream's parts
local WELD_MAP = {
	["Lstart"] = {part = "Left Sleeve", 	offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(-90), 0)},
	["MainTorso"] = {part = "Body", 		offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(-90), 0)},
	["RStart"] = {part = "Right Sleeve", 	offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, math.rad(-90), 0)},
}

-- Compatibility layer for Old Cream structure.
-- In the normal Cream rig, the forearm inside the ls/rs sub-models is named
-- "Left Sleevee" / "Right Sleevee" (extra 'e'), so FindFirstChild("Left Sleeve", true)
-- correctly returns the root-level upper-arm MeshPart.
-- In the OLD Cream rig, the forearm inside ls/rs is named
-- "Left Sleeve" / "Right Sleeve" (identical to the root-level part), so a recursive
-- FindFirstChild finds the wrong (nested) part first in depth-first order.
-- This function prefers root-level (direct child) BaseParts, then checks inside the
-- Torso sub-model, and only falls back to a full recursive search as a last resort.
local function findTargetPart(character, partName)
	-- 1. Try direct children first (works for root-level parts like "Left Sleeve", "Right Sleeve")
	local direct = character:FindFirstChild(partName)
	if direct and direct:IsA("BasePart") then
		return direct
	end

	-- 2. Try inside the Torso sub-model (works for "Body", "dress", etc. in both structures)
	local torso = character:FindFirstChild("Torso")
	if torso then
		local torsoPart = torso:FindFirstChild(partName)
		if torsoPart and torsoPart:IsA("BasePart") then
			return torsoPart
		end
	end

	-- 3. Full recursive fallback (last resort)
	local found = character:FindFirstChild(partName, true)
	if found and found:IsA("BasePart") then
		return found
	end

	return nil
end

-- Cream body parts to hide when AmyUniform is applied
-- (equivalent to what the Unique module does for Amy)
local HIDE_PARTS = {
	["Body"] = true,
	["dress"] = true,
	["tail"] = true,
	["Sphere.025"] = true,
	["Sphere.031"] = true,
	["Left Sleeve"] = true,
	["Right Sleeve"] = true,
}

local function weld(part0, part1)
	local c0 = part0.CFrame:ToObjectSpace(part1.CFrame)
	local w = Instance.new("Weld")
	w.Name = part1.Name
	w.Part0 = part0
	w.Part1 = part1
	w.C0 = c0
	w.Parent = part0
end

local function applyAmyUniform(character)
	-- Wait character build
	character:WaitForChild("Animate")

	-- Check Character Attribute
	if character:GetAttribute("Character") ~= "Cream" then return end

	-- Cleanup any previous stuff
	for _, child in character:GetDescendants() do
		if child:GetAttribute("AmyUniformCosmetic") then child:Destroy() end
	end

	print("[AmyUniformOnCream] Updating", character:GetFullName())

	-- Hide Cream body parts covered by the uniform
	for _, desc in character:GetDescendants() do
		if desc:IsA("BasePart") and HIDE_PARTS[desc.Name] then
			desc.Transparency = 1
		end
	end

	-- Clone cosmeticccc
	local cosmetic = game.ReplicatedStorage.ClientAssets.Cosmetics.Body[(_G.CreamAmyUniformCosmeticName or "AmyUniform")]:Clone()

	-- Process each Model child (each has a WeldTo attribute and a Weld part)
	for _, child in ipairs(cosmetic:GetChildren()) do
		if child:IsA("Model") then
			child:SetAttribute("AmyUniformCosmetic", true)

			local weldToName = child:GetAttribute("WeldTo")
			if not weldToName then
				continue
			end

			-- Map Amy part name to Cream equivalent + rotation offset
			local mapping = WELD_MAP[weldToName]
			if not mapping then
				warn("[AmyUniformOnCream] No mapping for WeldTo '" .. weldToName .. "'")
				continue
			end

			local targetPart = findTargetPart(character, mapping.part)
			if not targetPart then
				warn("[AmyUniformOnCream] Could not find target part '" .. mapping.part .. "' on Cream character")
				continue
			end

			-- Set PrimaryPart to the Weld part inside this model
			local weldPart = child:FindFirstChild("Weld")
			if weldPart and weldPart:IsA("BasePart") then
				child.PrimaryPart = weldPart
			end

			-- Disable collision and physics on all cosmetic parts
			for _, desc in child:GetDescendants() do
				child:SetAttribute("AmyUniformCosmetic", true)
				if desc:IsA("BasePart") then
					desc.CanCollide = false
					desc.Anchored = false
					desc.CanTouch = false
					desc.CanQuery = false
					desc.Massless = true
				end
			end

			-- Position the cosmetic model at the target part with rotation offset and weld it
			if child.PrimaryPart then
				child:PivotTo(targetPart.CFrame * mapping.offset)
				child.Parent = character
				weld(targetPart, child.PrimaryPart)
			end
		end
	end

	-- Remove the Unique module from the clone (already handled via HIDE_PARTS above)
	local uniqueModule = cosmetic:FindFirstChild("Unique")
	if uniqueModule then
		uniqueModule.Parent = nil
	end
end

local function onPlayerAdded(player)
	-- Check if they already spawned in
	if player.Character then applyAmyUniform(player.Character) end
	 -- Listen for the player (re)spawning
	_G.CreamAmyUniformCharacterAddedConn = _G.CreamAmyUniformCharacterAddedConn or {}
    if _G.CreamAmyUniformCharacterAddedConn[player.Name] then
        _G.CreamAmyUniformCharacterAddedConn[player.Name]:Disconnect()
        print("[AmyUniformOnCream] Previous CreamAmyUniformCharacterAddedConn disconnected for", player.Name)
    end
    _G.CreamAmyUniformCharacterAddedConn[player.Name] = player.CharacterAdded:Connect(applyAmyUniform)
end

for _, player in game.Players:GetPlayers() do onPlayerAdded(player) end

_G.CreamAmyUniformPlayerAddedConn = _G.CreamAmyUniformPlayerAddedConn or nil
if _G.CreamAmyUniformPlayerAddedConn then
	_G.CreamAmyUniformPlayerAddedConn:Disconnect()
	_G.CreamAmyUniformPlayerAddedConn = nil
	print("[AmyUniformOnCream] Previous CreamAmyUniformPlayerAddedConn disconnected")
end
_G.CreamAmyUniformPlayerAddedConn = game.Players.PlayerAdded:Connect(onPlayerAdded)

local ReplicatedStorageCream = game.ReplicatedStorage.ClientAssets.Characters.Survivors.Cream.Skins.Default
ReplicatedStorageCream.Parent.Parent.scriptstuff.Animate:Clone().Parent = ReplicatedStorageCream
ReplicatedStorageCream:SetAttribute("Character", "Cream")
applyAmyUniform(ReplicatedStorageCream)
ReplicatedStorageCream.Animate:Destroy()
