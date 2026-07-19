local GameUtils = require("./utils")
local Utils = require("../../utils")

local M = {}

M.player_esp_toggled = true
M.auto_shoot_criminals = false
M.auto_shoot_guards = false

M.teleports = {
	{ Name = "Criminal Hideout", Position = Vector3.new(-989, 94, 2039) },
	{ Name = "Guard Guns", Position = Vector3.new(817, 100, 2234) },
	{ Name = "Prison Yard", Position = Vector3.new(813, 98, 2448) },
	{ Name = "Prison Wall", Position = Vector3.new(512, 122, 2326) },
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

function M.onAutoShootCriminalsToggle(value)
	M.auto_shoot_criminals = value
end

task.spawn(function()
	while task.wait(0.1) do
		if M.auto_shoot_criminals then
			GameUtils.shootAllCriminals()
		end
	end
end)

function M.onAutoShootGuardsToggle(value)
	M.auto_shoot_guards = value
end

task.spawn(function()
	while task.wait(0.1) do
		if M.auto_shoot_guards then
			GameUtils.shootAllGuards()
		end
	end
end)

function M.removeDoors()
	GameUtils.removeDoors()
end

return M
