local function init()
	local UI = require("../../ui")
	local Utils = require("../../utils")
	local GameUtils = require("./utils")

	local HSTab = UI.Window:CreateTab("Hide and Seek", "gamepad-2")
	HSTab:CreateSection("ESP")

	local player_esp_toggled = true
	local function updatePlayerESP()
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if v ~= game:GetService("Players").LocalPlayer then
				local color = (GameUtils.isSeeker(v) and Color3.fromRGB(255, 0, 0)) or Color3.fromRGB(0, 255, 0)

				Utils.updatePlayerESP(v, color, player_esp_toggled, Color3.fromRGB(255, 0, 255))
			end
		end
	end

	local HSPlayerESPToggle = HSTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = player_esp_toggled,
		Flag = nil,
		Callback = function(value)
			player_esp_toggled = value
			updatePlayerESP()
		end,
	})

	task.spawn(function()
		while task.wait(1) do
			if player_esp_toggled then
				updatePlayerESP()
			end
		end
	end)

	HSTab:CreateSection("Utils")

	local HSKillAllButton = HSTab:CreateButton({
		Name = "Kill All",
		Callback = function()
			local plr = game:GetService("Players").LocalPlayer
			local char = plr and plr.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")

			if root then
				local c = 0
				Utils.Noclip.enable()
				while c < 10 do
					for i, v in pairs(game:GetService("Players"):GetPlayers()) do
						if v ~= plr then
							local pChar = v and v.Character
							local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")

							if pRoot then
								pRoot.CFrame = root.CFrame
							end
						end
					end
					c = c + 1
					task.wait()
				end
				Utils.Noclip.disable()
			end
		end,
	})
end

return init
