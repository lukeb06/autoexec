local Utils = require("./utils")

Utils.WaitForGameAndPlayer()

local UI = require("./ui")

require("./universal")
require("./games")
local Externals = require("./externals")

require("./emotes")

UI.Library:LoadConfiguration()

if Externals.DexToggle.CurrentValue then
	Externals.dex_injected = true
	task.spawn(function()
		loadstring(game:HttpGet("https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua"))()
	end)
end

if Externals.IYToggle.CurrentValue then
	Externals.iy_injected = true
	task.spawn(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end)
end

if Externals.RSToggle.CurrentValue then
	Externals.rs_injected = true
	task.spawn(function()
		loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))()
	end)
end
