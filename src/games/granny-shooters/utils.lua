local Utils = require("../../utils")

local M = {}

function M.getCurrentGun()
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local gun = char and char:FindFirstChildOfClass("Tool")

	return gun
end

function M.getGunFireEvent()
	local gun = M.getCurrentGun()
	local events = gun and gun:FindFirstChild("Events")
	local event = events and events:FindFirstChild("Fire")

	return event
end

function M.getGunReloadEvent()
	local gun = M.getCurrentGun()
	local events = gun and gun:FindFirstChild("Events")
	local event = events and events:FindFirstChild("Reload")

	return event
end

function M.getGunAmmo()
	local gun = M.getCurrentGun()
	local gunServer = gun and gun:FindFirstChild("GunServer")
	local ammoV = gunServer and gunServer:FindFirstChild("Ammo")
	local ammo = (ammoV and ammoV.Value) or 0

	return ammo
end

function M.reloadGun()
	local event = M.getGunReloadEvent()

	if event then
		event:FireServer()
	end
end

function M.shootChar(pChar)
	local event = M.getGunFireEvent()

	local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")
	local hum = pChar and pChar:FindFirstChildWhichIsA("Humanoid")

	if pRoot and hum and event then
		local latency = game:GetService("Players").LocalPlayer:GetNetworkPing() / 2
		local tVel = pRoot.AssemblyLinearVelocity
		local tMov = hum and (hum.MoveDirection * hum.WalkSpeed)
		tVel = tVel:Lerp(tMov, 0.6)
		local tPos = pRoot.Position + (tVel * latency)

		local rng = Random.new()

		event:FireServer({
			Origin = pRoot.Position,
			Timestamp = game.Workspace:GetServerTimeNow(),
			Direction = Utils.dir3d(pRoot.Position, tPos),
			Seed = rng:NextInteger(0, 100),
		})
	end
end

function M.findClosestChar()
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if root then
		local best = nil
		local best_dist = 99999999
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if v ~= plr then
				local pChar = v and v.Character
				local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")
				local ff = pChar and pChar:FindFirstChildOfClass("ForceField")
				local hum = pChar and pChar:FindFirstChildOfClass("Humanoid")

				if pRoot and not ff and (hum and hum.Health > 0) then
					local dist = Utils.dist3d(root.Position, pRoot.Position)
					-- local dist = hum.Health
					if dist < best_dist then
						best = pChar
						best_dist = dist
					end
				end
			end
		end
		return best
	end

	return nil
end

return M
