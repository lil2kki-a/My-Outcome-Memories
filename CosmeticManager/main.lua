print("[OM Cosmetic Manager] Now loading... Made by lil2kki <3")

if not game:IsLoaded() then game.Loaded:Wait() end

while game.ReplicatedStorage.ClientAssets.Characters:FindFirstChild("CosmeticManagerAvailableCharacters") do
game.ReplicatedStorage.ClientAssets.Characters:FindFirstChild("CosmeticManagerAvailableCharacters"):Destroy() end

local AvailableCharacters = game.ReplicatedStorage.ClientAssets.Characters.Survivors:Clone()
AvailableCharacters.Name = "CosmeticManagerAvailableCharacters"
AvailableCharacters.Parent = game.ReplicatedStorage.ClientAssets.Characters
for _, Character in ipairs(AvailableCharacters.Parent.EXE:GetChildren()) do
	Character:Clone().Parent = AvailableCharacters
	for _, Skin in ipairs(Character.Skins:GetChildren()) do
		if Skin.Name == "Default" then continue end
		if Skin.Name == "FeelstheRabbit" then continue end
		if Skin.Name == "OozingX" then continue end
		if Skin.Name == "gihun" then continue end
		if Skin.Name == "Yourself" then continue end
		if Skin.Name == "Glorbwire" then continue end
		if Skin.Name == "sirmartin" then continue end
		local SkinChar = Character:Clone()
		SkinChar.Name = Skin.Name
		SkinChar.Parent = AvailableCharacters
		SkinChar.Skins.Default:Destroy()
		SkinChar.Skins[Skin.Name].Name = "Default"
	end
end

local Cosmetics = game.ReplicatedStorage.ClientAssets.Cosmetics

local applycomestic = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/lil2kki-a/My-Outcome-Memories/refs/heads/main/applycomestic.lua"
))()

local FILE = "OMCosmeticManager.json"

_G.OMCosmeticManagerConfig = _G.OMCosmeticManagerConfig or {}

pcall(function() _G.OMCosmeticManagerConfig = game.HttpService:JSONDecode(readfile(FILE)) end)

local function save()
	pcall(function() writefile(FILE, game.HttpService:JSONEncode(_G.OMCosmeticManagerConfig)) end)
end

local function getItems(char)
	local t = {}
    for x in string.gmatch(_G.OMCosmeticManagerConfig[char] or "", "[^,]+") do table.insert(t, x) end
	return t
end

local NOT_FIRST_RUN = false

local function tryUpdatePlayer(player) task.spawn(function()
	if not player:IsA("Model") then return end

	if not player:FindFirstChild("cam") then player:WaitForChild("cam") end

	print("[OM Cosmetic Manager] Updating", player:GetFullName() .. "...")

	while player:FindFirstChild("CustomCosmeticModel", true) do
	player:FindFirstChild("CustomCosmeticModel", true):Destroy() end

	for _, item in ipairs(getItems(player:GetAttribute("Skin") == "Default" and player:GetAttribute("Character") or player:GetAttribute("Skin"))) do
		local OldItem = player:FindFirstChild(item, true)
		if OldItem then warn("[OM Cosmetic Manager] Destroyed old", OldItem:GetFullName()) OldItem:Destroy() end
		player:SetAttribute("EquippedCosmetics", item)
		pcall(applycomestic, player)
		local NewItem = player:FindFirstChild(item, true)
		if NewItem then NewItem.Name = "CustomCosmeticModel" end
	end

	local OverlayModel = player:FindFirstChild("OverlayModel") or player:WaitForChild("OverlayModel", 5)
	if OverlayModel then
		OverlayModel:SetAttribute("Character", player:GetAttribute("Character"))
		for _, item in ipairs(getItems(player:GetAttribute("Skin") == "Default" and player:GetAttribute("Character") or player:GetAttribute("Skin"))) do
			local OldItem = OverlayModel:FindFirstChild(item, true)
			if OldItem then warn("[OM Cosmetic Manager] Destroyed old", OldItem:GetFullName()) OldItem:Destroy() end
			OverlayModel:SetAttribute("EquippedCosmetics", item)
			pcall(applycomestic, OverlayModel)
			local NewItem = OverlayModel:FindFirstChild(item, true)
			if NewItem then NewItem.Name = "CustomCosmeticModel" end
		end
	else
		return
	end

	player.cam.Enabled = false
	player.cam.Enabled = true
end) end

