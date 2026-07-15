local function init()
	local UI = require("../../ui")
	local Utils = require("../../utils")
	local GameUtils = require("./utils")

	local ZOOTab = UI.Window:CreateTab("ZOO or OOF", "gamepad-2")
	local ZOOESPSection = ZOOTab:CreateSection("ESP")

	local zoo_esp_toggled = true
	local ZOOESPToggle = ZOOTab:CreateToggle({
		Name = "Animal ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			zoo_esp_toggled = value
			GameUtils.updateAnimalESP(value)
		end,
	})

	game:GetService("RunService").RenderStepped:Connect(function()
		if zoo_esp_toggled then
			GameUtils.updateAnimalESP(zoo_esp_toggled)
		end
	end)

	local ZOOFarmSection = ZOOTab:CreateSection("Farm")

	local zoo_farm_toggled = true
	local ZOOFarmToggle = ZOOTab:CreateToggle({
		Name = "Auto Farm",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			zoo_farm_toggled = value
		end,
	})
	task.spawn(function()
		local isInvis = false

		while task.wait() do
			if zoo_farm_toggled then
				if isInvis and not GameUtils.isInGame() then
					isInvis = false
				end

				if GameUtils.isAnimal() and not isInvis then
					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")

					if root then
						task.wait((Utils.isDev() and 1) or 2)
						root.CFrame = CFrame.new(1, 51, 224)
						task.wait(1)
						isInvis = true
					end
				end

				if isInvis then
					local keeper = GameUtils.getKeeper()

					if keeper then
						local plr = game:GetService("Players").LocalPlayer
						local char = plr and plr.Character
						local root = char and char:FindFirstChild("HumanoidRootPart")

						local kChar = keeper.Character
						local kRoot = kChar and kChar:FindFirstChild("HumanoidRootPart")

						if root and kRoot then
							root.CFrame = kRoot.CFrame
							local args = {
								[1] = "Taunt.play",
							}

							game:GetService("ReplicatedStorage").Net:FireServer(unpack(args))
						end
					end
				end
			else
				isInvis = false
			end
		end
	end)

	local auto_kill_toggled = true
	local ZOOAutoKillToggle = ZOOTab:CreateToggle({
		Name = "Auto Kill",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			auto_kill_toggled = value
		end,
	})
	task.spawn(function()
		while task.wait() do
			if GameUtils.isKeeper() and auto_kill_toggled then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				local closestAnimal = GameUtils.getClosestAnimal()

				if closestAnimal and root then
					local bAnimal = GameUtils.getPlayersAnimal(closestAnimal)
					local bRoot = bAnimal and bAnimal.PrimaryPart

					if bRoot then
						local args = {
							[1] = "Shooting.shotPlayer",
							[2] = root.CFrame,
							[3] = bRoot.CFrame,
							[4] = closestAnimal,
							[5] = bRoot,
							[6] = CFrame.new(0.8038291931152344, 0.09816551208496094, -0.000888824462890625)
								* CFrame.Angles(3.1407759189605713, 1.3910810947418213, 3.129187822341919),
						}

						game:GetService("ReplicatedStorage").Net:FireServer(unpack(args))
					end
				end
			end
		end
	end)
end

return init
