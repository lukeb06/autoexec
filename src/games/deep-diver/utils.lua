local Utils = require("../../utils")

local M = {}

function M.getBreathBar()
	local plr = Utils.getLocalPlayer()
	local gui = plr and plr:FindFirstChild("PlayerGui")
	local gsg = gui and gui:FindFirstChild("GameScreenGui")
	local hud = gsg and gsg:FindFirstChild("HUD")
	local bcf = hud and hud:FindFirstChild("BottomCenterFrame")
	local breath = bcf and bcf:FindFirstChild("Breath")
	local canvas = breath and breath:FindFirstChild("CanvasGroup")
	local track = canvas and canvas:FindFirstChild("Track")
	local fill = track and track:FindFirstChild("FillMask")
	local bar = fill and fill:FindFirstChild("Bar")

	return bar
end

function M.getBreath()
	local bar = M.getBreathBar()

	if bar then
		return bar.Size.X.Scale
	end

	return 1
end

function M.waitForBreath()
	local breath = M.getBreath()

	while breath < 0.9 do
		task.wait(0.1)
		breath = M.getBreath()
	end
end

function M.breathe()
	local localRoot = Utils.getLocalRoot()
	if localRoot then
		local pos = localRoot.CFrame
		local newPos = CFrame.new(Vector3.new(pos.Position.X, 230, pos.Position.Z))
		localRoot.CFrame = newPos

		M.waitForBreath()

		localRoot.CFrame = pos
	end
end

task.spawn(function()
	while task.wait(1) do
		local breath = M.getBreath()

		if breath < 0.1 then
			M.breathe()
		end
	end
end)

return M