_G.OMCosmeticManagerCharacterAddedConn = _G.OMCosmeticManagerCharacterAddedConn or nil
if _G.OMCosmeticManagerCharacterAddedConn then
	_G.OMCosmeticManagerCharacterAddedConn:Disconnect()
	print("[OM Cosmetic Manager] Previous OMCosmeticManagerCharacterAddedConn disconnected")
	NOT_FIRST_RUN = true
end
_G.OMCosmeticManagerCharacterAddedConn = game.Players.LocalPlayer.CharacterAdded:Connect(tryUpdatePlayer) 
tryUpdatePlayer(game.Players.LocalPlayer.Character)

if not NOT_FIRST_RUN then return game.StarterGui:SetCore("SendNotification", {
	Title = "OM Cosmetic Manager", 
	Text = "Working on your characters! Run script again to get config window.", 
	Icon = "rbxassetid://78729983278720", Duration = 10
}) end

local function hasItem(char, item)
	for _, x in ipairs(getItems(char)) do
		if x == item then return true end
	end
	return false
end

local function toggleItem(char, item)
	local t = getItems(char)
	for i, x in ipairs(t) do
		if x == item then
			table.remove(t, i)
			_G.OMCosmeticManagerConfig[char] = table.concat(t, ",")
			save()
			return
		end
	end
	table.insert(t, item)
	_G.OMCosmeticManagerConfig[char] = table.concat(t, ",")
	save()
end

local function new(class, props, parent)
	local x = Instance.new(class)
	for k, v in pairs(props or {}) do x[k] = v end
	x.Parent = parent
	return x
end

local function stroke(x, color, thick)
	if not x then return end
	local s = Instance.new("UIStroke")
	s.Color = color or Color3.fromRGB(139, 0, 0)
	s.Thickness = thick or 2
	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	s.BorderStrokePosition = Enum.BorderStrokePosition.Inner
	s.Parent = x
	return s
end

local old = game.Players.LocalPlayer.PlayerGui:FindFirstChild("CosmeticManager")
if old then old:Destroy() end

-- COLOR PALETTE
local C_BG_MAIN = Color3.fromRGB(10, 5, 5)
local C_BG_PANEL = Color3.fromRGB(18, 8, 8)
local C_BG_DARKER = Color3.fromRGB(8, 2, 2)
local C_ACCENT = Color3.fromRGB(180, 0, 0)
local C_ACCENT_BRIGHT = Color3.fromRGB(255, 0, 0)
local C_TEXT_MAIN = Color3.fromRGB(220, 220, 220)
local C_TEXT_DIM = Color3.fromRGB(120, 120, 120)
local C_TEXT_RED = Color3.fromRGB(255, 60, 60)

-- SCALING CONSTANTS
local screenSize = game.GuiService:GetGuiInset().X
local scale = math.min(workspace.CurrentCamera.ViewportSize.X / 1920, workspace.CurrentCamera.ViewportSize.Y / 1080)
local function s(x) return x * (scale) end

-- ROOT
local gui = new("ScreenGui", {
	Name = "CosmeticManager", 
	ResetOnSpawn = false, 
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
}, game.Players.LocalPlayer.PlayerGui)

local main = new("Frame", {
	Size = UDim2.fromOffset(s(1100), s(700)), 
	Position = UDim2.new(.5, -s(550), .5, -s(350)), 
	BackgroundColor3 = C_BG_MAIN, 
	BorderSizePixel = 0
}, gui)
stroke(main, C_ACCENT, 2)

-- TOP BAR
local bar = new("Frame", {
	Size = UDim2.new(1, 0, 0, s(56)), 
	BackgroundColor3 = C_BG_DARKER, 
	BorderSizePixel = 0
}, main)
stroke(bar, C_ACCENT, 1)

new("TextLabel", {
	Size = UDim2.new(1, -s(200), 1, 0), 
	Position = UDim2.fromOffset(s(18), 0), 
	BackgroundTransparency = 1, 
	Text = "C0SMETIC MANAGER", 
	TextColor3 = C_ACCENT_BRIGHT, 
	TextSize = s(34), 
	Font = Enum.Font.Arcade, 
	TextXAlignment = Enum.TextXAlignment.Left
}, bar)

