-- Start Custom UI Library

local function InitUI()
	local Library = {
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

-- End Custom UI Library

local function WaitForGameAndPlayer()
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

local function diff3d(origin, target)
	return target - origin
end

local function dist3d(pos1, pos2)
	return diff3d(pos1, pos2).Magnitude
end

local function dir3d(origin, target)
	return diff3d(origin, target).Unit
end

local function isDev()
	local prefix = "pathwise"

	local plr = game:GetService("Players").LocalPlayer

	if string.sub(plr.Name, 1, #prefix) == prefix then
		return true
	end

	return false
end

local function isKBM()
	local UIS = game:GetService("UserInputService")
	return UIS.KeyboardEnabled and UIS.MouseEnabled
end

local Noclipping = nil
local Clip = true

local manual_noclip = false

local function enableNoclip()
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

local function disableNoclip()
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

local function toggleNoclip()
	if Clip then
		enableNoclip()
	else
		disableNoclip()
	end
end

local function breakVelocity(t)
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

local function getRoot(char)
	if char and char:FindFirstChildOfClass("Humanoid") then
		return char:FindFirstChildOfClass("Humanoid").RootPart
	else
		return nil
	end
end

local function tweenGotoPart(part)
	local TweenService = game:GetService("TweenService")

	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")

	if part:IsA("BasePart") then
		if hum and hum.SeatPart then
			hum.Sit = false
			task.wait(0.1)
		end
		task.wait(0.1)
		TweenService:Create(root, TweenInfo.new(1, Enum.EasingStyle.Linear), { CFrame = part.CFrame }):Play()
	end
	breakVelocity(1)
end

local safeTweenSpeed = 20
local safeTweening = false
local function safeTweenToPos(cframe: CFrame)
	local TweenService = game:GetService("TweenService")

	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")

	local dist = dist3d(root.Position, cframe.Position)
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
	breakVelocity(t)
end

local function safeTweenToPart(part)
	if part:IsA("BasePart") then
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local hum = char and char:FindFirstChildWhichIsA("Humanoid")

		local dist = dist3d(root.Position, part.Position)
		local t = dist / safeTweenSpeed

		safeTweening = true
		if hum and hum.SeatPart then
			hum.Sit = false
			task.wait(0.1)
		end
		task.wait(0.1)
		local conn = nil
		safeTweening = true
		enableNoclip()
		game.Workspace.Gravity = 0
		conn = game:GetService("RunService").Heartbeat:Connect(function(dt)
			if not root or not part or not part.Parent then
				conn:Disconnect()
				safeTweening = false
				disableNoclip()
				game.Workspace.Gravity = 196.21
				if hum then
					hum:ChangeState(Enum.HumanoidStateType.GettingUp)
				end
				return
			end

			local currentPos = root.Position
			local targetPos = part.Position
			local distance = dist3d(currentPos, targetPos)

			local moveStep = safeTweenSpeed * dt

			if distance <= moveStep then
				root.CFrame = part.CFrame
				conn:Disconnect()
				safeTweening = false
				disableNoclip()
				if hum then
					hum:ChangeState(Enum.HumanoidStateType.GettingUp)
				end
				game.Workspace.Gravity = 196.21
			else
				local direction = dir3d(currentPos, targetPos)
				local newPosition = currentPos + (direction * moveStep)

				if hum then
					hum:ChangeState(Enum.HumanoidStateType.Physics)
				end

				root.CFrame = CFrame.new(newPosition) * (part.CFrame - part.CFrame.Position)
			end
		end)
		breakVelocity(t)
	end
end

local function aimbotToPart(part, smoothing)
	local camera = workspace.CurrentCamera

	if camera then
		game:GetService("TweenService")
			:Create(
				camera,
				TweenInfo.new(smoothing, Enum.EasingStyle.Linear),
				{ CFrame = CFrame.new(camera.CFrame.Position, part.Position) }
			)
			:Play()
	end
end

local flinging = false
local function flingCharacter(pChar)
	local plr = game:GetService("Players").LocalPlayer
	local char = plr and plr.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")

	local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")

	if root and pRoot then
		flinging = true

		enableNoclip()

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

			disableNoclip()
			flingloop:Disconnect()
			breakVelocity(0.2)
			task.wait(0.1)
			root.CFrame = pos
			flinging = false
		end)
	end
end

local function flingPlayer(plr)
	local char = plr and plr.Character
	flingCharacter(char)
end

local function isFriendsWith(plr)
	local player = game:GetService("Players").LocalPlayer
	return player:IsFriendsWith(plr.UserId)
end

WaitForGameAndPlayer()

local looped_functions = {}

local path_toggled = false
table.insert(looped_functions, function()
	if path_toggled == true then
		local paths = game.Workspace:FindFirstChild("PATHS")
		if not paths then
			Instance.new("Folder", game.Workspace).Name = "PATHS"
		end

		for i, v in pairs(paths:GetChildren()) do
			v.Age.Value = v.Age.Value + 1
			if v.Age.Value > 0 then
				v:Destroy()
			end
		end

		local p = Instance.new("Part", paths)
		Instance.new("NumberValue", p).Name = "Age"
		p.Size = Vector3.new(3, 1, 3)
		p.Anchored = true
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local hum = char and char:FindFirstChildWhichIsA("Humanoid")
		local rig = hum and hum.RigType

		if root and hum then
			if rig == Enum.HumanoidRigType.R15 then
				local i = root.Position
				local s = root.Size.Y
				local h = hum.HipHeight

				p.Position = Vector3.new(i.x, (i.y - s / 2) - h - 0.5, i.z)
			else
				local leg = char and char:FindFirstChild("Left Leg")
				if leg then
					local i = root.Position
					local s = root.Size.Y
					local h = leg.Size.Y

					p.Position = Vector3.new(i.x, (i.y - s / 2) - h - 0.5, i.z)
				end
			end
		end
	end
end)

local ctrl_click_delete_toggled = true
local function initCtrlClickDelete()
	local Plr = game:GetService("Players").LocalPlayer
	local Mouse = Plr:GetMouse()

	local deletedParts = Instance.new("Folder", game.Workspace)
	deletedParts.Name = "DELETED_PARTS"

	local index = 1

	local function isControlDown()
		local UIS = game:GetService("UserInputService")

		return UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.LeftMeta)
	end

	Mouse.Button1Down:Connect(function()
		if not ctrl_click_delete_toggled then
			return
		end
		if not isControlDown() then
			return
		end
		if not Mouse.Target then
			return
		end
		local objHolder = Instance.new("ObjectValue", deletedParts)
		objHolder.Value = Mouse.Target
		objHolder.Name = "" .. index
		local objPos = Instance.new("Vector3Value", objHolder)
		objPos.Value = Mouse.Target.Position
		objPos.Name = "pos"
		Mouse.Target.Position = Vector3.new(100000000, 100000000, 100000000)

		index = index + 1
	end)

	Mouse.Button2Down:Connect(function()
		if not ctrl_click_delete_toggled then
			return
		end
		if not isControlDown() then
			return
		end
		deletedParts:GetChildren()[#deletedParts:GetChildren()].Value.Position =
			deletedParts:GetChildren()[#deletedParts:GetChildren()].pos.Value
		deletedParts:GetChildren()[#deletedParts:GetChildren()]:Destroy()
	end)

	local h = Instance.new("Part", game.Workspace)
	local j = Instance.new("ObjectValue", deletedParts)
	j.Value = h
	j.Name = "0"
	local k = Instance.new("Vector3Value", j)
	k.Name = "pos"
	k.Value = Vector3.new(100000000, 100000000, 100000000)
end
initCtrlClickDelete()

local function initCustomUI()
	local ui = Instance.new("ScreenGui")

	local function createMovingToggle(name, currentValue, callback)
		local el = Instance.new("TextButton")
		el.Text = name
		el.Size = UDim2.new(0, 0, 0, 50) -- X must be 0 for AutomaticSize to work
		el.Position = UDim2.new(0.4, 0, 0.4, 0) -- Centered on screen by default
		if currentValue then
			el.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
		else
			el.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
		end
		el.TextColor3 = Color3.fromRGB(255, 255, 255)
		-- el.Font = Enum.Font.SourceSansBold
		el.TextSize = 16
		el.TextWrapped = false -- Prevents text from forcing a new line
		el.AutomaticSize = Enum.AutomaticSize.X -- Force width to scale with text
		el.Parent = ui

		local uiPadding = Instance.new("UIPadding")
		uiPadding.PaddingLeft = UDim.new(0, 10)
		uiPadding.PaddingRight = UDim.new(0, 10)
		uiPadding.Parent = el

		local UIS = game:GetService("UserInputService")

		local Dragging = nil
		local DragInput = nil
		local DragStart = nil
		local StartPosition = nil

		local function Update(input)
			local Delta = input.Position - DragStart
			local Position = UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
			-- Smooth Rayfield glide transition
			game:GetService("TweenService"):Create(el, TweenInfo.new(0.15), { Position = Position }):Play()
		end

		el.InputBegan:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = true
				DragStart = input.Position
				StartPosition = el.Position

				-- Disables dragging when you release the mouse/finger
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		el.InputChanged:Connect(function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end)

		UIS.InputChanged:Connect(function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end)

		local obj = {
			name = name,
			currentValue = currentValue,
			toggle = function(self)
				self:set(not self.currentValue)
			end,
			set = function(self, value)
				self.currentValue = value
				callback(value)

				if value then
					el.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
				else
					el.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
				end
			end,
		}

		el.MouseButton1Click:Connect(function()
			obj:toggle()
		end)

		return obj
	end

	local noclipToggle = createMovingToggle("Noclip", false, function(value)
		manual_noclip = value
		if value then
			enableNoclip()
		else
			disableNoclip()
		end
	end)

	ui.Parent = game.CoreGui

	return ui
end

-- local CustomUI = initCustomUI()

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = nil
local UseNewUI = isKBM()
local SETTINGS = {
	Name = "Luke's Script Hub",
	Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
	LoadingTitle = "Luke's Script Hub",
	LoadingSubtitle = "by @actuallyluke",
	ShowText = "Menu", -- for mobile users to unhide Rayfield, change if you'd like
	Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

	ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

	DisableRayfieldPrompts = true,
	DisableBuildWarnings = false, -- Prevents Rayfield from emitting warnings when the script has a version mismatch with the interface.

	ConfigurationSaving = {
		Enabled = true,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "Lukes Script Hub",
	},

	KeySystem = false, -- Set this to true to use our key system
}
if UseNewUI then
	local UI = InitUI()
	Window = UI:CreateWindow(SETTINGS)
else
	Window = Rayfield:CreateWindow(SETTINGS)
end

local UniversalTab = Window:CreateTab("Universal", "globe")

local NoclipSection = UniversalTab:CreateSection("Noclip")

local NoClipToggle = UniversalTab:CreateToggle({
	Name = "Toggle Noclip",
	CurrentValue = false,
	Flag = nil,
	Callback = function(value)
		manual_noclip = value
		if value then
			enableNoclip()
		else
			disableNoclip()
		end
	end,
})

local NoClipKeybind = UniversalTab:CreateKeybind({
	Name = "Toggle Noclip",
	CurrentKeybind = "V",
	HoldToInteract = false,
	Flag = "NoClipKeybind",
	Callback = function()
		if NoClipToggle.CurrentValue then
			Rayfield:Notify({
				Title = "Noclip Disabled",
				Content = "Noclip is now disabled.",
				Duration = 3,
				Image = "ban",
			})
		else
			Rayfield:Notify({
				Title = "Noclip Enabled",
				Content = "Noclip is now enabled.",
				Duration = 3,
				Image = "check",
			})
		end
		NoClipToggle:Set(not NoClipToggle.CurrentValue)
	end,
})

-- local ThemeSection = UniversalTab:CreateSection("Theme")

-- local ThemeDropdown = UniversalTab:CreateDropdown({
-- 	Name = "Theme",
-- 	Options = { "Default", "Bloom", "AmberGlow", "Amethyst", "DarkBlue", "Green", "Light", "Ocean", "Serenity" },
-- 	CurrentOption = { "Default" },
-- 	MultipleOptions = false,
-- 	Flag = "ThemeDropdown",
-- 	Callback = function(options)
-- 		local option = options[1]

-- 		Window.ModifyTheme(option)
-- 	end,
-- })

local PathSection = UniversalTab:CreateSection("Path")

local PathKeybind = UniversalTab:CreateKeybind({
	Name = "Toggle Paths",
	CurrentKeybind = "N",
	HoldToInteract = false,
	Flag = "PathKeybind", -- A flag is the identifier for the configuration file. Make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function()
		path_toggled = not path_toggled
	end,
})

local DelSection = UniversalTab:CreateSection("Ctrl+Click Delete")

local CtrlClickInstructions = UniversalTab:CreateLabel("Ctrl+Left-Click a part to delete. Ctrl+Right-Click to restore")

local CtrlClickDelToggle = UniversalTab:CreateToggle({
	Name = "Ctrl+Click Delete",
	CurrentValue = true,
	Flag = nil, -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value)
		ctrl_click_delete_toggled = value
	end,
})

local UniversalESPSection = UniversalTab:CreateSection("Universal ESP")

local function updateESP(obj, color, enabled)
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

local function updateUniversalESP(enabled)
	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
		if v.Character and v ~= game:GetService("Players").LocalPlayer then
			updateESP(v.Character, Color3.fromRGB(255, 0, 0), enabled)
		end
	end
end

local universal_esp_toggled = false
local UniversalESPToggle = UniversalTab:CreateToggle({
	Name = "Universal ESP",
	CurrentValue = false,
	Flag = nil,
	Callback = function(value)
		universal_esp_toggled = value
		updateUniversalESP(universal_esp_toggled)
	end,
})
game:GetService("RunService").RenderStepped:Connect(function()
	if universal_esp_toggled then
		updateUniversalESP(universal_esp_toggled)
	end
end)

local ussPlr = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local ussChar = ussPlr and ussPlr.Character
local ussHum = ussChar and ussChar:FindFirstChild("Humanoid")

local ussSpeed = (ussHum and ussHum.WalkSpeed) or 16

local UniversalSpeedSection = UniversalTab:CreateSection("Speed")

local UniversalSpeedSlider = UniversalTab:CreateSlider({
	Name = "Speed",
	Range = { 0, 100 },
	Increment = 1,
	Suffix = "",
	CurrentValue = ussSpeed,
	Flag = nil, -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value)
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local hum = char and char:FindFirstChildWhichIsA("Humanoid")

		if hum then
			hum.WalkSpeed = value
		end
	end,
})

UniversalTab:CreateButton({
	Name = "Set to 16",
	Callback = function()
		UniversalSpeedSlider:Set(16)
	end,
})

UniversalTab:CreateButton({
	Name = "Set to 18",
	Callback = function()
		UniversalSpeedSlider:Set(18)
	end,
})

UniversalTab:CreateButton({
	Name = "Set to 20",
	Callback = function()
		UniversalSpeedSlider:Set(20)
	end,
})

local SpeedMod = nil
local SpeedCA = nil
local LoopSpeedToggle = UniversalTab:CreateToggle({
	Name = "Loop Speed",
	CurrentValue = false,
	Flag = nil,
	Callback = function(value)
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local hum = char and char:FindFirstChildWhichIsA("Humanoid")

		if value and hum then
			local function SetWalkspeed()
				local _plr = game:GetService("Players").LocalPlayer
				local _char = _plr and _plr.Character
				local _hum = _char and _char:FindFirstChildWhichIsA("Humanoid")

				if _hum then
					_hum.WalkSpeed = UniversalSpeedSlider.CurrentValue
				end
			end
			SetWalkspeed()
			SpeedMod = (SpeedMod and SpeedMod:Disconnect() and false)
				or hum:GetPropertyChangedSignal("WalkSpeed"):Connect(SetWalkspeed)
			SpeedCA = (SpeedCA and SpeedCA:Disconnect() and false)
				or plr.CharacterAdded:Connect(function(nChar)
					hum = nChar:WaitForChild("Humanoid")
					SetWalkspeed()
					SpeedMod = (SpeedMod and SpeedMod:Disconnect() and false)
						or hum:GetPropertyChangedSignal("WalkSpeed"):Connect(SetWalkspeed)
				end)
		else
			SpeedMod = (SpeedMod and SpeedMod:Disconnect() and false) or nil
			SpeedCA = (SpeedCA and SpeedCA:Disconnect() and false) or nil
		end
	end,
})

-- Hide and Seek
if game.GameId == 93740418 then
	local HSTab = Window:CreateTab("Hide and Seek", "gamepad-2")
	HSTab:CreateSection("ESP")

	local function isSeeker(plr)
		local char = plr and plr.Character
		local itscript = char and char:FindFirstChild("ItScript")
		return itscript ~= nil
	end

	local player_esp_toggled = true
	local function updatePlayerESP()
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if v ~= game:GetService("Players").LocalPlayer then
				local char = v and v.Character
				local color = (isSeeker(v) and Color3.fromRGB(255, 0, 0))
					or (isFriendsWith(v) and Color3.fromRGB(0, 0, 255))
					or Color3.fromRGB(0, 255, 0)

				if char then
					updateESP(char, color, player_esp_toggled)
				end
			end
		end
	end

	local HSPlayerESPToggle = HSTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = player_esp_toggled,
		Flag = nil,
		Callback = function(value)
			player_esp_toggled = value
			updatePlayerESP()
		end,
	})

	task.spawn(function()
		while task.wait(1) do
			if player_esp_toggled then
				updatePlayerESP()
			end
		end
	end)

	HSTab:CreateSection("Utils")

	local HSKillAllButton = HSTab:CreateButton({
		Name = "Kill All",
		Callback = function()
			local plr = game:GetService("Players").LocalPlayer
			local char = plr and plr.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")

			if root then
				local c = 0
				enableNoclip()
				while c < 10 do
					for i, v in pairs(game:GetService("Players"):GetPlayers()) do
						if v ~= plr then
							local pChar = v and v.Character
							local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")

							if pRoot then
								pRoot.CFrame = root.CFrame
							end
						end
					end
					c = c + 1
					task.wait()
				end
				disableNoclip()
			end
		end,
	})
