local function init()
	local UI = require("../../ui")
	local GameUtils = require("./utils")

	local GSTab = UI.Window:CreateTab("Granny Shooters", "gamepad-2")

	local auto_kill_toggled = true
	local GSAutoKillToggle = GSTab:CreateToggle({
		Name = "Auto Kill",
		CurrentValue = auto_kill_toggled,
		Flag = nil,
		Callback = function(value)
			auto_kill_toggled = value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if auto_kill_toggled then
				local char = GameUtils.findClosestChar()
				GameUtils.shootChar(char)
			end
		end
	end)

	local auto_reload_toggled = true
	local GSAutoReloadToggle = GSTab:CreateToggle({
		Name = "Auto Reload",
		CurrentValue = auto_reload_toggled,
		Flag = nil,
		Callback = function(value)
			auto_reload_toggled = value
		end,
	})

	task.spawn(function()
		while task.wait() do
			if auto_reload_toggled then
				if GameUtils.getGunAmmo() == 0 then
					GameUtils.reloadGun()
					task.wait(5)
				end
			end
		end
	end)
end

return init
