local UI = require("../../ui")
local Utils = require("../../utils")
local GameUtils = require("./utils")

if game.GameId == 7585283196 then
	local AGTab = UI.Window:CreateTab("Agoraphobia", "gamepad-2")
	local AGESPSection = AGTab:CreateSection("ESP")

	local player_esp_toggled = true

	local function updateSurvivorESP()
		local survs = GameUtils.getSurvivors()
		for i, v in pairs(survs) do
			Utils.updateESP(v, Color3.fromRGB(0, 255, 0), player_esp_toggled)
		end
	end

	local function updateBeastESP()
		local beasts = GameUtils.getBeasts()
		for i, v in pairs(beasts) do
			Utils.updateESP(v, Color3.fromRGB(255, 0, 0), player_esp_toggled)
		end
	end

	local function updatePlayerESP()
		updateSurvivorESP()
		updateBeastESP()
	end

	local computer_esp_toggled = true

	local function updateComputerESP()
		local comps = GameUtils.getComputers()

		for i, v in pairs(comps) do
			local model = GameUtils.getComputerModel(v)
			local color = GameUtils.getComputerColor(v)
			if model then
				Utils.updateESP(model, color, computer_esp_toggled)
			end
		end
	end

	local AGESPToggle = AGTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			player_esp_toggled = value
			updatePlayerESP()
		end,
	})

	local AGPCESPToggle = AGTab:CreateToggle({
		Name = "Computer ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			computer_esp_toggled = value
			updateComputerESP()
		end,
	})

	task.spawn(function()
		while task.wait(1) do
			updatePlayerESP()
			updateComputerESP()
		end

		updatePlayerESP()
		updateComputerESP()
	end)
end

return true