local selectedInfo = new("TextLabel", {
	Size = UDim2.fromOffset(s(200), s(56)), 
	Position = UDim2.new(1, -s(280), 0, 0), 
	BackgroundTransparency = 1, 
	Text = "", 
	TextColor3 = C_TEXT_DIM, 
	TextSize = s(14), 
	Font = Enum.Font.Code, 
	TextXAlignment = Enum.TextXAlignment.Right
}, bar)

local close = new("TextButton", {
	Size = UDim2.fromOffset(s(260), s(42)), 
	Position = UDim2.new(1, -s(270), 0, s(7)), 
	BackgroundColor3 = Color3.fromRGB(90, 0, 0), 
	Text = "APPLY & CLOSE", 
	TextColor3 = Color3.fromRGB(255, 150, 150), 
	TextSize = s(18), 
	Font = Enum.Font.Arcade, 
	BorderSizePixel = 0, 
	AutoButtonColor = true
}, bar)
stroke(close, C_ACCENT_BRIGHT, 1)

close.MouseButton1Click:Connect(function()
	save()
	gui:Destroy()
	tryUpdatePlayer(game.Players.LocalPlayer.Character)
    game.StarterGui:SetCore("SendNotification", {
        Title = "OM Cosmetic Manager", 
        Text = "Saved and applied! Run script again to get config window back.", 
        Icon = "rbxassetid://78729983278720", Duration = 10
    })
end)

-- LEFT : CHARACTERS
local charPanel = new("Frame", {
	Size = UDim2.fromOffset(s(200), s(632)), 
	Position = UDim2.fromOffset(s(12), s(62)), 
	BackgroundColor3 = C_BG_PANEL, 
	BorderSizePixel = 0
}, main)
stroke(charPanel, Color3.fromRGB(60, 0, 0), 1)

new("TextLabel", {
	Size = UDim2.new(1, -s(18), 0, s(34)), 
	Position = UDim2.fromOffset(s(9), s(6)), 
	BackgroundTransparency = 1, 
	Text = "SUBJECTS", 
	TextColor3 = C_TEXT_RED, 
	TextSize = s(18), 
	Font = Enum.Font.Arcade, 
	TextXAlignment = Enum.TextXAlignment.Left
}, charPanel)

