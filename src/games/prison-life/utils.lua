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

-- if getrawmetatable and setreadonly and newcclosure and getnamecallmethod then
-- 	local RS = game:GetService("ReplicatedStorage")
-- 	local GUN_REMOTES = RS:WaitForChild("GunRemotes")
-- 	local SHOOT_EVENT = GUN_REMOTES:WaitForChild("ShootEvent")

-- 	local metatable = getrawmetatable(game)
-- 	local originalNamecall = metatable.__namecall

-- 	setreadonly(metatable, false)

-- 	-- FIX 1: Fetch the player and mouse ONCE globally outside of the hook.
-- 	-- This completely eliminates yielding inside the __namecall thread.
-- 	local plr = Utils.getLocalPlayer()
-- 	local mouse = plr and plr:GetMouse()

-- 	local isModifying = false

-- 	metatable.__namecall = newcclosure(function(self, ...)
-- 		local method = getnamecallmethod()

-- 		if method == "FireServer" and self == SHOOT_EVENT and not isModifying then
-- 			local args = { ... }

-- 			-- Wrap in a fast, non-yielding pcall
-- 			local success, err = pcall(function()
-- 				if args and args[1] and args[1][1] then
-- 					local eArgs = args[1][1]
-- 					local origin = eArgs[1]

-- 					print("Interception Active - Origin:", origin)

-- 					-- FIX 2: Check the pre-cached mouse object instantly
-- 					if mouse and mouse.Target then
-- 						local part = mouse.Target
-- 						local target = part.Position

-- 						-- Match your exact nested table structure
-- 						local newArgs = { { { origin, target, part } } }

-- 						-- Set the flag, fire via originalNamecall, and reset instantly
-- 						isModifying = true
-- 						originalNamecall(self, table.unpack(newArgs))
-- 						isModifying = false
-- 					end
-- 				end
-- 			end)

-- 			if not success then
-- 				warn("Error during argument handling:", err)
-- 				isModifying = false -- Safeguard against flag locking up on error
-- 			end

-- 			-- Return empty to drop the client's original packet
-- 			return
-- 		end

-- 		-- Pass through all normal network packets
-- 		return originalNamecall(self, ...)
-- 	end)

-- 	setreadonly(metatable, true)
-- end

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

	local char = Utils.getLocalChar()

	if char and event then
		local head = char:FindFirstChild("Head")

		if head then
			event:FireServer({
				{
					head.Position,
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
	local myChar = Utils.getLocalChar()

	if myChar and root then
		local head = char and char:FindFirstChild("Head")

		if head then
			local origin = head.Position
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
