local Noclipping = nil
local Clip = true

local manual_noclip = false

local M = {}

function M.set_manual(value)
	manual_noclip = value
end

function M.get_manual()
	return manual_noclip
end

function M.enable()
	if manual_noclip then
		return
	end
	local speaker = game:GetService("Players").LocalPlayer
	local RunService = game:GetService("RunService")

	Clip = false
	task.wait(0.1)
	local function NoclipLoop()
		if Clip == false and speaker.Character ~= nil then
			for _, child in pairs(speaker.Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
					local hasCouldCollide = child:FindFirstChild("CouldCollide")
					if not hasCouldCollide then
						local couldCollide = Instance.new("BoolValue")
						couldCollide.Name = "CouldCollide"
						couldCollide.Value = child.CanCollide
						couldCollide.Parent = child
					end
					child.CanCollide = false
				end
				if child:IsA("BasePart") and child.Transparency ~= 1 and child.Transparency ~= 0.5 then
					local trans = Instance.new("NumberValue")
					trans.Name = "Transparency"
					trans.Value = child.Transparency
					trans.Parent = child
					child.Transparency = 0.5
				end
			end
		end
	end
	Noclipping = RunService.Stepped:Connect(NoclipLoop)
end

function M.disable()
	if manual_noclip then
		return
	end
	if Noclipping then
		Noclipping:Disconnect()
		local speaker = game:GetService("Players").LocalPlayer
		for _, child in pairs(speaker.Character:GetDescendants()) do
			if child:IsA("BasePart") then
				local couldCollideValue = child:FindFirstChild("CouldCollide")
				if couldCollideValue then
					child.CanCollide = couldCollideValue.Value
					couldCollideValue:Destroy()
				end

				local trans = child:FindFirstChild("Transparency")
				if trans then
					child.Transparency = trans.Value
					trans:Destroy()
				end
			end
		end
	end
	Clip = true
end

function M.toggleNoclip()
	if Clip then
		M.enable()
	else
		M.disable()
	end
end

return M
