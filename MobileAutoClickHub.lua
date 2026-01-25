--==================================================
-- MOBILE AUTO CLICK HUB (FINAL iPHONE WIDE FIX)
-- AUTO CLICK / AUTO SPEED / GRAVITY / FPS
-- INFINITE JUMP / ESP / FOV
-- DRAG : ONLY TOGGLE BUTTON → MOVE HUB
-- KEY : ntmr1031
--==================================================

local CORRECT_KEY = "ntmr1031"

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
local Camera = workspace.CurrentCamera
if not UserInputService.TouchEnabled then return end

--================ States =================
getgenv().AutoClick = false
getgenv().GravityOn = false
getgenv().InfiniteJumpEnabled = false
getgenv().ESPEnabled = false
getgenv().FOVEnabled = false

local DEFAULT_FOV = Camera.FieldOfView
local FOV_VALUE = 120

--================ GUI ROOT =================
local Gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
Gui.Name = "MobileHub"
getgenv().MobileHub = Gui

--================ MAIN CONTAINER (WIDE) =================
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,340,0,560)
Main.Position = UDim2.new(0.5,-170,0.5,-280)
Main.BackgroundTransparency = 1

--================ KEY FRAME =================
local KeyFrame = Instance.new("Frame", Main)
KeyFrame.Size = UDim2.new(0,300,0,150)
KeyFrame.Position = UDim2.new(0.5,-150,0.5,-75)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", KeyFrame)

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(1,-20,0,40)
KeyBox.Position = UDim2.new(0,10,0,45)
KeyBox.PlaceholderText = "Key here"
KeyBox.TextScaled = false
KeyBox.TextSize = 22
KeyBox.ClearTextOnFocus = false
KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
KeyBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KeyBox)

local KeyBtn = Instance.new("TextButton", KeyFrame)
KeyBtn.Size = UDim2.new(1,-20,0,40)
KeyBtn.Position = UDim2.new(0,10,0,95)
KeyBtn.Text = "UNLOCK"
KeyBtn.TextScaled = true
KeyBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
KeyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KeyBtn)

--================ TOGGLE BUTTON =================
local ToggleBtn = Instance.new("TextButton", Main)
ToggleBtn.Size = UDim2.new(0,160,0,50)
ToggleBtn.Position = UDim2.new(0,20,0,170)
ToggleBtn.Text = "OPEN HUB"
ToggleBtn.Visible = false
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
ToggleBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", ToggleBtn)

--================ HUB FRAME =================
local Frame = Instance.new("ScrollingFrame", Main)
Frame.Size = UDim2.new(0,300,0,430)
Frame.Position = UDim2.new(0,20,0,230)
Frame.Visible = false
Frame.CanvasSize = UDim2.new(0,0,0,750)
Frame.ScrollBarThickness = 6
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.Active = true
Instance.new("UICorner", Frame)

--================ UI BUILDERS =================
local function Button(text,y)
    local b = Instance.new("TextButton", Frame)
    b.Size = UDim2.new(1,-20,0,52)
    b.Position = UDim2.new(0,10,0,y)
    b.Text = text
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    return b
end

local function Box(ph,y,def)
    local t = Instance.new("TextBox", Frame)
    t.Size = UDim2.new(1,-20,0,46)
    t.Position = UDim2.new(0,10,0,y)
    t.PlaceholderText = ph
    t.Text = def
    t.TextScaled = true
    t.BackgroundColor3 = Color3.fromRGB(40,40,40)
    t.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", t)
    return t
end

--================ UI =================
local SpeedBox   = Box("AUTO SPEED (0 = FAST)",10,"0")
local GravityBox = Box("GRAVITY",65,"196.2")
local AutoBtn    = Button("AUTO CLICK : OFF",120)
local GravityBtn = Button("GRAVITY : OFF",180)
local FOVBtn     = Button("FOV : OFF",240)
local JumpBtn    = Button("INFINITE JUMP : OFF",300)
local ESPBtn     = Button("ESP : OFF",360)

local FPS = Instance.new("TextLabel", Frame)
FPS.Size = UDim2.new(1,-20,0,40)
FPS.Position = UDim2.new(0,10,0,430)
FPS.TextScaled = true
FPS.BackgroundColor3 = Color3.fromRGB(35,35,35)
FPS.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", FPS)

--================ KEY CHECK =================
KeyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == CORRECT_KEY then
        KeyFrame.Visible = false
        ToggleBtn.Visible = true
    end
end)

--================ TOGGLE HUB =================
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
    while task.wait(0.03) do
        if getgenv().AutoClick then
            local c = Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
            VirtualUser:Button1Down(c,Camera.CFrame)
            VirtualUser:Button1Up(c,Camera.CFrame)
        end
    end
end)

--================ GRAVITY =================
GravityBtn.MouseButton1Click:Connect(function()
    getgenv().GravityOn = not getgenv().GravityOn
    workspace.Gravity = getgenv().GravityOn and (tonumber(GravityBox.Text) or 196.2) or 196.2
    GravityBtn.Text = "GRAVITY : "..(getgenv().GravityOn and "ON" or "OFF")
end)

--================ FOV =================
FOVBtn.MouseButton1Click:Connect(function()
    getgenv().FOVEnabled = not getgenv().FOVEnabled
    Camera.FieldOfView = getgenv().FOVEnabled and FOV_VALUE or DEFAULT_FOV
    FOVBtn.Text = "FOV : "..(getgenv().FOVEnabled and "ON" or "OFF")
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
            if p~=Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local r=p.Character.HumanoidRootPart
                if getgenv().ESPEnabled then
                    if not r:FindFirstChild("ESP") then
                        local g=Instance.new("BillboardGui",r)
                        g.Name="ESP"
                        g.Size=UDim2.new(0,120,0,45)
                        g.AlwaysOnTop=true
                        local t=Instance.new("TextLabel",g)
                        t.Size=UDim2.new(1,0,1,0)
                        t.BackgroundTransparency=1
                        t.TextScaled=true
                        t.Text=p.Name
                        t.TextColor3=Color3.fromRGB(0,255,0)
                    end
                elseif r:FindFirstChild("ESP") then
                    r.ESP:Destroy()
                end
            end
        end
    end
end)

--================ FPS =================
local f,lt=0,os.clock()
RunService.RenderStepped:Connect(function()
    f+=1
    if os.clock()-lt>=1 then
        FPS.Text="FPS : "..f
        f=0
        lt=os.clock()
    end
end)

--================ DRAG (TOGGLE ONLY) =================
local dragging=false
local dragStart,startFrame,startToggle

ToggleBtn.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.Touch then
        dragging=true
        dragStart=i.Position
        startFrame=Frame.Position
        startToggle=ToggleBtn.Position
        i.Changed:Connect(function()
            if i.UserInputState==Enum.UserInputState.End then dragging=false end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if dragging and i.UserInputType==Enum.UserInputType.Touch then
        local d=i.Position-dragStart
        Frame.Position=UDim2.new(startFrame.X.Scale,startFrame.X.Offset+d.X,startFrame.Y.Scale,startFrame.Y.Offset+d.Y)
        ToggleBtn.Position=UDim2.new(startToggle.X.Scale,startToggle.X.Offset+d.X,startToggle.Y.Scale,startToggle.Y.Offset+d.Y)
    end
end)
