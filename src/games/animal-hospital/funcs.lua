local GameUtils = require("./utils")

local M = {}

function M.getEyeDrops()
	GameUtils.grabItem("Eye Drops")
end

function M.getIVDrops()
	GameUtils.grabItem("IV Drops")
end

function M.getMedkit()
	GameUtils.grabItem("Medkit")
end

function M.getThermo()
	GameUtils.grabItem("Thermo")
end

function M.getOintment()
	GameUtils.grabItem("Ointment")
end

function M.getBandages()
	GameUtils.grabItem("Bandages")
end

function M.getMapleSyrup()
	GameUtils.grabItem("Maple Syrup")
end

function M.getCoughSyrup()
	GameUtils.grabItem("Cough Syrup")
end

function M.getMedicine()
	GameUtils.grabItem("Medicine")
end

function M.getHerbs()
	GameUtils.grabItem("Herbs")
end

local auto_toggled = false
function M.toggleAuto(value)
	auto_toggled = value
end

task.spawn(function()
	local doRun = true
	while task.wait() do
		if auto_toggled and doRun then
			local hl = GameUtils.getCheckInHL() or GameUtils.getNPCHL() or GameUtils.getMedicalHL()

			if hl then
				local pp = GameUtils.getPPFromHL(hl)

				if pp then
					local model = pp.Parent
					local base = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")

					if base then
						doRun = false
						GameUtils.Queue:add(function()
							GameUtils.fireProximityPrompt(pp, base)
						end, function()
							doRun = true
						end)
					end
				end
			end
		end
	end
end)

return M