local charCount = new("TextLabel", {
	Size = UDim2.fromOffset(s(50), s(34)), 
	Position = UDim2.new(1, -s(58), 0, s(6)), 
	BackgroundTransparency = 1, 
	Text = tostring(#AvailableCharacters:GetChildren()), 
	TextColor3 = C_TEXT_DIM, 
	TextSize = s(12), 
	Font = Enum.Font.Code, 
	TextXAlignment = Enum.TextXAlignment.Right
}, charPanel)

local chars = new("ScrollingFrame", {
	Size = UDim2.new(1, -s(12), 1, -s(46)), 
	Position = UDim2.fromOffset(s(6), s(44)), 
	BackgroundTransparency = 1, 
	BorderSizePixel = 0, 
	ScrollBarThickness = s(6), 
	ScrollBarImageColor3 = C_ACCENT,
	ScrollBarImageTransparency = 0.2, 
	CanvasSize = UDim2.new()
}, charPanel)

local charLayout = new("UIListLayout", {
	Padding = UDim.new(0, s(6)), 
	SortOrder = Enum.SortOrder.Name
}, chars)

-- CENTER : CHARACTER PREVIEW
local prev = new("Frame", {
	Size = UDim2.fromOffset(s(340), s(632)), 
	Position = UDim2.fromOffset(s(220), s(62)), 
	BackgroundColor3 = C_BG_PANEL, 
	BorderSizePixel = 0
}, main)
stroke(prev, Color3.fromRGB(60, 0, 0), 1)

local charName = new("TextLabel", {
	Size = UDim2.new(1, -s(18), 0, s(36)), 
	Position = UDim2.fromOffset(s(9), s(6)), 
	BackgroundTransparency = 1, 
	Text = "", 
	TextColor3 = C_TEXT_MAIN, 
	TextSize = s(20), 
	Font = Enum.Font.Arcade, 
	TextXAlignment = Enum.TextXAlignment.Left
}, prev)

local charCosmetics = new("TextLabel", {
	Size = UDim2.new(1, -s(18), 0, s(26)), 
	Position = UDim2.fromOffset(s(9), s(34)), 
	BackgroundTransparency = 1, 
	Text = "", 
	TextColor3 = C_TEXT_DIM, 
	TextSize = s(12), 
	Font = Enum.Font.Code, 
	TextXAlignment = Enum.TextXAlignment.Left
}, prev)

local view = new("ViewportFrame", {
	Size = UDim2.new(1, -s(16), 1, -s(110)), 
	Position = UDim2.fromOffset(s(8), s(62)), 
	BackgroundColor3 = C_BG_DARKER, 
	BorderSizePixel = 0,
}, prev)
stroke(view, Color3.fromRGB(40, 0, 0), 1)

local controls = new("Frame", {
	Size = UDim2.new(1, -s(16), 0, s(36)), 
	Position = UDim2.fromOffset(s(8), prev.AbsoluteSize.Y - s(42)), 
	BackgroundTransparency = 1
}, prev)

local reset = new("TextButton", {
	Size = UDim2.fromOffset(s(120), s(32)), 
	Position = UDim2.new(.5, -s(60), 0, 0), 
	BackgroundColor3 = Color3.fromRGB(40, 10, 10), 
	Text = "RESET VIEW", 
	TextColor3 = C_TEXT_MAIN, 
	TextSize = s(14), 
	Font = Enum.Font.Code, 
	BorderSizePixel = 0, 
	AutoButtonColor = true
}, controls)
stroke(reset, Color3.fromRGB(80, 0, 0), 1)

-- RIGHT : COSMETICS
local content = new("Frame", {
	Size = UDim2.new(1, -s(580), 1, -s(68)), 
	Position = UDim2.fromOffset(s(567), s(62)), 
	BackgroundTransparency = 1
}, main)

local typeBar = new("Frame", {
	Size = UDim2.new(1, 0, 0, s(42)), 
	BackgroundTransparency = 1
}, content)

local typeList = new("ScrollingFrame", {
	Size = UDim2.new(1, 0, 1, 0), 
	BackgroundTransparency = 1, 
	BorderSizePixel = 0, 
	ScrollingDirection = Enum.ScrollingDirection.X, 
	ScrollBarThickness = 0, 
	CanvasSize = UDim2.new()
}, typeBar)

local typeLayout = new("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal, 
	Padding = UDim.new(0, s(5)), 
	SortOrder = Enum.SortOrder.Name
}, typeList)

local itemsBG = new("Frame", {
	Size = UDim2.new(1, 0, 1, -s(50)), 
	Position = UDim2.fromOffset(0, s(50)), 
	BackgroundColor3 = C_BG_PANEL, 
	BorderSizePixel = 0
}, content)
stroke(itemsBG, Color3.fromRGB(60, 0, 0), 1)

new("TextLabel", {
	Size = UDim2.new(1, -s(20), 0, s(36)), 
	Position = UDim2.fromOffset(s(10), s(4)), 
	BackgroundTransparency = 1, 
	Text = "ALTERATIONS", 
	TextColor3 = C_TEXT_RED, 
	TextSize = s(18), 
	Font = Enum.Font.Arcade, 
	TextXAlignment = Enum.TextXAlignment.Left
}, itemsBG)

local itemCount = new("TextLabel", {
	Size = UDim2.fromOffset(s(120), s(36)), 
	Position = UDim2.new(1, -s(130), 0, s(4)), 
	BackgroundTransparency = 1, 
	Text = "", 
	TextColor3 = C_TEXT_DIM, 
	TextSize = s(12), 
	Font = Enum.Font.Code, 
	TextXAlignment = Enum.TextXAlignment.Right
}, itemsBG)

local itemList = new("ScrollingFrame", {
	Size = UDim2.new(1, -s(12), 1, -s(44)), 
	Position = UDim2.fromOffset(s(6), s(42)), 
	BackgroundTransparency = 1, 
	BorderSizePixel = 0, 
	ScrollBarThickness = s(6), 
	ScrollBarImageColor3 = C_ACCENT,
	ScrollBarImageTransparency = 0.2, 
	CanvasSize = UDim2.new()
}, itemsBG)

local grid = new("UIGridLayout", {
	CellSize = UDim2.fromOffset(s(160), s(180)), 
	CellPadding = UDim2.fromOffset(s(8), s(8)), 
	SortOrder = Enum.SortOrder.Name,
	FillDirectionMaxCells = 5
}, itemList)

