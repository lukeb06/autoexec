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

	PrisonLifeTab:CreateSection("Utils")

	PrisonLifeTab:CreateButton({
		Name = "Remove Doors",
		Callback = Funcs.removeDoors,
	})

	-- PrisonLifeTab:CreateToggle({
	-- 	Name = "Auto Shoot Criminals",
	-- 	CurrentValue = Funcs.auto_shoot_criminals,
	-- 	Flag = nil,
	-- 	Callback = Funcs.onAutoShootCriminalsToggle,
	-- })

	-- PrisonLifeTab:CreateToggle({
	-- 	Name = "Auto Shoot Guards",
	-- 	CurrentValue = Funcs.auto_shoot_guards,
	-- 	Flag = nil,
	-- 	Callback = Funcs.onAutoShootGuardsToggle,
	-- })

	PrisonLifeTab:CreateSection("Teleports")

	for i, v in pairs(Funcs.teleports) do
		PrisonLifeTab:CreateButton({
			Name = v.Name,
			Callback = function()
				Funcs.teleportTo(v.Position)
			end,
		})
	end
end

return init
