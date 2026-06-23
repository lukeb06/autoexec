local Utils = require("../../utils")

local M = {}

function M.getZombies()
	local zombies = game.Workspace:FindFirstChild("Zombies")
	return (zombies and zombies:GetChildren()) or {}
end

function M.getBox()
	local interactions = game.Workspace:FindFirstChild("Interactions")
	return interactions and interactions:FindFirstChild("Mystery")
end

function M.getPack()
	local interactions = game.Workspace:FindFirstChild("Interactions")
	return interactions and interactions:FindFirstChild("Pack-a-Punch")
end

function M.getPowerups()
	local powerups = game.Workspace:FindFirstChild("Power-ups")
	return (powerups and powerups:GetChildren()) or {}
end

function M.updateZombieESP(enabled)
	local zombies = M.getZombies()

	for i, v in pairs(zombies) do
		Utils.updateESP(v, Color3.fromRGB(255, 0, 255), enabled)
	end
end

function M.updateBoxESP(enabled)
	local box = M.getBox()

	if box then
		Utils.updateESP(box, Color3.fromRGB(255, 255, 0), enabled)
	end
end

function M.updatePowerupESP(enabled)
	local powerups = M.getPowerups()

	for i, v in pairs(powerups) do
		Utils.updateESP(v, Color3.fromRGB(107, 176, 255), enabled)
	end
end

return M