end

-- Granny Shooters
if game.GameId == 10141757860 then
	local GSTab = Window:CreateTab("Granny Shooters", "gamepad-2")

	local function getCurrentGun()
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local gun = char and char:FindFirstChildOfClass("Tool")

		return gun
	end

	local function getGunFireEvent()
		local gun = getCurrentGun()
		local events = gun and gun:FindFirstChild("Events")
		local event = events and events:FindFirstChild("Fire")

		return event
	end

	local function getGunReloadEvent()
		local gun = getCurrentGun()
		local events = gun and gun:FindFirstChild("Events")
		local event = events and events:FindFirstChild("Reload")

		return event
	end

	local function getGunAmmo()
		local gun = getCurrentGun()
		local gunServer = gun and gun:FindFirstChild("GunServer")
		local ammoV = gunServer and gunServer:FindFirstChild("Ammo")
		local ammo = (ammoV and ammoV.Value) or 0

		return ammo
	end

	local function reloadGun()
		local event = getGunReloadEvent()

		if event then
			event:FireServer()
		end
	end

	local function shootChar(pChar)
		local event = getGunFireEvent()

		local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")
		local hum = pChar and pChar:FindFirstChildWhichIsA("Humanoid")

		if pRoot and hum and event then
			local latency = game:GetService("Players").LocalPlayer:GetNetworkPing() / 2
			local tVel = pRoot.AssemblyLinearVelocity
			local tMov = hum and (hum.MoveDirection * hum.WalkSpeed)
			tVel = tVel:Lerp(tMov, 0.6)
			local tPos = pRoot.Position + (tVel * latency)

			local rng = Random.new()

			event:FireServer({
				Origin = pRoot.Position,
				Timestamp = game.Workspace:GetServerTimeNow(),
				Direction = dir3d(pRoot.Position, tPos),
				Seed = rng:NextInteger(0, 100),
			})
		end
	end

	local function findClosestChar()
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if root then
			local best = nil
			local best_dist = 99999999
			for i, v in pairs(game:GetService("Players"):GetPlayers()) do
				if v ~= plr then
					local pChar = v and v.Character
					local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")
					local ff = pChar and pChar:FindFirstChildOfClass("ForceField")
					local hum = pChar and pChar:FindFirstChildOfClass("Humanoid")

					if pRoot and not ff and (hum and hum.Health > 0) then
						local dist = dist3d(root.Position, pRoot.Position)
						-- local dist = hum.Health
						if dist < best_dist then
							best = pChar
							best_dist = dist
						end
					end
				end
			end
			return best
		end

		return nil
	end

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
				local char = findClosestChar()
				shootChar(char)
			end
		end
	end)

	-- task.spawn(function()
	-- 	while task.wait() do
	-- 		if auto_kill_toggled then
	-- 			for i, v in pairs(game.Players:GetPlayers()) do
	-- 				local char = v and v.Character
	-- 				local root = char and char:FindFirstChild("HumanoidRootPart")
	--
	-- 				if root then
	-- 					local mPlr = game:GetService("Players").LocalPlayer
	-- 					local mChar = mPlr and mPlr.Character
	-- 					local mRoot = mChar and mChar:FindFirstChild("HumanoidRootPart")
	--
	-- 					if mRoot then
	-- 						mRoot.CFrame = root.CFrame * CFrame.new(0, 0, 0)
	-- 					end
	-- 				end
	--
	-- 				task.wait(0.25)
	-- 			end
	-- 		end
	-- 	end
	-- end)

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
				if getGunAmmo() == 0 then
					reloadGun()
					task.wait(5)
				end
			end
		end
	end)
