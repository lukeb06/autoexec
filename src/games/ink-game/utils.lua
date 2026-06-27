local Utils = require("../../utils")

local M = {}

function M.updatePlayerESP(enabled)
	local plr = game:GetService("Players").LocalPlayer

	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		local char = v and v.Character

		local isFriend = Utils.isFriendsWith(v)
		local hasKnife = M.hasKnife(v)

		local normalColor = (isFriend and Color3.fromRGB(0, 255, 0)) or Color3.fromRGB(255, 0, 0)

		local color = (
			(M.getCurrentGame() == "HideAndSeek" and not isFriend) and (hasKnife and Color3.fromRGB(255, 0, 0))
			or Color3.fromRGB(0, 255, 0)
		) or normalColor

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

function M.getValues()
	local values = game.Workspace:FindFirstChild("Values")
	return values
end

function M.getCurrentGame()
	local values = M.getValues()
	local cg = values:FindFirstChild("CurrentGame")

	if cg then
		return cg.Value
	end

	return nil
end

function M.getGlassBridge()
	local gb = game.Workspace:FindFirstChild("GlassBridge")
	return gb
end

function M.getGlassHolder()
	local gb = M.getGlassBridge()

	if gb then
		local gh = gb:FindFirstChild("GlassHolder")
		return gh
	end

	return nil
end

function M.getGlassPanels()
	local gh = M.getGlassHolder()

	if gh then
		local panels = gh:GetChildren()
		return panels
	end

	return {}
end

function M.getGlassModels(panel)
	if panel then
		local models = panel:GetChildren()
		return models
	end

	return {}
end

function M.getGlassPart(model)
	local part = model and model:FindFirstChild("glasspart")
	return part
end

function M.isFakeGlass(part)
	local blur = part and part:FindFirstChild("Blur")

	if blur then
		return true
	end

	return false
end

function M.getGlassParts()
	local parts = {}
	local panels = M.getGlassPanels()

	for i, p in pairs(panels) do
		local models = M.getGlassModels(p)

		for j, m in pairs(models) do
			local part = M.getGlassPart(m)
			if part then
				table.insert(parts, part)
			end
		end
	end

	return parts
end

function M.updateGlassBridgeESP(enabled)
	local parts = M.getGlassParts()

	for i, p in pairs(parts) do
		local isFake = M.isFakeGlass(p)

		Utils.updateESP(p, Color3.fromRGB(255, 0, 0), enabled and isFake)
	end
end

function M.hasKnife(plr)
	local char = plr and plr.Character
	local backpack = plr and plr:FindFirstChild("Backpack")
	local knife = (backpack and backpack:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife"))

	if knife then
		return true
	end

	return false
end

return M
