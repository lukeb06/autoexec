local GameUtils = require("./utils")

local M = {}

local player_esp_toggled = true
local guard_esp_toggled = true

function M.onPlayerESPToggle(value)
	player_esp_toggled = value
	GameUtils.updatePlayerESP(value)
end

task.spawn(function()
	while task.wait(1) do
		if player_esp_toggled then
			GameUtils.updatePlayerESP(player_esp_toggled)
		end
	end
end)

function M.onGuardESPToggle(value)
	guard_esp_toggled = value
	GameUtils.updateGuardESP(value)
end

task.spawn(function()
	while task.wait(1) do
		if guard_esp_toggled then
			GameUtils.updateGuardESP(guard_esp_toggled)
		end
	end
end)

return M
