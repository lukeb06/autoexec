local GameUtils = require("./utils")

local M = {}

task.spawn(function()
	while task.wait(0.5) do
		GameUtils.grabAllDrops()
	end
end)

return M
