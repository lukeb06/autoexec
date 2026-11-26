local function init()
	local UI = require("../../ui")
	local Funcs = require("./funcs")

	local MPFTab = UI.Window:CreateTab("My Pony Farm", "gamepad-2")

	MPFTab:CreateToggle({
		Name = "Auto Buy 100s",
		CurrentValue = true,
		Flag = nil,
		Callback = Funcs.toggleAutoBuy100,
	})
end

return init
