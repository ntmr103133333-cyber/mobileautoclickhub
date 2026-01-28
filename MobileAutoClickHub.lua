--==================================================
-- MOBILE AUTO CLICK HUB (COMPACT / ALL-IN-ONE)
-- AUTO CLICK / AUTO SPEED / GRAVITY / FPS
-- INFINITE JUMP / ESP / FOV / PLAYER TP
-- DRAG OK / FAKE LOADING (50=6s, 99=13s)
--==================================================

--================ SERVICES =================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--================ SETTINGS =================
local CORRECT_KEY = "ntmr1031"
local LOADING_TITLE = "まんこ穴中出しセックス あーん///blせっくすいくいくおほおほ"
local LOADING_SUB, LOADING_TIME = "Loading...", 9

getgenv().AutoClick = false
getgenv().GravityOn = false
getgenv().InfiniteJumpEnabled = false
getgenv().ESPEnabled = false
getgenv().FOVEnabled = false
getgenv().ESPSize = getgenv().ESPSize or 120

local DEFAULT_FOV, FOV_VALUE = Camera.FieldOfView, 120

--================ GUI ROOT =================
local Gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
Gui.Name = "MobileHub"
getgenv().MobileHub = Gui

local function NewUICorner(obj) Instance.new("UICorner", obj) end
local function NewButton(parent,text,posY)
    local b=Instance.new("TextButton",parent)
    b.Size=UDim2.new(1,-16,0,44)
    b.Position=UDim2.new(0,8,0,posY)
    b.Text=text
    b.TextScaled=true
    b.BackgroundColor3=Color3.fromRGB(45,45,45)
    b.TextColor3=Color3.new(1,1,1)
    NewUICorner(b)
    return b
end
local function NewBox(parent,placeholder,posY,default)
    local t=Instance.new("TextBox",parent)
    t.Size=UDim2.new(1,-16,0,40)
    t.Position=UDim2.new(0,8,0,posY)
    t.PlaceholderText=placeholder
    t.Text=default
    t.TextScaled=true
    t.BackgroundColor3=Color3.fromRGB(40,40,40)
    t.TextColor3=Color3.new(1,1,1)
    NewUICorner(t)
    return t
end

--================ MAIN FRAMES =================
local Main=Instance.new("Frame",Gui)
Main.Size, Main.Position, Main.BackgroundTransparency =
    UDim2.new(0,300,0,520),
    UDim2.new(0.5,-150,0.5,-260),
    1

local KeyFrame=Instance.new("Frame",Main)
KeyFrame.Size, KeyFrame.Position, KeyFrame.BackgroundColor3 =
    UDim2.new(0,220,0,140),
    UDim2.new(0.5,-110,0.5,-70),
    Color3.fromRGB(25,25,25)
NewUICorner(KeyFrame)

local KeyBox=NewBox(KeyFrame,"Key here",40,"")
local KeyBtn=NewButton(KeyFrame,"UNLOCK",85)

local Loading=Instance.new("Frame",Gui)
Loading.Size, Loading.Position, Loading.BackgroundColor3, Loading.Visible =
    UDim2.new(0,920,0,520),
    UDim2.new(0.5,-460,0.5,-260),
    Color3.fromRGB(10,10,10),
    false

local LTitle=Instance.new("TextLabel",Loading)
LTitle.Size, LTitle.Position, LTitle.Text, LTitle.TextScaled,
LTitle.BackgroundTransparency, LTitle.TextColor3 =
    UDim2.new(1,0,0.2,0),
    UDim2.new(0,0,0.35,0),
    LOADING_TITLE,
    true,
    1,
    Color3.new(1,1,1)

local LSub=Instance.new("TextLabel",Loading)
LSub.Size, LSub.Position, LSub.Text, LSub.TextScaled,
LSub.BackgroundTransparency, LSub.TextColor3 =
    UDim2.new(1,0,0.1,0),
    UDim2.new(0,0,0.55,0),
    LOADING_SUB,
    true,
    1,
    Color3.fromRGB(180,180,180)

local LoadBack=Instance.new("Frame",Loading)
LoadBack.Size, LoadBack.Position, LoadBack.BackgroundColor3 =
    UDim2.new(0.6,0,0,26),
    UDim2.new(0.2,0,0.65,0),
    Color3.fromRGB(40,40,40)
