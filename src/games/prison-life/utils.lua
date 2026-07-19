local Utils = require("../../utils")

local M = {}

function M.updatePlayerESP(enabled)
	local plr = Utils.getLocalPlayer()

	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		if v ~= plr then
			Utils.updatePlayerESP(v, v.TeamColor.Color, enabled, Color3.fromRGB(255, 0, 255))
		end
	end
end

return M