end

-- Reminiscence Zombies
-- if game.PlaceId == 2778230703 then
if game.GameId == 1003981402 then
	local RZTab = Window:CreateTab("Reminiscence Zombies", "gamepad-2")
	local RZESPSection = RZTab:CreateSection("ESP")

	local function getZombies()
		local zombies = game.Workspace:FindFirstChild("Zombies")
		return (zombies and zombies:GetChildren()) or {}
	end

	local function getBox()
		local interactions = game.Workspace:FindFirstChild("Interactions")
		return interactions and interactions:FindFirstChild("Mystery")
	end

	local function getPack()
		local interactions = game.Workspace:FindFirstChild("Interactions")
		return interactions and interactions:FindFirstChild("Pack-a-Punch")
	end

	local function getPowerups()
		local powerups = game.Workspace:FindFirstChild("Power-ups")
		return (powerups and powerups:GetChildren()) or {}
	end

	local function updateZombieESP(enabled)
		local zombies = getZombies()

		for i, v in pairs(zombies) do
			updateESP(v, Color3.fromRGB(255, 0, 255), enabled)
		end
	end

	local function updateBoxESP(enabled)
		local box = getBox()

		if box then
			updateESP(box, Color3.fromRGB(255, 255, 0), enabled)
		end
	end

	local function updatePowerupESP(enabled)
		local powerups = getPowerups()

		for i, v in pairs(powerups) do
			updateESP(v, Color3.fromRGB(107, 176, 255), enabled)
		end
	end

	local zombie_esp_toggled = true
	local RZZombieESPToggle = RZTab:CreateToggle({
		Name = "Zombie ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			zombie_esp_toggled = value
			updateZombieESP(value)
		end,
	})

	local box_esp_toggled = true
	local RZBoxESPToggle = RZTab:CreateToggle({
		Name = "Box ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			box_esp_toggled = value
			updateBoxESP(value)
		end,
	})

	local powerup_esp_toggled = true
	local RZPowerupESPToggle = RZTab:CreateToggle({
		Name = "Powerup ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			powerup_esp_toggled = value
			updatePowerupESP(value)
		end,
	})

	game:GetService("RunService").RenderStepped:Connect(function()
		if zombie_esp_toggled then
			updateZombieESP(zombie_esp_toggled)
		end

		if box_esp_toggled then
			updateBoxESP(box_esp_toggled)
		end

		if powerup_esp_toggled then
			updatePowerupESP(powerup_esp_toggled)
		end
	end)

	local RZUtilSection = RZTab:CreateSection("Utils")

	local RZGotoBoxKeybind = RZTab:CreateKeybind({
		Name = "TP to Box",
		CurrentKeybind = "X",
		HoldToInteract = false,
		Flag = "RZGotoBoxKeybind",
		Callback = function()
			local box = getBox()

			if box then
				local primary = box.PrimaryPart or box:FindFirstChildWhichIsA("BasePart")

				if primary then
					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")

					if root then
						root.CFrame = primary.CFrame
					end
				end
			end
		end,
	})

	local RZGotoPackKeybind = RZTab:CreateKeybind({
		Name = "TP to Pack",
		CurrentKeybind = "Z",
		HoldToInteract = false,
		Flag = "RZGotoPackKeybind",
		Callback = function()
			local pack = getPack()

			if pack then
				local primary = pack.PrimaryPart or pack:FindFirstChildWhichIsA("BasePart")

				if primary then
					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")

					if root then
						root.CFrame = primary.CFrame
					end
				end
			end
		end,
	})

	local rz_bring_zombies_toggled = true
	local RZBringZombiesToggle = RZTab:CreateToggle({
		Name = "Bring Zombies (Right Click)",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			rz_bring_zombies_toggled = value
		end,
	})
	task.spawn(function()
		local plr = game:GetService("Players").LocalPlayer
		local mouse = plr and plr:GetMouse()

		local doBring = false

		if mouse then
			mouse.Button2Down:Connect(function()
				doBring = true
			end)

			mouse.Button2Up:Connect(function()
				doBring = false
			end)
		end

		game:GetService("RunService").RenderStepped:Connect(function()
			if rz_bring_zombies_toggled and doBring then
				local zombies = getZombies()

				for i, v in pairs(zombies) do
					local root = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart

					if root then
						local plr = game:GetService("Players").LocalPlayer
						local char = plr and plr.Character
						local pRoot = char and char:FindFirstChild("HumanoidRootPart")

						if pRoot then
							root.CFrame = pRoot.CFrame * CFrame.new(0, 0, -5)
						end
					end
				end
			end
		end)
	end)

	local grab_powerups_toggled = true
	local RZGrabPowerups = RZTab:CreateToggle({
		Name = "Auto Grab Powerups",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			grab_powerups_toggled = value
		end,
	})

	game:GetService("RunService").RenderStepped:Connect(function()
		if grab_powerups_toggled then
			local powerups = getPowerups()

			for i, v in pairs(powerups) do
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")
				local primary = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")

				if primary and root then
					primary.CFrame = root.CFrame
				end
			end
		end
	end)

	-- local RZAimbotKeybind = RZTab:CreateKeybind({
	-- 	Name = "Aimbot Keybind",
	-- 	CurrentKeybind = "H",
	-- 	HoldToInteract = true,
	-- 	Flag = "RZAimbotKeybind",
	-- 	Callback = function(value)
	-- 		if value then
	-- 			local plr = game:GetService("Players").LocalPlayer
	-- 			local char = plr and plr.Character
	-- 			local root = char and char:FindFirstChild("HumanoidRootPart")
	-- 			local zombies = getZombies()

	-- 			local best = nil
	-- 			local best_dist = 99999999

	-- 			for i, v in pairs(zombies) do
	-- 				local ppart = v.PrimaryPart
	-- 				if ppart then
	-- 					local dist = dist3d(root.Position, ppart.Position)

	-- 					if dist < best_dist then
	-- 						best_dist = dist
	-- 						best = v
	-- 					end
	-- 				end
	-- 			end

	-- 			if best then
	-- 				local head = best:FindFirstChild("Head") or best.PrimaryPart
	-- 				if head then
	-- 					aimbotToPart(head, 0.01)
	-- 				end
	-- 			end
	-- 		end
	-- 	end,
	-- })
end

-- Zoo or Oof
if game.PlaceId == 139233844569220 then
	local ZOOTab = Window:CreateTab("ZOO or OOF", "gamepad-2")
	local ZOOESPSection = ZOOTab:CreateSection("ESP")

	local function updateAnimalESP(enabled)
		local gameplay = game.Workspace:FindFirstChild("Gameplay")
		local dynamic = gameplay and gameplay:FindFirstChild("Dynamic")
		local animals_ = dynamic and dynamic:FindFirstChild("Animals")
		local animals = animals_ and animals_:GetChildren()

		for i, v in pairs(animals) do
			updateESP(v, Color3.fromRGB(0, 128, 255), enabled)
		end
	end

	local zoo_esp_toggled = true
	local ZOOESPToggle = ZOOTab:CreateToggle({
		Name = "Animal ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			zoo_esp_toggled = value
			updateAnimalESP(value)
		end,
	})

	game:GetService("RunService").RenderStepped:Connect(function()
		if zoo_esp_toggled then
			updateAnimalESP(zoo_esp_toggled)
		end
	end)

	local ZOOFarmSection = ZOOTab:CreateSection("Farm")

	local function getTeam()
		local plr = game:GetService("Players").LocalPlayer
		return (plr and plr.Team) or { Name = "Not in game" }
	end

	local function isAnimal()
		return getTeam().Name == "Animal"
	end

	local function isKeeper()
		return getTeam().Name == "Keeper"
	end

	local function isInGame()
		return getTeam().Name ~= "Not in game"
	end

	local function getKeeper()
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Team.Name == "Keeper" then
				return v
			end
		end

		return nil
	end

	local zoo_farm_toggled = true
	local ZOOFarmToggle = ZOOTab:CreateToggle({
		Name = "Auto Farm",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			zoo_farm_toggled = value
		end,
	})
	task.spawn(function()
		local isInvis = false

		while task.wait() do
			if zoo_farm_toggled then
				if isInvis and not isInGame() then
					isInvis = false
				end

				if isAnimal() and not isInvis then
					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")

					if root then
						task.wait((isDev() and 1) or 2)
						root.CFrame = CFrame.new(1, 51, 224)
						task.wait(1)
						isInvis = true
					end
				end

				if isInvis then
					local keeper = getKeeper()

					if keeper then
						local plr = game:GetService("Players").LocalPlayer
						local char = plr and plr.Character
						local root = char and char:FindFirstChild("HumanoidRootPart")

						local kChar = keeper.Character
						local kRoot = kChar and kChar:FindFirstChild("HumanoidRootPart")

						if root and kRoot then
							root.CFrame = kRoot.CFrame
							local args = {
								[1] = "Taunt.play",
							}

							game:GetService("ReplicatedStorage").Net:FireServer(unpack(args))
						end
					end
				end
			else
				isInvis = false
			end
		end
	end)

	local function getClosestAnimal()
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		local plrs = game:GetService("Players"):GetPlayers()

		local best = nil
		local best_dist = 99999999

		for i, v in pairs(plrs) do
			local vChar = v.Character
			local vRoot = vChar and vChar:FindFirstChild("HumanoidRootPart")

			if vRoot and root then
				local dist = dist3d(root.Position, vRoot.Position)

				if dist < best_dist and v ~= plr and v.Team.Name == "Animal" then
					best_dist = dist
					best = v
				end
			end
		end

		return best
	end

	local function getPlayersAnimal(plr)
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if root then
			local gameplay = game.Workspace:FindFirstChild("Gameplay")
			local dynamic = gameplay and gameplay:FindFirstChild("Dynamic")
			local animals_ = dynamic and dynamic:FindFirstChild("Animals")
			local animals = animals_ and animals_:GetChildren()

			if animals then
				local best = nil
				local best_dist = 99999999

				for i, v in pairs(animals) do
					local rootPart = v.PrimaryPart
					if rootPart then
						local dist = dist3d(root.Position, rootPart.Position)

						if dist < best_dist then
							best_dist = dist
							best = v
						end
					end
				end

				return best
			end
		end

		return nil
	end

	local auto_kill_toggled = true
	local ZOOAutoKillToggle = ZOOTab:CreateToggle({
		Name = "Auto Kill",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			auto_kill_toggled = value
		end,
	})
	task.spawn(function()
		while task.wait() do
			if isKeeper() and auto_kill_toggled then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				local closestAnimal = getClosestAnimal()

				if closestAnimal and root then
					local bAnimal = getPlayersAnimal(closestAnimal)
					local bRoot = bAnimal and bAnimal.PrimaryPart

					if bRoot then
						local args = {
							[1] = "Shooting.shotPlayer",
							[2] = root.CFrame,
							[3] = bRoot.CFrame,
							[4] = closestAnimal,
							[5] = bRoot,
							[6] = CFrame.new(0.8038291931152344, 0.09816551208496094, -0.000888824462890625)
								* CFrame.Angles(3.1407759189605713, 1.3910810947418213, 3.129187822341919),
						}

						game:GetService("ReplicatedStorage").Net:FireServer(unpack(args))
					end
				end
			end
		end
	end)
