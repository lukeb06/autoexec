local Utils = require("../../utils")

local M = {}

function M.getMap()
	local map = game.Workspace:FindFirstChild("Map")
	return map
end

function M.getFunctionals()
	local map = M.getMap()
	local funcs = map and map:FindFirstChild("Functionals")
	return funcs
end

function M.getComputers()
	local funcs = M.getFunctionals()
	local comps = funcs and funcs:FindFirstChild("Computers")
	if comps then
		return comps:GetChildren()
	else
		return {}
	end
end

function M.getComputerModel(pc)
	local model = pc and pc:FindFirstChild("ComputerModel")
	return model
end

function M.getComputerScreen(pc)
	local screen = pc and pc:FindFirstChild("Screen")
	return screen
end

function M.getComputerColor(pc)
	local screen = M.getComputerScreen(pc)
	local color = (screen and screen.Color) or Color3.fromRGB(0, 0, 255)
	return color
end

function M.getBeasts()
	local beasts = game.Workspace:FindFirstChild("Beasts")
	if beasts then
		return beasts:GetChildren()
	else
		return {}
	end
end

function M.getSurvivors()
	local survs = game.Workspace:FindFirstChild("Survivors")
	if survs then
		return survs:GetChildren()
	else
		return {}
	end
end

return M
