local Utils = require("../../utils")

local M = {}

function M.updatePlayerESP(enabled)
	local plr = game:GetService("Players").LocalPlayer

	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		local char = v and v.Character

		local isFriend = Utils.isFriendsWith(v)
		local color = (isFriend and Color3.fromRGB(0, 255, 0)) or Color3.fromRGB(255, 0, 0)

		if char and v ~= plr then
			Utils.updateESP(char, color, enabled and M.isAlive(char))
		end
	end
end

function M.updateGuardESP(enabled)
	local guards = M.getGuards()

	for i, v in pairs(guards) do
		Utils.updateESP(v, Color3.fromRGB(0, 0, 255), enabled and M.isAlive(v))
	end
end

function M.getLiving()
	local live = game.Workspace:FindFirstChild("Live")
	return live
end

function M.isGuard(entity)
	local tog = entity:FindFirstChild("TypeOfGuard")

	if tog then
		return true
	end

	return false
end

function M.getGuards()
	local living = M.getLiving()
	local guards = {}

	for i, v in pairs(living:GetChildren()) do
		if M.isGuard(v) then
			table.insert(guards, v)
		end
	end

	return guards
end

function M.isAlive(entity)
	local hum = entity:FindFirstChild("Humanoid")

	if hum then
		return hum.Health > 0
	end

	return true
end

return M
