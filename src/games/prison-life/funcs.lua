local GameUtils = require("./utils")
local Utils = require("../../utils")

local M = {}

M.player_esp_toggled = true

M.teleports = {
	{
		Name = "Criminal Hideout",
		Position = Vector3.new(-989, 94, 2039),
		Callback = function(self)
			M.teleportTo(self.Position)
		end,
	},
}

function M.teleportTo(pos)
	local root = Utils.getLocalRoot()
	if root then
		root.CFrame = CFrame.new(pos)
	end
end

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
