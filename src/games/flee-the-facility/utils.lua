local Utils = require("../../utils")

local M = {}

function M.getCurrentMap()
	for i, v in pairs(game.Workspace:GetChildren()) do
		if v:FindFirstChild("ComputerTable") then
			return v
		end
	end

	return nil
end

function M.getCurrentMapChildren()
	local map = M.getCurrentMap()
	if not map then
		return {}
	end

	return map:GetChildren()
end

function M.getExits()
	local exits = {}
	local map = M.getCurrentMapChildren()

	for i, v in pairs(map) do
		if v.Name == "ExitDoor" then
			table.insert(exits, v)
		end
	end

	return exits
end

function M.getExitArea(exit)
	local area = exit:FindFirstChild("ExitArea")
	return area
end

function M.getExitTrigger(exit)
	local trigger = exit:FindFirstChild("ExitDoorTrigger")
	return trigger
end

function M.exitNeedsToOpen(exit)
	local trigger = M.getExitTrigger(exit)
	local value = trigger and trigger:FindFirstChild("ActionSign")

	if value then
		return value.Value ~= 0
	end

	return false
end

function M.exitIsOpen(exit)
	local trigger = M.getExitTrigger(exit)

	if not trigger then
		return true
	end

	return false
end

function M.getClosestClosedExit()
	local exits = M.getExits()
	local closed_exits = {}

	for i, v in pairs(exits) do
		if not M.exitIsOpen(v) and M.exitNeedsToOpen(v) then
			table.insert(closed_exits, v)
		end
	end

	local best = nil
	local best_dist = 99999999

	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if root then
		for i, v in pairs(closed_exits) do
			local trigger = M.getExitTrigger(v)
			local dist = Utils.dist3d(trigger.Position, root.Position)
			if dist < best_dist then
				best_dist = dist
				best = v
			end
		end
	end

	return best
end

function M.findOpenExit()
	local open_exits = {}

	for i, v in pairs(M.getExits()) do
		if M.exitIsOpen(v) then
			table.insert(open_exits, v)
		end
	end

	local best = nil
	local best_dist = 99999999

	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if root then
		for i, v in pairs(open_exits) do
			local area = M.getExitArea(v)
			local dist = Utils.dist3d(area.Position, root.Position)

			if dist < best_dist then
				best_dist = dist
				best = v
			end
		end
	end

	return best
end

function M.findBeast()
	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		if
			v.Character
			and v.Character:FindFirstChild("BeastPowers")
			and v ~= game:GetService("Players").LocalPlayer
		then
			return v
		end
	end

	return nil
end

function M.findBeastIncludingLocal()
	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		if v.Character and v.Character:FindFirstChild("BeastPowers") then
			return v
		end
	end

	return nil
end

function M.getHammer()
	local beast = M.findBeastIncludingLocal()
	local char = beast and beast.Character
	local hammer = char and char:FindFirstChild("Hammer")

	return hammer
end

function M.getHammerHandle()
	local beast = M.findBeast()
	local char = beast and beast.Character
	local hammer = char and char:FindFirstChild("Hammer")
	local handle = hammer and hammer:FindFirstChild("Handle")

	return handle
end

function M.getHammerEvent()
	local hammer = M.getHammer()

	if hammer then
		return hammer:FindFirstChild("HammerEvent")
	end

	return nil
end

function M.getPowerEvent()
	local beast = M.findBeastIncludingLocal()
	local beastChar = beast and beast.Character
	local powers = beastChar and beastChar:FindFirstChild("BeastPowers")
	local event = powers and powers:FindFirstChild("PowersEvent")
	return event
end

function M.clickHammer()
	local event = M.getHammerEvent()

	if event then
		event:FireServer("HammerClick", true)
	end
end

function M.getStats(plr)
	local stats = plr and plr:FindFirstChild("TempPlayerStatsModule")
	return stats
end

function M.isRagdoll(plr)
	local stats = M.getStats(plr)
	local ragdoll = stats and stats:FindFirstChild("Ragdoll")
	local isRagdoll = ragdoll and ragdoll.Value

	if isRagdoll == nil then
		return false
	end

	return isRagdoll
end

function M.isCaptured(plr)
	local stats = M.getStats(plr)
	local captured = stats and stats:FindFirstChild("Captured")
	local isCaptured = captured and captured.Value

	if isCaptured == nil then
		return false
	end

	return isCaptured
end

function M.hitPlayer(plr)
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if root then
		local event = M.getHammerEvent()
		if event then
			M.clickHammer()
			event:FireServer("HammerHit", root)
		end
	end
end

function M.tiePlayer(plr)
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if root then
		local event = M.getHammerEvent()
		if event then
			event:FireServer("HammerTieUp", root, root.Position)
		end
	end
end

function M.getChaseMusic()
	local handle = M.getHammerHandle()
	local music = handle and handle:FindFirstChild("SoundChaseMusic")

	return music
end

local defaultChaseMusicVolume = 0.4
local chaseMusicVolume = 0.4

task.spawn(function()
	while task.wait() do
		local music = M.getChaseMusic()

		if music then
			music.Volume = chaseMusicVolume
		end
	end
end)

