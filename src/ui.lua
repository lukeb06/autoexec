local function InitUI()
	local Library = {}

	local CFileName = nil
	local EZUIFOLDER = "EZUI"
	local ConfigurationFolder = EZUIFOLDER .. "/Configurations"
	local ConfigurationExtension = ".ez"

	local function callSafely(func, ...)
		if func then
			local success, result = pcall(func, ...)
			if not success then
				warn("Function failed with error: ", result)
				return false
			else
				return result
			end
		end
	end

	local function ensureFolder(folderPath)
		if isfolder and not callSafely(isfolder, folderPath) then
			callSafely(makefolder, folderPath)
		end
	end

	local function SaveConfig()
		print("Saving Config")
		local data = {}
		for i, v in pairs(Library.Flags) do
			print(v)
			if typeof(v) == "boolean" then
				if v == false then
					data[i] = false
				else
					data[i] = v
				end
			else
				data[i] = v
			end
		end

		callSafely(
			writefile,
			ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension,
			tostring(game:GetService("HttpService"):JSONEncode(data))
		)
	end

	local function LoadConfig()
		callSafely(function()
			if isfile then
				if callSafely(isfile, ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension) then
					local config =
						callSafely(readfile, ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension)

					if config then
						local success, data = pcall(function()
							return game:GetService("HttpService"):JSONDecode(config)
						end)

						if success then
							for FlagName, Flag in pairs(data) do
								Library.Flags[FlagName] = Flag
							end
						end
					end
				end
			end
		end)
	end

	Library = {
		Flags = {},
		Theme = {
			Default = {
				TextColor = Color3.fromRGB(240, 240, 240),

				Background = Color3.fromRGB(25, 25, 25),
				Topbar = Color3.fromRGB(34, 34, 34),
				Shadow = Color3.fromRGB(20, 20, 20),

				NotificationBackground = Color3.fromRGB(20, 20, 20),
				NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

				TabBackground = Color3.fromRGB(80, 80, 80),
				TabStroke = Color3.fromRGB(85, 85, 85),
				TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
				TabTextColor = Color3.fromRGB(240, 240, 240),
				SelectedTabTextColor = Color3.fromRGB(50, 50, 50),

				ElementBackground = Color3.fromRGB(35, 35, 35),
				ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
				SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
				ElementStroke = Color3.fromRGB(50, 50, 50),
				SecondaryElementStroke = Color3.fromRGB(40, 40, 40),

				SliderBackground = Color3.fromRGB(50, 138, 220),
				SliderProgress = Color3.fromRGB(50, 138, 220),
				SliderStroke = Color3.fromRGB(58, 163, 255),

				ToggleBackground = Color3.fromRGB(30, 30, 30),
				ToggleEnabled = Color3.fromRGB(0, 146, 214),
				ToggleDisabled = Color3.fromRGB(100, 100, 100),
				ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
				ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
				ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
				ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),

				DropdownSelected = Color3.fromRGB(40, 40, 40),
				DropdownUnselected = Color3.fromRGB(30, 30, 30),

				InputBackground = Color3.fromRGB(30, 30, 30),
				InputStroke = Color3.fromRGB(65, 65, 65),
				PlaceholderColor = Color3.fromRGB(178, 178, 178),
			},

			Ocean = {
				TextColor = Color3.fromRGB(230, 240, 240),

				Background = Color3.fromRGB(20, 30, 30),
				Topbar = Color3.fromRGB(25, 40, 40),
				Shadow = Color3.fromRGB(15, 20, 20),

				NotificationBackground = Color3.fromRGB(25, 35, 35),
				NotificationActionsBackground = Color3.fromRGB(230, 240, 240),

				TabBackground = Color3.fromRGB(40, 60, 60),
				TabStroke = Color3.fromRGB(50, 70, 70),
				TabBackgroundSelected = Color3.fromRGB(100, 180, 180),
				TabTextColor = Color3.fromRGB(210, 230, 230),
				SelectedTabTextColor = Color3.fromRGB(20, 50, 50),

				ElementBackground = Color3.fromRGB(30, 50, 50),
				ElementBackgroundHover = Color3.fromRGB(40, 60, 60),
				SecondaryElementBackground = Color3.fromRGB(30, 45, 45),
				ElementStroke = Color3.fromRGB(45, 70, 70),
				SecondaryElementStroke = Color3.fromRGB(40, 65, 65),

				SliderBackground = Color3.fromRGB(0, 110, 110),
				SliderProgress = Color3.fromRGB(0, 140, 140),
				SliderStroke = Color3.fromRGB(0, 160, 160),

				ToggleBackground = Color3.fromRGB(30, 50, 50),
				ToggleEnabled = Color3.fromRGB(0, 130, 130),
				ToggleDisabled = Color3.fromRGB(70, 90, 90),
				ToggleEnabledStroke = Color3.fromRGB(0, 160, 160),
				ToggleDisabledStroke = Color3.fromRGB(85, 105, 105),
				ToggleEnabledOuterStroke = Color3.fromRGB(50, 100, 100),
				ToggleDisabledOuterStroke = Color3.fromRGB(45, 65, 65),

				DropdownSelected = Color3.fromRGB(30, 60, 60),
				DropdownUnselected = Color3.fromRGB(25, 40, 40),

				InputBackground = Color3.fromRGB(30, 50, 50),
				InputStroke = Color3.fromRGB(50, 70, 70),
				PlaceholderColor = Color3.fromRGB(140, 160, 160),
			},

			AmberGlow = {
				TextColor = Color3.fromRGB(255, 245, 230),

				Background = Color3.fromRGB(45, 30, 20),
				Topbar = Color3.fromRGB(55, 40, 25),
				Shadow = Color3.fromRGB(35, 25, 15),

				NotificationBackground = Color3.fromRGB(50, 35, 25),
				NotificationActionsBackground = Color3.fromRGB(245, 230, 215),

				TabBackground = Color3.fromRGB(75, 50, 35),
				TabStroke = Color3.fromRGB(90, 60, 45),
				TabBackgroundSelected = Color3.fromRGB(230, 180, 100),
				TabTextColor = Color3.fromRGB(250, 220, 200),
				SelectedTabTextColor = Color3.fromRGB(50, 30, 10),

				ElementBackground = Color3.fromRGB(60, 45, 35),
				ElementBackgroundHover = Color3.fromRGB(70, 50, 40),
				SecondaryElementBackground = Color3.fromRGB(55, 40, 30),
				ElementStroke = Color3.fromRGB(85, 60, 45),
				SecondaryElementStroke = Color3.fromRGB(75, 50, 35),

				SliderBackground = Color3.fromRGB(220, 130, 60),
				SliderProgress = Color3.fromRGB(250, 150, 75),
				SliderStroke = Color3.fromRGB(255, 170, 85),

				ToggleBackground = Color3.fromRGB(55, 40, 30),
				ToggleEnabled = Color3.fromRGB(240, 130, 30),
				ToggleDisabled = Color3.fromRGB(90, 70, 60),
				ToggleEnabledStroke = Color3.fromRGB(255, 160, 50),
				ToggleDisabledStroke = Color3.fromRGB(110, 85, 75),
				ToggleEnabledOuterStroke = Color3.fromRGB(200, 100, 50),
				ToggleDisabledOuterStroke = Color3.fromRGB(75, 60, 55),

				DropdownSelected = Color3.fromRGB(70, 50, 40),
				DropdownUnselected = Color3.fromRGB(55, 40, 30),

				InputBackground = Color3.fromRGB(60, 45, 35),
				InputStroke = Color3.fromRGB(90, 65, 50),
				PlaceholderColor = Color3.fromRGB(190, 150, 130),
			},

			Light = {
				TextColor = Color3.fromRGB(40, 40, 40),

				Background = Color3.fromRGB(245, 245, 245),
				Topbar = Color3.fromRGB(230, 230, 230),
				Shadow = Color3.fromRGB(200, 200, 200),

				NotificationBackground = Color3.fromRGB(250, 250, 250),
				NotificationActionsBackground = Color3.fromRGB(240, 240, 240),

				TabBackground = Color3.fromRGB(235, 235, 235),
				TabStroke = Color3.fromRGB(215, 215, 215),
				TabBackgroundSelected = Color3.fromRGB(255, 255, 255),
				TabTextColor = Color3.fromRGB(80, 80, 80),
				SelectedTabTextColor = Color3.fromRGB(0, 0, 0),

				ElementBackground = Color3.fromRGB(240, 240, 240),
				ElementBackgroundHover = Color3.fromRGB(225, 225, 225),
				SecondaryElementBackground = Color3.fromRGB(235, 235, 235),
				ElementStroke = Color3.fromRGB(210, 210, 210),
				SecondaryElementStroke = Color3.fromRGB(210, 210, 210),

				SliderBackground = Color3.fromRGB(150, 180, 220),
				SliderProgress = Color3.fromRGB(100, 150, 200),
				SliderStroke = Color3.fromRGB(120, 170, 220),

				ToggleBackground = Color3.fromRGB(220, 220, 220),
				ToggleEnabled = Color3.fromRGB(0, 146, 214),
				ToggleDisabled = Color3.fromRGB(150, 150, 150),
				ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
				ToggleDisabledStroke = Color3.fromRGB(170, 170, 170),
				ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
				ToggleDisabledOuterStroke = Color3.fromRGB(180, 180, 180),

				DropdownSelected = Color3.fromRGB(230, 230, 230),
				DropdownUnselected = Color3.fromRGB(220, 220, 220),

				InputBackground = Color3.fromRGB(240, 240, 240),
				InputStroke = Color3.fromRGB(180, 180, 180),
				PlaceholderColor = Color3.fromRGB(140, 140, 140),
			},

			Amethyst = {
				TextColor = Color3.fromRGB(240, 240, 240),

				Background = Color3.fromRGB(30, 20, 40),
				Topbar = Color3.fromRGB(40, 25, 50),
				Shadow = Color3.fromRGB(20, 15, 30),

				NotificationBackground = Color3.fromRGB(35, 20, 40),
				NotificationActionsBackground = Color3.fromRGB(240, 240, 250),

				TabBackground = Color3.fromRGB(60, 40, 80),
				TabStroke = Color3.fromRGB(70, 45, 90),
				TabBackgroundSelected = Color3.fromRGB(180, 140, 200),
				TabTextColor = Color3.fromRGB(230, 230, 240),
				SelectedTabTextColor = Color3.fromRGB(50, 20, 50),

				ElementBackground = Color3.fromRGB(45, 30, 60),
				ElementBackgroundHover = Color3.fromRGB(50, 35, 70),
				SecondaryElementBackground = Color3.fromRGB(40, 30, 55),
				ElementStroke = Color3.fromRGB(70, 50, 85),
				SecondaryElementStroke = Color3.fromRGB(65, 45, 80),

				SliderBackground = Color3.fromRGB(100, 60, 150),
				SliderProgress = Color3.fromRGB(130, 80, 180),
				SliderStroke = Color3.fromRGB(150, 100, 200),

				ToggleBackground = Color3.fromRGB(45, 30, 55),
				ToggleEnabled = Color3.fromRGB(120, 60, 150),
				ToggleDisabled = Color3.fromRGB(94, 47, 117),
				ToggleEnabledStroke = Color3.fromRGB(140, 80, 170),
				ToggleDisabledStroke = Color3.fromRGB(124, 71, 150),
				ToggleEnabledOuterStroke = Color3.fromRGB(90, 40, 120),
				ToggleDisabledOuterStroke = Color3.fromRGB(80, 50, 110),

				DropdownSelected = Color3.fromRGB(50, 35, 70),
				DropdownUnselected = Color3.fromRGB(35, 25, 50),

				InputBackground = Color3.fromRGB(45, 30, 60),
				InputStroke = Color3.fromRGB(80, 50, 110),
				PlaceholderColor = Color3.fromRGB(178, 150, 200),
			},

			Green = {
				TextColor = Color3.fromRGB(30, 60, 30),

				Background = Color3.fromRGB(235, 245, 235),
				Topbar = Color3.fromRGB(210, 230, 210),
				Shadow = Color3.fromRGB(200, 220, 200),

				NotificationBackground = Color3.fromRGB(240, 250, 240),
				NotificationActionsBackground = Color3.fromRGB(220, 235, 220),

				TabBackground = Color3.fromRGB(215, 235, 215),
				TabStroke = Color3.fromRGB(190, 210, 190),
				TabBackgroundSelected = Color3.fromRGB(245, 255, 245),
				TabTextColor = Color3.fromRGB(50, 80, 50),
				SelectedTabTextColor = Color3.fromRGB(20, 60, 20),

				ElementBackground = Color3.fromRGB(225, 240, 225),
				ElementBackgroundHover = Color3.fromRGB(210, 225, 210),
				SecondaryElementBackground = Color3.fromRGB(235, 245, 235),
				ElementStroke = Color3.fromRGB(180, 200, 180),
				SecondaryElementStroke = Color3.fromRGB(180, 200, 180),

				SliderBackground = Color3.fromRGB(90, 160, 90),
				SliderProgress = Color3.fromRGB(70, 130, 70),
				SliderStroke = Color3.fromRGB(100, 180, 100),

				ToggleBackground = Color3.fromRGB(215, 235, 215),
				ToggleEnabled = Color3.fromRGB(60, 130, 60),
				ToggleDisabled = Color3.fromRGB(150, 175, 150),
				ToggleEnabledStroke = Color3.fromRGB(80, 150, 80),
				ToggleDisabledStroke = Color3.fromRGB(130, 150, 130),
				ToggleEnabledOuterStroke = Color3.fromRGB(100, 160, 100),
				ToggleDisabledOuterStroke = Color3.fromRGB(160, 180, 160),

				DropdownSelected = Color3.fromRGB(225, 240, 225),
				DropdownUnselected = Color3.fromRGB(210, 225, 210),

				InputBackground = Color3.fromRGB(235, 245, 235),
				InputStroke = Color3.fromRGB(180, 200, 180),
				PlaceholderColor = Color3.fromRGB(120, 140, 120),
			},

			Bloom = {
				TextColor = Color3.fromRGB(60, 40, 50),

				Background = Color3.fromRGB(255, 240, 245),
				Topbar = Color3.fromRGB(250, 220, 225),
				Shadow = Color3.fromRGB(230, 190, 195),

				NotificationBackground = Color3.fromRGB(255, 235, 240),
				NotificationActionsBackground = Color3.fromRGB(245, 215, 225),

				TabBackground = Color3.fromRGB(240, 210, 220),
				TabStroke = Color3.fromRGB(230, 200, 210),
				TabBackgroundSelected = Color3.fromRGB(255, 225, 235),
				TabTextColor = Color3.fromRGB(80, 40, 60),
				SelectedTabTextColor = Color3.fromRGB(50, 30, 50),

				ElementBackground = Color3.fromRGB(255, 235, 240),
				ElementBackgroundHover = Color3.fromRGB(245, 220, 230),
				SecondaryElementBackground = Color3.fromRGB(255, 235, 240),
				ElementStroke = Color3.fromRGB(230, 200, 210),
				SecondaryElementStroke = Color3.fromRGB(230, 200, 210),

				SliderBackground = Color3.fromRGB(240, 130, 160),
				SliderProgress = Color3.fromRGB(250, 160, 180),
				SliderStroke = Color3.fromRGB(255, 180, 200),

				ToggleBackground = Color3.fromRGB(240, 210, 220),
				ToggleEnabled = Color3.fromRGB(255, 140, 170),
				ToggleDisabled = Color3.fromRGB(200, 180, 185),
				ToggleEnabledStroke = Color3.fromRGB(250, 160, 190),
				ToggleDisabledStroke = Color3.fromRGB(210, 180, 190),
				ToggleEnabledOuterStroke = Color3.fromRGB(220, 160, 180),
				ToggleDisabledOuterStroke = Color3.fromRGB(190, 170, 180),

				DropdownSelected = Color3.fromRGB(250, 220, 225),
				DropdownUnselected = Color3.fromRGB(240, 210, 220),

				InputBackground = Color3.fromRGB(255, 235, 240),
				InputStroke = Color3.fromRGB(220, 190, 200),
				PlaceholderColor = Color3.fromRGB(170, 130, 140),
			},

			DarkBlue = {
				TextColor = Color3.fromRGB(230, 230, 230),

				Background = Color3.fromRGB(20, 25, 30),
				Topbar = Color3.fromRGB(30, 35, 40),
				Shadow = Color3.fromRGB(15, 20, 25),

				NotificationBackground = Color3.fromRGB(25, 30, 35),
				NotificationActionsBackground = Color3.fromRGB(45, 50, 55),

				TabBackground = Color3.fromRGB(35, 40, 45),
				TabStroke = Color3.fromRGB(45, 50, 60),
				TabBackgroundSelected = Color3.fromRGB(40, 70, 100),
				TabTextColor = Color3.fromRGB(200, 200, 200),
				SelectedTabTextColor = Color3.fromRGB(255, 255, 255),

				ElementBackground = Color3.fromRGB(30, 35, 40),
				ElementBackgroundHover = Color3.fromRGB(40, 45, 50),
				SecondaryElementBackground = Color3.fromRGB(35, 40, 45),
				ElementStroke = Color3.fromRGB(45, 50, 60),
				SecondaryElementStroke = Color3.fromRGB(40, 45, 55),

				SliderBackground = Color3.fromRGB(0, 90, 180),
				SliderProgress = Color3.fromRGB(0, 120, 210),
				SliderStroke = Color3.fromRGB(0, 150, 240),

				ToggleBackground = Color3.fromRGB(35, 40, 45),
				ToggleEnabled = Color3.fromRGB(0, 120, 210),
				ToggleDisabled = Color3.fromRGB(70, 70, 80),
				ToggleEnabledStroke = Color3.fromRGB(0, 150, 240),
				ToggleDisabledStroke = Color3.fromRGB(75, 75, 85),
				ToggleEnabledOuterStroke = Color3.fromRGB(20, 100, 180),
				ToggleDisabledOuterStroke = Color3.fromRGB(55, 55, 65),

				DropdownSelected = Color3.fromRGB(30, 70, 90),
				DropdownUnselected = Color3.fromRGB(25, 30, 35),

				InputBackground = Color3.fromRGB(25, 30, 35),
				InputStroke = Color3.fromRGB(45, 50, 60),
				PlaceholderColor = Color3.fromRGB(150, 150, 160),
			},

			Serenity = {
				TextColor = Color3.fromRGB(50, 55, 60),
				Background = Color3.fromRGB(240, 245, 250),
				Topbar = Color3.fromRGB(215, 225, 235),
				Shadow = Color3.fromRGB(200, 210, 220),

				NotificationBackground = Color3.fromRGB(210, 220, 230),
				NotificationActionsBackground = Color3.fromRGB(225, 230, 240),

				TabBackground = Color3.fromRGB(200, 210, 220),
				TabStroke = Color3.fromRGB(180, 190, 200),
				TabBackgroundSelected = Color3.fromRGB(175, 185, 200),
				TabTextColor = Color3.fromRGB(50, 55, 60),
				SelectedTabTextColor = Color3.fromRGB(30, 35, 40),

				ElementBackground = Color3.fromRGB(210, 220, 230),
				ElementBackgroundHover = Color3.fromRGB(220, 230, 240),
				SecondaryElementBackground = Color3.fromRGB(200, 210, 220),
				ElementStroke = Color3.fromRGB(190, 200, 210),
				SecondaryElementStroke = Color3.fromRGB(180, 190, 200),

				SliderBackground = Color3.fromRGB(200, 220, 235), -- Lighter shade
				SliderProgress = Color3.fromRGB(70, 130, 180),
				SliderStroke = Color3.fromRGB(150, 180, 220),

				ToggleBackground = Color3.fromRGB(210, 220, 230),
				ToggleEnabled = Color3.fromRGB(70, 160, 210),
				ToggleDisabled = Color3.fromRGB(180, 180, 180),
				ToggleEnabledStroke = Color3.fromRGB(60, 150, 200),
				ToggleDisabledStroke = Color3.fromRGB(140, 140, 140),
				ToggleEnabledOuterStroke = Color3.fromRGB(100, 120, 140),
				ToggleDisabledOuterStroke = Color3.fromRGB(120, 120, 130),

				DropdownSelected = Color3.fromRGB(220, 230, 240),
				DropdownUnselected = Color3.fromRGB(200, 210, 220),

				InputBackground = Color3.fromRGB(220, 230, 240),
				InputStroke = Color3.fromRGB(180, 190, 200),
				PlaceholderColor = Color3.fromRGB(150, 150, 150),
			},
		},
		UI = nil,
		Window = nil,
		CurrentTheme = "Default",
		GetTheme = function(self)
			return self.Theme[self.CurrentTheme]
		end,
		Tabs = {},

		CreateUI = function(self)
			if self.UI then
				return self.UI
			end

			local ui = Instance.new("ScreenGui", game.CoreGui)
			ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

			self.UI = ui
			return ui
		end,
		CreateWindow = function(self, settings)
			local ui = self:CreateUI()

			if self.Window then
				return self.Window
			end

			local window = {}
			window.UI = ui
			window.Settings = settings
			if settings.Theme then
				self.CurrentTheme = settings.Theme
			end

			callSafely(function()
				if not settings.ConfigurationSaving.FileName then
					settings.ConfigurationSaving.FileName = tostring(game.PlaceId)
				end

				if settings.ConfigurationSaving.Enabled == nil then
					settings.ConfigurationSaving.Enabled = false
				end

				CFileName = settings.ConfigurationSaving.FileName
				ConfigurationFolder = settings.ConfigurationSaving.FolderName or ConfigurationFolder

				if settings.ConfigurationSaving.Enabled then
					ensureFolder(ConfigurationFolder)
				end
			end)

			LoadConfig()

			local theme = self:GetTheme()
			local frame = Instance.new("Frame", ui)
			frame.BorderSizePixel = 0
			frame.BackgroundColor3 = theme.Background
			frame.ClipsDescendants = true
			frame.Size = UDim2.new(0, 682, 0, 433)
			frame.Position = UDim2.new(0.5, -682 / 2, 0.5, -433 / 2)

			game:GetService("UserInputService").InputBegan:Connect(function(input, proc)
				if input.KeyCode == Enum.KeyCode[settings.ToggleUIKeybind] and not proc then
					if frame.Parent == nil then
						frame.Parent = ui
					else
						frame.Parent = nil
					end
				end
			end)

			local corner = Instance.new("UICorner", frame)
			corner.CornerRadius = UDim.new(0, 16)

			local tbc = Instance.new("Frame", frame)
			tbc.BorderSizePixel = 0
			tbc.ClipsDescendants = true
			tbc.Size = UDim2.new(0, 682, 0, 35)
			tbc.BackgroundTransparency = 1

			local tb = Instance.new("Frame", tbc)
			tb.BorderSizePixel = 0
			tb.BackgroundColor3 = theme.Topbar
			tb.Size = UDim2.new(0, 682, 0, 50)

			local corner2 = Instance.new("UICorner", tb)
			corner2.CornerRadius = UDim.new(0, 16)

			local tbi = Instance.new("Frame", tb)
			tbi.BorderSizePixel = 0
			tbi.Size = UDim2.new(0, 682, 0, 35)
			tbi.BackgroundTransparency = 1

			if settings.Name then
				local title = Instance.new("TextLabel", tbi)
				title.BorderSizePixel = 0
				title.TextSize = 20
				title.TextXAlignment = Enum.TextXAlignment.Left
				title.FontFace = Font.new(
					"rbxasset://fonts/families/SourceSansPro.json",
					Enum.FontWeight.Regular,
					Enum.FontStyle.Normal
				)
				title.TextColor3 = theme.TextColor
				title.BackgroundTransparency = 1
				title.Size = UDim2.new(0, 634, 0, 35)
				title.Text = settings.Name
				title.Position = UDim2.new(0.01884, 0, 0, 0)
			end

			local close = Instance.new("TextButton", tbi)
			close.BorderSizePixel = 0
			close.TextSize = 14
			close.TextScaled = true
			close.TextColor3 = theme.TextColor
			close.FontFace =
				Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			close.BackgroundTransparency = 1
			close.Size = UDim2.new(0, 35, 0, 35)
			close.Text = "×"
			close.Position = UDim2.new(0.94868, 0, 0, 0)

			local show = Instance.new("Frame")
			show.BorderSizePixel = 0
			show.Size = UDim2.new(1, 0, 0, 0)
			show.Position = UDim2.new(0, 0, 0, 30)
			show.BackgroundTransparency = 1

			local show_list = Instance.new("UIListLayout", show)
			show_list.HorizontalAlignment = Enum.HorizontalAlignment.Center
			show_list.FillDirection = Enum.FillDirection.Horizontal

			local show_inner = Instance.new("Frame", show)
			show_inner.BorderSizePixel = 0
			show_inner.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			show_inner.AutomaticSize = Enum.AutomaticSize.XY
			show_inner.BackgroundTransparency = 0.5

			local inner_pad = Instance.new("UIPadding", show_inner)
			inner_pad.PaddingTop = UDim.new(0, 10)
			inner_pad.PaddingBottom = UDim.new(0, 10)
			inner_pad.PaddingLeft = UDim.new(0, 15)
			inner_pad.PaddingRight = UDim.new(0, 15)

			local inner_corner = Instance.new("UICorner", show_inner)
			inner_corner.CornerRadius = UDim.new(0, 16)

			Instance.new("UIFlexItem", show_inner)

			local inner_label = Instance.new("TextLabel", show_inner)
			inner_label.BorderSizePixel = 0
			inner_label.TextSize = 20
			inner_label.FontFace =
				Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			inner_label.TextColor3 = Color3.fromRGB(255, 255, 255)
			inner_label.BackgroundTransparency = 1
			inner_label.Text = "Show " .. settings.ShowText
			inner_label.AutomaticSize = Enum.AutomaticSize.XY

			show_inner.InputBegan:Connect(function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch
				then
					frame.Parent = ui
					show.Parent = nil
				end
			end)

			close.MouseButton1Click:Connect(function()
				frame.Parent = nil
				show.Parent = ui
			end)

			local main = Instance.new("Frame", frame)
			main.BorderSizePixel = 0
			main.Size = UDim2.new(0, 682, 0, 398)
			main.Position = UDim2.new(0, 0, 0.08083, 0)
			main.BackgroundTransparency = 1

			local main_list = Instance.new("UIListLayout", main)
			main_list.Padding = UDim.new(0, 5)
			main_list.VerticalAlignment = Enum.VerticalAlignment.Bottom
			main_list.SortOrder = Enum.SortOrder.LayoutOrder
			main_list.FillDirection = Enum.FillDirection.Horizontal

			local tabsf = Instance.new("ScrollingFrame", main)
			tabsf.Active = true
			tabsf.ScrollingDirection = Enum.ScrollingDirection.Y
			tabsf.BorderSizePixel = 0
			tabsf.CanvasSize = UDim2.new(0, 0, 0, 0)
			tabsf.AutomaticCanvasSize = Enum.AutomaticSize.Y
			tabsf.Size = UDim2.new(0, 72, 0, 398)
			tabsf.ScrollBarThickness = 0
			tabsf.BackgroundTransparency = 1

			local tabsf_flex = Instance.new("UIFlexItem", tabsf)

			local twrapper = Instance.new("Frame", tabsf)
			twrapper.BorderSizePixel = 0
			twrapper.AutomaticSize = Enum.AutomaticSize.XY
			twrapper.BackgroundTransparency = 1

			task.spawn(function()
				local tabs = twrapper.Parent
				local main = tabs.Parent

				local function updateWidth()
					local w = twrapper.AbsoluteSize.X

					tabs.Size = UDim2.new(0, w, 1, 0)

					if main then
						local size = main.Size
						main.Size = size + UDim2.new(0, 1, 0, 0)
						main.Size = size
					end
				end

				twrapper:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateWidth)
			end)

			local twrapper_list = Instance.new("UIListLayout", twrapper)
			twrapper_list.HorizontalAlignment = Enum.HorizontalAlignment.Center
			twrapper_list.Padding = UDim.new(0, 10)
			twrapper_list.SortOrder = Enum.SortOrder.LayoutOrder

			local twrapper_pad = Instance.new("UIPadding", twrapper)
			twrapper_pad.PaddingTop = UDim.new(0, 10)
			twrapper_pad.PaddingLeft = UDim.new(0, 10)
			twrapper_pad.PaddingRight = UDim.new(0, 10)
			twrapper_pad.PaddingBottom = UDim.new(0, 10)

			local tabContent = Instance.new("ScrollingFrame", main)
			tabContent.Active = true
			tabContent.ScrollingDirection = Enum.ScrollingDirection.Y
			tabContent.BorderSizePixel = 0
			tabContent.CanvasSize = UDim2.new(0, 0, 1, 0)
			tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
			tabContent.Size = UDim2.new(0, 0, 0, 398)
			tabContent.ScrollBarThickness = 0
			tabContent.BackgroundTransparency = 1

			local tc_pad = Instance.new("UIPadding", tabContent)
			tc_pad.PaddingTop = UDim.new(0, 10)
			tc_pad.PaddingRight = UDim.new(0, 10)
			tc_pad.PaddingLeft = UDim.new(0, 5)
			tc_pad.PaddingBottom = UDim.new(0, 10)

			local tc_list = Instance.new("UIListLayout", tabContent)
			tc_list.HorizontalFlex = Enum.UIFlexAlignment.Fill
			tc_list.Padding = UDim.new(0, 10)
			tc_list.SortOrder = Enum.SortOrder.LayoutOrder

			local tc_flex = Instance.new("UIFlexItem", tabContent)
			tc_flex.FlexMode = Enum.UIFlexMode.Grow

			local cw_self = self
			window.CreateTab = function(self, name)
				local frame = Instance.new("Frame", twrapper)
				frame.BorderSizePixel = 0
				frame.BackgroundColor3 = theme.TabBackground
				frame.AutomaticSize = Enum.AutomaticSize.X
				frame.Size = UDim2.new(0, 0, 0, 30)
				frame.Position = UDim2.new(0, 0, 0, 0)
				frame.BackgroundTransparency = 0.7

				local corner = Instance.new("UICorner", frame)
				local stroke = Instance.new("UIStroke", frame)
				stroke.Transparency = 0.5
				stroke.Color = theme.TabStroke

				local flex = Instance.new("UIFlexItem", frame)
				flex.ItemLineAlignment = Enum.ItemLineAlignment.Stretch

				local label = Instance.new("TextLabel", frame)
				label.BorderSizePixel = 0
				label.TextSize = 16
				label.TextTransparency = 0.2
				label.FontFace = Font.new(
					"rbxasset://fonts/families/SourceSansPro.json",
					Enum.FontWeight.Regular,
					Enum.FontStyle.Normal
				)
				label.TextColor3 = theme.TabTextColor
				label.BackgroundTransparency = 1
				label.Size = UDim2.new(0, 0, 0, 30)
				label.AutomaticSize = Enum.AutomaticSize.X
				label.Text = name

				local padding = Instance.new("UIPadding", frame)
				padding.PaddingRight = UDim.new(0, 10)
				padding.PaddingLeft = UDim.new(0, 10)

				local function selectTab()
					local theme = cw_self:GetTheme()
					local TS = game:GetService("TweenService")
					TS:Create(
						frame,
						TweenInfo.new(0.7, Enum.EasingStyle.Exponential),
						{ BackgroundColor3 = theme.TabBackgroundSelected }
					):Play()
					TS:Create(frame, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0 })
						:Play()
					TS:Create(stroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), { Transparency = 0 }):Play()
					TS:Create(label, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
					TS:Create(
						label,
						TweenInfo.new(0.7, Enum.EasingStyle.Exponential),
						{ TextColor3 = theme.SelectedTabTextColor }
					):Play()

					local tabs = cw_self.Tabs

					for i, v in pairs(tabs) do
						if v.Name ~= name then
							v:Deselect()
						else
							v.Active = true

							for i, v in pairs(v.Content) do
								v.Parent = tabContent
							end
						end
					end
				end

				frame.InputBegan:Connect(function(input)
					if
						input.UserInputType == Enum.UserInputType.MouseButton1
						or input.UserInputType == Enum.UserInputType.Touch
					then
						selectTab()
					end
				end)

				local tab = {}

				tab.Name = name
				tab.Content = {}
				tab.Active = false

				tab.Deselect = function(self)
					local theme = cw_self:GetTheme()
					local TS = game:GetService("TweenService")
					TS:Create(
						frame,
						TweenInfo.new(0.7, Enum.EasingStyle.Exponential),
						{ BackgroundColor3 = theme.TabBackground }
					):Play()
					TS:Create(frame, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0.7 })
						:Play()
					TS:Create(stroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), { Transparency = 0.5 }):Play()
					TS:Create(label, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), { TextTransparency = 0.2 })
						:Play()
					TS:Create(
						label,
						TweenInfo.new(0.7, Enum.EasingStyle.Exponential),
						{ TextColor3 = theme.TabTextColor }
					):Play()

					self.Active = false

					for i, v in pairs(self.Content) do
						v.Parent = nil
					end
				end

				local cb_self = self
				tab.CreateButton = function(self, settings)
					local button = Instance.new("Frame")
					button.BorderSizePixel = 0
					button.BackgroundColor3 = theme.ElementBackground
					button.AutomaticSize = Enum.AutomaticSize.X
					button.Size = UDim2.new(0, 0, 0, 40)

					Instance.new("UICorner", button)

					local btn_stroke = Instance.new("UIStroke", button)
					btn_stroke.Color = theme.ElementStroke

					Instance.new("UIFlexItem", button)

					local btn_list = Instance.new("UIListLayout", button)
					btn_list.HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
					btn_list.Padding = UDim.new(0, 15)
					btn_list.VerticalAlignment = Enum.VerticalAlignment.Center
					btn_list.SortOrder = Enum.SortOrder.LayoutOrder
					btn_list.FillDirection = Enum.FillDirection.Horizontal

					local btn_pad = Instance.new("UIPadding", button)
					btn_pad.PaddingRight = UDim.new(0, 10)
					btn_pad.PaddingLeft = UDim.new(0, 10)

					local btn_flex = Instance.new("UIFlexItem")
					btn_flex.FlexMode = Enum.UIFlexMode.Grow

					local label = Instance.new("TextLabel", button)
					label.BorderSizePixel = 0
					label.TextSize = 18
					label.FontFace = Font.new(
						"rbxasset://fonts/families/SourceSansPro.json",
						Enum.FontWeight.Regular,
						Enum.FontStyle.Normal
					)
					label.TextColor3 = theme.TextColor
					label.BackgroundTransparency = 1
					label.Size = UDim2.new(0, 0, 0, 30)
					label.Text = settings.Name
					label.AutomaticSize = Enum.AutomaticSize.X

					button.InputBegan:Connect(function(input)
						if
							input.UserInputType == Enum.UserInputType.MouseButton1
							or input.UserInputType == Enum.UserInputType.Touch
						then
							task.spawn(function()
								settings:Callback()
							end)
						end
					end)

					button.MouseEnter:Connect(function()
						local TS = game:GetService("TweenService")
						TS:Create(
							button,
							TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
							{ BackgroundColor3 = theme.ElementBackgroundHover }
						):Play()
					end)

					button.MouseLeave:Connect(function()
						local TS = game:GetService("TweenService")
						TS:Create(
							button,
							TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
							{ BackgroundColor3 = theme.ElementBackground }
						):Play()
					end)

					table.insert(self.Content, button)

					if self.Active then
						button.Parent = tabContent
					end
				end

				tab.CreateToggle = function(self, settings)
					local toggle = Instance.new("Frame")
					toggle.BorderSizePixel = 0
					toggle.BackgroundColor3 = theme.ElementBackground
					toggle.AutomaticSize = Enum.AutomaticSize.X
					toggle.Size = UDim2.new(0, 0, 0, 40)

					Instance.new("UICorner", toggle)

					local btn_stroke = Instance.new("UIStroke", toggle)
					btn_stroke.Color = theme.ElementStroke

					Instance.new("UIFlexItem", toggle)

					local btn_list = Instance.new("UIListLayout", toggle)
					btn_list.HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
					btn_list.Padding = UDim.new(0, 15)
					btn_list.VerticalAlignment = Enum.VerticalAlignment.Center
					btn_list.SortOrder = Enum.SortOrder.LayoutOrder
					btn_list.FillDirection = Enum.FillDirection.Horizontal

					local btn_pad = Instance.new("UIPadding", toggle)
					btn_pad.PaddingRight = UDim.new(0, 10)
					btn_pad.PaddingLeft = UDim.new(0, 10)

					local btn_flex = Instance.new("UIFlexItem")
					btn_flex.FlexMode = Enum.UIFlexMode.Grow

					local label = Instance.new("TextLabel", toggle)
					label.BorderSizePixel = 0
					label.TextSize = 18
					label.FontFace = Font.new(
						"rbxasset://fonts/families/SourceSansPro.json",
						Enum.FontWeight.Regular,
						Enum.FontStyle.Normal
					)
					label.TextColor3 = theme.TextColor
					label.BackgroundTransparency = 1
					label.Size = UDim2.new(0, 0, 0, 30)
					label.Text = settings.Name
					label.AutomaticSize = Enum.AutomaticSize.X

					local switch = Instance.new("Frame", toggle)
					switch.BorderSizePixel = 0
					switch.BackgroundColor3 = theme.ToggleBackground
					switch.Size = UDim2.new(0, 60, 0, 30)

					local switch_stroke = Instance.new("UIStroke", switch)
					switch_stroke.Color = theme.ToggleDisabledOuterStroke

					local switch_corner = Instance.new("UICorner", switch)
					switch_corner.CornerRadius = UDim.new(0, 999)

					local indicator = Instance.new("Frame", switch)
					indicator.BorderSizePixel = 0
					indicator.BackgroundColor3 = theme.ToggleDisabled
					indicator.Size = UDim2.new(0, 20, 0, 20)
					indicator.Position = UDim2.new(0, 5, 0, 5)

					local indicator_corner = Instance.new("UICorner", indicator)
					indicator_corner.CornerRadius = UDim.new(0, 999)

					local indicator_stroke = Instance.new("UIStroke", indicator)
					indicator_stroke.Color = theme.ToggleDisabledStroke

					local Toggle = {}
					Toggle.CurrentValue = settings.CurrentValue
					Toggle.Set = function(self, value)
						self.CurrentValue = value

						if settings.Flag then
							cw_self.Flags[settings.Flag] = value
							SaveConfig()
						end

						task.spawn(function()
							settings.Callback(value)
						end)

						if value then
							local TS = game:GetService("TweenService")
							TS:Create(
								switch_stroke,
								TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
								{ Color = theme.ToggleEnabledOuterStroke }
							):Play()
							TS:Create(
								indicator,
								TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
								{ BackgroundColor3 = theme.ToggleEnabled }
							):Play()
							TS:Create(
								indicator,
								TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
								{ Position = UDim2.new(0, 60 - 20 - 5, 0, 5) }
							):Play()
							TS:Create(
								indicator_stroke,
								TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
								{ Color = theme.ToggleEnabledStroke }
							):Play()
						else
							local TS = game:GetService("TweenService")
							TS:Create(
								switch_stroke,
								TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
								{ Color = theme.ToggleDisabledOuterStroke }
							):Play()
							TS:Create(
								indicator,
								TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
								{ BackgroundColor3 = theme.ToggleDisabled }
							):Play()
							TS:Create(
								indicator,
								TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
								{ Position = UDim2.new(0, 5, 0, 5) }
							):Play()
							TS:Create(
								indicator_stroke,
								TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
								{ Color = theme.ToggleDisabledStroke }
							):Play()
						end
					end
					Toggle.Toggle = function(self)
						self:Set(not self.CurrentValue)
					end

					if settings.CurrentValue then
						Toggle:Set(settings.CurrentValue)
					end

					if settings.Flag and cw_self.Flags[settings.Flag] then
						Toggle:Set(cw_self.Flags[settings.Flag])
					end

					toggle.InputBegan:Connect(function(input)
						if
							input.UserInputType == Enum.UserInputType.MouseButton1
							or input.UserInputType == Enum.UserInputType.Touch
						then
							Toggle:Toggle()
						end
					end)

					toggle.MouseEnter:Connect(function()
						local TS = game:GetService("TweenService")
						TS:Create(
							toggle,
							TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
							{ BackgroundColor3 = theme.ElementBackgroundHover }
						):Play()
					end)

					toggle.MouseLeave:Connect(function()
						local TS = game:GetService("TweenService")
						TS:Create(
							toggle,
							TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
							{ BackgroundColor3 = theme.ElementBackground }
						):Play()
					end)

					table.insert(self.Content, toggle)

					if self.Active then
						toggle.Parent = tabContent
					end

					return Toggle
				end

				tab.CreateSlider = function(self, settings)
					local slider = Instance.new("Frame")
					slider.BorderSizePixel = 0
					slider.BackgroundColor3 = theme.ElementBackground
					slider.AutomaticSize = Enum.AutomaticSize.X
					slider.Size = UDim2.new(0, 0, 0, 40)

					Instance.new("UICorner", slider)

					local btn_stroke = Instance.new("UIStroke", slider)
					btn_stroke.Color = theme.ElementStroke

					Instance.new("UIFlexItem", slider)

					local btn_list = Instance.new("UIListLayout", slider)
					btn_list.HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
					btn_list.Padding = UDim.new(0, 15)
					btn_list.VerticalAlignment = Enum.VerticalAlignment.Center
					btn_list.SortOrder = Enum.SortOrder.LayoutOrder
					btn_list.FillDirection = Enum.FillDirection.Horizontal

					local btn_pad = Instance.new("UIPadding", slider)
					btn_pad.PaddingRight = UDim.new(0, 10)
					btn_pad.PaddingLeft = UDim.new(0, 10)

					local btn_flex = Instance.new("UIFlexItem")
					btn_flex.FlexMode = Enum.UIFlexMode.Grow

					local label = Instance.new("TextLabel", slider)
					label.BorderSizePixel = 0
					label.TextSize = 18
					label.FontFace = Font.new(
						"rbxasset://fonts/families/SourceSansPro.json",
						Enum.FontWeight.Regular,
						Enum.FontStyle.Normal
					)
					label.TextColor3 = theme.TextColor
					label.BackgroundTransparency = 1
					label.Size = UDim2.new(0, 0, 0, 30)
					label.Text = settings.Name
					label.AutomaticSize = Enum.AutomaticSize.X

					local slide = Instance.new("Frame", slider)
					slide.BorderSizePixel = 0
					slide.BackgroundColor3 = theme.SliderBackground
					slide.BackgroundTransparency = 0.75
					slide.Size = UDim2.new(0, 270, 0, 30)

					local switch_stroke = Instance.new("UIStroke", slide)
					switch_stroke.Color = theme.SliderStroke

					local switch_corner = Instance.new("UICorner", slide)
					switch_corner.CornerRadius = UDim.new(0, 999)

					local progress = Instance.new("Frame", slide)
					progress.BorderSizePixel = 0
					progress.BackgroundColor3 = theme.SliderProgress
					progress.Size = UDim2.new(0.5, 0, 1, 0)

					local indicator_corner = Instance.new("UICorner", progress)
					indicator_corner.CornerRadius = UDim.new(0, 999)

					local Slider = {}

					local min = settings.Range and settings.Range[1] or 0
					local max = settings.Range and settings.Range[2] or 1
					local step = settings.Increment or 0.1

					Slider.CurrentValue = settings.CurrentValue
					Slider.Set = function(self, value)
						local cvalue = math.clamp(value, min, max)
						self.CurrentValue = cvalue
						if settings.Flag then
							cw_self.Flags[settings.Flag] = cvalue
							SaveConfig()
						end
						label.Text = settings.Name .. ": " .. cvalue .. (settings.Suffix or "")

						local TS = game:GetService("TweenService")
						local percent = (cvalue - min) / (max - min)
						TS:Create(
							progress,
							TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
							{ Size = UDim2.new(percent, 0, 1, 0) }
						):Play()

						task.spawn(function()
							settings.Callback(cvalue)
						end)
					end

					if settings.CurrentValue then
						Slider:Set(settings.CurrentValue)
					end

					if settings.Flag and cw_self.Flags[settings.Flag] then
						Slider:Set(cw_self.Flags[settings.Flag])
					end

					slider.MouseEnter:Connect(function()
						local TS = game:GetService("TweenService")
						TS:Create(
							slider,
							TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
							{ BackgroundColor3 = theme.ElementBackgroundHover }
						):Play()
					end)

					slider.MouseLeave:Connect(function()
						local TS = game:GetService("TweenService")
						TS:Create(
							slider,
							TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
							{ BackgroundColor3 = theme.ElementBackground }
						):Play()
					end)

					local DragLoop = nil
					slide.InputBegan:Connect(function(Input)
						if
							Input.UserInputType == Enum.UserInputType.MouseButton1
							or Input.UserInputType == Enum.UserInputType.Touch
						then
							local UIS = game:GetService("UserInputService")
							local width = slide.AbsoluteSize.X
							DragLoop = game:GetService("RunService").Stepped:Connect(function()
								local x = UIS:GetMouseLocation().X - slide.AbsolutePosition.X
								local percent = x / width

								local val = min + (percent * (max - min))
								val = math.floor(val / step) * step

								local mult = 1 / step
								val = math.round(val * mult) / mult

								Slider:Set(val)
							end)
						end
					end)

					slide.InputEnded:Connect(function(Input)
						if
							Input.UserInputType == Enum.UserInputType.MouseButton1
							or Input.UserInputType == Enum.UserInputType.Touch
						then
							DragLoop:Disconnect()
							DragLoop = nil
						end
					end)

					table.insert(self.Content, slider)

					if self.Active then
						slider.Parent = tabContent
					end

					return Slider
				end

				tab.CreateKeybind = function(self, settings)
					if settings.Flag and cw_self.Flags[settings.Flag] then
						settings.CurrentKeybind = cw_self.Flags[settings.Flag]
						SaveConfig()
					end

					local toggle = Instance.new("Frame")
					toggle.BorderSizePixel = 0
					toggle.BackgroundColor3 = theme.ElementBackground
					toggle.AutomaticSize = Enum.AutomaticSize.X
					toggle.Size = UDim2.new(0, 0, 0, 40)

					Instance.new("UICorner", toggle)

					local btn_stroke = Instance.new("UIStroke", toggle)
					btn_stroke.Color = theme.ElementStroke

					Instance.new("UIFlexItem", toggle)

					local btn_list = Instance.new("UIListLayout", toggle)
					btn_list.HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween
					btn_list.Padding = UDim.new(0, 15)
					btn_list.VerticalAlignment = Enum.VerticalAlignment.Center
					btn_list.SortOrder = Enum.SortOrder.LayoutOrder
					btn_list.FillDirection = Enum.FillDirection.Horizontal

					local btn_pad = Instance.new("UIPadding", toggle)
					btn_pad.PaddingRight = UDim.new(0, 10)
					btn_pad.PaddingLeft = UDim.new(0, 10)

					local btn_flex = Instance.new("UIFlexItem")
					btn_flex.FlexMode = Enum.UIFlexMode.Grow

					local label = Instance.new("TextLabel", toggle)
					label.BorderSizePixel = 0
					label.TextSize = 18
					label.FontFace = Font.new(
						"rbxasset://fonts/families/SourceSansPro.json",
						Enum.FontWeight.Regular,
						Enum.FontStyle.Normal
					)
					label.TextColor3 = theme.TextColor
					label.BackgroundTransparency = 1
					label.Size = UDim2.new(0, 0, 0, 30)
					label.Text = settings.Name
					label.AutomaticSize = Enum.AutomaticSize.X

					local switch = Instance.new("Frame", toggle)
					switch.BorderSizePixel = 0
					switch.BackgroundColor3 = theme.InputBackground
					switch.Size = UDim2.new(0, 30, 0, 30)

					local switch_stroke = Instance.new("UIStroke", switch)
					switch_stroke.Color = theme.InputStroke

					local switch_corner = Instance.new("UICorner", switch)
					switch_corner.CornerRadius = UDim.new(0, 3)

					local input = Instance.new("TextBox", switch)
					input.BorderSizePixel = 0
					input.TextSize = 16
					input.TextColor3 = theme.TextColor
					input.FontFace = Font.new(
						"rbxasset://fonts/families/SourceSansPro.json",
						Enum.FontWeight.Regular,
						Enum.FontStyle.Normal
					)
					input.Size = UDim2.new(1, 0, 1, 0)
					input.Text = settings.CurrentKeybind or ""
					input.BackgroundTransparency = 1

					toggle.InputBegan:Connect(function(input)
						if
							input.UserInputType == Enum.UserInputType.MouseButton1
							or input.UserInputType == Enum.UserInputType.Touch
						then
						end
					end)

					toggle.MouseEnter:Connect(function()
						local TS = game:GetService("TweenService")
						TS:Create(
							toggle,
							TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
							{ BackgroundColor3 = theme.ElementBackgroundHover }
						):Play()
					end)

					toggle.MouseLeave:Connect(function()
						local TS = game:GetService("TweenService")
						TS:Create(
							toggle,
							TweenInfo.new(0.6, Enum.EasingStyle.Exponential),
							{ BackgroundColor3 = theme.ElementBackground }
						):Play()
					end)

					local checking = false
					input.Focused:Connect(function()
						checking = true
						input.Text = ""
					end)

					input.FocusLost:Connect(function()
						checking = false
						if input.Text == nil or input.Text == "" then
							input.Text = settings.CurrentKeybind
						end
					end)

					local _input = input
					game:GetService("UserInputService").InputBegan:Connect(function(input, proc)
						if checking then
							if input.KeyCode ~= Enum.KeyCode.Unknown then
								local SplitMessage = string.split(tostring(input.KeyCode), ".")
								local NewKeyNoEnum = SplitMessage[3]
								_input.Text = tostring(NewKeyNoEnum)
								settings.CurrentKeybind = tostring(NewKeyNoEnum)
								if settings.Flag then
									cw_self.Flags[settings.Flag] = tostring(NewKeyNoEnum)
									SaveConfig()
								end
								_input:ReleaseFocus()
							end
						elseif
							settings.CurrentKeybind ~= nil
							and (input.KeyCode == Enum.KeyCode[settings.CurrentKeybind] and not proc)
						then
							settings.Callback()
						end
					end)

					table.insert(self.Content, toggle)

					if self.Active then
						toggle.Parent = tabContent
					end
				end

				tab.CreateSection = function(self, name)
					local label = Instance.new("TextLabel")
					label.BorderSizePixel = 0
					label.TextSize = 20
					label.FontFace = Font.new(
						"rbxasset://fonts/families/SourceSansPro.json",
						Enum.FontWeight.Regular,
						Enum.FontStyle.Normal
					)
					label.TextColor3 = theme.TextColor
					label.BackgroundTransparency = 1
					label.Size = UDim2.new(0, 0, 0, 30)
					label.Text = name
					label.AutomaticSize = Enum.AutomaticSize.X

					table.insert(self.Content, label)

					if self.Active then
						label.Parent = tabContent
					end
				end

				tab.CreateDropdown = function(self, settings) end

				tab.CreateLabel = function(self, name)
					local label = Instance.new("TextLabel")
					label.BorderSizePixel = 0
					label.TextSize = 18
					label.FontFace = Font.new(
						"rbxasset://fonts/families/SourceSansPro.json",
						Enum.FontWeight.Regular,
						Enum.FontStyle.Normal
					)
					label.TextColor3 = theme.TextColor
					label.BackgroundTransparency = 1
					label.Size = UDim2.new(0, 0, 0, 30)
					label.Text = name
					label.AutomaticSize = Enum.AutomaticSize.X

					table.insert(self.Content, label)

					if self.Active then
						label.Parent = tabContent
					end
				end

				table.insert(cw_self.Tabs, tab)
				if cw_self.Tabs[1].Name == name then
					selectTab()
				end

				return tab
			end

			window.Frame = frame

			self.Window = window
			return window
		end,
	}

	return Library
end
