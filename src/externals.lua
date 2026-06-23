local UI = require("./ui")

local M = {}

local ExternalsTab = UI.Window:CreateTab("Externals", "telescope")

ExternalsTab:CreateSection("Dex")

M.dex_injected = false
M.iy_injected = false
M.rs_injected = false

local DexButton = ExternalsTab:CreateButton({
	Name = "Inject Dex",
	Callback = function()
		if M.dex_injected then
			return
		end
		M.dex_injected = true
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
	end,
})

M.DexToggle = ExternalsTab:CreateToggle({
	Name = "Load Dex on Startup",
	CurrentValue = false,
	Flag = "LoadDexOnStartup", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value) end,
})

ExternalsTab:CreateSection("Infinite Yield")

local IYButton = ExternalsTab:CreateButton({
	Name = "Inject IY",
	Callback = function()
		if M.iy_injected then
			return
		end
		M.iy_injected = true
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end,
})

M.IYToggle = ExternalsTab:CreateToggle({
	Name = "Load IY on Startup",
	CurrentValue = false,
	Flag = "LoadIYOnStartup", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value) end,
})

ExternalsTab:CreateSection("Cobalt Spy")

local RSButton = ExternalsTab:CreateButton({
	Name = "Inject Cobalt Spy",
	Callback = function()
		if M.rs_injected then
			return
		end
		M.rs_injected = true
		loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))()
	end,
})

M.RSToggle = ExternalsTab:CreateToggle({
	Name = "Load Cobalt on Startup",
	CurrentValue = false,
	Flag = "LoadRSOnStartup", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value) end,
})

return M