end

-- Murder Mystery 2

if game.PlaceId == 142823291 then
	local function plrHasItem(player, item)
		local pBackpack = player:FindFirstChild("Backpack")
		local pChar = player.Character

		local itemBackpack = pBackpack and pBackpack:FindFirstChild(item)
		local itemPlayer = pChar and pChar:FindFirstChild(item)

		if itemBackpack or itemPlayer then
			return true
		end

		return false
	end

	local function plrHasKnife(player)
		return plrHasItem(player, "Knife")
	end

	local function plrHasGun(player)
		return plrHasItem(player, "Gun")
	end

	local murderer = nil
	local sheriff = nil

	task.spawn(function()
		game:GetService("ReplicatedStorage")
			:WaitForChild("Remotes")
			:WaitForChild("Gameplay")
			:WaitForChild("PlayerDataChanged").OnClientEvent
			:Connect(function(data)
				murderer = nil
				sheriff = nil

				for k, v in pairs(data) do
					local plr = game:GetService("Players"):FindFirstChild(k)

					for vk, vv in pairs(v) do
						if vk == "Role" then
							if vv == "Murderer" then
								-- is murderer
								murderer = plr
							end

							if vv == "Sheriff" then
								-- is sheriff
								sheriff = plr
							end
						end
					end
				end
			end)

		game:GetService("ReplicatedStorage")
			:WaitForChild("Remotes")
			:WaitForChild("Gameplay")
			:WaitForChild("RoundEndFade").OnClientEvent
			:Connect(function(data)
				murderer = nil
				sheriff = nil
			end)
	end)

	local function getMurderer()
		if not murderer then
			-- local murderer = nil
			for i, plr in pairs(game:GetService("Players"):GetPlayers()) do
				if plrHasKnife(plr) then
					murderer = plr
					break
				end
			end
		end

		return murderer
	end

	local function getSheriff()
		-- local sheriff = nil

		if not sheriff then
			for i, plr in pairs(game:GetService("Players"):GetPlayers()) do
				if plrHasGun(plr) then
					sheriff = plr
					break
				end
			end
		end

		return sheriff
	end

	local function shootPos(pos)
		local plr = game:GetService("Players").LocalPlayer

		if plrHasGun(plr) then
			local char = plr and plr.Character
			local gun = char and char:FindFirstChild("Gun")
			local shoot = gun and gun:FindFirstChild("Shoot")
			local handle = gun and gun:FindFirstChild("Handle")

			if shoot and handle then
				-- shoot:FireServer(handle.CFrame, cf)
				shoot:FireServer(handle.CFrame, CFrame.new(pos))
			end
		end
	end

	local function shootPlayer(plr)
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local hum = char and char:FindFirstChildWhichIsA("Humanoid")

		if root then
			local latency = game:GetService("Players").LocalPlayer:GetNetworkPing() / 2
			local tVel = root.AssemblyLinearVelocity
			local tMov = hum and (hum.MoveDirection * hum.WalkSpeed)
			tVel = tVel:Lerp(tMov, 0.5)
			local tPos = root.Position + (tVel * latency)

			shootPos(tPos)
		end
	end

	local function tpShoot(other)
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		local otherChar = other and other.Character
		local otherRoot = otherChar and otherChar:FindFirstChild("HumanoidRootPart")

		local latency = plr:GetNetworkPing()
		if root and otherRoot then
			local pos = root.CFrame
			task.wait(0.1)

			root.CFrame = otherRoot.CFrame

			task.wait(latency)

			shootPlayer(other)

			task.wait(latency)

			root.CFrame = pos
		end
	end

	local MMTab = Window:CreateTab("Murder Mystery 2", "gamepad-2")
	local MMESPSection = MMTab:CreateSection("ESP")

	local function updatePlayerESP(enabled)
		local murderer = getMurderer()
		local sheriff = getSheriff()

		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			local char = v.Character
			if char and v ~= game:GetService("Players").LocalPlayer then
				local isMurderer = v == murderer
				local isSheriff = v == sheriff

				if isSheriff then
					updateESP(char, Color3.fromRGB(0, 0, 255), enabled)
				elseif isMurderer then
					updateESP(char, Color3.fromRGB(255, 0, 0), enabled)
				else
					updateESP(char, Color3.fromRGB(0, 255, 0), enabled)
				end
			end
		end
	end

	local mm_player_esp_toggled = true
	local MMPlayerEspToggle = MMTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			mm_player_esp_toggled = value
			updatePlayerESP(value)
		end,
	})
	game:GetService("RunService").RenderStepped:Connect(function()
		if mm_player_esp_toggled then
			updatePlayerESP(mm_player_esp_toggled)
		end
	end)

	local function updateCoinESP(enabled)
		local coins = game.Workspace:FindFirstChild("CoinContainer", true)

		if coins then
			for i, v in pairs(coins:GetChildren()) do
				-- if v.Name == "Coin_Server" then
				-- 	updateESP(v, Color3.fromRGB(255, 200, 0), enabled)
				-- end
				if v.Name == "CollectedCoin" then
					v:Destroy()
				end
			end

			updateESP(coins, Color3.fromRGB(255, 200, 0), enabled)
		end
	end

	local mm_coin_esp_toggled = true
	local MMCoinEspToggle = MMTab:CreateToggle({
		Name = "Coin ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			mm_coin_esp_toggled = value
			updateCoinESP(value)
		end,
	})
	game:GetService("RunService").RenderStepped:Connect(function()
		if mm_coin_esp_toggled then
			updateCoinESP(mm_coin_esp_toggled)
		end
	end)

	local MMUtilsSection = MMTab:CreateSection("Utils")

	local MMKillAllButton = MMTab:CreateButton({
		Name = "Kill All (Murderer)",
		Callback = function()
			local plr = game:GetService("Players").LocalPlayer
			local char = plr and plr.Character
			local hum = char and char:FindFirstChild("Humanoid")
			local root = char and char:FindFirstChild("HumanoidRootPart")

			if hum then
				local backpack = plr:FindFirstChild("Backpack")
				local knifeBackpack = backpack and backpack:FindFirstChild("Knife")

				if knifeBackpack then
					hum:EquipTool(knifeBackpack)
					task.wait()
				end

				local knifePlayer = plr.Character:FindFirstChild("Knife")

				if knifePlayer then
					task.spawn(function()
						local running = true
						task.spawn(function()
							task.wait(1)
							running = false
						end)
						while running do
							for i, v in pairs(game:GetService("Players"):GetPlayers()) do
								local pChar = v.Character
								local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")

								if pChar and v ~= game:GetService("Players").LocalPlayer then
									pRoot.CFrame = root.CFrame * CFrame.new(0, 0, -3)
								end
							end

							task.wait()
						end
					end)

					task.wait()

					knifePlayer:Activate()
				end
			end
		end,
	})

	local MMShootMurdererKeybind = MMTab:CreateKeybind({
		Name = "Shoot Murderer",
		CurrentKeybind = "G",
		HoldToInteract = false,
		Flag = "MMShootMurdererKeybind",
		Callback = function()
			local murderer = getMurderer()
			if murderer then
				tpShoot(murderer)
			end
		end,
	})

	local mm_grab_gun_toggled = true
	local MMGrabGunToggle = MMTab:CreateToggle({
		Name = "Auto Grab Gun",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			mm_grab_gun_toggled = value
		end,
	})
	task.spawn(function()
		local pickupGun = true

		while task.wait() do
			if mm_grab_gun_toggled then
				local gun = game.Workspace:FindFirstChild("GunDrop", true)

				if not gun and not pickupGun then
					pickupGun = true
				end

				if gun and pickupGun then
					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")
					local pos = root and root.CFrame

					if root then
						task.wait(1)
						root.CFrame = gun.CFrame
						task.wait(0.2)
						root.CFrame = pos
					end

					pickupGun = false
				end
			end
		end
	end)

	local function flingMurderer()
		local murderer = getMurderer()

		if murderer and murderer ~= game:GetService("Players").LocalPlayer then
			flingPlayer(murderer)
		end
	end

	local MMFlingMurdererButton = MMTab:CreateButton({
		Name = "Fling Murderer",
		Callback = function()
			flingMurderer()
		end,
	})

	local mm_auto_fling_murderer_toggled = false
	local MMAutoFlingMurdererToggle = MMTab:CreateToggle({
		Name = "Auto Fling Murderer",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			mm_auto_fling_murderer_toggled = value
		end,
	})
	task.spawn(function()
		while task.wait() do
			if mm_auto_fling_murderer_toggled then
				local murderer = getMurderer()

				if murderer then
					flingMurderer()
					task.wait(4)
				end
			end
		end
	end)

	local mm_collect_coin_toggled = false
	local MMCollectCoinToggle = MMTab:CreateToggle({
		Name = "Collect Coins",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			mm_collect_coin_toggled = value
		end,
	})
	task.spawn(function()
		while task.wait() do
			if mm_collect_coin_toggled and not safeTweening then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if root then
					local coins = game.Workspace:FindFirstChild("CoinContainer", true)

					if coins then
						local best = nil
						local best_dist = 99999999

						for i, v in pairs(coins:GetChildren()) do
							if v.Name == "Coin_Server" then
								local dist = dist3d(root.Position, v.Position)
								if dist < best_dist then
									best_dist = dist
									best = v
								end
							end
						end

						if best then
							safeTweenToPart(best)
						end
					end
				end
			end
		end
	end)
