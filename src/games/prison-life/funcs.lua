local GameUtils = require("./utils")

local M = {}

M.player_esp_toggled = true

function M.onPlayerESPToggle(value)
	M.player_esp_toggled = value
	GameUtils.updatePlayerESP(value)
end

task.spawn(function()
	while task.wait() do
		if M.player_esp_toggled then
			GameUtils.updatePlayerESP(M.player_esp_toggled)
		end
	end
end)

return M