function M.updateChaseVolume(value)
	chaseMusicVolume = ((value / 100) * defaultChaseMusicVolume)
end

function M.isGameActive()
	return game.ReplicatedStorage.IsGameActive.Value and game.ReplicatedStorage.GameTimer.Value ~= 0
end

function M.isBeast()
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character

	if M.isGameActive() and char then
		task.wait()
		return char:FindFirstChild("BeastPowers")
	end

	return false
end

function M.getDistToBeast()
	local beast = M.findBeast()
	local beastChar = beast and beast.Character
	local beastRoot = beastChar and beastChar:FindFirstChild("HumanoidRootPart")

	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if beastRoot and root then
		return Utils.dist3d(root.Position, beastRoot.Position)
	end

	return 99999999
end

function M.getActivePlayers()
	local players = {}

	local plr = game:GetService("Players").LocalPlayer
	local pgui = plr and plr:FindFirstChild("PlayerGui")
	local sgui = pgui and pgui:FindFirstChild("ScreenGui")
	local sbars = sgui and sgui:FindFirstChild("StatusBars")

	local bars = sbars and sbars:GetChildren()

	if bars then
		for i, v in pairs(bars) do
			if v:IsA("TextLabel") and v.TextColor3 == Color3.fromRGB(255, 255, 255) then
				local name = v.ContentText
				local player = game:GetService("Players"):FindFirstChild(name)

				if player then
					table.insert(players, player)
				end
			end
		end
	end

	return players
end

function M.isPlayerCaptured(plr)
	local stats = M.getStats(plr)
	local cap = stats and stats:FindFirstChild("Captured")
	if cap then
		return cap.Value
	end

	return false
end

function M.getCapturablePlayers()
	local players = {}

	local plr = game:GetService("Players").LocalPlayer

	for i, v in pairs(M.getActivePlayers()) do
		if v ~= plr then
			if not M.isPlayerCaptured(v) then
				table.insert(players, v)
			end
		end
	end

	return players
end

function M.triggerEvent(event, value)
	local RemoteEvent = game:GetService("ReplicatedStorage").RemoteEvent
	RemoteEvent:FireServer("Input", "Trigger", value, event)
end

function M.triggerInput(value)
	local RemoteEvent = game:GetService("ReplicatedStorage").RemoteEvent
	RemoteEvent:FireServer("Input", "Action", value)
end

function M.triggerCrawl(value)
	local RemoteEvent = game:GetService("ReplicatedStorage").RemoteEvent
	RemoteEvent:FireServer("Input", "Crawl", value)
end

function M.triggerPod(pod)
	local event = pod:FindFirstChild("Event")

	if event then
		local stats = M.getStats(game:GetService("Players").LocalPlayer)
		local actionEvent = stats and stats:FindFirstChild("ActionEvent")
		local prevEvent = actionEvent and actionEvent.Value

		task.spawn(function()
			M.triggerEvent(event, true)
			M.triggerInput(true)
			task.wait(1)
			M.triggerEvent(event, false)
			M.triggerInput(false)
			task.wait(1)
			if prevEvent then
				M.triggerEvent(prevEvent, true)
				M.triggerInput(true)
			end
		end)
	end
end

function M.findNearestFreezePod()
	local best
	local best_dist = 99999999

	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	for i, v in pairs(game.Workspace:GetDescendants()) do
		if v.Name == "FreezePod" then
			local pod = v:FindFirstChild("PodTrigger")
			if pod then
				local capturedTorsoValue = pod:FindFirstChild("CapturedTorso")

				if capturedTorsoValue.Value == nil then
					local dist = Utils.dist3d(root.Position, pod.Position)
					if dist < best_dist then
						best = pod
						best_dist = dist
					end
				end
			end
		end
	end

	return best
end

function M.triggerNearestFreezePod()
	local pod = M.findNearestFreezePod()
	if pod then
		M.triggerPod(pod)
	end
end

function M.teleportToNearestFreezePod()
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if root then
		local pod = M.findNearestFreezePod()

		Utils.Noclip.enable()
		root.CFrame = pod.CFrame
		task.delay(1, Utils.Noclip.disable)
	end
end

function M.isInGame()
	local plr = game:GetService("Players").LocalPlayer
	local players = M.getActivePlayers()

	if plr and players then
		for i, v in pairs(players) do
			if v == plr then
				return true
			end
		end
	end

	return false
end

function M.partCloseToModel(part, model, ddist)
	local base = nil
	if model.PrimaryPart then
		base = model.PrimaryPart
	else
		local d = model:GetDescendants()
		for i, v in pairs(d) do
			if v:IsA("BasePart") then
				base = v
				break
			end
		end
	end

	if part and base then
		local dist = Utils.dist3d(part.Position, base.Position)
		return dist <= ddist
	end

	return false
end

function M.isCloseToModel(model, ddist)
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	return M.partCloseToModel(root, model, ddist)
end

function M.partCloseToModelName(part, name, ddist)
	for i, v in pairs(M.getCurrentMapChildren()) do
		if v.Name == name then
			if M.partCloseToModel(part, v, ddist) then
				return true, v
			end
		end
	end

	return false, nil
