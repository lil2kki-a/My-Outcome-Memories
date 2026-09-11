-- CreamAnimate (local, no key/RemoteEvent)
-- Usage: local Animate = require(path.to.CreamAnimate)
--        local controller = Animate.setup(characterModel, animsFolder, sounds)
-- sounds is optional: { jumpSound = Sound, footstepSound = Sound }
game.LogService:Info("Running thaLILNIKKI/Cream.LMS-Outcome-Memories/CreamAnimate.lua, version 3")

local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local CreamAnimate = {}

function CreamAnimate.setup(characterModel, animsFolder, sounds)
	sounds = sounds or {}
	local jumpSound = sounds.jumpSound
	local footstepSound = sounds.footstepSound

	local HumanoidRootPart = characterModel:FindFirstChild("HumanoidRootPart")
	local Humanoid = characterModel:FindFirstChild("Humanoid")
	if not HumanoidRootPart or not Humanoid then
		warn("CreamAnimate: characterModel is missing HumanoidRootPart or Humanoid")
		return nil
	end
	local Animator = Humanoid:FindFirstChild("Animator")
	if not Animator then
		warn("CreamAnimate: Humanoid has no Animator")
		return nil
	end

	local excludeAnims = { "Dies2011x" }
	local tracks = {}       -- [stateName][lowerAnimName] = AnimationTrack  OR  [lowerAnimName] = AnimationTrack (top-level)
	local currentState = characterModel:GetAttribute("State") or "default"

	-- runSpeed is computed from velocity in Heartbeat so it works on other players' characters too
	-- (Humanoid.Running only fires on the controlling client, not for remote characters)
	local runSpeed = 0

	-- ---- helpers ----

	local function setanimations(animFolder, stateName)
		local cheese = characterModel:FindFirstChild("cheese")
		for _, anim in animFolder:GetChildren() do
			if anim:IsA("Animation") then
				local key = stateName or "unknown"
				if not tracks[key] then
					tracks[key] = {}
				end
				local isCheese = string.match(anim.Name, "Cheese")
				local targetAnimator = if isCheese and cheese and cheese:FindFirstChild("Humanoid") then cheese.Humanoid:FindFirstChild("Animator") or cheese.Humanoid:FindFirstChildOfClass("Animator") else Animator
				local track = targetAnimator:LoadAnimation(anim)
				tracks[key][string.lower(anim.Name)] = track
				track.Priority = Enum.AnimationPriority[anim:GetAttribute("type") or "Core"]
				track:GetMarkerReachedSignal("step"):Connect(function()
					if Humanoid.FloorMaterial == Enum.Material.Air then
						return
					end
					if footstepSound then
						footstepSound:Play()
					end
				end)
			end
		end
	end

	local function stopAll(exceptName)
		for _, stateTracks in pairs(tracks) do
			if stateTracks and typeof(stateTracks) == "table" then
				for _, track in pairs(stateTracks) do
					if exceptName ~= track.Name then
						track:Stop()
					end
				end
			end
		end
	end

	local function stopallandonlyplay(track)
		if not track then
			return warn("CreamAnimate: pls use a valid animation track")
		end
		local cheese = characterModel:FindFirstChild("cheese")
		track:Play()
		stopAll(track.Name)
		if not cheese then return end
		local cheeseTrack = tracks.default and tracks.default["cheese" .. string.lower(track.Name)]
		if cheeseTrack then
			cheeseTrack:Play()
		end
	end

	-- ---- load top-level animations ----
	for _, anim in animsFolder:GetChildren() do
		if anim:IsA("Animation") and not table.find(excludeAnims, anim.Name) then
			local track = Animator:LoadAnimation(anim)
			tracks[string.lower(anim.Name)] = track
			track.Priority = if anim.Name == "Fall" then Enum.AnimationPriority.Movement else Enum.AnimationPriority.Action
		end
	end

	-- ---- load state animation sets ----
	for _, Child in ipairs(animsFolder:GetChildren()) do
		if Child:IsA("Folder") then setanimations(Child, Child.Name:lower()) end
	end

	-- ---- movement helpers ----
	local currentAnim = ""
	local isRunningFast = false
	local facingDirection = 1
	local baseWalkSpeed = Humanoid.WalkSpeed

	local function getMovementData()
		local horizontalVel = HumanoidRootPart.Velocity * Vector3.new(1, 0, 1)
		if horizontalVel.Magnitude > 2 then
			local unit = horizontalVel.Unit
			return {
				HumanoidRootPart.CFrame.LookVector:Dot(unit),
				HumanoidRootPart.CFrame.RightVector:Dot(unit),
			}
		end
		return { 0, 0 }
	end

	local function updateFacing()
		local data = getMovementData()
		if data[1] >= 0.5 then
			facingDirection = 1
		elseif data[1] <= -0.5 then
			facingDirection = -1
		end
	end

	-- ---- get movement direction from velocity (works for dummy players) ----
	local function getMovementDirection()
		-- Try to use Humanoid.MoveDirection first (works on controlled character)
		local moveDir = Humanoid.MoveDirection
		if moveDir.Magnitude > 0 then
			return moveDir
		end

		-- Fallback: use velocity magnitude to detect movement (works on dummy/remote characters)
		local horizontalVel = HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
		if horizontalVel.Magnitude > 2 then
			return horizontalVel.Unit
		end

		return Vector3.new(0, 0, 0)
	end

	-- ---- humanoid state changes (jump / fall / land / roll) ----
	local landHeight = 0
	Humanoid.StateChanged:Connect(function(_, newState)
		if newState == Enum.HumanoidStateType.Jumping then
			if jumpSound then jumpSound:Play() end
			if tracks.fall then tracks.fall:Stop() end
			if tracks.jump then
				if not tracks.jump.Looped then
					tracks.jump:Play()
					return
				end
				tracks.jump.Looped = false
				tracks.jump:Play()
			end
		elseif newState == Enum.HumanoidStateType.Freefall then
			if tracks.fall then tracks.fall:Play() end
			landHeight = Humanoid.RootPart.Position.Y
		elseif newState == Enum.HumanoidStateType.Landed then
			if tracks.jump then tracks.jump:Stop() end
			if tracks.fall then tracks.fall:Stop() end
			if landHeight - Humanoid.RootPart.Position.Y <= 25 then return end

			local position = Humanoid.RootPart.Position
			local rayParams = RaycastParams.new()
			rayParams.FilterDescendantsInstances = workspace:FindFirstChild("Players") and workspace.Players:GetChildren() or {}
			rayParams.FilterType = Enum.RaycastFilterType.Exclude
			local result = workspace:Raycast(position, Humanoid.RootPart.Position + Humanoid.RootPart.CFrame.LookVector * 30 - position, rayParams)

			if Humanoid.MoveDirection.Magnitude ~= 0 and not (result or characterModel:FindFirstChildOfClass("LinearVelocity")) then
				local rolling = Instance.new("BodyVelocity")
				rolling.Name = "Rolling"
				rolling.Parent = HumanoidRootPart
				rolling.MaxForce = Vector3.new(1, 1, 1) * math.huge
				rolling.Velocity = Humanoid.RootPart.CFrame.LookVector * 80 - Vector3.new(0, 2, 0)
				Debris:AddItem(rolling, 0.35)
				if tracks.roll then tracks.roll:Play() end
				return
			end

			if tracks.land then
				tracks.land:Play()
				tracks.land:AdjustSpeed(5)
				if tracks.land.Looped then
					tracks.land.Looped = false
				end
			end
		end
	end)

	-- ---- health / hit reaction ----
	local lastHealth = 100
	local healthPart = characterModel:FindFirstChild("Health")
	if healthPart then
		healthPart.Changed:Connect(function(health)
			if health < lastHealth and health - lastHealth <= -2 then
				if tracks.hitted then
					tracks.hitted:Play(0.01, 100 / health, 1 - health / 100)
				end
			end
			lastHealth = health
		end)
	end

	-- ---- glide (flies) ----
	local isGliding = false
	Humanoid.RootPart.ChildAdded:Connect(function(child)
		if child.Name ~= "flies" or isGliding then return end
		isGliding = true
		if tracks.glide then tracks.glide:Play() end
	end)
	Humanoid.RootPart.ChildRemoved:Connect(function(child)
		if child.Name ~= "flies" or not isGliding then return end
		isGliding = false
		if tracks.glide then tracks.glide:Stop() end
	end)

	-- ---- heartbeat: state-based animation switching ----
	local connection = RunService.Heartbeat:Connect(function()
		if Humanoid.WalkSpeed <= 0 then return end

		local modelState = characterModel:GetAttribute("State")
		if currentState ~= modelState then
			currentState = modelState or "default"
			currentAnim = ""
			stopAll()
			return
		end

		-- Get movement direction (works for dummy players too)
		local moveDirection = getMovementDirection()

		if currentState == "downed" and tracks.fall and tracks.fall.IsPlaying then
			tracks.fall:Stop()
		end
		if Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall and tracks.fall and tracks.fall.IsPlaying then
			tracks.fall:Stop()
		end

		if characterModel:GetAttribute("Pause") == true then
			currentAnim = ""
			stopAll()
			return
		end

		-- Compute runSpeed from actual velocity so it works on remote characters
		local horizontalVel = HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
		runSpeed = horizontalVel.Magnitude

		updateFacing()
		if tracks.default and tracks.default.run then
			tracks.default.run:AdjustSpeed(runSpeed / 20 * facingDirection)
		end
		if tracks.canon and tracks.canon.walk then
			tracks.canon.walk:AdjustSpeed(runSpeed / baseWalkSpeed * facingDirection)
		end
		-- Use velocity (replicated) instead of WalkSpeed (may not replicate for remote characters)
		isRunningFast = runSpeed >= 17

		if moveDirection ~= Vector3.new(0, 0, 0) and currentAnim ~= "walk" and not isRunningFast then
			currentAnim = "walk"
			if tracks[currentState] and tracks[currentState][currentAnim] then
				stopallandonlyplay(tracks[currentState][currentAnim])
			end
			return
		end
		if moveDirection ~= Vector3.new(0, 0, 0) and currentAnim ~= "run" and isRunningFast then
			currentAnim = "run"
			if tracks[currentState] and tracks[currentState][currentAnim] then
				stopallandonlyplay(tracks[currentState][currentAnim])
			end
			return
		end
		if moveDirection ~= Vector3.new(0, 0, 0) or (currentAnim == "idle" or Humanoid:GetState() ~= Enum.HumanoidStateType.Running) then
			return
		end
		currentAnim = "idle"
		if tracks[currentState] and tracks[currentState][currentAnim] then
			stopallandonlyplay(tracks[currentState][currentAnim])
		end
	end)

	-- ---- public controller ----
	local controller = {}

	function controller.play(stateName, animName)
		local state = string.lower(stateName or "")
		local anim = string.lower(animName or "")
		if tracks[state] and tracks[state][anim] then
			tracks[state][anim]:Play()
		elseif tracks[anim] then
			tracks[anim]:Play()
		end
	end

	function controller.stop(animName)
		local anim = string.lower(animName or "")
		if tracks[anim] then
			tracks[anim]:Stop()
		end
		-- also check inside state tables
		for _, stateTracks in pairs(tracks) do
			if stateTracks and typeof(stateTracks) == "table" and stateTracks[anim] then
				stateTracks[anim]:Stop()
			end
		end
	end

	function controller.stopAll()
		stopAll()
	end

	function controller.getTracks()
		return tracks
	end

	function controller.destroy()
		connection:Disconnect()
		stopAll()
	end

	return controller
end

return CreamAnimate
