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

function M.getGunRemotes()
	local RS = game:GetService("ReplicatedStorage")
	return RS:FindFirstChild("GunRemotes")
end

function M.getShootEvent()
	local gr = M.getGunRemotes()
	return gr and gr:FindFirstChild("ShootEvent")
end

function M.getReloadEvent()
	local gr = M.getGunRemotes()
	return gr and gr:FindFirstChild("FuncReload")
end

function M.reload()
	local event = M.getReloadEvent()

	if event then
		event:InvokeServer()
	end
end

local shots = 0

function M.shootPart(part)
	local event = M.getShootEvent()

	local root = Utils.getLocalRoot()

	if event then
		event:FireServer({
			{
				root.Position,
				part.Position,
				part,
			},
		})
		shots = shots + 1

		if shots > 20 then
			shots = 0
			M.reload()
		end
	end
end

function M.shootPlayer(plr)
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if root then
		M.shootPart(root)
	end
end

function M.shootPlayerIfVisible(plr)
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local myRoot = Utils.getLocalRoot()
	local myChar = Utils.getLocalChar()

	if myChar and myRoot and root then
		local origin = myRoot.Position
		local target = root.Position
		local dir = (target - origin)

		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = { myChar }
		params.IgnoreWater = true

		local result = game.Workspace:Raycast(origin, dir, params)

		if result then
			if result.Instance:IsDescendantOf(char) then
				M.shootPlayer(plr)
			end
		end
	end
end

function M.getAllOnTeam(teamName)
	local players = {}

	local plr = Utils.getLocalPlayer()
	for _, v in pairs(game:GetService("Players"):GetPlayers()) do
		if v.Team.Name == teamName and v ~= plr then
			table.insert(players, v)
		end
	end

	return players
end

function M.getCriminals()
	return M.getAllOnTeam("Criminals")
end

function M.getGuards()
	return M.getAllOnTeam("Guards")
end

function M.getInmates()
	return M.getAllOnTeam("Inmates")
end

function M.shootAllCriminals()
	local criminals = M.getCriminals()
	for _, v in pairs(criminals) do
		M.shootPlayerIfVisible(v)
	end
end

function M.shootAllGuards()
	local guards = M.getGuards()
	for _, v in pairs(guards) do
		M.shootPlayerIfVisible(v)
	end
end

function M.shootAllInmates()
	local inmates = M.getInmates()
	for _, v in pairs(inmates) do
		M.shootPlayerIfVisible(v)
	end
end

function M.removeDoors()
	local doors = workspace:FindFirstChild("Doors")
	if doors then
		doors:Destroy()
	end
end

return M
