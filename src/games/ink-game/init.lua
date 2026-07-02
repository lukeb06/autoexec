local UI = require("../../ui")

if game.GameId == 7008097940 then
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

	-- InkGameTab:CreateToggle({
	-- 	Name = "Glass Bridge ESP",
	-- 	CurrentValue = Funcs.State.glass_bridge_esp_toggled,
	-- 	Flag = nil,
	-- 	Callback = Funcs.onGlassBridgeESPToggle,
	-- })
end

return true
