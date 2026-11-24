local GameUtils = require("./utils")

local M = {}

task.spawn(function()
	while task.wait() do
		GameUtils.grabAllDrops()
	end
end)

return M
