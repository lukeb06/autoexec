local function init()
	local UI = require("../../ui")
	local GameUtils = require("./utils")

	local RZTab = UI.Window:CreateTab("Reminiscence Zombies", "gamepad-2")
	local RZESPSection = RZTab:CreateSection("ESP")

	local zombie_esp_toggled = true
	local RZZombieESPToggle = RZTab:CreateToggle({
		Name = "Zombie ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			zombie_esp_toggled = value
			GameUtils.updateZombieESP(value)
		end,
	})

	local box_esp_toggled = true
	local RZBoxESPToggle = RZTab:CreateToggle({
		Name = "Box ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			box_esp_toggled = value
			GameUtils.updateBoxESP(value)
		end,
	})

	local powerup_esp_toggled = true
	local RZPowerupESPToggle = RZTab:CreateToggle({
		Name = "Powerup ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			powerup_esp_toggled = value
			GameUtils.updatePowerupESP(value)
		end,
	})

	game:GetService("RunService").RenderStepped:Connect(function()
		if zombie_esp_toggled then
			GameUtils.updateZombieESP(zombie_esp_toggled)
		end

		if box_esp_toggled then
			GameUtils.updateBoxESP(box_esp_toggled)
		end

		if powerup_esp_toggled then
			GameUtils.updatePowerupESP(powerup_esp_toggled)
		end
	end)

	local RZUtilSection = RZTab:CreateSection("Utils")

	local RZGotoBoxKeybind = RZTab:CreateKeybind({
		Name = "TP to Box",
		CurrentKeybind = "X",
		HoldToInteract = false,
		Flag = "RZGotoBoxKeybind",
		Callback = function()
			local box = GameUtils.getBox()

			if box then
				local primary = box.PrimaryPart or box:FindFirstChildWhichIsA("BasePart")

				if primary then
					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")

					if root then
						root.CFrame = primary.CFrame
					end
				end
			end
		end,
	})

	local RZGotoPackKeybind = RZTab:CreateKeybind({
		Name = "TP to Pack",
		CurrentKeybind = "Z",
		HoldToInteract = false,
		Flag = "RZGotoPackKeybind",
		Callback = function()
			local pack = GameUtils.getPack()

			if pack then
				local primary = pack.PrimaryPart or pack:FindFirstChildWhichIsA("BasePart")

				if primary then
					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")

					if root then
						root.CFrame = primary.CFrame
					end
				end
			end
		end,
	})

	local rz_bring_zombies_toggled = true
	local RZBringZombiesToggle = RZTab:CreateToggle({
		Name = "Bring Zombies (Right Click)",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			rz_bring_zombies_toggled = value
		end,
	})
	task.spawn(function()
		local plr = game:GetService("Players").LocalPlayer
		local mouse = plr and plr:GetMouse()

		local doBring = false

		if mouse then
			mouse.Button2Down:Connect(function()
				doBring = true
			end)

			mouse.Button2Up:Connect(function()
				doBring = false
			end)
		end

		game:GetService("RunService").RenderStepped:Connect(function()
			if rz_bring_zombies_toggled and doBring then
				local zombies = GameUtils.getZombies()

				for i, v in pairs(zombies) do
					local root = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart

					if root then
						local plr = game:GetService("Players").LocalPlayer
						local char = plr and plr.Character
						local pRoot = char and char:FindFirstChild("HumanoidRootPart")

						if pRoot then
							root.CFrame = pRoot.CFrame * CFrame.new(0, 0, -5)
						end
					end
				end
			end
		end)
	end)

	local grab_powerups_toggled = true
	local RZGrabPowerups = RZTab:CreateToggle({
		Name = "Auto Grab Powerups",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			grab_powerups_toggled = value
		end,
	})

	game:GetService("RunService").RenderStepped:Connect(function()
		if grab_powerups_toggled then
			local powerups = GameUtils.getPowerups()

			for i, v in pairs(powerups) do
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")
				local primary = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")

				if primary and root then
					primary.CFrame = root.CFrame
				end
			end
		end
	end)
end

return init