end

-- Agoraphobia

if game.GameId == 7585283196 then
	local AGTab = Window:CreateTab("Agoraphobia", "gamepad-2")
	local AGESPSection = AGTab:CreateSection("ESP")

	local function getMap()
		local map = game.Workspace:FindFirstChild("Map")
		return map
	end

	local function getFunctionals()
		local map = getMap()
		local funcs = map and map:FindFirstChild("Functionals")
		return funcs
	end

	local function getComputers()
		local funcs = getFunctionals()
		local comps = funcs and funcs:FindFirstChild("Computers")
		if comps then
			return comps:GetChildren()
		else
			return {}
		end
	end

	local function getComputerModel(pc)
		local model = pc and pc:FindFirstChild("ComputerModel")
		return model
	end

	local function getComputerScreen(pc)
		local screen = pc and pc:FindFirstChild("Screen")
		return screen
	end

	local function getComputerColor(pc)
		local screen = getComputerScreen(pc)
		local color = (screen and screen.Color) or Color3.fromRGB(0, 0, 255)
		return color
	end

	local function getBeasts()
		local beasts = game.Workspace:FindFirstChild("Beasts")
		if beasts then
			return beasts:GetChildren()
		else
			return {}
		end
	end

	local function getSurvivors()
		local survs = game.Workspace:FindFirstChild("Survivors")
		if survs then
			return survs:GetChildren()
		else
			return {}
		end
	end

	local player_esp_toggled = true

	local function updateSurvivorESP()
		local survs = getSurvivors()
		for i, v in pairs(survs) do
			updateESP(v, Color3.fromRGB(0, 255, 0), player_esp_toggled)
		end
	end

	local function updateBeastESP()
		local beasts = getBeasts()
		for i, v in pairs(beasts) do
			updateESP(v, Color3.fromRGB(255, 0, 0), player_esp_toggled)
		end
	end

	local function updatePlayerESP()
		updateSurvivorESP()
		updateBeastESP()
	end

	local computer_esp_toggled = true

	local function updateComputerESP()
		local comps = getComputers()

		for i, v in pairs(comps) do
			local model = getComputerModel(v)
			local color = getComputerColor(v)
			if model then
				updateESP(model, color, computer_esp_toggled)
			end
		end
	end

	local AGESPToggle = AGTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			player_esp_toggled = value
			updatePlayerESP()
		end,
	})

	local AGPCESPToggle = AGTab:CreateToggle({
		Name = "Computer ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			computer_esp_toggled = value
			updateComputerESP()
		end,
	})

	task.spawn(function()
		while task.wait(1) do
			updatePlayerESP()
			updateComputerESP()
		end

		updatePlayerESP()
		updateComputerESP()
	end)
end

-- Flee The Facility

