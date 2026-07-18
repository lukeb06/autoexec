local function init()
	local UI = require("../../ui")
	local Funcs = require("./funcs")

	local InkGameTab = UI.Window:CreateTab("Ink Game", "gamepad-2")

	InkGameTab:CreateSection("ESP")

	InkGameTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = Funcs.State.player_esp_toggled,
		Flag = nil,
		Callback = Funcs.onPlayerESPToggle,
	})

	InkGameTab:CreateToggle({
		Name = "Guard ESP",
		CurrentValue = Funcs.State.guard_esp_toggled,
		Flag = nil,
		Callback = Funcs.onGuardESPToggle,
	})

	InkGameTab:CreateKeybind({
		Name = "Bring Player Guards",
		CurrentKeybind = "H",
		HoldToInteract = false,
		Flag = "BringPlayerGuards",
		Callback = Funcs.onPlayerGuardTPToggle,
	})

	InkGameTab:CreateKeybind({
		Name = "Bring NPC Guards",
		CurrentKeybind = "J",
		HoldToInteract = false,
		Flag = "BringNPCGuards",
		Callback = Funcs.onNPCGuardTPToggle,
	})

	-- InkGameTab:CreateToggle({
	-- 	Name = "Glass Bridge ESP",
	-- 	CurrentValue = Funcs.State.glass_bridge_esp_toggled,
	-- 	Flag = nil,
	-- 	Callback = Funcs.onGlassBridgeESPToggle,
	-- })

	task.spawn(function()
		loadstring(
			game:HttpGet("https://raw.githubusercontent.com/wefwef34/inkgames.github.io/refs/heads/main/ringta.lua")
		)()
	end)
end

return init
