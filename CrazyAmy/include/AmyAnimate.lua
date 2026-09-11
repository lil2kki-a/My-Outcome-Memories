-- AmyAnimate (Client-side only, bypasses server checks)
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local AmyAnimate = {}

function AmyAnimate.setup(characterModel, animsFolder, sounds)
	sounds = sounds or {}
	local jumpSound = sounds.jumpSound
	local footstepSound = sounds.footstepSound

	local HumanoidRootPart = characterModel:FindFirstChild("HumanoidRootPart")
	local Humanoid = characterModel:FindFirstChild("Humanoid")
	if not HumanoidRootPart or not Humanoid then
		warn("AmyAnimate: characterModel is missing HumanoidRootPart or Humanoid")
		return nil
	end
	local Animator = Humanoid:FindFirstChild("Animator")
	if not Animator then
		warn("AmyAnimate: Humanoid has no Animator")
		return nil
	end

	local excludeAnims = { "Dies2011x" }
	local tracks = {}
	local currentState = characterModel:GetAttribute("State") or "default"
	local runSpeed = 0

	-- ---- helpers ----

	local function setanimations(animFolder, stateName)
		for _, anim in animFolder:GetChildren() do
			if anim:IsA("Animation") then
				local key = stateName or "unknown"
				if not tracks[key] then
					tracks[key] = {}
				end
				
				local track = Animator:LoadAnimation(anim)
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
			return warn("AmyAnimate: pls use a valid animation track")
		end
		track:Play()
		stopAll(track.Name)
	end

	-- ---- load top-level animations ----
	for _, anim in animsFolder:GetChildren() do
		if anim:IsA("Animation") and not table.find(excludeAnims, anim.Name) then
			local track = Animator:LoadAnimation(anim)
			tracks[string.lower(anim.Name)] = track
			if anim.Name == "Fall" then
				track.Priority = Enum.AnimationPriority.Movement
			elseif anim.Name == "ThrowHold" then
				track.Priority = Enum.AnimationPriority.Action4
			else
				track.Priority = Enum.AnimationPriority.Action
			end
		end
	end

	-- ---- load state animation sets ----
	for _, Child in ipairs(animsFolder:GetChildren()) do
		if Child:IsA("Folder") then 
			setanimations(Child, Child.Name:lower()) 
		end
	end

	-- ---- movement helpers ----
	local currentAnim = ""
	local isRunningFast = false
	local facingDirection = 1
	local baseWalkSpeed = Humanoid.WalkSpeed

	local function getMovementData()
		local horizontalVel = HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
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

	local function getMovementDirection()
		local horizontalVel = HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
		if horizontalVel.Magnitude > 2 then
			return horizontalVel.Unit
		end
		return Vector3.new(0, 0, 0)
	end

	local function updateRunSpeed()
		local horizontalVel = HumanoidRootPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
		runSpeed = horizontalVel.Magnitude
	end

	local function checkRunningFast()
		local speedBoost = tonumber(characterModel:GetAttribute("SpeedBoost")) or 1
		local threshold = speedBoost * 38 or 38
		isRunningFast = runSpeed >= threshold
		return isRunningFast
	end

	-- ---- humanoid state changes ----
	local landHeight = 0
	
	Humanoid.StateChanged:Connect(function(_, newState)
		if newState == Enum.HumanoidStateType.Jumping then
			if jumpSound then jumpSound:Play() end
			if tracks.fall then tracks.fall:Stop() end
			if tracks.fallh then tracks.fallh:Stop() end
			
			if currentState == "hammerless" then
				if tracks.jumph then
					if tracks.jumph.Looped then
						tracks.jumph.Looped = false
					end
					tracks.jumph:Play()
				end
			else
				if tracks.jump then
					if tracks.jump.Looped then
						tracks.jump.Looped = false
					end
					tracks.jump:Play()
				end
			end
			
		elseif newState == Enum.HumanoidStateType.Freefall then
			if currentState == "hammerless" then
				if tracks.fallh then tracks.fallh:Play() end
			else
				if tracks.fall then tracks.fall:Play() end
			end
			landHeight = Humanoid.RootPart.Position.Y
			
		elseif newState == Enum.HumanoidStateType.Landed then
			if tracks.jump then tracks.jump:Stop() end
			if tracks.fall then tracks.fall:Stop() end
			if tracks.jumph then tracks.jumph:Stop() end
			if tracks.fallh then tracks.fallh:Stop() end
			
			if landHeight - Humanoid.RootPart.Position.Y <= 25 then 
				return 
			end

			local position = Humanoid.RootPart.Position
			local rayParams = RaycastParams.new()
			rayParams.FilterDescendantsInstances = workspace:FindFirstChild("Players") and workspace.Players:GetChildren() or {}
			rayParams.FilterType = Enum.RaycastFilterType.Exclude
			local result = workspace:Raycast(position, Humanoid.RootPart.Position + Humanoid.RootPart.CFrame.LookVector * 30 - position, rayParams)

			if Humanoid.MoveDirection.Magnitude ~= 0 and not (result or characterModel:FindFirstChildOfClass("LinearVelocity") or characterModel:HasTag("Attack")) then
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

	-- ---- base heartbeat ----
	local connection = RunService.Heartbeat:Connect(function()
		if Humanoid.WalkSpeed <= 0 then return end

		local modelState = characterModel:GetAttribute("State")
		if currentState ~= modelState then
			currentState = modelState or "default"
			currentAnim = ""
			stopAll()
			return
		end

		updateRunSpeed()
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

		updateFacing()
		
		if tracks.default and tracks.default.walk then
			tracks.default.walk:AdjustSpeed(runSpeed / baseWalkSpeed * facingDirection)
		end
		if tracks.alt and tracks.alt.run then
			tracks.alt.run:AdjustSpeed(2)
		end
		if tracks.default and tracks.default.run then
			tracks.default.run:AdjustSpeed(runSpeed / 38 * facingDirection)
		end
		
		checkRunningFast()

		if moveDirection ~= Vector3.new(0, 0, 0) then
			if isRunningFast then
				if currentAnim ~= "run" then
					currentAnim = "run"
					if tracks[currentState] and tracks[currentState][currentAnim] then
						stopallandonlyplay(tracks[currentState][currentAnim])
					end
				end
			else
				if currentAnim ~= "walk" then
					currentAnim = "walk"
					if tracks[currentState] and tracks[currentState][currentAnim] then
						stopallandonlyplay(tracks[currentState][currentAnim])
					end
				end
			end
		else
			if currentAnim ~= "idle" then
				currentAnim = "idle"
				if tracks[currentState] and tracks[currentState][currentAnim] then
					stopallandonlyplay(tracks[currentState][currentAnim])
				end
			end
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

return AmyAnimate