if game.GameId == 372226183 then
	local FTFEspTab = Window:CreateTab("ESP")

	local beast_esp_toggled = true
	function UpdateBeastESP()
		for i, v in pairs(game.Players:GetPlayers()) do
			if v.Character and v.Character:FindFirstChild("BeastPowers") and v ~= game.Players.LocalPlayer then
				updateESP(v.Character, Color3.fromRGB(255, 0, 0), beast_esp_toggled)
			end
		end
	end

	local FTFBeastEspToggle = FTFEspTab:CreateToggle({
		Name = "Beast ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			beast_esp_toggled = value
			UpdateBeastESP()
		end,
	})

	local player_esp_toggled = true
	function UpdatePlrESP()
		for i, v in pairs(game.Players:GetPlayers()) do
			if v.Character and not v.Character:FindFirstChild("BeastPowers") and v ~= game.Players.LocalPlayer then
				updateESP(v.Character, Color3.fromRGB(0, 255, 0), player_esp_toggled)
			end
		end
	end

	local FTFPlayerEspToggle = FTFEspTab:CreateToggle({
		Name = "Player ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			player_esp_toggled = value
			UpdatePlrESP()
		end,
	})

	local function getCurrentMap()
		for i, v in pairs(game.Workspace:GetChildren()) do
			if v:FindFirstChild("ComputerTable") then
				return v
			end
		end

		return nil
	end

	local function getCurrentMapChildren()
		local map = getCurrentMap()
		if not map then
			return {}
		end

		return map:GetChildren()
	end

	local function getExits()
		local exits = {}
		local map = getCurrentMapChildren()

		for i, v in pairs(map) do
			if v.Name == "ExitDoor" then
				table.insert(exits, v)
			end
		end

		return exits
	end

	local function getExitArea(exit)
		local area = exit:FindFirstChild("ExitArea")
		return area
	end

	local function getExitTrigger(exit)
		local trigger = exit:FindFirstChild("ExitDoorTrigger")
		return trigger
	end

	task.spawn(function()
		while task.wait(1) do
			for i, v in pairs(getExits()) do
				local trigger = getExitTrigger(v)
				if trigger then
					trigger.Size = Vector3.new(20, 20, 20)
				end
			end
		end
	end)

	local function exitNeedsToOpen(exit)
		local trigger = getExitTrigger(exit)
		local value = trigger and trigger:FindFirstChild("ActionSign")

		if value then
			return value.Value ~= 0
		end

		return false
	end

	local function exitIsOpen(exit)
		local trigger = getExitTrigger(exit)

		if not trigger then
			return true
		end

		return false
	end

	local function getClosestClosedExit()
		local exits = getExits()
		local closed_exits = {}

		for i, v in pairs(exits) do
			if not exitIsOpen(v) and exitNeedsToOpen(v) then
				table.insert(closed_exits, v)
			end
		end

		local best = nil
		local best_dist = 99999999

		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if root then
			for i, v in pairs(closed_exits) do
				local trigger = getExitTrigger(v)
				local dist = dist3d(trigger.Position, root.Position)
				if dist < best_dist then
					best_dist = dist
					best = v
				end
			end
		end

		return best
	end

	local function findOpenExit()
		local open_exits = {}

		for i, v in pairs(getExits()) do
			if exitIsOpen(v) then
				table.insert(open_exits, v)
			end
		end

		local best = nil
		local best_dist = 99999999

		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if root then
			for i, v in pairs(open_exits) do
				local area = getExitArea(v)
				local dist = dist3d(area.Position, root.Position)

				if dist < best_dist then
					best_dist = dist
					best = v
				end
			end
		end

		return best
	end

	local function findBeast()
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if
				v.Character
				and v.Character:FindFirstChild("BeastPowers")
				and v ~= game:GetService("Players").LocalPlayer
			then
				return v
			end
		end

		return nil
	end

	local function findBeastIncludingLocal()
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.Character and v.Character:FindFirstChild("BeastPowers") then
				return v
			end
		end

		return nil
	end

	local function getHammer()
		local beast = findBeastIncludingLocal()
		local char = beast and beast.Character
		local hammer = char and char:FindFirstChild("Hammer")

		return hammer
	end

	local function getHammerHandle()
		local beast = findBeast()
		local char = beast and beast.Character
		local hammer = char and char:FindFirstChild("Hammer")
		local handle = hammer and hammer:FindFirstChild("Handle")

		return handle
	end

	local function getHammerEvent()
		local hammer = getHammer()

		if hammer then
			return hammer:FindFirstChild("HammerEvent")
		end

		return nil
	end

	local function getChaseMusic()
		local handle = getHammerHandle()
		local music = handle and handle:FindFirstChild("SoundChaseMusic")

		return music
	end

	local defaultChaseMusicVolume = 0.4
	local chaseMusicVolume = 0.4

	task.spawn(function()
		while task.wait() do
			local music = getChaseMusic()

			if music then
				music.Volume = chaseMusicVolume
			end
		end
	end)

	local function updateChaseVolume(value)
		chaseMusicVolume = value
	end

	local function isGameActive()
		return game.ReplicatedStorage.IsGameActive.Value and game.ReplicatedStorage.GameTimer.Value ~= 0
	end

	local function isBeast()
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character

		if isGameActive() and char then
			task.wait()
			return char:FindFirstChild("BeastPowers")
		end

		return false
	end

	local function getDistToBeast()
		local beast = findBeast()
		local beastChar = beast and beast.Character
		local beastRoot = beastChar and beastChar:FindFirstChild("HumanoidRootPart")

		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if beastRoot and root then
			return dist3d(root.Position, beastRoot.Position)
		end

		return 99999999
	end

	local function getActivePlayers()
		local players = {}

		local plr = game:GetService("Players").LocalPlayer
		local pgui = plr and plr:FindFirstChild("PlayerGui")
		local sgui = pgui and pgui:FindFirstChild("ScreenGui")
		local sbars = sgui and sgui:FindFirstChild("StatusBars")

		local bars = sbars and sbars:GetChildren()

		if bars then
			for i, v in pairs(bars) do
				if v:IsA("TextLabel") and v.TextColor3 == Color3.fromRGB(255, 255, 255) then
					local name = v.ContentText
					local player = game:GetService("Players"):FindFirstChild(name)

					if player then
						table.insert(players, player)
					end
				end
			end
		end

		return players
	end

	local function getStats(plr)
		local stats = plr and plr:FindFirstChild("TempPlayerStatsModule")
		return stats
	end

	local function isPlayerCaptured(plr)
		local stats = getStats(plr)
		local cap = stats and stats:FindFirstChild("Captured")
		if cap then
			return cap.Value
		end

		return false
	end

	local function getCapturablePlayers()
		local players = {}

		local plr = game:GetService("Players").LocalPlayer

		for i, v in pairs(getActivePlayers()) do
			if v ~= plr then
				if not isPlayerCaptured(v) then
					table.insert(players, v)
				end
			end
		end

		return players
	end

	local function teleportToNearestFreezePod()
		local best_pod
		local best_pod_dist = 99999999

		local char = game:GetService("Players").LocalPlayer.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		local plrPos = root and root.Position

		for i, v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "FreezePod" then
				local pod = v:FindFirstChild("PodTrigger")
				if pod then
					local capturedTorsoValue = pod:FindFirstChild("CapturedTorso")

					if capturedTorsoValue.Value == nil then
						local dist = dist3d(plrPos, pod.Position)
						if dist < best_pod_dist and dist > 20 then
							best_pod = pod
							best_pod_dist = dist
						end
					end
				end
			end
		end

		enableNoclip()
		root.CFrame = best_pod.CFrame
		task.delay(1, disableNoclip)
	end

	local function isInGame()
		local plr = game:GetService("Players").LocalPlayer
		local players = getActivePlayers()

		if plr and players then
			for i, v in pairs(players) do
				if v == plr then
					return true
				end
			end
		end

		return false
	end

	local function partCloseToModel(part, model, ddist)
		local base = nil
		if model.PrimaryPart then
			base = model.PrimaryPart
		else
			local d = model:GetDescendants()
			for i, v in pairs(d) do
				if v:IsA("BasePart") then
					base = v
					break
				end
			end
		end

		if part and base then
			local dist = dist3d(part.Position, base.Position)
			return dist <= ddist
		end

		return false
	end

	local function isCloseToModel(model, ddist)
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		return partCloseToModel(root, model, ddist)
	end

	local function partCloseToModelName(part, name, ddist)
		for i, v in pairs(getCurrentMapChildren()) do
			if v.Name == name then
				if partCloseToModel(part, v, ddist) then
					return true, v
				end
			end
		end

		return false, nil
	end

	local function isCloseToModelName(name, ddist)
		for i, v in pairs(getCurrentMapChildren()) do
			if v.Name == name then
				if isCloseToModel(v, ddist) then
					return true, v
				end
			end
		end

		return false, nil
	end

	local function partCloseToComputer(part)
		return partCloseToModelName(part, "ComputerTable", 20)
	end

	local function isCloseToComputer()
		return isCloseToModelName("ComputerTable", 8.5)
	end

	local function isCloseToFreezePod()
		return isCloseToModelName("FreezePod", 10)
	end

	local function isCloseToExit()
		return isCloseToModelName("ExitDoor", 20)
	end

	local function getLockers()
		return game:GetService("CollectionService"):GetTagged("LOCKER")
	end

	local function findNearestLocker()
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		if root then
			local best = nil
			local best_dist = 999999999

			for i, v in pairs(getLockers()) do
				local part = v:FindFirstChildOfClass("Part")
				if part then
					local dist = dist3d(root.Position, part.Position)

					if dist < best_dist then
						best_dist = dist
						best = v
					end
				end
			end

			return best
		end

		return nil
	end

	local function getCurrentPower()
		local v = game:GetService("ReplicatedStorage"):FindFirstChild("CurrentPower")
		if v then
			return v.Value
		end
		return ""
	end

	local function isPowerActive()
		local v = game:GetService("ReplicatedStorage"):FindFirstChild("PowerActive")
		if v then
			return v.Value
		end
		return false
	end

	local function isSeerActive()
		local isSeer = getCurrentPower() == "Seer"
		return isSeer and isPowerActive()
	end

	local computer_esp_toggled = true
	local function updatePCESP()
		for _, v in pairs(getCurrentMapChildren()) do
			if v.Name == "ComputerTable" and v:FindFirstChild("Screen") then
				updateESP(v, v.Screen.Color, computer_esp_toggled)
			end
		end
	end

	local FTFPCEspToggle = FTFEspTab:CreateToggle({
		Name = "Computer ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			computer_esp_toggled = value
			updatePCESP()
		end,
	})

	local locker_esp_toggled = true
	local function updateLockerESP()
		local lockers = getLockers()
		for i, v in pairs(lockers) do
			updateESP(v, Color3.fromRGB(255, 255, 0), locker_esp_toggled)
		end
	end

	local FTFLockerEspToggle = FTFEspTab:CreateToggle({
		Name = "Locker ESP",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			locker_esp_toggled = value
			updateLockerESP()
		end,
	})

	task.spawn(function()
		while task.wait(1) do
			UpdateBeastESP()
			UpdatePlrESP()
			updatePCESP()
			updateLockerESP()
		end

		UpdateBeastESP()
		UpdatePlrESP()
		updatePCESP()
		updateLockerESP()
	end)

	-- task.spawn(function()
	-- 	while task.wait() do
	-- 		local plr = game:GetService("Players").LocalPlayer
	-- 		local char = plr and plr.Character
	-- 		local hum = char and char:FindFirstChildWhichIsA("Humanoid")

	-- 		if hum then
	-- 			hum.PlatformStand = false
	-- 			hum.JumpPower = 36
	-- 		end

	-- 		if plr then
	-- 			local stats = plr:FindFirstChild("TempPlayerStatsModule")
	-- 			local ragdoll = stats and stats:FindFirstChild("Ragdoll")
	-- 			if ragdoll then
	-- 				ragdoll.Value = false
	-- 			end
	-- 		end
	-- 	end
	-- end)

	local FTFUtilsTab = Window:CreateTab("Utils")

	local FTFFlingBeast = FTFUtilsTab:CreateButton({
		Name = "Fling Beast",
		Callback = function()
			local beast = findBeast()
			if beast then
				flingPlayer(beast)
			end
		end,
	})

	local slow_beast_toggled = false
	local FTFSlowBeast = FTFUtilsTab:CreateToggle({
		Name = "Slow Beast",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			slow_beast_toggled = value
		end,
	})

	local untie_toggled = false
	local FTFUntie = FTFUtilsTab:CreateToggle({
		Name = "Make Beast Untie",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			untie_toggled = value
		end,
	})

	local auto_hide_toggled = isDev()
	local FTFAutoHideToggle = FTFUtilsTab:CreateToggle({
		Name = "Auto Hide (Seer)",
		CurrentValue = auto_hide_toggled,
		Flag = nil,
		Callback = function(value)
			auto_hide_toggled = value
		end,
	})

	task.spawn(function()
		local hiding = false
		while task.wait() do
			if hiding then
				task.wait(2)
				hiding = false
				task.wait(5)
			end
			if auto_hide_toggled and isSeerActive() and isInGame() then
				local locker = findNearestLocker()
				local center = locker and locker:GetBoundingBox()
				if center then
					task.wait(2.5)
					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")
					if root then
						root.CFrame = center
						hiding = true
					end
				end
			end
		end
	end)

	local ftf_auto_save_toggled = false
	local FTFAutoSaveToggle = FTFUtilsTab:CreateToggle({
		Name = "Auto Save",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			ftf_auto_save_toggled = value
		end,
	})

	local ftf_auto_saving = false
	task.spawn(function()
		while task.wait() do
			if ftf_auto_save_toggled and isInGame() and not isBeast() then
				local children = getCurrentMapChildren()

				for i, v in pairs(children) do
					if v.Name == "FreezePod" then
						local pod = v:FindFirstChild("PodTrigger")

						if pod then
							local capturedTorsoValue = pod:FindFirstChild("CapturedTorso")
							if capturedTorsoValue.Value ~= nil then
								local event = pod:FindFirstChild("Event")

								if event then
									task.spawn(function()
										local RemoteEvent = game:GetService("ReplicatedStorage").RemoteEvent
										RemoteEvent:FireServer("Input", "Trigger", true, event)
										RemoteEvent:FireServer("Input", "Action", true)
										task.wait(1)
										RemoteEvent:FireServer("Input", "Trigger", false, event)
										RemoteEvent:FireServer("Input", "Action", false)
									end)
								end
							end
						end
					end
				end
			end
		end
	end)

	local auto_tie_toggled = true
	local FTFAutoTie = FTFUtilsTab:CreateToggle({
		Name = "Auto Tie",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			auto_tie_toggled = value
		end,
	})

	local auto_hit_toggled = isDev()
	local FTFAutoHit = FTFUtilsTab:CreateToggle({
		Name = "Auto Hit",
		CurrentValue = auto_hit_toggled,
		Flag = nil,
		Callback = function(value)
			auto_hit_toggled = value
		end,
	})

	local auto_beast_toggled = isDev()
	local FTFAutoBeast = FTFUtilsTab:CreateToggle({
		Name = "Auto Beast",
		CurrentValue = auto_beast_toggled,
		Flag = nil,
		Callback = function(value)
			auto_beast_toggled = value
		end,
	})

	local function GetCurrentBeastPEvent()
		local beast = findBeast()
		local beastChar = beast and beast.Character
		local powers = beastChar and beastChar:FindFirstChild("BeastPowers")
		local event = powers and powers:FindFirstChild("PowersEvent")
		return event
	end

	local function GetCurrentBeastHEvent()
		local beast = findBeast()
		local beastChar = beast and beast.Character
		local hammer = beastChar and beastChar:FindFirstChild("Hammer")
		local event = hammer and hammer:FindFirstChild("HammerEvent")
		return event
	end

	task.spawn(function()
		while task.wait() do
			if slow_beast_toggled then
				local event = GetCurrentBeastPEvent()
				if event then
					event:FireServer("Jumped")
				end
			end
		end
	end)

	task.spawn(function()
		while task.wait() do
			if untie_toggled then
				local event = GetCurrentBeastHEvent()
				if event then
					event:FireServer("HammerClick", true)
				end
			end
		end
	end)

	task.spawn(function()
		while task.wait() do
			if auto_tie_toggled then
				local hammerEvent = getHammerEvent()
				local plr = game:GetService("Players").LocalPlayer
				local p_char = plr and plr.Character
				local p_root = p_char and p_char:FindFirstChild("HumanoidRootPart")

				for _, p in pairs(game:GetService("Players"):GetPlayers()) do
					if p ~= plr and not isFriendsWith(p) then
						local Stats = p:FindFirstChild("TempPlayerStatsModule")
						if not Stats then
							continue
						end

						local PisRagdoll, PisCaptured =
							Stats:FindFirstChild("Ragdoll"), Stats:FindFirstChild("Captured")

						if not (PisRagdoll and PisCaptured) then
							continue
						end

						if PisRagdoll.Value and not PisCaptured.Value then
							local root = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
							if root and p_char and p_root and hammerEvent then
								if (root.Position - p_root.Position).Magnitude <= 15 then
									local pos = root.Position
									hammerEvent:FireServer("HammerTieUp", root, pos)
								end
							end
						end
					end
				end
			end
		end
	end)

	task.spawn(function()
		while task.wait() do
			if auto_hit_toggled then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local lroot = char and char:FindFirstChild("HumanoidRootPart")
				local event = char and char:FindFirstChild("HammerEvent", true)
				for _, p in pairs(game:GetService("Players"):GetPlayers()) do
					if p ~= plr and not isFriendsWith(p) then
						local Stats = p:FindFirstChild("TempPlayerStatsModule")
						if not Stats then
							continue
						end

						local PisRagdoll, PisCaptured =
							Stats:FindFirstChild("Ragdoll"), Stats:FindFirstChild("Captured")
						if not (PisRagdoll and PisCaptured) then
							continue
						end

						if not (PisRagdoll.Value or PisCaptured.Value) then
							local root = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
							if root and char and lroot and event then
								if (root.Position - lroot.Position).Magnitude <= 15 then
									event:FireServer("HammerHit", root)
								end
							end
						end
					end
				end
			end
		end
	end)

	task.spawn(function()
		while task.wait() do
			if auto_beast_toggled and isBeast() then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if root then
					local players = getCapturablePlayers()
					for i, v in pairs(players) do
						local pChar = v and v.Character
						local pRoot = pChar and pChar:FindFirstChild("HumanoidRootPart")
						if pRoot and root and not isFriendsWith(v) then
							root.CFrame = pRoot.CFrame
							task.wait(0.5)
							teleportToNearestFreezePod()
							task.wait(0.5)
						end
					end
				end
			end
		end
	end)

	local no_errors_toggled = true
	local FTFNoErrorToggle = FTFUtilsTab:CreateToggle({
		Name = "No Errors",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			no_errors_toggled = value
		end,
	})

	local no_fog_toggled = true
	local FTFNoFogToggle = FTFUtilsTab:CreateToggle({
		Name = "No Fog",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			no_fog_toggled = value
		end,
	})

	local better_cam_toggled = true
	local FTFBetterCamToggle = FTFUtilsTab:CreateToggle({
		Name = "Better Camera",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			better_cam_toggled = value
		end,
	})

	local avoid_beast_toggled = false
	local FTFAvoidBeastToggle = FTFUtilsTab:CreateToggle({
		Name = "Avoid Beast",
		CurrentValue = avoid_beast_toggled,
		Flag = nil,
		Callback = function(value)
			avoid_beast_toggled = value
		end,
	})

	local auto_exit_toggled = false
	local FTFAutoExitToggle = FTFUtilsTab:CreateToggle({
		Name = "Auto Exit",
		CurrentValue = auto_exit_toggled,
		Flag = nil,
		Callback = function(value)
			auto_exit_toggled = value
		end,
	})

	task.spawn(function()
		local teleported = false

		while task.wait(1) do
			if teleported and not isCloseToExit() then
				task.wait(10)
				teleported = false
			end
			if auto_exit_toggled and isInGame() and not isBeast() and not teleported then
				local exit = findOpenExit()

				if exit then
					local area = getExitArea(exit)

					local plr = game:GetService("Players").LocalPlayer
					local char = plr and plr.Character
					local root = char and char:FindFirstChild("HumanoidRootPart")

					if root then
						root.CFrame = area.CFrame
						teleported = true
					end
				end
			end
		end
	end)

	local auto_open_exit_toggled = false
	local FTFAutoOpenExitToggle = FTFUtilsTab:CreateToggle({
		Name = "Auto Open Exit",
		CurrentValue = auto_open_exit_toggled,
		Flag = nil,
		Callback = function(value)
			auto_open_exit_toggled = value
		end,
	})

	task.spawn(function()
		local teleported = false
		while task.wait() do
			if teleported and not isCloseToExit() then
				task.wait(10)
				teleported = false
			end
			if auto_open_exit_toggled and isInGame() and not isBeast() and not teleported then
				local openExit = findOpenExit()
				if openExit then
					return
				end

				local exit = getClosestClosedExit()

				if exit then
					local trigger = getExitTrigger(exit)

					if trigger then
						local plr = game:GetService("Players").LocalPlayer
						local char = plr and plr.Character
						local root = char and char:FindFirstChild("HumanoidRootPart")

						if root then
							root.CFrame = trigger.CFrame
							teleported = true
						end
					end
				end
			end
		end
	end)

	local function clickHammer()
		local hammerEvent = getHammerEvent()

		if hammerEvent then
			hammerEvent:FireServer("HammerClick", true)
		end
	end

	local function hitCharacter(char)
		local hammerEvent = getHammerEvent()
		local torso = char and char:FindFirstChild("HumanoidRootPart")

		if torso and hammerEvent then
			hammerEvent:FireServer("HammerHit", torso)
		end
	end

	local function hitPlayer(plr)
		local char = plr and plr.Character
		hitCharacter(char)
	end

	local function tieCharacter(char)
		local hammerEvent = getHammerEvent()
		local torso = char and char:FindFirstChild("Torso")

		if torso and hammerEvent then
			clickHammer()
			task.wait()
			hammerEvent:FireServer("HammerTieUp", torso, torso.Position)
		end
	end

	local function tiePlayer(plr)
		local char = plr and plr.Character
		tieCharacter(char)
	end

	local function hitAndTiePlayer(plr)
		hitPlayer(plr)
		task.wait(0.5)
		tiePlayer(plr)
	end

	local function tpToPlayerIfSafe(plr)
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		local myPlr = game:GetService("Players").LocalPlayer
		local myChar = myPlr and myPlr.Character
		local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

		if root and myRoot then
			if not partCloseToComputer(root) then
				myRoot.CFrame = root.CFrame
				task.wait(0.2)
				return true
			else
				safeTweenToPart(root)
				while safeTweening do
					task.wait()
				end
				return true
			end
		end

		return false
	end

	local function tpHitAndTie(plr)
		local hammer = getHammer()

		if hammer then
			task.spawn(function()
				local success = tpToPlayerIfSafe(plr)
				if success then
					hitAndTiePlayer(plr)
				end
			end)
		end
	end

	local computerUnhacked = Color3.fromRGB(13, 105, 172)
	local computerErrored = Color3.fromRGB(196, 40, 28)
	local function getClosestComputer(includeHacked)
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")

		local best = nil
		local best_dist = 99999999

		if root then
			for i, v in pairs(getCurrentMapChildren()) do
				if v.Name == "ComputerTable" then
					local base = v.PrimaryPart

					if base then
						local dist = dist3d(root.Position, base.Position)

						if includeHacked then
							if dist < best_dist then
								best_dist = dist
								best = v
							end
						else
							local screen = v:FindFirstChild("Screen")
							if screen and (screen.Color == computerUnhacked or screen.Color == computerErrored) then
								if dist < best_dist then
									best_dist = dist
									best = v
								end
							end
						end
					end
				end
			end
		end

		return best
	end

	local function getValidSpot(computer)
		local screen = computer:FindFirstChild("Screen")
		if screen and (screen.Color == computerUnhacked or screen.Color == computerErrored) then
			local trigger1 = computer:FindFirstChild("ComputerTrigger1")
			local trigger2 = computer:FindFirstChild("ComputerTrigger2")
			local trigger3 = computer:FindFirstChild("ComputerTrigger3")

			local triggers = { trigger1, trigger2, trigger3 }

			local valid_triggers = {}

			for _, t in pairs(triggers) do
				local v = t:FindFirstChild("ActionSign")

				if v then
					if v.Value ~= 0 then
						table.insert(valid_triggers, t)
					end
				end
			end

			local best_dist = 99999999
			local best = nil

			local plr = game:GetService("Players").LocalPlayer
			local char = plr and plr.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")

			if root then
				for i, t in pairs(valid_triggers) do
					local dist = dist3d(root.Position, t.Position)
					if dist < best_dist then
						best_dist = dist
						best = t
					end
				end
			end

			return best
		end

		return nil
	end

	local beast_max_dist = 20
	local hidingFromBeast = false

	local function doBeastRaycast(part)
		local beast = findBeast()
		local beastChar = beast and beast.Character
		local beastHead = beastChar and beastChar:FindFirstChild("Head")

		if beastHead and part then
			local origin = part.Position
			local target = beastHead.Position

			local dir = (target - origin) * 1.5

			local plrs = game:GetService("Players"):GetPlayers()
			local exclusions = { part, part.Parent }

			for i, v in pairs(plrs) do
				local char = v.Character
				if char and v ~= beast then
					table.insert(exclusions, char)
				end
			end

			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Exclude
			params.FilterDescendantsInstances = exclusions
			params.IgnoreWater = true

			local result = game.Workspace:Raycast(origin, dir, params)

			if result then
				local instance = result.Instance

				if instance then
					if instance:IsDescendantOf(beastChar) then
						return true
					end
				end
			end
		end

		return false
	end

	local function LOSToBeast()
		local plr = game:GetService("Players").LocalPlayer
		local char = plr and plr.Character

		local root = char and char:FindFirstChild("HumanoidRootPart")
		local head = char and char:FindFirstChild("Head")
		local lleg = char and char:FindFirstChild("Left Leg")
		local rleg = char and char:FindFirstChild("Right Leg")

		local parts = { root, head, lleg, rleg }

		for i, v in pairs(parts) do
			if v then
				if doBeastRaycast(v) then
					return true
				end
			end
		end

		return false
	end

	local function isInDanger()
		return getDistToBeast() <= beast_max_dist and LOSToBeast()
	end

	local function shouldEasyHack()
		return getDistToBeast() > 30 or not LOSToBeast()
	end

	local auto_e_toggled = true
	local quick_hack_toggled = true
	local auto_hack_toggled = false

	local FTFAutoEToggle
	FTFAutoEToggle = FTFUtilsTab:CreateToggle({
		Name = "Auto E",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			auto_e_toggled = value

			if quick_hack_toggled and not value then
				FTFAutoEToggle:Set(true)
			end
		end,
	})

	local FTFQuickHackToggle
	FTFQuickHackToggle = FTFUtilsTab:CreateToggle({
		Name = "Easy Hack (Requires Auto E)",
		CurrentValue = true,
		Flag = nil,
		Callback = function(value)
			quick_hack_toggled = value
			if value then
				FTFAutoEToggle:Set(true)
			end

			if auto_hack_toggled and not value then
				FTFQuickHackToggle:Set(true)
			end
		end,
	})

	local FTFAutoHackToggle = FTFUtilsTab:CreateToggle({
		Name = "Auto Hack (Requires Easy Hack)",
		CurrentValue = false,
		Flag = nil,
		Callback = function(value)
			auto_hack_toggled = value
			if value then
				FTFQuickHackToggle:Set(true)
			end
		end,
	})
	task.spawn(function()
		local last_computer = nil

		while task.wait(0.1) do
			local ictc, computer = isCloseToComputer()
			local ictfp, freeze_pod = isCloseToFreezePod()
			local icte, exit = isCloseToExit()

			if
				(isInGame() and auto_e_toggled and (ictc or ictfp or icte))
				or (isBeast() and auto_e_toggled and ictfp) and shouldEasyHack()
			then
				game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", true)
				task.wait(0.1)
				game.ReplicatedStorage.RemoteEvent:FireServer("Input", "Action", false)
			end

			if
				isInGame()
				and quick_hack_toggled
				and ictc
				and last_computer ~= computer
				and not isInDanger()
				and not hidingFromBeast
			then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if root then
					local spot = getValidSpot(computer)

					task.spawn(function()
						local running = true

						task.spawn(function()
							while running and not isInDanger() and not hidingFromBeast do
								if spot then
									root.CFrame = spot.CFrame * CFrame.new(0, 0, 0.1)
								end
								task.wait()
							end
						end)

						task.delay(1, function()
							running = false
						end)
					end)
				end
			end

			if isInGame() and auto_hack_toggled and not isInDanger() and not hidingFromBeast then
				local cComp = getClosestComputer(false)

				if not safeTweening and cComp and cComp ~= computer then
					local spot = getValidSpot(cComp)

					if spot then
						safeTweening = true

						task.delay(1, function()
							local plr = game:GetService("Players").LocalPlayer
							local char = plr and plr.Character
							local root = char and char:FindFirstChild("HumanoidRootPart")

							-- if root then
							-- 	root.CFrame = CFrame.new(spot.Position.X, -40, spot.Position.Z)
							-- end

							safeTweenToPart(spot)
						end)
					end
				end
			end

			last_computer = computer
		end
	end)

	local FTFFreezePodKeybind = FTFUtilsTab:CreateKeybind({
		Name = "Teleport to Freeze Pod",
		CurrentKeybind = "F",
		HoldToInteract = false,
		Flag = "FTFFreezePodKeybind", -- A flag is the identifier for the configuration file. Make sure every element has a different flag if you're using configuration saving to ensure no overlaps
		Callback = teleportToNearestFreezePod,
	})

	task.spawn(function()
		local oldPos
		local oldPosV

		local V3 = Vector3.new(0, 0, 0)

		while task.wait() do
			if no_errors_toggled then
				game.ReplicatedStorage.RemoteEvent:FireServer("SetPlayerMinigameResult", true)
			end

			if no_fog_toggled then
				game:GetService("Lighting").Atmosphere.Density = 0
				game:GetService("Lighting").Atmosphere.Offset = 0
				game:GetService("Lighting").Atmosphere.Glare = 0
				game:GetService("Lighting").Atmosphere.Haze = 0
				game:GetService("Lighting").Blur.Enabled = false
				game:GetService("Lighting").DepthOfField.Enabled = false
				game:GetService("Lighting").Brightness = 2
				game:GetService("Lighting").ClockTime = 14
				game:GetService("Lighting").FogEnd = 100000
				game:GetService("Lighting").GlobalShadows = false
				game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
			end

			if better_cam_toggled then
				local player = game:GetService("Players").LocalPlayer
				if player then
					player.CameraMode = Enum.CameraMode.Classic
					player.CameraMaxZoomDistance = 30
				end
			end

			if avoid_beast_toggled and not ftf_auto_saving then
				local beast = findBeast()
				local beastChar = beast and beast.Character
				local beastRoot = beastChar and beastChar:FindFirstChild("HumanoidRootPart")

				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if beastChar then
					if char then
						if isInDanger() then
							if not hidingFromBeast then
								oldPos = root.CFrame
								oldPosV = root.Position
								game.Workspace.Gravity = 0

								enableNoclip()

								task.wait(0.1)
								hidingFromBeast = true
							end
						end
					end
				elseif hidingFromBeast then
					root.CFrame = oldPos
					game.Workspace.Gravity = 196.2
					disableNoclip()
					hidingFromBeast = false
				end

				if hidingFromBeast then
					local testDist = dist3d(oldPosV, beastRoot.Position)

					if testDist >= beast_max_dist then
						root.CFrame = oldPos
						game.Workspace.Gravity = 196.21
						disableNoclip()
						hidingFromBeast = false
					else
						local newPos = beastRoot.CFrame * CFrame.new(0, -10, 0)
						root.CFrame = newPos

						for _, v in ipairs(char:GetDescendants()) do
							if v:IsA("BasePart") then
								v.Velocity, v.RotVelocity = V3, V3
							end
						end
					end
				end
			elseif hidingFromBeast then
				local plr = game:GetService("Players").LocalPlayer
				local char = plr and plr.Character
				local root = char and char:FindFirstChild("HumanoidRootPart")

				if root then
					root.CFrame = oldPos
				end

				game.Workspace.Gravity = 196.21
				disableNoclip()
				hidingFromBeast = false
			end
		end
	end)

	local FTFChaseMusicSlider = FTFUtilsTab:CreateSlider({
		Name = "Chase Music Volume",
		Range = { 0, 100 },
		Increment = 1,
		Suffix = "%",
		CurrentValue = 100,
		Flag = nil,
		Callback = function(value)
			updateChaseVolume((value / 100) * defaultChaseMusicVolume)
		end,
	})

	local hitOptions = {}

	local FTFHitDropdown

	local function refreshHitOptions()
		hitOptions = {}
		for i, v in pairs(game:GetService("Players"):GetPlayers()) do
			table.insert(hitOptions, v.Name)
		end

		if FTFHitDropdown then
			FTFHitDropdown:Refresh(hitOptions)
		end
	end

	refreshHitOptions()

	FTFHitDropdown = FTFUtilsTab:CreateDropdown({
		Name = "Hit Player",
		Options = hitOptions,
		CurrentOption = {},
		MultipleOptions = false,
		Flag = nil,
		Callback = function(options)
			local plr = game:GetService("Players"):FindFirstChild(options[1])
			if plr then
				tpHitAndTie(plr)
			end
		end,
	})

	game:GetService("Players").PlayerAdded:Connect(refreshHitOptions)
	game:GetService("Players").PlayerRemoving:Connect(function()
		task.wait(1)
		refreshHitOptions()
	end)
