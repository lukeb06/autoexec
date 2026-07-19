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

	PrisonLifeTab:CreateSection("Teleports")

	for i, v in pairs(Funcs.teleports) do
		PrisonLifeTab:CreateButton({
			Name = v.Name,
			Callback = function()
				v:Callback()
			end,
		})
	end
end

return init
