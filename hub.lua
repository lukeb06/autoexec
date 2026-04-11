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

local function breakVelocity()
	task.spawn(function()
		local speaker = game:GetService("Players").LocalPlayer
		local BeenASecond, V3 = false, Vector3.new(0, 0, 0)
		task.spawn(function()
			task.wait(1)
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
	local speaker = game:GetService("Players").LocalPlayer
	local TweenService = game:GetService("TweenService")

	if part:IsA("BasePart") then
		if
			speaker.Character:FindFirstChildOfClass("Humanoid")
			and speaker.Character:FindFirstChildOfClass("Humanoid").SeatPart
		then
			speaker.Character:FindFirstChildOfClass("Humanoid").Sit = false
			task.wait(0.1)
		end
		task.wait(0.1)
		TweenService
			:Create(getRoot(speaker.Character), TweenInfo.new(1, Enum.EasingStyle.Linear), { CFrame = part.CFrame })
			:Play()
	end
	breakVelocity()
end

WaitForGameAndPlayer()

local looped_functions = {}

local path_toggled = false
local path_vertical_offset = -3.5
table.insert(looped_functions, function()
	if path_toggled == true then
		local paths = game.Workspace:FindFirstChild("PATHS")
		if not paths then
			Instance.new("Folder", game.Workspace).Name = "PATHS"
		end

		for i, v in pairs(paths:GetChildren()) do
			v.Age.Value = v.Age.Value + 1
			if v.Age.Value > 3 then
				v:Destroy()
			end
		end

		local p = Instance.new("Part", paths)
		Instance.new("NumberValue", p).Name = "Age"
		p.Size = Vector3.new(5, 1, 5)
		p.Anchored = true
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char.HumanoidRootPart
		local hum = char and char.Humanoid

		if root and hum then
			local i = root.Position
			local s = root.Size.Y
			local h = hum.HipHeight

			p.Position = Vector3.new(i.x, (i.y - s / 2) - h + path_vertical_offset, i.z)
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

	Mouse.Button1Down:connect(function()
		if not ctrl_click_delete_toggled then
			return
		end
		if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
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
		if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
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

local PathSlider = UniversalTab:CreateSlider({
	Name = "Vertical Offset",
	Range = { -2, 0 },
	Increment = 0.1,
	Suffix = "",
	CurrentValue = -0.5,
	Flag = "PathVerticalOffset", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value)
		path_vertical_offset = value
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

			if hum then
				local knifeBackpack = plr.Backpack:FindFirstChild("Knife")

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

								if pChar and v ~= game:GetService("Players").LocalPlayer then
									pChar.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
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
					local root = char and char.HumanoidRootPart
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
				local backpack = plr and plr.Backpack

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
							local pBackpack = v.Backpack
							local pChar = v.Character

							local knifeBackpack = pBackpack and pBackpack:FindFirstChild("Knife")
							local knifePlayer = pChar and pChar:FindFirstChild("Knife")

							if knifeBackpack or knifePlayer then
								murderer = v
							end
						end

						local pChar = murderer and murderer.Character
						local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")

						if pRoot then
							plr.CameraMode = Enum.CameraMode.LockFirstPerson
							local pos = root.CFrame

							task.wait(0.1)

							root.CFrame = pRoot.CFrame * CFrame.new(0, 0, 1)

							local startTime = tick()
							local connection

							connection = game:GetService("RunService").RenderStepped:Connect(function()
								if tick() - startTime > 0.25 then -- how long to force the look (0.2 seconds here)
									connection:Disconnect()
									return
								end

								-- Better first-person feel: look from roughly head height
								local head = plr.Character:FindFirstChild("Head")
								local camPos = head and head.Position or root.Position + Vector3.new(0, 1.5, 0)

								camera.CFrame = CFrame.lookAt(camPos, pRoot.Position)
							end)

							task.wait(0.1)

							gunPlayer:Activate()

							task.wait(0.2)

							root.CFrame = pos -- return to original position
							plr.CameraMode = Enum.CameraMode.Classic

							task.wait(5)
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

	local PCHighlights = {}
	local computer_esp_toggled = true

	local Comp = 0

	task.spawn(function()
		while task.wait() do
			local GotComputers = 0
			for i, v in pairs(game.Workspace:GetChildren()) do
				if v:FindFirstChild("MapThumbnail") then
					for i2, v2 in pairs(v:GetChildren()) do
						if v2.Name == "ComputerTable" and v2:FindFirstChild("Screen") then
							GotComputers += 1
							if computer_esp_toggled then
								local Found = false
								for i3, v3 in pairs(PCHighlights) do
									if v3.Adornee == v2 then
										v3.FillColor = v2.Screen.Color
										Found = true
									end
								end
								if Found == false then
									local NewHighlight = Instance.new("Highlight")
									NewHighlight.FillColor = v2.Screen.Color
									NewHighlight.Adornee = v2
									NewHighlight.Parent = v2
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

	local FTFFreezePodKeybind = FTFTab:CreateKeybind({
		Name = "Teleport to Freeze Pod",
		CurrentKeybind = "F",
		HoldToInteract = false,
		Flag = "FTFFreezePodKeybind", -- A flag is the identifier for the configuration file. Make sure every element has a different flag if you're using configuration saving to ensure no overlaps
		Callback = function()
			local best_pod
			local best_pod_dist = 99999999

			local char = game:GetService("Players").LocalPlayer.Character
			local plrPos = char.HumanoidRootPart.Position

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

	task.spawn(function()
		local hidingFromBeast = false
		local oldPos
		local oldPosV

		local beast_max_dist = 20

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
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				if beastChar then
					if char then
						local dist = dist3d(char.HumanoidRootPart.Position, beastChar.HumanoidRootPart.Position)

						if dist < beast_max_dist then
							if not hidingFromBeast then
								oldPos = char.HumanoidRootPart.CFrame
								oldPosV = char.HumanoidRootPart.Position
								game.Workspace.Gravity = 0

								enableNoclip()

								task.wait(0.1)
								hidingFromBeast = true
							end
						end
					end
				elseif hidingFromBeast then
					char.HumanoidRootPart.CFrame = oldPos
					game.Workspace.Gravity = 196.2
					disableNoclip()
					hidingFromBeast = false
				end

				if hidingFromBeast then
					local testDist = dist3d(oldPosV, beastChar.HumanoidRootPart.Position)

					if testDist >= beast_max_dist then
						char.HumanoidRootPart.CFrame = oldPos
						game.Workspace.Gravity = 196.21
						disableNoclip()
						hidingFromBeast = false
					else
						local newPos = beastChar.HumanoidRootPart.CFrame * CFrame.new(0, -10, 0)
						char.HumanoidRootPart.CFrame = newPos

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

				char.HumanoidRootPart.CFrame = oldPos
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

Rayfield:LoadConfiguration()

if DexToggle.CurrentValue then
	dex_injected = true
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-DEX-Explorer-29920"))()
end

if IYToggle.CurrentValue then
	iy_injected = true
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end

path_vertical_offset = PathSlider.CurrentValue

task.spawn(function()
	while task.wait() do
		for i, v in pairs(looped_functions) do
			task.spawn(v)
		end
	end
end)
