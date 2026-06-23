local Theme = require("./themes")

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
				local config = callSafely(readfile, ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension)

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
	Theme = Theme,
	UI = nil,
	Window = nil,
	CurrentTheme = "Default",
	GetTheme = function(self)
		return self.Theme[self.CurrentTheme]
	end,
	Tabs = {},
	Notify = function(self, settings) end,
	LoadConfiguration = function(self) end,
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
			title.FontFace =
				Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
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
			label.FontFace =
				Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
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
				TS:Create(label, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), { TextTransparency = 0.2 }):Play()
				TS:Create(label, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), { TextColor3 = theme.TabTextColor })
					:Play()

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
