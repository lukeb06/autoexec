local UI = require("../../ui")
local Utils = require("../../utils")
local GameUtils = require("./utils")

if game.PlaceId == 142823291 then
	local MMTab = UI.Window:CreateTab("Murder Mystery 2", "gamepad-2")
	local MMESPSection = MMTab:CreateSection("ESP")

	local mm_player_esp_toggled = true
	local MMPlayerEspToggle = MMTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			mm_player_esp_toggled = value
			GameUtils.updatePlayerESP(value)
		end,
	})
	game:GetService("RunService").RenderStepped:Connect(function()
		if mm_player_esp_toggled then
			GameUtils.updatePlayerESP(mm_player_esp_toggled)
		end
	end)

	local mm_coin_esp_toggled = true
	local MMCoinEspToggle = MMTab:CreateToggle({
		Name = "Coin ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			mm_coin_esp_toggled = value
			GameUtils.updateCoinESP(value)
		end,
	})
	game:GetService("RunService").RenderStepped:Connect(function()
		if mm_coin_esp_toggled then
			GameUtils.updateCoinESP(mm_coin_esp_toggled)
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

	local MMShootMurdererKeybind = MMTab:CreateKeybind({
		Name = "Shoot Murderer",
		CurrentKeybind = "G",
		HoldToInteract = false,
		Flag = "MMShootMurdererKeybind",
		Callback = function()
			local murderer = GameUtils.getMurderer()
			if murderer then
				GameUtils.tpShoot(murderer)
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
						task.wait(0.5)
						if not Utils.isDev() then
							task.wait(0.1)
						end
						root.CFrame = gun.CFrame
						task.wait(0.1)
						root.CFrame = pos
					end

					pickupGun = false
				end
			end
		end
	end)

	local MMFlingMurdererButton = MMTab:CreateButton({
		Name = "Fling Murderer",
		Callback = function()
			GameUtils.flingMurderer()
		end,
	})

	local mm_auto_fling_murderer_toggled = false
	local MMAutoFlingMurdererToggle = MMTab:CreateToggle({
		Name = "Auto Fling Murderer",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			mm_auto_fling_murderer_toggled = value
		end,
	})
	task.spawn(function()
		while task.wait() do
			if mm_auto_fling_murderer_toggled then
				local murderer = GameUtils.getMurderer()

				if murderer then
					GameUtils.flingMurderer()
					task.wait(4)
				end
			end
		end
	end)

	local mm_collect_coin_toggled = false
	local MMCollectCoinToggle = MMTab:CreateToggle({
		Name = "Collect Coins",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			mm_collect_coin_toggled = value
		end,
	})
	task.spawn(function()
		while task.wait() do
			if mm_collect_coin_toggled and not Utils.get_safeTweening() then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if root then
					local coins = game.Workspace:FindFirstChild("CoinContainer", true)

					if coins then
						local best = nil
						local best_dist = 99999999

						for i, v in pairs(coins:GetChildren()) do
							if v.Name == "Coin_Server" then
								local dist = Utils.dist3d(root.Position, v.Position)
								if dist < best_dist then
									best_dist = dist
									best = v
								end
							end
						end

						if best then
							Utils.safeTweenToPart(best)
						end
					end
				end
			end
		end
	end)
end

return true
