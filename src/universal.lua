local UI = require("./ui")
local Utils = require("./utils")

local UniversalTab = UI.Window:CreateTab("Universal", "globe")

local NoclipSection = UniversalTab:CreateSection("Noclip")

local NoClipToggle = UniversalTab:CreateToggle({
	Name = "Toggle Noclip",
	CurrentValue = false,
	Flag = nil,
	Callback = function(value)
		Utils.Noclip.set_manual(value)
		if value then
			Utils.Noclip.enable()
		else
			Utils.Noclip.disable()
		end
	end,
})

local NoClipKeybind = UniversalTab:CreateKeybind({
	Name = "Toggle Noclip",
	CurrentKeybind = "V",
	HoldToInteract = false,
	Flag = "NoClipKeybind",
	Callback = function()
		if NoClipToggle.CurrentValue then
			UI.Library:Notify({
				Title = "Noclip Disabled",
				Content = "Noclip is now disabled.",
				Duration = 3,
				Image = "ban",
			})
		else
			UI.Library:Notify({
				Title = "Noclip Enabled",
				Content = "Noclip is now enabled.",
				Duration = 3,
				Image = "check",
			})
		end
		NoClipToggle:Set(not NoClipToggle.CurrentValue)
	end,
})

local PathSection = UniversalTab:CreateSection("Path")

local path_toggled = false
local PathKeybind = UniversalTab:CreateKeybind({
	Name = "Toggle Paths",
	CurrentKeybind = "N",
	HoldToInteract = false,
	Flag = "PathKeybind", -- A flag is the identifier for the configuration file. Make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function()
		path_toggled = not path_toggled
	end,
})

task.spawn(function()
	local path = nil

	local function getPath()
		if not path then
			path = Instance.new("Part", game.Workspace)
			path.Size = Vector3.new(3, 1, 3)
			path.Anchored = true
		end

		return path
	end

	while task.wait() do
		if path_toggled == true then
			local p = getPath()

			local plr = game:GetService("Players").LocalPlayer
			local char = plr and plr.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChildWhichIsA("Humanoid")
			local rig = hum and hum.RigType

			if root and hum and rig then
				if rig == Enum.HumanoidRigType.R15 then
					local s = root.Size.Y
					local h = hum.HipHeight

					p.CFrame = root.CFrame * CFrame.new(0, -(s / 2) - h - 0.5, 0)
				else
					local leg = char and char:FindFirstChild("Left Leg")
					if leg then
						local s = root.Size.Y
						local h = leg.Size.Y

						p.CFrame = root.CFrame * CFrame.new(0, -(s / 2) - h - 0.5, 0)
					end
				end
			end
		else
			if path then
				path:Destroy()
				path = nil
			end
		end
	end
end)

local DelSection = UniversalTab:CreateSection("Ctrl+Click Delete")

local CtrlClickInstructions = UniversalTab:CreateLabel("Ctrl+Left-Click a part to delete. Ctrl+Right-Click to restore")

local ctrl_click_delete_toggled = true
local CtrlClickDelToggle = UniversalTab:CreateToggle({
	Name = "Ctrl+Click Delete",
	CurrentValue = true,
	Flag = nil, -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value)
		ctrl_click_delete_toggled = value
	end,
})

task.spawn(function()
	local Plr = game:GetService("Players").LocalPlayer
	local Mouse = Plr:GetMouse()

	local deletedParts = Instance.new("Folder", game.Workspace)
	deletedParts.Name = "DELETED_PARTS"

	local index = 1

	local function isControlDown()
		local UIS = game:GetService("UserInputService")

		return UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.LeftMeta)
	end

	Mouse.Button1Down:Connect(function()
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

	Mouse.Button2Down:Connect(function()
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
end)

local UniversalESPSection = UniversalTab:CreateSection("Universal ESP")

local function updateUniversalESP(enabled)
	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		if v.Character and v ~= game:GetService("Players").LocalPlayer then
			Utils.updateESP(v.Character, Color3.fromRGB(255, 0, 0), enabled)
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
game:GetService("RunService").RenderStepped:Connect(function()
	if universal_esp_toggled then
		updateUniversalESP(universal_esp_toggled)
	end
end)

local ussPlr = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local ussChar = ussPlr and ussPlr.Character
local ussHum = ussChar and ussChar:FindFirstChild("Humanoid")

local ussSpeed = (ussHum and ussHum.WalkSpeed) or 16

local UniversalSpeedSection = UniversalTab:CreateSection("Speed")

local UniversalSpeedSlider = UniversalTab:CreateSlider({
	Name = "Speed",
	Range = { 0, 100 },
	Increment = 1,
	Suffix = "",
	CurrentValue = ussSpeed,
	Flag = nil, -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value)
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local hum = char and char:FindFirstChildWhichIsA("Humanoid")

		if hum then
			hum.WalkSpeed = value
		end
	end,
})

UniversalTab:CreateButton({
	Name = "Set to 16",
	Callback = function()
		UniversalSpeedSlider:Set(16)
	end,
})

UniversalTab:CreateButton({
	Name = "Set to 18",
	Callback = function()
		UniversalSpeedSlider:Set(18)
	end,
})

UniversalTab:CreateButton({
	Name = "Set to 20",
	Callback = function()
		UniversalSpeedSlider:Set(20)
	end,
})

local SpeedMod = nil
local SpeedCA = nil
local LoopSpeedToggle = UniversalTab:CreateToggle({
	Name = "Loop Speed",
	CurrentValue = false,
	Flag = nil,
	Callback = function(value)
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local hum = char and char:FindFirstChildWhichIsA("Humanoid")

		if value and hum then
			local function SetWalkspeed()
				local _plr = game:GetService("Players").LocalPlayer
				local _char = _plr and _plr.Character
				local _hum = _char and _char:FindFirstChildWhichIsA("Humanoid")

				if _hum then
					_hum.WalkSpeed = UniversalSpeedSlider.CurrentValue
				end
			end
			SetWalkspeed()
			SpeedMod = (SpeedMod and SpeedMod:Disconnect() and false)
				or hum:GetPropertyChangedSignal("WalkSpeed"):Connect(SetWalkspeed)
			SpeedCA = (SpeedCA and SpeedCA:Disconnect() and false)
				or plr.CharacterAdded:Connect(function(nChar)
					hum = nChar:WaitForChild("Humanoid")
					SetWalkspeed()
					SpeedMod = (SpeedMod and SpeedMod:Disconnect() and false)
						or hum:GetPropertyChangedSignal("WalkSpeed"):Connect(SetWalkspeed)
				end)
		else
			SpeedMod = (SpeedMod and SpeedMod:Disconnect() and false) or nil
			SpeedCA = (SpeedCA and SpeedCA:Disconnect() and false) or nil
		end
	end,
})

return true
