local Noclip = require("./noclip")

local M = {}

function M.WaitForGameAndPlayer()
	local gameLoaded = false
	local playerLoaded = false

	while not (gameLoaded and playerLoaded) do
		if game:IsLoaded() then
			gameLoaded = true
		end

		if game:GetService("Players").LocalPlayer then
			playerLoaded = true
		end

		task.wait()
	end
end

function M.diff3d(origin, target)
	return target - origin
end

function M.dist3d(pos1, pos2)
	return M.diff3d(pos1, pos2).Magnitude
end

function M.dir3d(origin, target)
	return M.diff3d(origin, target).Unit
end

function M.isDev()
	local prefix = "pathwise"

	local plr = game:GetService("Players").LocalPlayer

	if string.sub(plr.Name, 1, #prefix) == prefix then
		return true
	end

	return false
end

function M.isKBM()
	local UIS = game:GetService("UserInputService")
	return UIS.KeyboardEnabled and UIS.MouseEnabled
end

M.Noclip = Noclip

function M.breakVelocity(t)
	task.spawn(function()
		local speaker = game:GetService("Players").LocalPlayer
		local BeenASecond, V3 = false, Vector3.new(0, 0, 0)
		task.spawn(function()
			task.wait(t)
			BeenASecond = true
		end)
		while not BeenASecond do
			for _, v in ipairs(speaker.Character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.Velocity, v.RotVelocity = V3, V3
				end
			end
			task.wait()
		end
	end)
end

local safeTweenSpeed = 20
local safeTweening = false

function M.get_safeTweening()
	return safeTweening
end

function M.set_safeTweening(value)
	safeTweening = value
end

function M.safeTweenToPos(cframe)
	local TweenService = game:GetService("TweenService")

	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")

	local dist = M.dist3d(root.Position, cframe.Position)
	local t = dist / safeTweenSpeed

	safeTweening = true
	if hum and hum.SeatPart then
		hum.Sit = false
		task.wait(0.1)
	end
	task.wait(0.1)
	TweenService:Create(root, TweenInfo.new(t, Enum.EasingStyle.Linear), { CFrame = cframe }):Play()

	task.delay(t, function()
		safeTweening = false
	end)
	M.breakVelocity(t)
end

function M.safeTweenToPart(part)
	if part:IsA("BasePart") then
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local hum = char and char:FindFirstChildWhichIsA("Humanoid")

		local dist = M.dist3d(root.Position, part.Position)
		local t = dist / safeTweenSpeed

		safeTweening = true
		if hum and hum.SeatPart then
			hum.Sit = false
			task.wait(0.1)
		end
		task.wait(0.1)
		local conn = nil
		safeTweening = true
		M.Noclip.enable()
		game.Workspace.Gravity = 0
		conn = game:GetService("RunService").Heartbeat:Connect(function(dt)
			if not root or not part or not part.Parent then
				conn:Disconnect()
				safeTweening = false
				M.Noclip.disable()
				game.Workspace.Gravity = 196.21
				if hum then
					hum:ChangeState(Enum.HumanoidStateType.GettingUp)
				end
				return
			end

			local currentPos = root.Position
			local targetPos = part.Position
			local distance = M.dist3d(currentPos, targetPos)

			local moveStep = safeTweenSpeed * dt

			if distance <= moveStep then
				root.CFrame = part.CFrame
				conn:Disconnect()
				safeTweening = false
				M.Noclip.disable()
				if hum then
					hum:ChangeState(Enum.HumanoidStateType.GettingUp)
				end
				game.Workspace.Gravity = 196.21
			else
				local direction = M.dir3d(currentPos, targetPos)
				local newPosition = currentPos + (direction * moveStep)

				if hum then
					hum:ChangeState(Enum.HumanoidStateType.Physics)
				end

				root.CFrame = CFrame.new(newPosition) * (part.CFrame - part.CFrame.Position)
			end
		end)
		M.breakVelocity(t)
	end
end

function M.flingCharacter(pChar)
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")

	if root and pRoot then
		M.Noclip.enable()

		task.wait(0.2)

		local pos = root.CFrame

		task.wait(0.1)

		for _, child in pairs(char:GetDescendants()) do
			if child:IsA("BasePart") then
				child.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
			end
		end

		for i, v in char:GetChildren() do
			if v:IsA("BasePart") then
				v.CanCollide = false
				v.Massless = true
				v.Velocity = Vector3.new(0, 0, 0)
			end
		end

		local power = 99999
		local spin = power

		local flingloop
		flingloop = game:GetService("RunService").Heartbeat:Connect(function(dt)
			if not pRoot or not pRoot.Parent then
				return
			end

			local jitter = math.random(-100, 100)

			local tVel = pRoot.AssemblyLinearVelocity

			if tVel.Magnitude > 500 then
				flingloop:Disconnect()
			end

			local tPos = pRoot.Position + (tVel * 0.08)

			if tPos.Y <= game.Workspace.FallenPartsDestroyHeight + 50 then
				return
			end

			root.CFrame = (CFrame.new(tPos + Vector3.new(0.1, 0, 0.1))) * (root.CFrame - root.CFrame.Position)

			root.AssemblyLinearVelocity = Vector3.new(power + jitter, -100, power + jitter)
			root.AssemblyAngularVelocity = Vector3.new(0, spin, 0)
		end)

		task.spawn(function()
			while flingloop.Connected do
				spin = power
				task.wait(0.2)
				spin = 0
				task.wait(0.1)
			end
		end)

		-- local att1 = Instance.new("Attachment", root)
		-- local att2 = Instance.new("Attachment", pRoot)

		-- local ap = Instance.new("AlignPosition", root)
		-- ap.Attachment0 = att1
		-- ap.Attachment1 = att2
		-- -- ap.RigidityEnabled = true
		-- ap.ReactionForceEnabled = false -- DON'T pull back on the player
		-- ap.RigidityEnabled = false -- Use force instead of instant snapping
		-- ap.MaxForce = 1e6 -- High enough to follow, but not infinite
		-- ap.Responsiveness = 200

		task.delay(3, function()
			-- ap:Destroy()
			-- att1:Destroy()
			-- att2:Destroy()

			for _, child in pairs(char:GetDescendants()) do
				if child.ClassName == "Part" or child.ClassName == "MeshPart" then
					child.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
				end
			end

			M.Noclip.disable()
			flingloop:Disconnect()
			M.breakVelocity(0.2)
			task.wait(0.1)
			root.CFrame = pos
		end)
	end
end

function M.flingPlayer(plr)
	local char = plr and plr.Character
	M.flingCharacter(char)
end

function M.isFriendsWith(plr)
	local player = game:GetService("Players").LocalPlayer
	return player:IsFriendsWith(plr.UserId)
end

function M.updateESP(obj, color, enabled)
	local oldHl = obj:FindFirstChild("ESPHL")
	if oldHl then
		if not enabled then
			oldHl:Destroy()
		elseif color ~= oldHl.FillColor then
			oldHl.FillColor = color
			oldHl.OutlineColor = color
		end
	elseif enabled then
		local hl = Instance.new("Highlight")
		hl.Name = "ESPHL"
		hl.Adornee = obj
		hl.FillColor = color
		hl.OutlineColor = color
		hl.Parent = obj
	end
end

M.esp_players = {}
M.esp_show_names = false

function M.updatePlayerESP(plr, color, enabled, friendColor)
	local char = plr and plr.Character

	local col = (M.isFriendsWith(plr) and (friendColor or color)) or color

	M.esp_players[plr] = { enabled = enabled, color = col }

	if char then
		M.updateESP(char, col, enabled)
	end
end

task.spawn(function()
	local GlobalESPHolder = Instance.new("Folder", game.CoreGui)
	while task.wait() do
		if M.esp_show_names then
			if not GlobalESPHolder or not GlobalESPHolder.Parent then
				GlobalESPHolder = Instance.new("Folder", game.CoreGui)
			end

			for plr, data in pairs(M.esp_players) do
				local enabled = data.enabled
				local color = data.color
				local esp = GlobalESPHolder:FindFirstChild(plr.Name .. "_ESP")

				local function getHealth()
					local char = plr and plr.Character
					local hum = char and char:FindFirstChildWhichIsA("Humanoid")

					if hum then
						local health = hum.Health / hum.MaxHealth

						local percent = math.floor(health * 100)

						local col = Color3.fromHSV(health * (100 / 360), 0.8, 0.8)

						return { health = percent, color = col }
					else
						return { health = 0, color = Color3.fromRGB(0, 0, 0) }
					end
				end

				if enabled then
					local char = plr and plr.Character
					local head = char and char:FindFirstChild("Head")

					if not esp then
						if head then
							local ESPholder = Instance.new("Folder", GlobalESPHolder)
							ESPholder.Name = plr.Name .. "_ESP"

							local bb = Instance.new("BillboardGui", ESPholder)
							local label = Instance.new("TextLabel", bb)
							local hLabel = Instance.new("TextLabel", bb)

							bb.Adornee = head
							bb.Size = UDim2.new(0, 100, 0, 40)
							bb.StudsOffset = Vector3.new(0, 2, 0)
							bb.AlwaysOnTop = true

							label.Name = "NameLabel"
							label.BackgroundTransparency = 1
							label.Position = UDim2.new(0, 0, 0, 0)
							label.Size = UDim2.new(0, 100, 0, 20)
							label.Font = Enum.Font.SourceSansSemibold
							label.TextSize = 20
							label.TextColor3 = color
							label.TextStrokeTransparency = 0
							label.TextStrokeColor3 = Color3.new(0, 0, 0)
							label.TextYAlignment = Enum.TextYAlignment.Bottom
							label.Text = plr.Name
							label.ZIndex = 10

							hLabel.Name = "HealthLabel"
							hLabel.BackgroundTransparency = 1
							hLabel.Position = UDim2.new(0, 0, 0, 20)
							hLabel.Size = UDim2.new(0, 100, 0, 20)
							hLabel.Font = Enum.Font.SourceSansSemibold
							hLabel.TextSize = 20
							hLabel.TextColor3 = color
							hLabel.TextStrokeTransparency = 0
							hLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
							hLabel.TextYAlignment = Enum.TextYAlignment.Bottom
							hLabel.Text = ""
							hLabel.ZIndex = 10
						end
					else
						local bb = esp:FindFirstChild("BillboardGui")

						if bb and head then
							bb.Adornee = head

							local label = bb:FindFirstChild("NameLabel")

							if label then
								label.TextColor3 = color
							end

							local hLabel = bb:FindFirstChild("HealthLabel")

							if hLabel then
								local h = getHealth()
								local hp = h.health
								local hc = h.color

								hLabel.Text = hp .. "%"
								hLabel.TextColor3 = hc
							end
						end
					end
				else
					if esp then
						esp:Destroy()
					end
				end
			end
		else
			GlobalESPHolder:Destroy()
		end
	end
end)

function M.getLocalPlayer()
	return game:GetService("Players").LocalPlayer
end

function M.getLocalChar()
	local plr = M.getLocalPlayer()
	return plr and plr.Character
end

function M.getLocalRoot()
	local char = M.getLocalChar()
	return char and char:FindFirstChild("HumanoidRootPart")
end

function M.getLocalHumanoid()
	local root = M.getLocalChar()
	return root and root:FindFirstChildWhichIsA("Humanoid")
end

return M
