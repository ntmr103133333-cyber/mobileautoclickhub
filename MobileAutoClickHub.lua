--==================================================
-- MOBILE AUTO CLICK HUB (FINAL iPHONE COMPACT)
-- AUTO CLICK / AUTO SPEED / GRAVITY / FPS
-- INFINITE JUMP / ESP / FOV
-- LOADING SCREEN : GAUGE + 0/100 (50で5秒, 99で13秒)
-- DRAG : TOGGLE BUTTON → MOVE HUB
-- KEY + FULLSCREEN LOADING
--==================================================

local CORRECT_KEY = "ntmr1031"
local LOADING_TITLE = "まんこ穴中出しセックス あーん///blせっくすいくいくおほおほ"
local LOADING_SUB = "Loading..."
local LOADING_TIME = 9

pcall(function()
    if getgenv().MobileHub then
        getgenv().MobileHub:Destroy()
    end
end)

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

getgenv().AutoClick = getgenv().AutoClick or false
getgenv().GravityOn = false
getgenv().InfiniteJumpEnabled = false
getgenv().ESPEnabled = false
getgenv().FOVEnabled = false
getgenv().ESPSize = getgenv().ESPSize or 120
local DEFAULT_FOV = Camera.FieldOfView
local FOV_VALUE = 120

local Gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
Gui.Name = "MobileHub"
getgenv().MobileHub = Gui

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,300,0,520)
Main.Position = UDim2.new(0.5,-150,0.5,-260)
Main.BackgroundTransparency = 1

local KeyFrame = Instance.new("Frame", Main)
KeyFrame.Size = UDim2.new(0,220,0,140)
KeyFrame.Position = UDim2.new(0.5,-110,0.5,-70)
KeyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", KeyFrame)

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(1,-20,0,34)
KeyBox.Position = UDim2.new(0,10,0,40)
KeyBox.PlaceholderText = "Key here"
KeyBox.TextSize = 16
KeyBox.ClearTextOnFocus = false
KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
KeyBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KeyBox)

local KeyBtn = Instance.new("TextButton", KeyFrame)
KeyBtn.Size = UDim2.new(1,-20,0,34)
KeyBtn.Position = UDim2.new(0,10,0,85)
KeyBtn.Text = "UNLOCK"
KeyBtn.TextSize = 16
KeyBtn.BackgroundColor3 = Color3.fromRGB(45,45,45)
KeyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KeyBtn)

local Loading = Instance.new("Frame", Gui)
Loading.Size = UDim2.new(0,920,0,520)
Loading.Position = UDim2.new(0.5,-460,0.5,-260)
Loading.BackgroundColor3 = Color3.fromRGB(10,10,10)
Loading.Visible = false

local LTitle = Instance.new("TextLabel", Loading)
LTitle.Size = UDim2.new(1,0,0.2,0)
LTitle.Position = UDim2.new(0,0,0.35,0)
LTitle.Text = LOADING_TITLE
LTitle.TextScaled = true
LTitle.BackgroundTransparency = 1
LTitle.TextColor3 = Color3.new(1,1,1)

local LSub = Instance.new("TextLabel", Loading)
LSub.Size = UDim2.new(1,0,0.1,0)
LSub.Position = UDim2.new(0,0,0.55,0)
LSub.Text = LOADING_SUB
LSub.TextScaled = true
LSub.BackgroundTransparency = 1
LSub.TextColor3 = Color3.fromRGB(180,180,180)

local LoadBack = Instance.new("Frame", Loading)
LoadBack.Size = UDim2.new(0.6,0,0,26)
LoadBack.Position = UDim2.new(0.2,0,0.65,0)
LoadBack.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", LoadBack)

local LoadBar = Instance.new("Frame", LoadBack)
LoadBar.Size = UDim2.new(0,0,1,0)
LoadBar.BackgroundColor3 = Color3.fromRGB(0,200,0)
Instance.new("UICorner", LoadBar)

local LoadText = Instance.new("TextLabel", LoadBack)
LoadText.Size = UDim2.new(1,0,1,0)
LoadText.BackgroundTransparency = 1
LoadText.TextScaled = true
LoadText.TextColor3 = Color3.new(1,1,1)
LoadText.Text = "0 / 100"

local ToggleBtn = Instance.new("TextButton", Main)
ToggleBtn.Size = UDim2.new(0,140,0,44)
ToggleBtn.Position = UDim2.new(0,20,0,160)
ToggleBtn.Text = "まんこ"
ToggleBtn.Visible = false
ToggleBtn.TextScaled = true
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
ToggleBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", ToggleBtn)

local Frame = Instance.new("ScrollingFrame", Main)
Frame.Size = UDim2.new(0,260,0,360)
Frame.Position = UDim2.new(0,20,0,220)
Frame.Visible = false
Frame.CanvasSize = UDim2.new(0,0,0,720)
Frame.ScrollBarThickness = 6
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.Active = true
Instance.new("UICorner", Frame)

local function Button(t,y)
    local b = Instance.new("TextButton", Frame)
    b.Size = UDim2.new(1,-16,0,44)
    b.Position = UDim2.new(0,8,0,y)
    b.Text = t
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    return b
end

