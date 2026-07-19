local function init()
	local UI = require("../../ui")
	local Funcs = require("./funcs")

	local PrisonLifeTab = UI.Window:CreateTab("Prison Life", "gamepad-2")

	PrisonLifeTab:CreateSection("ESP")

	PrisonLifeTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = Funcs.onPlayerESPToggle,
	})
end

return init
