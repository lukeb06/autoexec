local UI = require("../../ui")

if game.GameId == 10148749921 then
	local Funcs = require("./funcs")

	local AHTab = UI.Window:CreateTab("Animal Hospital", "gamepad-2")

	AHTab:CreateSection("Utils")

	AHTab:CreateToggle({
		Name = "Auto Check-In",
		CurrentValue = false,
		Flag = nil,
		Callback = Funcs.toggleAutoCheckIn,
	})

	AHTab:CreateToggle({
		Name = "Auto NPC",
		CurrentValue = false,
		Flag = nil,
		Callback = Funcs.toggleAutoNPC,
	})

	AHTab:CreateToggle({
		Name = "Auto Medical",
		CurrentValue = false,
		Flag = nil,
		Callback = Funcs.toggleAutoMedical,
	})

	AHTab:CreateSection("Items")

	AHTab:CreateButton({
		Name = "Bandages",
		Callback = Funcs.getBandages,
	})

	AHTab:CreateButton({
		Name = "Cough Syrup",
		Callback = Funcs.getCoughSyrup,
	})

	AHTab:CreateButton({
		Name = "Eye Drops",
		Callback = Funcs.getEyeDrops,
	})

	AHTab:CreateButton({
		Name = "Herbs",
		Callback = Funcs.getHerbs,
	})

	AHTab:CreateButton({
		Name = "IV Drops",
		Callback = Funcs.getIVDrops,
	})

	AHTab:CreateButton({
		Name = "Maple Syrup",
		Callback = Funcs.getMapleSyrup,
	})

	AHTab:CreateButton({
		Name = "Medicine",
		Callback = Funcs.getMedicine,
	})

	AHTab:CreateButton({
		Name = "Medkit",
		Callback = Funcs.getMedkit,
	})

	AHTab:CreateButton({
		Name = "Ointment",
		Callback = Funcs.getOintment,
	})

	AHTab:CreateButton({
		Name = "Thermo",
		Callback = Funcs.getThermo,
	})
end

return true
