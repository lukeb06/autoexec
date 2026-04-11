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
		enableNoclip()
		task.spawn(function()
			task.wait(1)
			BeenASecond = true
			disableNoclip()
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
		local i = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
		p.Position = Vector3.new(i.x, i.y + path_vertical_offset, i.z)
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
	Range = { -5, 0 },
	Increment = 0.1,
	Suffix = "",
	CurrentValue = -3.5,
	Flag = "PathVerticalOffsetSlider", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
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

function updateUniversalESP(highlights, color, enabled)
	for i, v in pairs(highlights) do
		if not enabled then
			table.remove(highlights, i)
			v:Destroy()
		elseif v.Adornee == nil or v.Adornee.Parent == nil then
			table.remove(highlights, i)
			v:Destroy()
		end
	end

	if enabled then
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Character and v ~= game:GetService("Players").LocalPlayer then
				local NewHighlight = Instance.new("Highlight")
				NewHighlight.Adornee = v.Character
				NewHighlight.FillColor = color
				NewHighlight.Parent = v.Character
				table.insert(highlights, NewHighlight)
			end
		end
	else
		for i, v in pairs(highlights) do
			v:Destroy()
		end
	end
end

local universal_esp_highlights = {}
local UniversalESPToggle = UniversalTab:CreateToggle({
	Name = "Universal ESP",
	CurrentValue = false,
	Flag = nil,
	Callback = function(value)
		updateUniversalESP(universal_esp_highlights, Color3.fromRGB(255, 0, 0), value)
	end,
})

local ussPlr = game:GetService("Players").LocalPlayer
local ussChar = ussPlr and ussPlr.Character
local ussHum = ussChar and ussChar.Humanoid

local ussSpeed = (ussHum and ussHum.WalkSpeed) or 16

task.spawn(function()
	while task.wait() do
		game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = ussSpeed
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

-- Flee The Facility

if game.PlaceId == 893973440 then
	local FTFTab = Window:CreateTab("Flee The Facility", "gamepad-2")
	local FTFESPSection = FTFTab:CreateSection("ESP")

	local BeastHighlights = {}
	local beast_esp_toggled = true
	function UpdateBeastESP()
		for i, v in pairs(BeastHighlights) do
			if not beast_esp_toggled then
				table.remove(BeastHighlights, i)
				v:Destroy()
			elseif v.Adornee == nil then
				table.remove(BeastHighlights, i)
				v:Destroy()
			end
		end
		if beast_esp_toggled then
			for i, v in pairs(game.Players:GetPlayers()) do
				if v.Character and v.Character:FindFirstChild("BeastPowers") and v ~= game.Players.LocalPlayer then
					local NewHighlight = Instance.new("Highlight")
					NewHighlight.Adornee = v.Character
					NewHighlight.Parent = v.Character
					table.insert(BeastHighlights, NewHighlight)
				end
			end
		else
			for i, v in pairs(BeastHighlights) do
				v:Destroy()
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

	local PlrHighlights = {}
	local player_esp_toggled = true
	function UpdatePlrESP()
		for i, v in pairs(PlrHighlights) do
			if not player_esp_toggled then
				table.remove(PlrHighlights, i)
				v:Destroy()
			elseif v.Adornee == nil or v.Adornee.Parent == nil or v.Adornee.Parent:FindFirstChild("BeastPowers") then
				table.remove(PlrHighlights, i)
				v:Destroy()
			end
		end
		if player_esp_toggled then
			for i, v in pairs(game.Players:GetPlayers()) do
				if v.Character and not v.Character:FindFirstChild("BeastPowers") and v ~= game.Players.LocalPlayer then
					local NewHighlight = Instance.new("Highlight")
					NewHighlight.Adornee = v.Character
					NewHighlight.FillColor = Color3.fromRGB(0, 255, 0)
					NewHighlight.Parent = v.Character
					table.insert(PlrHighlights, NewHighlight)
				end
			end
		else
			for i, v in pairs(PlrHighlights) do
				v:Destroy()
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
		local oldPathToggled = false

		local beast_max_dist = 15

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
				if beastChar then
					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					if char then
						local dist = dist3d(char.HumanoidRootPart.Position, beastChar.HumanoidRootPart.Position)

						if dist < beast_max_dist then
							if not hidingFromBeast then
								oldPos = char.HumanoidRootPart.CFrame
								oldPosV = char.HumanoidRootPart.Position
								oldPathToggled = path_toggled
								enableNoclip()

								local newPos = char.HumanoidRootPart.CFrame * CFrame.new(0, -beast_max_dist, 0)

								char.HumanoidRootPart.CFrame = newPos

								hidingFromBeast = true
								path_toggled = true
							else
								local newPos = char.HumanoidRootPart.CFrame * CFrame.new(0, -1, 0)

								char.HumanoidRootPart.CFrame = newPos
							end
						elseif hidingFromBeast then
							local testDist = dist3d(oldPosV, beastChar.HumanoidRootPart.Position)

							if testDist >= beast_max_dist then
								char.HumanoidRootPart.CFrame = oldPos
								path_toggled = oldPathToggled
								hidingFromBeast = false
								disableNoclip()
							end
						end
					end
				end
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
