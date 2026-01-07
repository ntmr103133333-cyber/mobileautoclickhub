--==================================================
-- MOBILE AUTO CLICK HUB + GRAVITY + AUTO SPEED + FPS + INFINITE JUMP + ESP + FOV ON/OFF
-- (SCROLLABLE & DRAGGABLE + Open Hubも一緒に動く)
-- KEY : ntmr10317
--==================================================

local CORRECT_KEY = "ntmr10317"

pcall(function()
	if getgenv().MobileHub then
		getgenv().MobileHub:Destroy()
	end
end)

--================ Services =================
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

if not UserInputService.TouchEnabled then return end

--================ Variables =================
getgenv().AutoClick = false
getgenv().AutoSpeed = 0
getgenv().GravityOn = false
getgenv().InfiniteJumpEnabled = false
getgenv().ESPEnabled = false
getgenv().FOVEnabled = false

--================ GUI =================
local Gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
Gui.Name = "MobileHub"
getgenv().MobileHub = Gui

--================ KEY FRAME =================
local KeyFrame = Instance.new("Frame", Gui)
KeyFrame.Size = UDim2.new(0,220,0,140)
KeyFrame.Position = UDim2.new(0.5,-110,0.5,-70)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,12)

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(1,-20,0,35)
KeyBox.Position = UDim2.new(0,10,0,45)
KeyBox.PlaceholderText = "Key here"
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,8)

local KeyBtn = Instance.new("TextButton", KeyFrame)
KeyBtn.Size = UDim2.new(1,-20,0,35)
KeyBtn.Position = UDim2.new(0,10,0,90)
KeyBtn.Text = "UNLOCK"
KeyBtn.TextColor3 = Color3.new(1,1,1)
KeyBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0,8)

--================ TOGGLE BUTTON =================
local ToggleBtn = Instance.new("TextButton", Gui)
ToggleBtn.Size = UDim2.new(0,120,0,40)
ToggleBtn.Position = UDim2.new(0,10,0,70)
ToggleBtn.Text = "OPEN HUB"
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
ToggleBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0,10)

--================ MAIN HUB (SCROLLABLE) =================
local Frame = Instance.new("ScrollingFrame", Gui)
Frame.Size = UDim2.new(0,220,0,440)
Frame.Position = UDim2.new(0,10,0,120)
Frame.Visible = false
Frame.Active = true
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.CanvasSize = UDim2.new(0,0,2,0)
Frame.ScrollBarThickness = 10
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,12)

local UIList = Instance.new("UIListLayout", Frame)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0,10)

--================ Helper functions =================
local function createButton(text)
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(1,-20,0,40)
	btn.Text = text
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
	return btn
end

local function createTextBox(placeholder, default)
	local box = Instance.new("TextBox", Frame)
	box.Size = UDim2.new(1,-20,0,35)
	box.PlaceholderText = placeholder
	box.Text = default or ""
	box.TextColor3 = Color3.new(1,1,1)
	box.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)
	return box
end

--================ BUTTONS & TEXTBOXES =================
local AutoBtn = createButton("AUTO CLICK : OFF")
local SpeedBox = createTextBox("AUTO SPEED (0 = FAST)","0")
local GravityBox = createTextBox("Gravity value", tostring(workspace.Gravity))
local GravityBtn = createButton("GRAVITY : OFF")
local JumpBtn = createButton("INFINITE JUMP : OFF")
local ESPBtn = createButton("ESP : OFF")
local FOVBtn = createButton("FOV : OFF")

-- FPS LABEL
local FPSLabel = Instance.new("TextLabel", Frame)
FPSLabel.Size = UDim2.new(1,-20,0,30)
FPSLabel.BackgroundColor3 = Color3.fromRGB(35,35,35)
FPSLabel.TextColor3 = Color3.new(1,1,1)
FPSLabel.Text = "FPS : ..."
FPSLabel.TextScaled = true
FPSLabel.Font = Enum.Font.SourceSansBold
FPSLabel.BorderSizePixel = 0
Instance.new("UICorner", FPSLabel).CornerRadius = UDim.new(0,8)

--================ KEY CHECK =================
KeyBtn.MouseButton1Click:Connect(function()
	if KeyBox.Text == CORRECT_KEY then
		KeyFrame:Destroy()
		ToggleBtn.Visible = true
	else
		KeyBtn.Text = "WRONG"
		task.wait(1)
		KeyBtn.Text = "UNLOCK"
	end
end)

--================ TOGGLE HUB =================
ToggleBtn.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
	ToggleBtn.Text = Frame.Visible and "CLOSE HUB" or "OPEN HUB"