end

function M.isCloseToModelName(name, ddist)
	for i, v in pairs(M.getCurrentMapChildren()) do
		if v.Name == name then
			if M.isCloseToModel(v, ddist) then
				return true, v
			end
		end
	end

	return false, nil
end

function M.partCloseToComputer(part)
	return M.partCloseToModelName(part, "ComputerTable", 20)
end

function M.isCloseToComputer()
	return M.isCloseToModelName("ComputerTable", 8.5)
end

function M.isCloseToFreezePod()
	return M.isCloseToModelName("FreezePod", 10)
end

function M.isCloseToExit()
	return M.isCloseToModelName("ExitDoor", 20)
end

function M.getLockers()
	return game:GetService("CollectionService"):GetTagged("LOCKER")
end

function M.findNearestLocker()
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if root then
		local best = nil
		local best_dist = 999999999

		for i, v in pairs(M.getLockers()) do
			local part = v:FindFirstChildOfClass("Part")
			if part then
				local dist = Utils.dist3d(root.Position, part.Position)

				if dist < best_dist then
					best_dist = dist
					best = v
				end
			end
		end

		return best
	end

	return nil
end

function M.getCurrentPower()
	local v = game:GetService("ReplicatedStorage"):FindFirstChild("CurrentPower")
	if v then
		return v.Value
	end
	return ""
end

function M.isPowerActive()
	local v = game:GetService("ReplicatedStorage"):FindFirstChild("PowerActive")
	if v then
		return v.Value
	end
	return false
end

function M.isSeerActive()
	local isSeer = M.getCurrentPower() == "Seer"
	return isSeer and M.isPowerActive()
end

local computerUnhacked = Color3.fromRGB(13, 105, 172)
local computerErrored = Color3.fromRGB(196, 40, 28)
function M.getClosestComputer(includeHacked)
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	local best = nil
	local best_dist = 99999999

	if root then
		for i, v in pairs(M.getCurrentMapChildren()) do
			if v.Name == "ComputerTable" then
				local base = v.PrimaryPart

				if base then
					local dist = Utils.dist3d(root.Position, base.Position)

					if includeHacked then
						if dist < best_dist then
							best_dist = dist
							best = v
						end
					else
						local screen = v:FindFirstChild("Screen")
						if screen and (screen.Color == computerUnhacked or screen.Color == computerErrored) then
							if dist < best_dist then
								best_dist = dist
								best = v
							end
						end
					end
				end
			end
		end
	end

	return best
end

function M.getValidSpot(computer)
	local screen = computer:FindFirstChild("Screen")
	if screen and (screen.Color == computerUnhacked or screen.Color == computerErrored) then
		local trigger1 = computer:FindFirstChild("ComputerTrigger1")
		local trigger2 = computer:FindFirstChild("ComputerTrigger2")
		local trigger3 = computer:FindFirstChild("ComputerTrigger3")

		local triggers = { trigger1, trigger2, trigger3 }

		local valid_triggers = {}

		for _, t in pairs(triggers) do
			local v = t:FindFirstChild("ActionSign")

			if v then
				if v.Value ~= 0 then
					table.insert(valid_triggers, t)
				end
			end
		end

		local best_dist = 99999999
		local best = nil

		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if root then
			for i, t in pairs(valid_triggers) do
				local dist = Utils.dist3d(root.Position, t.Position)
				if dist < best_dist then
					best_dist = dist
					best = t
				end
			end
		end

		return best
	end

	return nil
end

local beast_max_dist = 20
M.beast_max_dist = beast_max_dist

function M.doBeastRaycast(part)
	local beast = M.findBeast()
	local beastChar = beast and beast.Character
	local beastHead = beastChar and beastChar:FindFirstChild("Head")

	if beastHead and part then
		local origin = part.Position
		local target = beastHead.Position

		local dir = (target - origin) * 1.5

		local plrs = game:GetService("Players"):GetPlayers()
		local exclusions = { part, part.Parent }

		for i, v in pairs(plrs) do
			local char = v.Character
			if char and v ~= beast then
				table.insert(exclusions, char)
			end
		end

		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = exclusions
		params.IgnoreWater = true

		local result = game.Workspace:Raycast(origin, dir, params)

		if result then
			local instance = result.Instance

			if instance then
				if instance:IsDescendantOf(beastChar) then
					return true
				end
			end
		end
	end

	return false
end

function M.LOSToBeast()
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character

	local root = char and char:FindFirstChild("HumanoidRootPart")
	local head = char and char:FindFirstChild("Head")
	local lleg = char and char:FindFirstChild("Left Leg")
	local rleg = char and char:FindFirstChild("Right Leg")

	local parts = { root, head, lleg, rleg }

	for i, v in pairs(parts) do
		if v then
			if M.doBeastRaycast(v) then
				return true
			end
		end
	end

	return false
end

function M.isInDanger()
	return M.getDistToBeast() <= beast_max_dist and M.LOSToBeast()
end

local function M.shouldEasyHack()
	return M.getDistToBeast() > 30 or not M.LOSToBeast()
end

return M