-- STATE
local current
local currentType
local previewModel
local previewCamera
local previewWorld
local angle = 0
local pitch = 8
local zoom = 1.52

local charButtons = {}
local typeButtons = {}
local itemButtons = {}

local blocked = {
	Emotes = true, 
	["BONELY I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU"] = true
}

-- PREVIEW
local function updateCamera()
	if not previewModel or not previewCamera then return end
	local ok, cf, size = pcall(function() return previewModel:GetBoundingBox() end)
	if not ok then return end

	local dist = math.max(size.X, size.Y, size.Z) * zoom
	local a = math.rad(angle)
	local p = math.rad(pitch)

	previewCamera.CFrame = CFrame.new(
		cf.Position + Vector3.new(
			math.sin(a) * math.cos(p) * dist, 
			math.sin(p) * dist + size.Y * .05, 
			math.cos(a) * math.cos(p) * -dist
		), 
		cf.Position + Vector3.new(0, size.Y * .05, 0)
	)
end

local function updateInfo()
	local t = getItems(current)
	charName.Text = current or ""
	charCosmetics.Text = #t > 0 and (#t .. " ALTERED") or "NO ALTERATIONS"
	selectedInfo.Text = current and ("[ " .. current .. " ]") or ""
end

local function preview()
	view:ClearAllChildren()
	previewModel = nil
	previewCamera = nil
	previewWorld = nil

	local char = AvailableCharacters:FindFirstChild(current)
	local skins = char and char:FindFirstChild("Skins")
	local default = skins and skins:FindFirstChild("Default")
	if not default then return end

	previewWorld = Instance.new("WorldModel")
	previewWorld.Parent = view

	previewModel = default:Clone()
	previewModel.Parent = previewWorld
	previewModel:SetAttribute("Character", current)

	for _, x in ipairs(previewModel:GetDescendants()) do
		if x:IsA("BasePart") then
			x.CanCollide = false
			x.CanTouch = false
			x.CanQuery = false
			x.Massless = true
		end
	end

	for _, item in ipairs(getItems(current)) do
		previewModel:SetAttribute("EquippedCosmetics", item)
		pcall(applycomestic, previewModel)
	end

	local hum = previewModel:FindFirstChildOfClass("Humanoid")
	local animator = hum:FindFirstChildOfClass("Animator")

	local tracks = {}
	for _, child in ipairs(char:FindFirstChild("Anims", true).Default:GetChildren()) do
		if child:IsA("Animation") then table.insert(tracks, animator:LoadAnimation(child)) end
	end
	
	local currentAnim = 1
	local track = nil
	local function playAnim()
		if not previewModel or not previewModel.Parent then return end
		track = tracks[currentAnim]
		track:Play(0.1)
		currentAnim = currentAnim % #tracks + 1
	end
	playAnim()
	task.spawn(function()
		while previewModel and previewModel.Parent do
			task.wait(3)
			track:Stop(0.1)
			if previewModel and previewModel.Parent then playAnim() end
		end
	end)

	previewCamera = Instance.new("Camera")
	previewCamera.Parent = view
	view.CurrentCamera = previewCamera
	updateCamera()
	updateInfo()
end

-- VISUAL STATES
local function updateChars()
	for name, b in pairs(charButtons) do
		local isSelected = name == current
		b.BackgroundColor3 = isSelected and Color3.fromRGB(80, 10, 10) or Color3.fromRGB(25, 8, 8)
		b.TextColor3 = isSelected and C_ACCENT_BRIGHT or C_TEXT_DIM
		local s = b:FindFirstChild("UIStroke")
		if s then s.Color = isSelected and C_ACCENT_BRIGHT or Color3.fromRGB(40, 0, 0) end
	end
end

local function updateTypes()
	for name, b in pairs(typeButtons) do
		local isSelected = name == currentType
		b.BackgroundColor3 = isSelected and Color3.fromRGB(90, 0, 0) or Color3.fromRGB(25, 8, 8)
		b.TextColor3 = isSelected and C_ACCENT_BRIGHT or C_TEXT_DIM
		local s = b:FindFirstChild("UIStroke")
		if s then s.Color = isSelected and C_ACCENT_BRIGHT or Color3.fromRGB(40, 0, 0) end
	end
end

