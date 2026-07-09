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

local auto_check_in_toggled = false
function M.toggleAutoCheckIn(value)
	auto_check_in_toggled = value
end

local auto_npc_toggled = false
function M.toggleAutoNPC(value)
	auto_npc_toggled = value
end

local auto_medical_toggled = false
function M.toggleAutoMedical(value)
	auto_medical_toggled = value
end

task.spawn(function()
	local doRun = true
	while task.wait() do
		if (auto_check_in_toggled or auto_npc_toggled or auto_medical_toggled) and doRun then
			local hl = (auto_check_in_toggled and GameUtils.getCheckInHL())
				or (auto_npc_toggled and GameUtils.getNPCHL())
				or (auto_medical_toggled and GameUtils.getMedicalHL())

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