end

-- Externals

local ExternalsTab = Window:CreateTab("Externals", "telescope")

ExternalsTab:CreateSection("Dex")

local dex_injected = false
local DexButton = ExternalsTab:CreateButton({
	Name = "Inject Dex",
	Callback = function()
		if dex_injected then
			return
		end
		dex_injected = true
		loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))()
	end,
})

local DexToggle = ExternalsTab:CreateToggle({
	Name = "Load Dex on Startup",
	CurrentValue = false,
	Flag = "LoadDexOnStartup", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value) end,
})

ExternalsTab:CreateSection("Infinite Yield")

local iy_injected = false
local IYButton = ExternalsTab:CreateButton({
	Name = "Inject IY",
	Callback = function()
		if iy_injected then
			return
		end
		iy_injected = true
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end,
})

local IYToggle = ExternalsTab:CreateToggle({
	Name = "Load IY on Startup",
	CurrentValue = false,
	Flag = "LoadIYOnStartup", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value) end,
})

ExternalsTab:CreateSection("Remote Spy")

local rs_injected = false
local RSButton = ExternalsTab:CreateButton({
	Name = "Inject Remote Spy",
	Callback = function()
		if rs_injected then
			return
		end
		rs_injected = true
		loadstring(game:HttpGet("https://paste.ee/r/hK1Q4D65"))()
	end,
})

local RSToggle = ExternalsTab:CreateToggle({
	Name = "Load RS on Startup",
	CurrentValue = false,
	Flag = "LoadRSOnStartup", -- A flag is the identifier for the configuration file; make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(value) end,
})

Rayfield:LoadConfiguration()

if DexToggle.CurrentValue then
	dex_injected = true
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-DEX-Explorer-29920"))()
end

if IYToggle.CurrentValue then
	iy_injected = true
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end

if RSToggle.CurrentValue then
	rs_injected = true
	loadstring(game:HttpGet("https://paste.ee/r/hK1Q4D65"))()
end

task.spawn(function()
	while task.wait() do
		for i, v in pairs(looped_functions) do
			task.spawn(v)
		end
	end
end)
