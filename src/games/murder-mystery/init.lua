local function init()
	local UI = require("../../ui")
	local Utils = require("../../utils")
	local GameUtils = require("./utils")

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
		Callback = GameUtils.killAll,
	})

	local auto_kill_all_toggled = false
	local MMAutoKillAllToggle = MMTab:CreateToggle({
		Name = "Auto Kill All",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			auto_kill_all_toggled = value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if auto_kill_all_toggled then
				GameUtils.killAll()
				task.wait(4)
			end
		end
	end)

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
		while task.wait() do
			if mm_grab_gun_toggled then
				local gun = game.Workspace:FindFirstChild("GunDrop", true)
				local root = Utils.getLocalRoot()

				if gun and root then
					if not Utils.isDev() then
						task.wait(0.1)
					end
					gun.CFrame = root.CFrame
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
		local function coinCollected(part)
			local cv = part:FindFirstChild("CoinVisual")
			if not cv then
				return true
			end

			local main = cv:FindFirstChild("MainCoin")

			if not main then
				return true
			end

			if main.Transparency > 0 then
				return true
			end

			return false
		end

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

						for _, v in pairs(coins:GetChildren()) do
							if v.Name == "Coin_Server" and not coinCollected(v) then
								local dist = Utils.dist3d(root.Position, v.Position)
								if dist < best_dist and dist > 1 then
									best_dist = dist
									best = v
								end
							end
						end

						if best then
							Utils.set_safeTweenSpeed(22)
							Utils.safeTweenToPart(best, coinCollected)
						end
					end
				end
			end
		end
	end)

	task.spawn(function()
		while task.wait(0.1) do
			local base = game.Workspace:FindFirstChild("Base", true)
			local gp = base and base:FindFirstChild("GlitchProof")

			if gp then
				gp:Destroy()
			end
		end
	end)
end

return init
