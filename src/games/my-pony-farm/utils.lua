local Utils = require("../../utils")

local M = {}

M.getDropsFolder = function()
	return workspace:FindFirstChild("Drops")
end

M.getDrops = function()
	local dropsFolder = M.getDropsFolder()

	if not dropsFolder then
		return {}
	end

	return dropsFolder:GetChildren()
end

local function split(str, sep)
	sep = sep or "%s"
	local result = {}
	for match in string.gmatch(str, "([^" .. sep .. "]+)") do
		table.insert(result, match)
	end
	return result
end

M.grabDrop = function(drop)
	local touch = drop:FindFirstChild("Touch")

	local root = Utils.getLocalRoot()

	if drop and root then
		firetouchinterest(touch, root, true)
		task.wait()
		firetouchinterest(touch, root, false)
	end

	-- local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
	-- local Event = remotes and remotes:FindFirstChild("DropPickup")

	-- -- game:GetService("ReplicatedStorage").Remotes.DropPickup

	-- if Event then
	-- 	local dropNumStr = split(drop.Name, "_")[2]
	-- 	local dropNum = tonumber(dropNumStr)
	-- 	print("Grabbing drop: " .. dropNum)
	-- 	Event:FireServer(dropNum)
	-- end
end

M.grabAllDrops = function()
	local drops = M.getDrops()

	for _, drop in pairs(drops) do
		-- print("Grabbing drop: " .. drop.Name)
		M.grabDrop(drop)
	end
end

return M
