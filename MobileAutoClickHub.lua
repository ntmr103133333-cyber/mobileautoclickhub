--==================================================
-- MOBILE AUTO CLICK HUB (FINAL FIX / NO FLING)
-- AUTO CLICK / AUTO SPEED / GRAVITY / FPS
-- INFINITE JUMP / ESP / FOV
-- DRAG : ONLY OPEN HUB → MOVE ALL
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
getgenv().GravityOn = false
getgenv().InfiniteJumpEnabled = false
getgenv().ESPEnabled = false
getgenv().FOVEnabled = false

--================ GUI =================
local Gui = Instance.new("ScreenGui", game.CoreGui)
Gui.Name = "MobileHub"
getgenv().MobileHub = Gui

--================ KEY UI =================
local KeyFrame = Instance.new("Frame", Gui)
KeyFrame.Size = UDim2.new(0,220,0,140)
KeyFrame.Position = UDim2.new(0.5,-110,0.5,-70)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", KeyFrame)

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(1,-20,0,35)
KeyBox.Position = UDim2.new(0,10,0,45)
KeyBox.PlaceholderText = "Key here"
KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
KeyBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KeyBox)

local KeyBtn = Instance.new("TextButton", KeyFrame)
KeyBtn.Size = UDim2.new(1,-20,0,35)
KeyBtn.Position = UDim2.new(0,10,0,90)
KeyBtn.Text = "UNLOCK"
KeyBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
KeyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KeyBtn)

--================ OPEN HUB =================
local ToggleBtn = Instance.new("TextButton", Gui)
ToggleBtn.Size = UDim2.new(0,120,0,40)
ToggleBtn.Position = UDim2.new(0,10,0,70)
ToggleBtn.Text = "OPEN HUB"
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
ToggleBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", ToggleBtn)

--================ HUB =================
local Frame = Instance.new("ScrollingFrame", Gui)
Frame.Size = UDim2.new(0,220,0,440)
Frame.Position = UDim2.new(0,10,0,120)
Frame.Visible = false
Frame.Active = true
Frame.CanvasSize = UDim2.new(0,0,2,0)
Frame.ScrollBarThickness = 8
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", Frame)

local UIList = Instance.new("UIListLayout", Frame)
UIList.Padding = UDim.new(0,10)

local function btn(t)
	local b = Instance.new("TextButton", Frame)
	b.Size = UDim2.new(1,-20,0,40)
	b.Text = t
	b.BackgroundColor3 = Color3.fromRGB(45,45,45)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)
	return b
end

local function box(ph, d)
	local t = Instance.new("TextBox", Frame)
	t.Size = UDim2.new(1,-20,0,35)
	t.PlaceholderText = ph
	t.Text = d or ""
	t.BackgroundColor3 = Color3.fromRGB(40,40,40)
	t.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", t)
	return t
end

local AutoBtn = btn("AUTO CLICK : OFF")
local SpeedBox = box("AUTO SPEED (0 = FAST)", "0")
local GravityBox = box("GRAVITY", tostring(workspace.Gravity))
local GravityBtn = btn("GRAVITY : OFF")
local JumpBtn = btn("INFINITE JUMP : OFF")
local ESPBtn = btn("ESP : OFF")
local FOVBtn = btn("FOV : OFF")

local FPS = Instance.new("TextLabel", Frame)
FPS.Size = UDim2.new(1,-20,0,30)
FPS.Text = "FPS : ..."
FPS.BackgroundColor3 = Color3.fromRGB(35,35,35)
FPS.TextColor3 = Color3.new(1,1,1)
FPS.BorderSizePixel = 0
Instance.new("UICorner", FPS)

--================ KEY =================
KeyBtn.MouseButton1Click:Connect(function()
	if KeyBox.Text == CORRECT_KEY then
		KeyFrame:Destroy()
		ToggleBtn.Visible = true
	end
end)

ToggleBtn.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
	ToggleBtn.Text = Frame.Visible and "CLOSE HUB" or "OPEN HUB"
end)

