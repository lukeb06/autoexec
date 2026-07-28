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

		local function coinDistToMurderer(coin)
			local murderer = GameUtils.getMurderer()
			local char = murderer and murderer.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")

			local plr = Utils.getLocalPlayer()

			if plr and root and murderer ~= plr then
				if root then
					local dist = Utils.dist3d(coin.Position, root.Position)
					return dist
				end
			end

			return 10
		end

		local function plrDistToMurderer()
			local murderer = GameUtils.getMurderer()
			local mChar = murderer and murderer.Character
			local mRoot = mChar and mChar:FindFirstChild("HumanoidRootPart")

			local root = Utils.getLocalRoot()

			if root and mRoot then
				local dist = Utils.dist3d(root.Position, mRoot.Position)
				return dist
			end

			return 10
		end

		local function clumpCount(coin)
			local coins = game.Workspace:FindFirstChild("CoinContainer", true)
			local count = 0
			local clumpDist = 10

			if coins then
				for _, v in pairs(coins:GetChildren()) do
					if v.Name == "Coin_Server" and not coinCollected(v) then
						if Utils.dist3d(coin.Position, v.Position) < clumpDist then
							count = count + 1
						end
					end
				end
			end

			return count
		end

		local function rankCoin(coin)
			local idealMurdDist = 20
			local idealDist = 10
			local idealClumpCount = 8

			local murdDistMult = 1 / idealMurdDist
			local distMult = 1 / (1 / idealDist)
			local clumpMult = 1 / idealClumpCount

			local murdDistBias = 0.3
			local distBias = 0.5
			local clumpBias = 0.2

			local score = 0

			local root = Utils.getLocalRoot()
			if root then
				local dist = Utils.dist3d(coin.Position, root.Position)
				if dist <= 1 then
					return -1
				end
				score = score + (1 / dist) * distMult * distBias
			end

			local murdDist = math.max(coinDistToMurderer(coin), idealMurdDist)

			if murdDist <= 10 then
				return -1
			end

			score = score + murdDist * murdDistMult * murdDistBias

			local clumpSize = clumpCount(coin)
			score = score + clumpSize * clumpMult * clumpBias

			return score
		end

		local function cancelTween(coin)
			if coinCollected(coin) then
				return true
			end

			if plrDistToMurderer() <= 20 then
				local root = Utils.getLocalRoot()
				root.CFrame = root.CFrame * CFrame.new(0, 0, 10)
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
						local best_score = 0

						for _, v in pairs(coins:GetChildren()) do
							if v.Name == "Coin_Server" and not coinCollected(v) then
								local score = rankCoin(v)
								if score > best_score then
									best_score = score
									best = v
								end
							end
						end

						if best then
							Utils.set_safeTweenSpeed(22)
							Utils.safeTweenToPart(best, cancelTween)
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
