local function init()
	local UI = require("../../ui")
	local Utils = require("../../utils")
	local GameUtils = require("./utils")

	local FTFEspTab = UI.Window:CreateTab("ESP")

	local beast_esp_toggled = true
	function UpdateBeastESP()
		for _, v in pairs(game.Players:GetPlayers()) do
			if v.Character and v.Character:FindFirstChild("BeastPowers") and v ~= game.Players.LocalPlayer then
				Utils.updatePlayerESP(v, Color3.fromRGB(255, 0, 0), beast_esp_toggled, Color3.fromRGB(255, 0, 255))
			end
		end
	end

	local FTFBeastEspToggle = FTFEspTab:CreateToggle({
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
				Utils.updatePlayerESP(v, Color3.fromRGB(0, 255, 0), player_esp_toggled, Color3.fromRGB(255, 0, 255))
			end
		end
	end

	local FTFPlayerEspToggle = FTFEspTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			player_esp_toggled = value
			UpdatePlrESP()
		end,
	})

	task.spawn(function()
		while task.wait(1) do
			for i, v in pairs(GameUtils.getExits()) do
				local trigger = GameUtils.getExitTrigger(v)
				if trigger then
					trigger.Size = Vector3.new(20, 20, 20)
				end
			end
		end
	end)

	local computer_esp_toggled = true
	local function updatePCESP()
		for _, v in pairs(GameUtils.getCurrentMapChildren()) do
			if v.Name == "ComputerTable" and v:FindFirstChild("Screen") then
				Utils.updateESP(v, v.Screen.Color, computer_esp_toggled)
			end
		end
	end

	local FTFPCEspToggle = FTFEspTab:CreateToggle({
		Name = "Computer ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			computer_esp_toggled = value
			updatePCESP()
		end,
	})

	local locker_esp_toggled = not Utils.isDev()
	local function updateLockerESP()
		local lockers = GameUtils.getLockers()
		for i, v in pairs(lockers) do
			Utils.updateESP(v, Color3.fromRGB(255, 255, 0), locker_esp_toggled)
		end
	end

	local FTFLockerEspToggle = FTFEspTab:CreateToggle({
		Name = "Locker ESP",
		CurrentValue = locker_esp_toggled,
		Flag = nil,
		Callback = function(value)
			locker_esp_toggled = value
			updateLockerESP()
		end,
	})

	task.spawn(function()
		while task.wait(1) do
			UpdateBeastESP()
			UpdatePlrESP()
			updatePCESP()
			updateLockerESP()
		end

		UpdateBeastESP()
		UpdatePlrESP()
		updatePCESP()
		updateLockerESP()
	end)

	-- task.spawn(function()
	-- 	while task.wait() do
	-- 		local plr = game:GetService("Players").LocalPlayer
	-- 		local char = plr and plr.Character
	-- 		local hum = char and char:FindFirstChildWhichIsA("Humanoid")

	-- 		if hum then
	-- 			hum.PlatformStand = false
	-- 			hum.JumpPower = 36
	-- 		end

	-- 		if plr then
	-- 			local stats = plr:FindFirstChild("TempPlayerStatsModule")
	-- 			local ragdoll = stats and stats:FindFirstChild("Ragdoll")
	-- 			if ragdoll then
	-- 				ragdoll.Value = false
	-- 			end
	-- 		end
	-- 	end
	-- end)

	local FTFUtilsTab = UI.Window:CreateTab("Utils")

	local FTFFlingBeast = FTFUtilsTab:CreateButton({
		Name = "Fling Beast",
		Callback = function()
			local beast = GameUtils.findBeast()
			if beast then
				Utils.flingPlayer(beast)
			end
		end,
	})

	local slow_beast_toggled = false
	local FTFSlowBeast = FTFUtilsTab:CreateToggle({
		Name = "Slow Beast",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			slow_beast_toggled = value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if slow_beast_toggled and not GameUtils.isBeast() then
				local event = GameUtils.getPowerEvent()
				if event then
					event:FireServer("Jumped")
				end
			end
		end
	end)

	local untie_toggled = false
	local FTFUntie = FTFUtilsTab:CreateToggle({
		Name = "Make Beast Untie",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			untie_toggled = value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if untie_toggled then
				GameUtils.clickHammer()
			end
		end
	end)

	local ftf_auto_save_toggled = false
	local FTFAutoSaveToggle = FTFUtilsTab:CreateToggle({
		Name = "Auto Save",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			ftf_auto_save_toggled = value
		end,
	})

	local ftf_auto_saving = false
	task.spawn(function()
		while task.wait() do
			if ftf_auto_save_toggled and GameUtils.isInGame() and not GameUtils.isBeast() then
				local children = GameUtils.getCurrentMapChildren()

				for i, v in pairs(children) do
					if v.Name == "FreezePod" then
						local pod = v:FindFirstChild("PodTrigger")

						if pod then
							local capturedTorsoValue = pod:FindFirstChild("CapturedTorso")
							if capturedTorsoValue.Value ~= nil then
								GameUtils.triggerPod(pod)
							end
						end
					end
				end
			end
		end
	end)

	-- local auto_hide_toggled = Utils.isDev()
	-- local FTFAutoHideToggle = FTFUtilsTab:CreateToggle({
	-- 	Name = "Auto Hide (Seer)",
	-- 	CurrentValue = auto_hide_toggled,
	-- 	Flag = nil,
	-- 	Callback = function(value)
	-- 		auto_hide_toggled = value
	-- 	end,
	-- })

	-- task.spawn(function()
	-- 	local hiding = false
	-- 	while task.wait() do
	-- 		if hiding then
	-- 			task.wait(2)
	-- 			hiding = false
	-- 			task.wait(10)
	-- 		end
	-- 		if auto_hide_toggled and GameUtils.isSeerActive() and GameUtils.isInGame() then
	-- 			local locker = GameUtils.findNearestLocker()
	-- 			local center = locker and locker:GetBoundingBox()
	-- 			if center then
	-- 				task.wait(2.5)
	-- 				local plr = game:GetService("Players").LocalPlayer
	-- 				local char = plr and plr.Character
	-- 				local root = char and char:FindFirstChild("HumanoidRootPart")
	-- 				if root then
	-- 					root.CFrame = center
	-- 					hiding = true
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end)

	local auto_tie_toggled = true
	local FTFAutoTie = FTFUtilsTab:CreateToggle({
		Name = "Auto Tie",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			auto_tie_toggled = value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if auto_tie_toggled and GameUtils.isBeast() then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if root then
					for _, p in pairs(game:GetService("Players"):GetPlayers()) do
						if
							p ~= plr
							and not Utils.isFriendsWith(p)
							and GameUtils.isRagdoll(p)
							and not GameUtils.isCaptured(p)
						then
							local pRoot = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
							if pRoot then
								if Utils.dist3d(root.Position, pRoot.Position) <= 15 then
									GameUtils.tiePlayer(p)
								end
							end
						end
					end
				end
			end
		end
	end)

	local auto_hit_toggled = Utils.isDev()
	local FTFAutoHit = FTFUtilsTab:CreateToggle({
		Name = "Auto Hit",
		CurrentValue = auto_hit_toggled,
		Flag = nil,
		Callback = function(value)
			auto_hit_toggled = value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if auto_hit_toggled then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if root then
					for _, p in pairs(game:GetService("Players"):GetPlayers()) do
						if
							p ~= plr
							and not Utils.isFriendsWith(p)
							and not GameUtils.isRagdoll(p)
							and not GameUtils.isCaptured(p)
						then
							local pRoot = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
							if pRoot then
								if Utils.dist3d(root.Position, pRoot.Position) <= 15 then
									GameUtils.hitPlayer(p)
								end
							end
						end
					end
				end
			end
		end
	end)

	local auto_beast_toggled = Utils.isDev()
	local FTFAutoBeast = FTFUtilsTab:CreateToggle({
		Name = "Auto Beast",
		CurrentValue = auto_beast_toggled,
		Flag = nil,
		Callback = function(value)
			auto_beast_toggled = value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if auto_beast_toggled and GameUtils.isBeast() then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if root then
					local players = GameUtils.getCapturablePlayers()
					for i, v in pairs(players) do
						local pChar = v and v.Character
						local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")
						if pRoot and root and not Utils.isFriendsWith(v) then
							root.CFrame = pRoot.CFrame
							task.wait(0.1)
							GameUtils.hitPlayer(v)
							task.wait(0.1)
							GameUtils.tiePlayer(v)
							task.wait(0.1)
							GameUtils.triggerNearestFreezePod()
						end
					end
				end
			end
		end
	end)

	local no_errors_toggled = true
	local FTFNoErrorToggle = FTFUtilsTab:CreateToggle({
		Name = "No Errors",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			no_errors_toggled = value
		end,
	})

	local no_fog_toggled = true
	local FTFNoFogToggle = FTFUtilsTab:CreateToggle({
		Name = "No Fog",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			no_fog_toggled = value
		end,
	})

	local better_cam_toggled = true
	local FTFBetterCamToggle = FTFUtilsTab:CreateToggle({
		Name = "Better Camera",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			better_cam_toggled = value
		end,
	})

	local avoid_beast_toggled = false
	local FTFAvoidBeastToggle = FTFUtilsTab:CreateToggle({
		Name = "Avoid Beast",
		CurrentValue = avoid_beast_toggled,
		Flag = nil,
		Callback = function(value)
			avoid_beast_toggled = value
		end,
	})

	local auto_exit_toggled = false
	local FTFAutoExitToggle = FTFUtilsTab:CreateToggle({
		Name = "Auto Exit",
		CurrentValue = auto_exit_toggled,
		Flag = nil,
		Callback = function(value)
			auto_exit_toggled = value
		end,
	})

	task.spawn(function()
		local teleported = false

		while task.wait(1) do
			if teleported and not GameUtils.isCloseToExit() then
				task.wait(10)
				teleported = false
			end
			if auto_exit_toggled and GameUtils.isInGame() and not GameUtils.isBeast() and not teleported then
				local exit = GameUtils.findOpenExit()

				if exit then
					local area = GameUtils.getExitArea(exit)

					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")

					if root then
						root.CFrame = area.CFrame
						teleported = true
					end
				end
			end
		end
	end)

	local auto_open_exit_toggled = false
	local FTFAutoOpenExitToggle = FTFUtilsTab:CreateToggle({
		Name = "Auto Open Exit",
		CurrentValue = auto_open_exit_toggled,
		Flag = nil,
		Callback = function(value)
			auto_open_exit_toggled = value
		end,
	})

	task.spawn(function()
		local teleported = false
		while task.wait() do
			if teleported and not GameUtils.isCloseToExit() then
				task.wait(10)
				teleported = false
			end
			if auto_open_exit_toggled and GameUtils.isInGame() and not GameUtils.isBeast() and not teleported then
				local openExit = GameUtils.findOpenExit()
				if openExit then
					return
				end

				local exit = GameUtils.getClosestClosedExit()

				if exit then
					local trigger = GameUtils.getExitTrigger(exit)

					if trigger then
						local plr = game:GetService("Players").LocalPlayer
						local char = plr and plr.Character
						local root = char and char:FindFirstChild("HumanoidRootPart")

						if root then
							root.CFrame = trigger.CFrame
							teleported = true
						end
					end
				end
			end
		end
	end)

	local auto_e_toggled = true
	local quick_hack_toggled = true
	local auto_hack_toggled = false

	local FTFAutoEToggle
	FTFAutoEToggle = FTFUtilsTab:CreateToggle({
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
	FTFQuickHackToggle = FTFUtilsTab:CreateToggle({
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

	local FTFAutoHackToggle = FTFUtilsTab:CreateToggle({
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

	local hidingFromBeast = false

	task.spawn(function()
		local last_computer = nil

		while task.wait(0.1) do
			local ictc, computer = GameUtils.isCloseToComputer()
			local ictfp, freeze_pod = GameUtils.isCloseToFreezePod()
			local icte, exit = GameUtils.isCloseToExit()

			if
				(GameUtils.isInGame() and auto_e_toggled and (ictc or ictfp or icte))
				or (GameUtils.isBeast() and auto_e_toggled and ictfp) and GameUtils.shouldEasyHack()
			then
				game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
				task.wait(0.1)
				game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", false)
			end

			if
				GameUtils.isInGame()
				and quick_hack_toggled
				and ictc
				and last_computer ~= computer
				and not GameUtils.isInDanger()
				and not hidingFromBeast
			then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if root then
					local spot = GameUtils.getValidSpot(computer)

					task.spawn(function()
						local running = true

						task.spawn(function()
							while running and not GameUtils.isInDanger() and not hidingFromBeast do
								if spot then
									root.CFrame = spot.CFrame * CFrame.new(0, 0, 0.1)
								end
								task.wait()
							end
						end)

						task.delay(1, function()
							running = false
						end)
					end)
				end
			end

			if GameUtils.isInGame() and auto_hack_toggled and not GameUtils.isInDanger() and not hidingFromBeast then
				local cComp = GameUtils.getClosestComputer(false)

				if not Utils.get_safeTweening() and cComp and cComp ~= computer then
					local spot = GameUtils.getValidSpot(cComp)

					if spot then
						Utils.set_safeTweening(true)

						task.delay(1, function()
							local plr = game:GetService("Players").LocalPlayer
							local char = plr and plr.Character
							local root = char and char:FindFirstChild("HumanoidRootPart")

							-- if root then
							-- 	root.CFrame = CFrame.new(spot.Position.X, -40, spot.Position.Z)
							-- end

							Utils.safeTweenToPart(spot)
						end)
					end
				end
			end

			last_computer = computer
		end
	end)

	local FTFFreezePodKeybind = FTFUtilsTab:CreateKeybind({
		Name = "Teleport to Freeze Pod",
		CurrentKeybind = "F",
		HoldToInteract = false,
		Flag = "FTFFreezePodKeybind", -- A flag is the identifier for the configuration file. Make sure every element has a different flag if you're using configuration saving to ensure no overlaps
		Callback = GameUtils.teleportToNearestFreezePod,
	})

	task.spawn(function()
		local oldPos
		local oldPosV

		local V3 = Vector3.new(0, 0, 0)

		while task.wait() do
			if no_errors_toggled then
				local stats = GameUtils.getStats(game:GetService("Players").LocalPlayer)
				local actionEvent = stats and stats:FindFirstChild("ActionEvent")

				if actionEvent.Value then
					game.ReplicatedStorage.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
				end
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
					player.CameraMaxZoomDistance = 100
				end
			end

			if avoid_beast_toggled and not ftf_auto_saving then
				local beast = GameUtils.findBeast()
				local beastChar = beast and beast.Character
				local beastRoot = beastChar and beastChar:FindFirstChild("HumanoidRootPart")

				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if beastChar then
					if char then
						if GameUtils.isInDanger() then
							if not hidingFromBeast then
								oldPos = root.CFrame
								oldPosV = root.Position
								game.Workspace.Gravity = 0

								Utils.Noclip.enable()

								task.wait(0.1)
								hidingFromBeast = true
							end
						end
					end
				elseif hidingFromBeast then
					root.CFrame = oldPos
					game.Workspace.Gravity = 196.2
					Utils.Noclip.disable()
					hidingFromBeast = false
				end

				if hidingFromBeast then
					local testDist = Utils.dist3d(oldPosV, beastRoot.Position)

					if testDist >= GameUtils.beast_max_dist then
						root.CFrame = oldPos
						game.Workspace.Gravity = 196.21
						Utils.Noclip.disable()
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
				Utils.Noclip.disable()
				hidingFromBeast = false
			end
		end
	end)

	local FTFChaseMusicSlider = FTFUtilsTab:CreateSlider({
		Name = "Chase Music Volume",
		Range = { 0, 100 },
		Increment = 1,
		Suffix = "%",
		CurrentValue = 100,
		Flag = "FTFChaseMusicVolume",
		Callback = function(value)
			GameUtils.updateChaseVolume(value)
		end,
	})
end

return init
