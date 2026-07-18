local GameUtils = require("./utils")
local Utils = require("../../utils")

local M = {}

M.State = {
	player_esp_toggled = true,
	guard_esp_toggled = true,
	glass_bridge_esp_toggled = true,
	player_guard_tp_toggled = false,
	npc_guard_tp_toggled = false,
}

function M.onPlayerESPToggle(value)
	M.State.player_esp_toggled = value
	GameUtils.updatePlayerESP(value)
end

task.spawn(function()
	while task.wait(1) do
		if M.State.player_esp_toggled then
			GameUtils.updatePlayerESP(M.State.player_esp_toggled)
		end
	end
end)

function M.onGuardESPToggle(value)
	M.State.guard_esp_toggled = value
	GameUtils.updateGuardESP(value)
end

task.spawn(function()
	while task.wait(1) do
		if M.State.guard_esp_toggled then
			GameUtils.updateGuardESP(M.State.guard_esp_toggled)
		end
	end
end)

function M.onGlassBridgeESPToggle(value)
	M.State.glass_bridge_esp_toggled = value
	GameUtils.updateGlassBridgeESP(value)
end

task.spawn(function()
	while task.wait(1) do
		if M.State.glass_bridge_esp_toggled then
			GameUtils.updateGlassBridgeESP(M.State.glass_bridge_esp_toggled)
		end
	end
end)

function M.onPlayerGuardTPToggle()
	M.State.player_guard_tp_toggled = not M.State.player_guard_tp_toggled
end

function M.onNPCGuardTPToggle()
	M.State.npc_guard_tp_toggled = not M.State.npc_guard_tp_toggled
end

task.spawn(function()
	while task.wait() do
		if M.State.player_guard_tp_toggled then
			local guards = GameUtils.getPlayerGuards()
			local myRoot = Utils.getLocalRoot()

			if myRoot then
				for i, v in pairs(guards) do
					local root = v and v:FindFirstChild("HumanoidRootPart")
					if root and GameUtils.isAlive(root) then
						root.CFrame = myRoot.CFrame * CFrame.new(0, 0, -10)
					end
				end
			end
		end
	end
end)

task.spawn(function()
	while task.wait() do
		if M.State.npc_guard_tp_toggled then
			local guards = GameUtils.getNPCGuards()
			local myRoot = Utils.getLocalRoot()

			if myRoot then
				for i, v in pairs(guards) do
					local root = v and v:FindFirstChild("HumanoidRootPart")
					if root and GameUtils.isAlive(root) then
						root.CFrame = myRoot.CFrame * CFrame.new(0, 0, -10)
					end
				end
			end
		end
	end
end)

return M
