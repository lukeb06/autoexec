local UI = require("./ui")
local Utils = require("./utils")

local EmotesTab = UI.Window:CreateTab("Emotes")

local emotes = {
	{ Name = "Take The L", Id = 93090980853782 },
	{ Name = "UFO", Id = 120449791578755 },
	{ Name = "Fake Dead", Id = 73689381418785 },
	{ Name = "67 Body", Id = 82296043272517 },
	{ Name = "Obby Head", Id = 122814100170962 },
	{ Name = "Floating", Id = 131950236025472 },
	{ Name = "Katseye", Id = 100829635809504 },
	{ Name = "Floating Headless", Id = 98728517497209 },
	{ Name = "Levitate", Id = 111499780397123 },
	{ Name = "67", Id = 88672473602461 },
	{ Name = "Hide", Id = 117450501566142 },
	{ Name = "Biblically Accurate", Id = 133596366979822 },
	{ Name = "Best Mates", Id = 113016438012253 },
	{ Name = "Car", Id = 71229119391920 },
	{ Name = "Dab", Id = 114366486943553 },
	{ Name = "Tank", Id = 109896367267714 },
	{ Name = "Heart", Id = 100501857801770 },
	{ Name = "Plane", Id = 111917372615551 },
	{ Name = "Headless", Id = 74738520664045 },
	{ Name = "NLE", Id = 133293268056643 },
}

local function getTrueId(emote)
	local hum = Utils.getLocalHumanoid()

	local connection = nil
	local capturedId = nil

	connection = hum.AnimationPlayed:Connect(function(playingTrack)
		if playingTrack.Animation and playingTrack.Animation.AnimationId ~= "" then
			capturedId = playingTrack.Animation.AnimationId
			playingTrack:Stop()
		end
	end)

	local description = hum:WaitForChild("HumanoidDescription")
	description:AddEmote(emote.Name, emote.Id)
	hum:PlayEmote(emote.Name)

	local timeout = 0
	while not capturedId and timeout < 2 do
		task.wait(0.1)
		timeout += 0.1
	end

	if connection then
		connection:Disconnect()
	end
	return capturedId
end

local currentTrack = nil

local function stopAnimations()
	if currentTrack then
		currentTrack:Stop()
		currentTrack = nil
	end
end

EmotesTab:CreateButton({
	Name = "Stop Emote",
	Callback = stopAnimations,
})

EmotesTab:CreateSection("Emotes")

for i, v in pairs(emotes) do
	EmotesTab:CreateButton({
		Name = v.Name,
		Callback = function()
			local hum = Utils.getLocalHumanoid()
			local animator = hum:FindFirstChild("Animator")

			stopAnimations()

			local animInst = Instance.new("Animation")
			local id = getTrueId(v)
			if id then
				print(id)
				animInst.AnimationId = id

				currentTrack = animator:LoadAnimation(animInst)
				currentTrack.Looped = true
				currentTrack.Priority = Enum.AnimationPriority.Action4
				currentTrack:Play()
			else
				warn("Failed to add emote")
			end

			-- local Players = game:GetService("Players")
			-- local speaker = Players.LocalPlayer
			-- local character = speaker.Character or speaker.CharacterAdded:Wait()
			-- local humanoid = character:WaitForChild("Humanoid")

			-- local description = humanoid:WaitForChild("HumanoidDescription")

			-- description:AddEmote(v.Name, v.Id)

			-- local track = nil

			-- local success, playedTrack = humanoid:PlayEmote(v.Name)
			-- if success then
			-- 	track = playedTrack
			-- end

			-- humanoid.Died:Connect(function()
			-- 	if track then
			-- 		track:Stop()
			-- 		track = nil
			-- 	else
			-- 		local animator = humanoid:FindFirstChildOfClass("Animator")
			-- 		if animator then
			-- 			for _, playingTrack in ipairs(animator:GetPlayingAnimationTracks()) do
			-- 				if playingTrack.Name == v.Name then
			-- 					playingTrack:Stop()
			-- 				end
			-- 			end
			-- 		end
			-- 	end
			-- end)
		end,
	})
end

return true
