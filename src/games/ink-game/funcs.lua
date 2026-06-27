local GameUtils = require("./utils")

local M = {}

M.State = {
	player_esp_toggled = true,
	guard_esp_toggled = true,
}

function M.onPlayerESPToggle(value)
	M.State.player_esp_toggled = value
	GameUtils.updatePlayerESP(value)
end

task.spawn(function()
	while task.wait(1) do
		if M.State.player_esp_toggled then
			GameUtils.updatePlayerESP(M.State.player_esp_toggled)
		end
	end
end)

function M.onGuardESPToggle(value)
	M.State.guard_esp_toggled = value
	GameUtils.updateGuardESP(value)
end

task.spawn(function()
	while task.wait(1) do
		if M.State.guard_esp_toggled then
			GameUtils.updateGuardESP(M.State.guard_esp_toggled)
		end
	end
end)

return M
