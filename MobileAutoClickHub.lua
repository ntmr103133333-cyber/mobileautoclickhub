--==================================================
-- MOBILE AUTO CLICK HUB + GRAVITY + AUTO SPEED + FPS
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

if not UserInputService.TouchEnabled then return end

local Player = Players.LocalPlayer

getgenv().AutoClick = false
getgenv().AutoSpeed = 0
getgenv().GravityOn = false
getgenv().CustomGravity = workspace.Gravity

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
KeyBox.Text = ""
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,8)

local KeyBtn = Instance.new("TextButton", KeyFrame)
KeyBtn.Size = UDim2.new(1,-20,0,35)
KeyBtn.Position = UDim2.new(0,10,0,90)
KeyBtn.Text = "UNLOCK"
KeyBtn.TextColor3 = Color3.new(1,1,1)
KeyBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0,8)

--================ TOGGLE =================
local ToggleBtn = Instance.new("TextButton", Gui)
ToggleBtn.Size = UDim2.new(0,120,0,40)
ToggleBtn.Position = UDim2.new(0,10,0,70)
ToggleBtn.Text = "OPEN HUB"
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
ToggleBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0,10)

--================ MAIN HUB =================
local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.new(0,220,0,320)
Frame.Position = UDim2.new(0,10,0,120)
Frame.Visible = false
Frame.Active = true
Frame.Draggable = true
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,12)

-- AUTO BUTTON
local AutoBtn = Instance.new("TextButton", Frame)
AutoBtn.Size = UDim2.new(1,-20,0,40)
AutoBtn.Position = UDim2.new(0,10,0,10)
AutoBtn.Text = "AUTO CLICK : OFF"
AutoBtn.TextColor3 = Color3.new(1,1,1)
AutoBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
Instance.new("UICorner", AutoBtn).CornerRadius = UDim.new(0,10)

-- AUTO SPEED
local SpeedBox = Instance.new("TextBox", Frame)
SpeedBox.Size = UDim2.new(1,-20,0,35)
SpeedBox.Position = UDim2.new(0,10,0,60)
SpeedBox.PlaceholderText = "AUTO SPEED (0 = FAST)"
SpeedBox.Text = "0"
SpeedBox.TextColor3 = Color3.new(1,1,1)
SpeedBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", SpeedBox).CornerRadius = UDim.new(0,8)

-- GRAVITY VALUE
local GravityBox = Instance.new("TextBox", Frame)
GravityBox.Size = UDim2.new(1,-20,0,35)
GravityBox.Position = UDim2.new(0,10,0,110)
GravityBox.Text = tostring(workspace.Gravity)
GravityBox.PlaceholderText = "Gravity value"
GravityBox.TextColor3 = Color3.new(1,1,1)
GravityBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", GravityBox).CornerRadius = UDim.new(0,8)

-- GRAVITY BUTTON
local GravityBtn = Instance.new("TextButton", Frame)
GravityBtn.Size = UDim2.new(1,-20,0,40)
GravityBtn.Position = UDim2.new(0,10,0,155)
GravityBtn.Text = "GRAVITY : OFF"
GravityBtn.TextColor3 = Color3.new(1,1,1)
GravityBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
Instance.new("UICorner", GravityBtn).CornerRadius = UDim.new(0,10)

-- FPS LABEL
local FPSLabel = Instance.new("TextLabel", Frame)
FPSLabel.Size = UDim2.new(1,-20,0,30)
FPSLabel.Position = UDim2.new(0,10,1,-40)
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

ToggleBtn.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
	ToggleBtn.Text = Frame.Visible and "CLOSE HUB" or "OPEN HUB"
end)

--================ AUTO LOOP (0 = FAST) =================
task.spawn(function()
	while true do
		if getgenv().AutoClick then
			VirtualUser:Button1Down(Vector2.new(), workspace.CurrentCamera.CFrame)
			VirtualUser:Button1Up(Vector2.new(), workspace.CurrentCamera.CFrame)

			local speed = tonumber(SpeedBox.Text) or 0
			getgenv().AutoSpeed = speed

			if speed == 0 then
				RunService.Heartbeat:Wait()
			else
				task.wait(speed)
			end
		else
			task.wait(0.15)
		end
	end
end)

AutoBtn.MouseButton1Click:Connect(function()
	getgenv().AutoClick = not getgenv().AutoClick
	AutoBtn.Text = "AUTO CLICK : " .. (getgenv().AutoClick and "ON" or "OFF")
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
