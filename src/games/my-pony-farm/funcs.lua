local GameUtils = require("./utils")

local M = {}

task.spawn(function()
	while task.wait() do
		GameUtils.grabAllDrops()
	end
end)

task.spawn(function()
	while task.wait() do
		local mult = GameUtils.getMult()

		if mult > 1.9 then
			GameUtils.touchDepositButton()
		end
	end
end)

task.spawn(function()
	while task.wait() do
		GameUtils.touchCollectButton()
	end
end)

return M