--================ AUTO CLICK =================
AutoBtn.MouseButton1Click:Connect(function()
	getgenv().AutoClick = not getgenv().AutoClick
	AutoBtn.Text = "AUTO CLICK : "..(getgenv().AutoClick and "ON" or "OFF")
end)

task.spawn(function()
	while true do
		if getgenv().AutoClick then
			VirtualUser:Button1Down(Vector2.zero, workspace.CurrentCamera.CFrame)
			VirtualUser:Button1Up(Vector2.zero, workspace.CurrentCamera.CFrame)
			local s = tonumber(SpeedBox.Text) or 0
			if s == 0 then RunService.Heartbeat:Wait() else task.wait(s) end
		else
			task.wait(0.15)
		end
	end
end)

--================ GRAVITY =================
GravityBtn.MouseButton1Click:Connect(function()
	getgenv().GravityOn = not getgenv().GravityOn
	workspace.Gravity = getgenv().GravityOn and tonumber(GravityBox.Text) or 196.2
	GravityBtn.Text = "GRAVITY : "..(getgenv().GravityOn and "ON" or "OFF")
end)

--================ INFINITE JUMP =================
JumpBtn.MouseButton1Click:Connect(function()
	getgenv().InfiniteJumpEnabled = not getgenv().InfiniteJumpEnabled
	JumpBtn.Text = "INFINITE JUMP : "..(getgenv().InfiniteJumpEnabled and "ON" or "OFF")
end)

UserInputService.JumpRequest:Connect(function()
	if getgenv().InfiniteJumpEnabled and Player.Character then
		Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

--================ ESP =================
ESPBtn.MouseButton1Click:Connect(function()
	getgenv().ESPEnabled = not getgenv().ESPEnabled
	ESPBtn.Text = "ESP : "..(getgenv().ESPEnabled and "ON" or "OFF")
end)

task.spawn(function()
	while task.wait(0.5) do
		for _,p in pairs(Players:GetPlayers()) do
			if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				local r = p.Character.HumanoidRootPart
				if getgenv().ESPEnabled then
					if not r:FindFirstChild("ESP") then
						local g = Instance.new("BillboardGui", r)
						g.Name = "ESP"
						g.Size = UDim2.new(0,100,0,40)
						g.AlwaysOnTop = true
						local t = Instance.new("TextLabel", g)
						t.Size = UDim2.new(1,0,1,0)
						t.BackgroundTransparency = 1
						t.Text = p.Name
						t.TextColor3 = Color3.fromRGB(0,255,0)
					end
				elseif r:FindFirstChild("ESP") then
					r.ESP:Destroy()
				end
			end
		end
	end
end)

--================ FOV =================
FOVBtn.MouseButton1Click:Connect(function()
	getgenv().FOVEnabled = not getgenv().FOVEnabled
	FOVBtn.Text = "FOV : "..(getgenv().FOVEnabled and "ON" or "OFF")
end)

task.spawn(function()
	while task.wait() do
		workspace.CurrentCamera.FieldOfView = getgenv().FOVEnabled and 120 or 70
	end
end)

--================ FPS =================
local f, lt = 0, os.clock()
RunService.RenderStepped:Connect(function()
	f += 1
	if os.clock() - lt >= 1 then
		FPS.Text = "FPS : "..f
		f = 0
		lt = os.clock()
	end
end)

--================ DRAG =================
local dragging = false
local dragStart, startFrame, startToggle

ToggleBtn.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = i.Position
		startFrame = Frame.Position
		startToggle = ToggleBtn.Position
		i.Changed:Connect(function()
			if i.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(i)
	if dragging and i.UserInputType == Enum.UserInputType.Touch then
		local d = i.Position - dragStart
		Frame.Position = UDim2.new(startFrame.X.Scale, startFrame.X.Offset + d.X,
								   startFrame.Y.Scale, startFrame.Y.Offset + d.Y)
		ToggleBtn.Position = UDim2.new(startToggle.X.Scale, startToggle.X.Offset + d.X,
									   startToggle.Y.Scale, startToggle.Y.Offset + d.Y)
	end
end)
