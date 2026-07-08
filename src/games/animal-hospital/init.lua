local UI = require("../../ui")

if game.GameId == 10148749921 then
	local Funcs = require("./funcs")

	local AHTab = UI.Window:CreateTab("Animal Hospital", "gamepad-2")

	AHTab:CreateToggle({
		Name = "Auto",
		Callback = Funcs.toggleAuto,
	})

	AHTab:CreateSection("Items")

	-- Eye Drops
	-- IV Drops
	-- Medkit
	-- Thermo
	-- Ointment
	-- Bandages
	-- Maple Syrup
	-- Cough Syrup
	-- Medicine
	-- Herbs

	AHTab:CreateButton({
		Name = "Eye Drops",
		Callback = Funcs.getEyeDrops,
	})

	AHTab:CreateButton({
		Name = "IV Drops",
		Callback = Funcs.getIVDrops,
	})

	AHTab:CreateButton({
		Name = "Medkit",
		Callback = Funcs.getMedkit,
	})

	AHTab:CreateButton({
		Name = "Thermo",
		Callback = Funcs.getThermo,
	})

	AHTab:CreateButton({
		Name = "Ointment",
		Callback = Funcs.getOintment,
	})

	AHTab:CreateButton({
		Name = "Bandages",
		Callback = Funcs.getBandages,
	})

	AHTab:CreateButton({
		Name = "Maple Syrup",
		Callback = Funcs.getMapleSyrup,
	})

	AHTab:CreateButton({
		Name = "Cough Syrup",
		Callback = Funcs.getCoughSyrup,
	})

	AHTab:CreateButton({
		Name = "Medicine",
		Callback = Funcs.getMedicine,
	})

	AHTab:CreateButton({
		Name = "Herbs",
		Callback = Funcs.getHerbs,
	})
end

return true
