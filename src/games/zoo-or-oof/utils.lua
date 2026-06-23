local Utils = require("../../utils")

local M = {}

function M.updateAnimalESP(enabled)
	local gameplay = game.Workspace:FindFirstChild("Gameplay")
	local dynamic = gameplay and gameplay:FindFirstChild("Dynamic")
	local animals_ = dynamic and dynamic:FindFirstChild("Animals")
	local animals = animals_ and animals_:GetChildren()

	for i, v in pairs(animals) do
		Utils.updateESP(v, Color3.fromRGB(0, 128, 255), enabled)
	end
end

function M.getTeam()
	local plr = game:GetService("Players").LocalPlayer
	return (plr and plr.Team) or { Name = "Not in game" }
end

function M.isAnimal()
	return M.getTeam().Name == "Animal"
end

function M.isKeeper()
	return M.getTeam().Name == "Keeper"
end

function M.isInGame()
	return M.getTeam().Name ~= "Not in game"
end

function M.getKeeper()
	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		if v.Team.Name == "Keeper" then
			return v
		end
	end

	return nil
end

function M.getClosestAnimal()
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	local plrs = game:GetService("Players"):GetPlayers()

	local best = nil
	local best_dist = 99999999

	for i, v in pairs(plrs) do
		local vChar = v.Character
		local vRoot = vChar and vChar:FindFirstChild("HumanoidRootPart")

		if vRoot and root then
			local dist = Utils.dist3d(root.Position, vRoot.Position)

			if dist < best_dist and v ~= plr and v.Team.Name == "Animal" then
				best_dist = dist
				best = v
			end
		end
	end

	return best
end

function M.getPlayersAnimal(plr)
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if root then
		local gameplay = game.Workspace:FindFirstChild("Gameplay")
		local dynamic = gameplay and gameplay:FindFirstChild("Dynamic")
		local animals_ = dynamic and dynamic:FindFirstChild("Animals")
		local animals = animals_ and animals_:GetChildren()

		if animals then
			local best = nil
			local best_dist = 99999999

			for i, v in pairs(animals) do
				local rootPart = v.PrimaryPart
				if rootPart then
					local dist = Utils.dist3d(root.Position, rootPart.Position)

					if dist < best_dist then
						best_dist = dist
						best = v
					end
				end
			end

			return best
		end
	end

	return nil
end

return M
