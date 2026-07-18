local M = {}

M.target = nil
M.locked = false

function M.findTarget()
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local mouse = plr and plr:GetMouse()

	local camera = workspace.CurrentCamera
	local unitRay = camera:ScreenPointToRay(mouse.X, mouse.Y)
	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {
		char,
	}
	params.FilterType = Enum.RaycastFilterType.Exclude
	local result = workspace:Raycast(unitRay.Origin, unitRay.Direction * 500, params)
	if result and result.Instance then
		local model = result.Instance:FindFirstAncestorOfClass("Model")
		if model and model:FindFirstChild("Humanoid") and model ~= char then
			return model
		end
	end
	local closest = nil
	local minDist = math.huge
	for _, p in game:GetService("Players"):GetPlayers() do
		if p ~= plr and p.Character and p.Character:FindFirstChild("Head") then
			local head = p.Character.Head
			local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
			if onScreen then
				local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
				if dist < minDist then
					minDist = dist
					closest = p.Character
				end
			end
		end
	end
	return closest
end

function M.toggleLock()
	M.locked = not M.locked
	if M.locked then
		local targChar = M.findTarget()
		if targChar then
			M.target = targChar:WaitForChild("Head")
		else
			M.locked = false
		end
	else
		M.target = nil
	end
end

game:GetService("RunService").RenderStepped:Connect(function()
	if M.locked and M.target and M.target.Parent then
		local camera = workspace.CurrentCamera
		camera.CFrame = CFrame.new(camera.CFrame.Position, M.target.Position)
	end
end)

return M
