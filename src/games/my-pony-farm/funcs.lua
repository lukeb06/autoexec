local GameUtils = require("./utils")

local M = {}

M.autoBuy100Toggled = false

M.toggleAutoBuy100 = function(value)
	M.autoBuy100Toggled = value
end

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

task.spawn(function()
	while task.wait() do
		if M.autoBuy100Toggled then
			GameUtils.touchAdd100Button()
		end
	end
end)

return M