local function Box(p,y,d)
    local t = Instance.new("TextBox", Frame)
    t.Size = UDim2.new(1,-16,0,40)
    t.Position = UDim2.new(0,8,0,y)
    t.PlaceholderText = p
    t.Text = d
    t.TextScaled = true
    t.BackgroundColor3 = Color3.fromRGB(40,40,40)
    t.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", t)
    return t
end

local SpeedBox   = Box("AUTO SPEED (0 = FAST)",10,"0")
local GravityBox = Box("GRAVITY",55,"196.2")
local ESPSizeBox = Box("ESP SIZE (2~50)",100,tostring(getgenv().ESPSize))

local AutoBtn    = Button("AUTO CLICK : OFF",150)
local GravityBtn = Button("GRAVITY : OFF",200)
local FOVBtn     = Button("FOV : OFF",250)
local JumpBtn    = Button("INFINITE JUMP : OFF",300)
local ESPBtn     = Button("ESP : OFF",350)

local FPS = Instance.new("TextLabel", Frame)
FPS.Size = UDim2.new(1,-16,0,36)
FPS.Position = UDim2.new(0,8,0,410)
FPS.TextScaled = true
FPS.BackgroundColor3 = Color3.fromRGB(35,35,35)
FPS.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", FPS)

KeyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == CORRECT_KEY then
        KeyFrame.Visible = false
        Loading.Visible = true
        task.spawn(function()
            for i=0,50 do
                LoadBar.Size = UDim2.new(i/100,0,1,0)
                LoadText.Text = i.." / 100"
                task.wait(LOADING_TIME/100)
            end
            task.wait(5)
            for i=51,99 do
                LoadBar.Size = UDim2.new(i/100,0,1,0)
                LoadText.Text = i.." / 100"
                task.wait(LOADING_TIME/100)
            end
            task.wait(13)
            LoadBar.Size = UDim2.new(1,0,1,0)
            LoadText.Text = "100 / 100"
            Loading.Visible = false
            ToggleBtn.Visible = true
        end)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
    ToggleBtn.Text = Frame.Visible and "まんこ" or "ちんこ"
end)

AutoBtn.MouseButton1Click:Connect(function()
    getgenv().AutoClick = not getgenv().AutoClick
    AutoBtn.Text = "AUTO CLICK : "..(getgenv().AutoClick and "ON" or "OFF")
end)

task.spawn(function()
    while true do
        if getgenv().AutoClick then
            local c = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            VirtualUser:Button1Down(c, Camera.CFrame)
            VirtualUser:Button1Up(c, Camera.CFrame)
        end
        task.wait(0.03)
    end
end)

GravityBtn.MouseButton1Click:Connect(function()
    getgenv().GravityOn = not getgenv().GravityOn
    workspace.Gravity = getgenv().GravityOn and (tonumber(GravityBox.Text) or 196.2) or 196.2
    GravityBtn.Text = "GRAVITY : "..(getgenv().GravityOn and "ON" or "OFF")
end)

FOVBtn.MouseButton1Click:Connect(function()
    getgenv().FOVEnabled = not getgenv().FOVEnabled
    Camera.FieldOfView = getgenv().FOVEnabled and FOV_VALUE or DEFAULT_FOV
    FOVBtn.Text = "FOV : "..(getgenv().FOVEnabled and "ON" or "OFF")
end)

JumpBtn.MouseButton1Click:Connect(function()
    getgenv().InfiniteJumpEnabled = not getgenv().InfiniteJumpEnabled
    JumpBtn.Text = "INFINITE JUMP : "..(getgenv().InfiniteJumpEnabled and "ON" or "OFF")
end)

UserInputService.JumpRequest:Connect(function()
    if getgenv().InfiniteJumpEnabled and Player.Character then
        local h = Player.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

ESPBtn.MouseButton1Click:Connect(function()
    getgenv().ESPEnabled = not getgenv().ESPEnabled
    ESPBtn.Text = "ESP : "..(getgenv().ESPEnabled and "ON" or "OFF")
end)

ESPSizeBox.FocusLost:Connect(function()
    local v = tonumber(ESPSizeBox.Text)
    if v then getgenv().ESPSize = math.clamp(v,2,50) end
    ESPSizeBox.Text = tostring(getgenv().ESPSize)
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
                        g.AlwaysOnTop = true
                        local t = Instance.new("TextLabel", g)
                        t.Size = UDim2.new(1,0,1,0)
                        t.BackgroundTransparency = 1
                        t.TextScaled = true
                        t.Text = p.Name
                        t.TextColor3 = Color3.fromRGB(0,255,0)
                    end
                    r.ESP.Size = UDim2.new(0,getgenv().ESPSize*10,0,getgenv().ESPSize*4)
                elseif r:FindFirstChild("ESP") then
                    r.ESP:Destroy()
                end
            end
        end
    end
end)

local f,lt=0,os.clock()
RunService.RenderStepped:Connect(function()
    f+=1
    if os.clock()-lt>=1 then
        FPS.Text="FPS : "..f
        f=0
        lt=os.clock()
    end
end)

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
        local d = i.Position - dragStart
        Frame.Position = UDim2.new(startFrame.X.Scale,startFrame.X.Offset+d.X,startFrame.Y.Scale,startFrame.Y.Offset+d.Y)
        ToggleBtn.Position = UDim2.new(startToggle.X.Scale,startToggle.X.Offset+d.X,startToggle.Y.Scale,startToggle.Y.Offset+d.Y)
    end
end)