local function updateItems()
	local selected = 0
	for _, item in ipairs(getItems(current)) do selected += 1 end
	itemCount.Text = selected .. " SELECTED"

	for name, b in pairs(itemButtons) do
		local on = hasItem(current, name)
		b.BackgroundColor3 = on and Color3.fromRGB(100, 0, 0) or Color3.fromRGB(25, 8, 8)

		local s = b:FindFirstChild("SelectStroke")
		if s then 
			s.Enabled = on 
			s.Color = on and C_ACCENT_BRIGHT or Color3.fromRGB(60, 0, 0)
		end

		local tag = b:FindFirstChild("SelectedTag")
		if tag then tag.Visible = on end
	end
	updateInfo()
end

-- ITEM PREVIEW
local function itemPreview(v, item)
	local world = Instance.new("WorldModel", v)
	local source

	if currentType == "Colors" then
		local char = AvailableCharacters:FindFirstChild(current)
		local skins = char and char:FindFirstChild("Skins")
		source = skins and skins:FindFirstChild("Default")
	else
		source = item
	end

	if not source then return end

	local clone = source:Clone()
	clone.Parent = world

	for _, x in ipairs(clone:GetDescendants()) do
		if x:IsA("BasePart") then
			x.Anchored = true
			x.CanCollide = false
			x.CanTouch = false
			x.CanQuery = false
		end
	end

	if currentType == "Colors" then
		clone:SetAttribute("Character", current)
		clone:SetAttribute("EquippedCosmetics", item.Name)
		pcall(applycomestic, clone)
	end

	local ok, cf, size = pcall(function() return clone:GetBoundingBox() end)
	if not ok then return end

	local cam = Instance.new("Camera", v)
	v.CurrentCamera = cam

	local dist = math.max(size.X, size.Y, size.Z) * 1.85
	cam.FieldOfView = 38
	cam.CFrame = CFrame.new(
		cf.Position + Vector3.new(0, size.Y * .05, -dist), 
		cf.Position + Vector3.new(0, size.Y * .05, 0)
	)
end

-- SHOW TYPE
local function showType(name)
	currentType = name
	updateTypes()

	for _, x in ipairs(itemList:GetChildren()) do
		if not x:IsA("UIGridLayout") then x:Destroy() end
	end
	itemButtons = {}

	local folder = Cosmetics:FindFirstChild(name)
	if not folder then return end

	for _, item in ipairs(folder:GetChildren()) do
		local b = new("TextButton", {
			BackgroundColor3 = Color3.fromRGB(25, 8, 8), 
			BorderSizePixel = 0, 
			Text = "", 
			AutoButtonColor = true
		}, itemList)
		stroke(b, Color3.fromRGB(60, 0, 0), 1).Name = "SelectStroke"

		local v = new("ViewportFrame", {
			Size = UDim2.new(1, -s(8), 1, -s(44)), 
			Position = UDim2.fromOffset(s(4), s(4)), 
			BackgroundColor3 = C_BG_DARKER, 
			BorderSizePixel = 0,
			LightDirection = Vector3.new(-1, -2, -1)
		}, b)

		itemPreview(v, item)

		if not item:GetAttribute("Belongs") then item:SetAttribute("Belongs", "UNKNOWN") end

		new("TextLabel", {
			Size = UDim2.new(1, -s(10), 0, s(34)), 
			Position = UDim2.new(0, s(5), 1, -s(38)), 
			BackgroundTransparency = 1, 
			Text = item.Name .. "\n[ " .. item:GetAttribute("Belongs") .. " ]", 
			TextColor3 = C_TEXT_MAIN, 
			TextSize = s(16), 
			Font = Enum.Font.Code, 
			TextTruncate = Enum.TextTruncate.AtEnd
		}, b)

		local tag = new("TextLabel", {
			Name = "SelectedTag", 
			Size = UDim2.fromOffset(s(65), s(22)), 
			Position = UDim2.fromOffset(s(6), s(6)), 
			BackgroundColor3 = C_ACCENT_BRIGHT, 
			Text = "ACTIVE", 
			TextColor3 = Color3.fromRGB(0, 0, 0), 
			TextSize = s(11), 
			Font = Enum.Font.Arcade, 
			Visible = false
		}, b)

		itemButtons[item.Name] = b

		b.MouseButton1Click:Connect(function()
			toggleItem(current, item.Name)
			updateItems()
			preview()
			if currentType == "Colors" then showType("Colors") end
		end)
	end

	task.wait()
	itemList.CanvasSize = UDim2.fromOffset(0, grid.AbsoluteContentSize.Y + s(8))

	updateItems()