end)

--================ AUTO CLICK LOOP =================
AutoBtn.MouseButton1Click:Connect(function()
	getgenv().AutoClick = not getgenv().AutoClick
	AutoBtn.Text = "AUTO CLICK : " .. (getgenv().AutoClick and "ON" or "OFF")
end)

task.spawn(function()
	while true do
		if getgenv().AutoClick then
			VirtualUser:Button1Down(Vector2.new(), workspace.CurrentCamera.CFrame)
			VirtualUser:Button1Up(Vector2.new(), workspace.CurrentCamera.CFrame)
			local speed = tonumber(SpeedBox.Text) or 0
			getgenv().AutoSpeed = speed
			if speed == 0 then RunService.Heartbeat:Wait() else task.wait(speed) end
		else
			task.wait(0.15)
		end
	end
end)

--================ GRAVITY =================
GravityBtn.MouseButton1Click:Connect(function()
	getgenv().GravityOn = not getgenv().GravityOn
	if getgenv().GravityOn then
		local v = tonumber(GravityBox.Text)
		if v then workspace.Gravity = v end
	else
		workspace.Gravity = 196.2
	end
	GravityBtn.Text = "GRAVITY : " .. (getgenv().GravityOn and "ON" or "OFF")
end)

--================ INFINITE JUMP =================
JumpBtn.MouseButton1Click:Connect(function()
	getgenv().InfiniteJumpEnabled = not getgenv().InfiniteJumpEnabled
	JumpBtn.Text = "INFINITE JUMP : " .. (getgenv().InfiniteJumpEnabled and "ON" or "OFF")
end)

UserInputService.JumpRequest:Connect(function()
	if getgenv().InfiniteJumpEnabled and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
		Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

--================ ESP =================
ESPBtn.MouseButton1Click:Connect(function()
	getgenv().ESPEnabled = not getgenv().ESPEnabled
	ESPBtn.Text = "ESP : " .. (getgenv().ESPEnabled and "ON" or "OFF")
end)

task.spawn(function()
	while true do
		task.wait(0.5)
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local root = plr.Character.HumanoidRootPart
				if getgenv().ESPEnabled then
					if not root:FindFirstChild("ESP") then
						local box = Instance.new("BillboardGui")
						box.Name = "ESP"
						box.Size = UDim2.new(0,100,0,50)
						box.Adornee = root
						box.AlwaysOnTop = true
						box.Parent = root
						local label = Instance.new("TextLabel", box)
						label.Size = UDim2.new(1,0,1,0)
						label.BackgroundTransparency = 1
						label.TextColor3 = Color3.fromRGB(0,255,0)
						label.TextScaled = true
						label.Font = Enum.Font.SourceSansBold
						label.Text = plr.Name
					end
				else
					if root:FindFirstChild("ESP") then root.ESP:Destroy() end
				end
			end
		end
	end
end)

--================ FOV LOOP =================
FOVBtn.MouseButton1Click:Connect(function()
	getgenv().FOVEnabled = not getgenv().FOVEnabled
	FOVBtn.Text = "FOV : " .. (getgenv().FOVEnabled and "ON" or "OFF")
end)

task.spawn(function()
	while true do
		task.wait()
		if getgenv().FOVEnabled then
			workspace.CurrentCamera.FieldOfView = 120
		else
			workspace.CurrentCamera.FieldOfView = 70
		end
	end
end)

--================ FPS COUNTER =================
task.spawn(function()
	local last = os.clock()
	local frames = 0
	RunService.RenderStepped:Connect(function()
		frames += 1
		local now = os.clock()
		if now - last >= 1 then
			FPSLabel.Text = "FPS : " .. frames
			frames = 0
			last = now
		end
	end)
end)

--================ DRAG HUB + TOGGLE =================
local dragging = false
local dragInput, startPos, startFramePos, startTogglePos

local function update(input)
	local delta = input.Position - startPos
	Frame.Position = UDim2.new(startFramePos.X.Scale, startFramePos.X.Offset + delta.X,
		startFramePos.Y.Scale, startFramePos.Y.Offset + delta.Y)
	ToggleBtn.Position = UDim2.new(startTogglePos.X.Scale, startTogglePos.X.Offset + delta.X,
		startTogglePos.Y.Scale, startTogglePos.Y.Offset + delta.Y)
end

ToggleBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		startPos = input.Position
		startFramePos = Frame.Position
		startTogglePos = ToggleBtn.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

ToggleBtn.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