NewUICorner(LoadBack)

local LoadBar=Instance.new("Frame",LoadBack)
LoadBar.Size, LoadBar.BackgroundColor3 =
    UDim2.new(0,0,1,0),
    Color3.fromRGB(0,200,0)
NewUICorner(LoadBar)

local LoadText=Instance.new("TextLabel",LoadBack)
LoadText.Size, LoadText.BackgroundTransparency,
LoadText.TextScaled, LoadText.TextColor3, LoadText.Text =
    UDim2.new(1,0,1,0),
    1,
    true,
    Color3.new(1,1,1),
    "0 / 100"

local ToggleBtn=Instance.new("TextButton",Main)
ToggleBtn.Size, ToggleBtn.Position, ToggleBtn.Text,
ToggleBtn.Visible, ToggleBtn.TextScaled,
ToggleBtn.BackgroundColor3, ToggleBtn.TextColor3 =
    UDim2.new(0,140,0,44),
    UDim2.new(0,20,0,160),
    "まんこ",
    false,
    true,
    Color3.fromRGB(35,35,35),
    Color3.new(1,1,1)
NewUICorner(ToggleBtn)

local Frame=Instance.new("ScrollingFrame",Main)
Frame.Size, Frame.Position, Frame.Visible,
Frame.CanvasSize, Frame.ScrollBarThickness,
Frame.BackgroundColor3, Frame.Active =
    UDim2.new(0,260,0,360),
    UDim2.new(0,20,0,220),
    false,
    UDim2.new(0,0,0,860),
    6,
    Color3.fromRGB(25,25,25),
    true
NewUICorner(Frame)

--================ UI ELEMENTS =================
local SpeedBox = NewBox(Frame,"AUTO SPEED (0 = FAST)",10,"0")
local GravityBox = NewBox(Frame,"GRAVITY",55,"196.2")
local ESPSizeBox = NewBox(Frame,"ESP SIZE (2~50)",100,tostring(getgenv().ESPSize))

local AutoBtn = NewButton(Frame,"AUTO CLICK : OFF",150)
local GravityBtn = NewButton(Frame,"GRAVITY : OFF",200)
local FOVBtn = NewButton(Frame,"FOV : OFF",250)
local JumpBtn = NewButton(Frame,"INFINITE JUMP : OFF",300)
local ESPBtn = NewButton(Frame,"ESP : OFF",350)

local FPS=Instance.new("TextLabel",Frame)
FPS.Size, FPS.Position, FPS.TextScaled,
FPS.BackgroundColor3, FPS.TextColor3 =
    UDim2.new(1,-16,0,36),
    UDim2.new(0,8,0,410),
    true,
    Color3.fromRGB(35,35,35),
    Color3.new(1,1,1)
NewUICorner(FPS)

-- PLAYER TP
local TPBox = NewBox(Frame,"PLAYER NAME",460,"")
local TPBtn = NewButton(Frame,"TELEPORT TO PLAYER",510)

--================ FAKE LOADING =================
KeyBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text ~= CORRECT_KEY then return end
    KeyFrame.Visible=false
    Loading.Visible=true
    LoadBar.Size=UDim2.new(0,0,1,0)
    LoadText.Text="0 / 100"

    task.spawn(function()
        -- 0 -> 50
        for i=0,50 do
            LoadBar.Size=UDim2.new(i/100,0,1,0)
            LoadText.Text=i.." / 100"
            task.wait(LOADING_TIME/100)
        end
        task.wait(6) -- fake stop at 50

        -- 51 -> 99
        for i=51,99 do
            LoadBar.Size=UDim2.new(i/100,0,1,0)
            LoadText.Text=i.." / 100"
            task.wait(LOADING_TIME/100)
        end
        task.wait(13) -- fake stop at 99

        -- 100
        LoadBar.Size=UDim2.new(1,0,1,0)
        LoadText.Text="100 / 100"
        task.wait(0.5)
        Loading.Visible=false
        ToggleBtn.Visible=true
    end)
end)

--================ TOGGLES =================
ToggleBtn.MouseButton1Click:Connect(function()
    Frame.Visible=not Frame.Visible
    ToggleBtn.Text=Frame.Visible and "まんこ" or "ちんこ"
end)