end

-- CHARACTERS
for _, char in ipairs(AvailableCharacters:GetChildren()) do
	local b = new("TextButton", {
		Size = UDim2.new(1, -s(4), 0, s(38)), 
		BackgroundColor3 = Color3.fromRGB(25, 8, 8), 
		Text = "   " .. char.Name, 
		TextColor3 = C_TEXT_DIM, 
		TextSize = s(15), 
		Font = Enum.Font.Code, 
		BorderSizePixel = 0, 
		AutoButtonColor = true, 
		TextXAlignment = Enum.TextXAlignment.Left
	}, chars)
	stroke(b, Color3.fromRGB(40, 0, 0), 1)

	charButtons[char.Name] = b

	b.MouseButton1Click:Connect(function()
		current = char.Name
		_G.OMCosmeticManagerConfig[current] = _G.OMCosmeticManagerConfig[current] or ""
		angle = 0
		pitch = 8
		zoom = 1.52
		updateChars()
		updateItems()
		preview()
		if currentType == "Colors" then showType("Colors") end
	end)
end

task.wait()
chars.CanvasSize = UDim2.fromOffset(0, charLayout.AbsoluteContentSize.Y + s(6))

-- TYPES
for _, folder in ipairs(Cosmetics:GetChildren()) do
	if not blocked[folder.Name] then
		local b = new("TextButton", {
			Size = UDim2.fromOffset(math.max(s(90), #folder.Name * s(10) + s(30)), s(34)), 
			BackgroundColor3 = Color3.fromRGB(25, 8, 8), 
			Text = folder.Name, 
			TextColor3 = C_TEXT_DIM, 
			TextSize = s(14), 
			Font = Enum.Font.Code, 
			BorderSizePixel = 0, 
			AutoButtonColor = true
		}, typeList)
		stroke(b, Color3.fromRGB(40, 0, 0), 1)

		typeButtons[folder.Name] = b

		b.MouseButton1Click:Connect(function()
			showType(folder.Name)
		end)
	end
end

task.wait()
typeList.CanvasSize = UDim2.fromOffset(typeLayout.AbsoluteContentSize.X + s(8), 0)

-- INITIAL
local firstChar = AvailableCharacters:GetChildren()[1]
if firstChar then
	current = firstChar.Name
	_G.OMCosmeticManagerConfig[current] = _G.OMCosmeticManagerConfig[current] or ""
end

for _, folder in ipairs(Cosmetics:GetChildren()) do
	if not blocked[folder.Name] then
		showType(folder.Name)
		break
	end
end

updateChars()
preview()
updateItems()

-- PREVIEW CONTROLS
local rotating = false
local lastMouse

view.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
		rotating = true
		lastMouse = game.UserInputService:GetMouseLocation()
	end
end)

game.UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
		rotating = false
	end
end)

game.UserInputService.InputChanged:Connect(function(input)
	if rotating and input.UserInputType == Enum.UserInputType.MouseMovement then
		local mouse = game.UserInputService:GetMouseLocation()
		local delta = mouse - lastMouse
		lastMouse = mouse
		angle -= delta.X * .5
		pitch = math.clamp(pitch - delta.Y * .25, -25, 25)
		updateCamera()
	end

	if input.UserInputType == Enum.UserInputType.MouseWheel then
		local mouse = game.UserInputService:GetMouseLocation()
		local pos = view.AbsolutePosition
		local size = view.AbsoluteSize
		if mouse.X >= pos.X and mouse.X <= pos.X + size.X and mouse.Y >= pos.Y and mouse.Y <= pos.Y + size.Y then
			zoom = math.clamp(zoom - input.Position.Z * .12, .55, 2)
			updateCamera()
		end
	end
end)

reset.MouseButton1Click:Connect(function()
	angle = 0
	pitch = 8
	zoom = 1.52
	updateCamera()
end)

-- DRAG WINDOW
local dragging = false
local dragStart
local startPos

bar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

game.UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local d = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale, 
			startPos.X.Offset + d.X, 
			startPos.Y.Scale, 
			startPos.Y.Offset + d.Y
		)
	end
end)
