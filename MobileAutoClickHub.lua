--==================================================
-- MOBILE AUTO CLICK HUB (FULL VERSION / SPIN 99999)
-- Rayfield Edition (Original Text Preserved)
--==================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 設定とテキストの保持
local CORRECT_KEY   = "ntmr1031"
local LOADING_TITLE = "まんこ穴中出しセックス あーん///blせっくすいくいくおほおほ"
local TOGGLE_TEXT_ON = "まんこ"
local TOGGLE_TEXT_OFF = "ちんこ"

local Window = Rayfield:CreateWindow({
   Name = "MOBILE AUTO CLICK HUB",
   LoadingTitle = LOADING_TITLE, -- 元のテキストをロード画面に使用
   LoadingSubtitle = "Loading...",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = true,
   KeySettings = {
      Title = "Key System",
      Subtitle = "Enter Key",
      Note = "Key is: ntmr1031",
      FileName = "MobileHubKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {CORRECT_KEY}
   }
})

--================ SERVICES =================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--================ GLOBALS =================
getgenv().AutoClick = false
getgenv().SpinEnabled = false
getgenv().SpinSpeed = 99999
getgenv().InfiniteJumpEnabled = false
getgenv().ESPEnabled = false
getgenv().ESPSize = 120

--================ TABS =================
local MainTab = Window:CreateTab(TOGGLE_TEXT_ON, 4483362458) -- タブ名を元のテキストに
local VisualTab = Window:CreateTab("Visuals", 4483362458)

--================ MAIN FUNCTIONS =================

-- Auto Click
MainTab:CreateToggle({
   Name = "AUTO CLICK",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoClick = Value
   end,
})

-- Spin Bot
MainTab:CreateToggle({
   Name = "SPIN",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().SpinEnabled = Value
   end,
})

MainTab:CreateInput({
   Name = "SPIN SPEED",
   PlaceholderText = "99999",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      getgenv().SpinSpeed = tonumber(Text) or 99999
   end,
})

-- Gravity
MainTab:CreateInput({
   Name = "GRAVITY (Default: 196.2)",
   PlaceholderText = "196.2",
   Callback = function(Text)
      workspace.Gravity = tonumber(Text) or 196.2
   end,
})

-- Infinite Jump
MainTab:CreateToggle({
   Name = "INFINITE JUMP",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().InfiniteJumpEnabled = Value
   end,
})

--================ VISUAL FUNCTIONS =================

-- ESP
VisualTab:CreateToggle({
   Name = "ESP",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().ESPEnabled = Value
   end,
})

VisualTab:CreateInput({
   Name = "ESP SIZE (2~50)",
   PlaceholderText = "120",
   Callback = function(Text)
      getgenv().ESPSize = tonumber(Text) or 120
   end,
})

-- FOV
VisualTab:CreateToggle({
   Name = "FOV (120)",
   CurrentValue = false,
   Callback = function(Value)
      Camera.FieldOfView = Value and 120 or 70
   end,
})

--================ LOGIC LOOPS =================

-- Spin
RunService.RenderStepped:Connect(function()
    if getgenv().SpinEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = Player.Character.HumanoidRootPart
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(getgenv().SpinSpeed), 0)
    end
end)

-- Auto Click
task.spawn(function()
    while task.wait(0.03) do
        if getgenv().AutoClick then
            local c = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            VirtualUser:Button1Down(c, Camera.CFrame)
            VirtualUser:Button1Up(c, Camera.CFrame)
        end
    end
end)

-- Infinite Jump
UIS.JumpRequest:Connect(function()
    if getgenv().InfiniteJumpEnabled and Player.Character then
        local h = Player.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- ESP
task.spawn(function()
    while task.wait(0.5) do
        if getgenv().ESPEnabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local r = p.Character.HumanoidRootPart
                    if not r:FindFirstChild("ESP") then
                        local g = Instance.new("BillboardGui", r)
                        g.Name = "ESP"
                        g.AlwaysOnTop = true
                        local t = Instance.new("TextLabel", g)
                        t.Size = UDim2.new(1, 0, 1, 0)
                        t.BackgroundTransparency = 1
                        t.TextScaled = true
                        t.Text = p.Name
                        t.TextColor3 = Color3.fromRGB(0,255,0)
                    end
                    r.ESP.Size = UDim2.new(0, getgenv().ESPSize*10, 0, getgenv().ESPSize*4)
                end
            end
        else
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:FindFirstChild("ESP") then
                    p.Character.HumanoidRootPart.ESP:Destroy()
                end
            end
        end
    end
end)

-- Aimbot Load
pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DanielHubll/DanielHubll/refs/heads/main/Aimbot%20Mobile"))()
end)
