local Utils = require("../../utils")

local M = {}

M.Queue = {
	running = false,
	items = {},
	add = function(self, item, onDone)
		table.insert(self.items, { item = item, onDone = onDone })
	end,
	update = function(self)
		if not self.running and #self.items > 0 then
			local item = table.remove(self.items, 1)
			self.running = true
			item.item()
			self.running = false
			if item.onDone then
				item.onDone()
			end
		end
	end,
}

task.spawn(function()
	while task.wait() do
		M.Queue:update()
	end
end)

function M.getItemFolders()
	if M.ItemFolders then
		return M.ItemFolders
	end

	local itemFolders = {}

	-- workspace:GetChildren()[146].Items["Eye Drops"]
	-- Model
	for i, v in pairs(game.Workspace:GetChildren()) do
		if v.Name == "Model" then
			local itemsFolder = v:FindFirstChild("Items")
			if itemsFolder then
				table.insert(itemFolders, itemsFolder)
			end
		end
	end

	M.ItemFolders = itemFolders
	return itemFolders
end

function M.getItems()
	if M.Items then
		return M.Items
	end

	local items = {}
	local itemFolders = M.getItemFolders()

	for i, v in pairs(itemFolders) do
		for i, v in pairs(v:GetChildren()) do
			table.insert(items, v)
		end
	end

	M.Items = items
	return items
end

function M.getItem(itemName)
	local items = M.getItems()

	for i, v in pairs(items) do
		if v.Name == itemName then
			return v
		end
	end

	return nil
end

function M.fireProximityPrompt(pp, base)
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	if root then
		local camera = game.Workspace.CurrentCamera
		local pos = root.CFrame
		local grav = game.Workspace.Gravity

		task.wait()

		Utils.Noclip.enable()
		game.Workspace.Gravity = 0

		task.wait()

		root.CFrame = base.CFrame * CFrame.new(0, 0, -2)
		camera.CFrame = CFrame.lookAt(camera.CFrame.Position, base.Position)

		-- task.wait(0.1)
		task.wait()

		pp.Enabled = false
		pp.Enabled = true

		local attempts = 0
		repeat
			task.wait()
			attempts = attempts + 1
		until pp:InputHoldBegin() or attempts > 10

		fireproximityprompt(pp)
		pp:InputHoldEnd()

		-- task.wait(0.1)
		task.wait()

		root.CFrame = pos

		task.wait()

		Utils.Noclip.disable()
		game.Workspace.Gravity = grav

		task.wait()

		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local humanoid = char and char:FindFirstChildWhichIsA("Humanoid")
		humanoid.PlatformStand = false
	end
end

function M.grabItem(itemName)
	local item = M.getItem(itemName)
	if item then
		local pp = item:FindFirstChild("PP")
		local base = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")

		if pp and base then
			M.Queue:add(function()
				M.fireProximityPrompt(pp, base)
			end)
		end
	end
end

function M.getCheckInHL()
	local misc = game.Workspace:FindFirstChild("Misc")
	local checkIn = misc and misc:FindFirstChild("CheckIn")
	local hl = checkIn and checkIn:FindFirstChild("CheckStepHighlight", true)

	return hl
end

function M.getNPCHL()
	local npcs = game.Workspace:FindFirstChild("NPCs")
	local hl = npcs
		and (npcs:FindFirstChild("CheckStepHighlight", true) or npcs:FindFirstChild("PatientHighlight", true))

	return hl
end

function M.getMedicalHL()
	local rooms = game.Workspace:FindFirstChild("Rooms")
	local medical = rooms and rooms:FindFirstChild("Medical")
	local hl = medical and medical:FindFirstChild("PatientHighlight", true)

	return hl
end

function M.getPPFromHL(hl)
	return hl.Parent.Parent:FindFirstChild("PP2") or hl.Parent:FindFirstChild("PP")
end

return M
