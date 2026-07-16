local Utils = require("../../utils")

local M = {}

function M.plrHasItem(player, item)
	local pBackpack = player:FindFirstChild("Backpack")
	local pChar = player.Character

	local itemBackpack = pBackpack and pBackpack:FindFirstChild(item)
	local itemPlayer = pChar and pChar:FindFirstChild(item)

	if itemBackpack or itemPlayer then
		return true
	end

	return false
end

function M.plrHasKnife(player)
	return M.plrHasItem(player, "Knife")
end

function M.plrHasGun(player)
	return M.plrHasItem(player, "Gun")
end

local murderer = nil
local sheriff = nil

task.spawn(function()
	game:GetService("ReplicatedStorage")
		:WaitForChild("Remotes")
		:WaitForChild("Gameplay")
		:WaitForChild("PlayerDataChanged").OnClientEvent
		:Connect(function(data)
			murderer = nil
			sheriff = nil

			for k, v in pairs(data) do
				local plr = game:GetService("Players"):FindFirstChild(k)

				for vk, vv in pairs(v) do
					if vk == "Role" then
						if vv == "Murderer" then
							murderer = plr
						end

						if vv == "Sheriff" then
							sheriff = plr
						end
					end
				end
			end
		end)

	game:GetService("ReplicatedStorage")
		:WaitForChild("Remotes")
		:WaitForChild("Gameplay")
		:WaitForChild("RoundEndFade").OnClientEvent
		:Connect(function(data)
			murderer = nil
			sheriff = nil
		end)
end)

function M.getMurderer()
	for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
		if M.plrHasKnife(plr) then
			murderer = plr
			break
		end
	end

	return murderer
end

function M.getSheriff()
	for _, plr in pairs(game:GetService("Players"):GetPlayers()) do
		if M.plrHasGun(plr) then
			sheriff = plr
			break
		end
	end

	return sheriff
end

function M.shootPos(pos)
	local plr = Utils.getLocalPlayer()

	if M.plrHasGun(plr) then
		local char = Utils.getLocalChar()
		local root = Utils.getLocalRoot()
		local gun = char and char:FindFirstChild("Gun")
		local shoot = gun and gun:FindFirstChild("Shoot")
		-- local handle = gun and gun:FindFirstChild("Handle")

		if shoot and root then
			-- shoot:FireServer(handle.CFrame, cf)
			-- shoot:FireServer(handle.CFrame, CFrame.new(pos))
			shoot:FireServer(root.CFrame, CFrame.new(pos))
			-- shoot:FireServer(CFrame.new(pos), CFrame.new(pos))
		end
	end
end

function M.shootPlayer(plr)
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildWhichIsA("Humanoid")

	local lplr = Utils.getLocalPlayer()

	if lplr and root then
		local latency = lplr:GetNetworkPing() * 1.5
		local tVel = root.AssemblyLinearVelocity
		-- local tMov = hum and (hum.MoveDirection * hum.WalkSpeed)
		-- tVel = tVel:Lerp(tMov, 0.6)
		local tPos = root.Position + (tVel * latency)

		M.shootPos(tPos)
	end
end

function M.doMurderRaycast(origin, target)
	local char = Utils.getLocalChar()

	local dir = (target - origin) - ((target - origin).Unit * 1.5)

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { char }
	params.IgnoreWater = true

	local result = game.Workspace:Spherecast(origin, 1.5, dir, params)

	if not result then
		return true
	end

	return false
end

function M.getValidOffset(otherRoot, offsets)
	for _, offset in pairs(offsets) do
		local origin = otherRoot.Position + offset
		local target = otherRoot.Position
		if M.doMurderRaycast(origin, target) then
			return offset
		end
	end

	return Vector3.new(0, 0, 0)
end

function M.getShotPos(other)
	local root = Utils.getLocalRoot()

	local otherChar = other and other.Character
	local otherRoot = otherChar and otherChar:FindFirstChild("HumanoidRootPart")

	local offsets = {
		Vector3.new(0, 0, -15),
		Vector3.new(0, 0, 15),
		Vector3.new(0, -15, 0),
		Vector3.new(0, 15, 0),
		Vector3.new(-15, 0, 0),
		Vector3.new(15, 0, 0),
	}

	if root and otherRoot then
		local offset = M.getValidOffset(otherRoot, offsets)
		return otherRoot.CFrame * CFrame.new(offset)
	end

	return nil
end

function M.tpShoot(other)
	local plr = Utils.getLocalPlayer()
	local root = Utils.getLocalRoot()

	local otherChar = other and other.Character
	local otherRoot = otherChar and otherChar:FindFirstChild("HumanoidRootPart")

	local latency = plr:GetNetworkPing()
	if root and otherRoot then
		local pos = root.CFrame
		task.wait(0.1)

		local cf = M.getShotPos(other)

		root.CFrame = cf

		task.wait(latency * 2)

		M.shootPlayer(other)

		task.wait(latency * 2)

		root.CFrame = pos
	end
end

function M.updatePlayerESP(enabled)
	local _murderer = M.getMurderer()
	local _sheriff = M.getSheriff()

	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		if v ~= game:GetService("Players").LocalPlayer then
			local isMurderer = v == _murderer
			local isSheriff = v == _sheriff

			if isSheriff then
				Utils.updatePlayerESP(v, Color3.fromRGB(0, 0, 255), enabled, Color3.fromRGB(255, 0, 255))
			elseif isMurderer then
				Utils.updatePlayerESP(v, Color3.fromRGB(255, 0, 0), enabled, Color3.fromRGB(255, 0, 255))
			else
				Utils.updatePlayerESP(v, Color3.fromRGB(0, 255, 0), enabled, Color3.fromRGB(255, 0, 255))
			end
		end
	end
end

function M.updateCoinESP(enabled)
	local coins = game.Workspace:FindFirstChild("CoinContainer", true)

	if coins then
		for i, v in pairs(coins:GetChildren()) do
			if v.Name == "CollectedCoin" then
				v:Destroy()
			end
		end

		Utils.updateESP(coins, Color3.fromRGB(255, 200, 0), enabled)
	end
end

function M.flingMurderer()
	local murderer = M.getMurderer()

	if murderer and murderer ~= game:GetService("Players").LocalPlayer then
		Utils.flingPlayer(murderer)
	end
end

function M.killAll()
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local hum = char and char:FindFirstChild("Humanoid")
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if hum then
		local backpack = plr:FindFirstChild("Backpack")
		local knifeBackpack = backpack and backpack:FindFirstChild("Knife")

		if knifeBackpack then
			hum:EquipTool(knifeBackpack)
			task.wait()
		end

		local knifePlayer = plr.Character:FindFirstChild("Knife")

		if knifePlayer then
			task.spawn(function()
				local running = true
				task.spawn(function()
					task.wait(1)
					running = false
				end)
				while running do
					for i, v in pairs(game:GetService("Players"):GetPlayers()) do
						local pChar = v.Character
						local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")

						if pChar and v ~= game:GetService("Players").LocalPlayer and not Utils.isFriendsWith(v) then
							pRoot.CFrame = root.CFrame * CFrame.new(0, 0, -3)
						end
					end

					task.wait()
				end
			end)

			task.wait()

			knifePlayer:Activate()
		end
	end
end

return M