AutoBtn.MouseButton1Click:Connect(function()
    getgenv().AutoClick=not getgenv().AutoClick
    AutoBtn.Text="AUTO CLICK : "..(getgenv().AutoClick and "ON" or "OFF")
end)

GravityBtn.MouseButton1Click:Connect(function()
    getgenv().GravityOn=not getgenv().GravityOn
    workspace.Gravity=getgenv().GravityOn and (tonumber(GravityBox.Text) or 196.2) or 196.2
    GravityBtn.Text="GRAVITY : "..(getgenv().GravityOn and "ON" or "OFF")
end)

FOVBtn.MouseButton1Click:Connect(function()
    getgenv().FOVEnabled=not getgenv().FOVEnabled
    Camera.FieldOfView=getgenv().FOVEnabled and FOV_VALUE or DEFAULT_FOV
    FOVBtn.Text="FOV : "..(getgenv().FOVEnabled and "ON" or "OFF")
end)

JumpBtn.MouseButton1Click:Connect(function()
    getgenv().InfiniteJumpEnabled=not getgenv().InfiniteJumpEnabled
    JumpBtn.Text="INFINITE JUMP : "..(getgenv().InfiniteJumpEnabled and "ON" or "OFF")
end)

ESPBtn.MouseButton1Click:Connect(function()
    getgenv().ESPEnabled=not getgenv().ESPEnabled
    ESPBtn.Text="ESP : "..(getgenv().ESPEnabled and "ON" or "OFF")
end)

ESPSizeBox.FocusLost:Connect(function()
    local v=tonumber(ESPSizeBox.Text)
    if v then getgenv().ESPSize=math.clamp(v,2,50) end
    ESPSizeBox.Text=tostring(getgenv().ESPSize)
end)

--================ PLAYER TP =================
TPBtn.MouseButton1Click:Connect(function()
    local name = TPBox.Text
    if name=="" then return end
    for _,p in pairs(Players:GetPlayers()) do
        if string.lower(p.Name)==string.lower(name) then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame =
                    p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-3)
            end
        end
    end
end)

--================ ESP =================
task.spawn(function()
    while task.wait(0.5) do
        for _,p in pairs(Players:GetPlayers()) do
            if p~=Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local r=p.Character.HumanoidRootPart
                if getgenv().ESPEnabled then
                    if not r:FindFirstChild("ESP") then
                        local g=Instance.new("BillboardGui",r)
                        g.Name="ESP"; g.AlwaysOnTop=true
                        local t=Instance.new("TextLabel",g)
                        t.Size=UDim2.new(1,0,1,0)
                        t.BackgroundTransparency=1
                        t.TextScaled=true
                        t.Text=p.Name
                        t.TextColor3=Color3.fromRGB(0,255,0)
                    end
                    r.ESP.Size=UDim2.new(0,getgenv().ESPSize*10,0,getgenv().ESPSize*4)
                elseif r:FindFirstChild("ESP") then
                    r.ESP:Destroy()
                end
            end
        end
    end
end)

--================ AUTO CLICK =================
task.spawn(function()
    while task.wait(0.03) do
        if getgenv().AutoClick then
            local c=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y/2)
            VirtualUser:Button1Down(c,Camera.CFrame)
            VirtualUser:Button1Up(c,Camera.CFrame)
        end
    end
end)

--================ FPS =================
local f,lt=0,os.clock()
RunService.RenderStepped:Connect(function()
    f+=1
    if os.clock()-lt>=1 then
        FPS.Text="FPS : "..f
        f=0; lt=os.clock()
    end
end)

--================ DRAG (TOGGLE + FRAME) =================
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
UIS.InputChanged:Connect(function(i)
    if dragging and i.UserInputType==Enum.UserInputType.Touch then
        local d=i.Position-dragStart
        Frame.Position=UDim2.new(startFrame.X.Scale,startFrame.X.Offset+d.X,startFrame.Y.Scale,startFrame.Y.Offset+d.Y)
        ToggleBtn.Position=UDim2.new(startToggle.X.Scale,startToggle.X.Offset+d.X,startToggle.Y.Scale,startToggle.Y.Offset+d.Y)
    end
end)

--================ INFINITE JUMP =================
UIS.JumpRequest:Connect(function()
    if getgenv().InfiniteJumpEnabled and Player.Character then
        local h=Player.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)
