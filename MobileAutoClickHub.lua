--==================================================
-- MOBILE AUTO CLICK HUB (FULL VERSION / SPEED 0 FIXED)
-- Rayfield Edition (Original Text & Speed 0 Support)
--==================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 元のテキスト設定（一切変更なし）
local CORRECT_KEY   = "ntmr1031"
local LOADING_TITLE = "まんこ穴中出しセックス あーん///blせっくすいくいくおほおほ"
local TAB_NAME_1    = "まんこ"

local Window = Rayfield:CreateWindow({
   Name = "MOBILE AUTO CLICK HUB",
   LoadingTitle = LOADING_TITLE,
   LoadingSubtitle = "Setting Auto Clicker to Max Speed...",
   ConfigurationSaving = { Enabled = false },
   KeySystem = true,
   KeySettings = {
      Title = "Key System",
      Subtitle = "Enter Key",
      Note = "Key is: ntmr1031",
      Key = {CORRECT_KEY}
   }
})

--================ SERVICES =================
local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local UIS           = game:GetService("UserInputService")
local VirtualUser   = game:GetService("VirtualUser")
local Player        = Players.LocalPlayer
local Camera        = workspace.CurrentCamera

--================ GLOBALS =================
getgenv().AutoClick           = false
getgenv().AutoClickSpeed      = 0 -- デフォルト最速
getgenv().SpinEnabled         = false
getgenv().SpinSpeed           = 99999
getgenv().InfiniteJumpEnabled = false
getgenv().ESPEnabled          = false
getgenv().ESPSize             = 20
local TargetPlayerName        = ""

--================ TABS =================
local MainTab = Window:CreateTab(TAB_NAME_1, 4483362458)
local PlayerTab = Window:CreateTab("Players", 4483362458)
local VisualTab = Window:CreateTab("Visuals", 4483362458)

--================ ESP CORE LOGIC =================
local function UpdateESP()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local gui = hrp:FindFirstChild("ESP_Gui")
            
            if getgenv().ESPEnabled then
                if not gui then
                    gui = Instance.new("BillboardGui", hrp)
                    gui.Name = "ESP_Gui"
                    gui.AlwaysOnTop = true
                    gui.ExtentsOffset = Vector3.new(0, 3, 0)
                    gui.Size = UDim2.new(0, 200, 0, 50)
                    
                    local tl = Instance.new("TextLabel", gui)
                    tl.Name = "ESP_Label"
                    tl.BackgroundTransparency = 1
                    tl.Size = UDim2.new(1, 0, 1, 0)
                    tl.Text = p.DisplayName or p.Name
                    tl.TextColor3 = Color3.fromRGB(0, 255, 0)
                    tl.TextStrokeTransparency = 0
                end
                if gui:FindFirstChild("ESP_Label") then
                    gui.ESP_Label.TextSize = getgenv().ESPSize
                end
            else
                if gui then gui:Destroy() end
            end
        end
    end
end

--================ MAIN TAB (Auto Click Speed Fixed) =================

MainTab:CreateToggle({
   Name = "AUTO CLICK",
   CurrentValue = false,
   Callback = function(Value) getgenv().AutoClick = Value end,
})

-- 【リクエスト】速さを入力。0にすると最速（0.01）で待機
MainTab:CreateInput({
   Name = "AUTO CLICK SPEED (0 = FASTEST)",
   PlaceholderText = "0",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local s = tonumber(Text) or 0
      getgenv().AutoClickSpeed = s
   end,
})

MainTab:CreateToggle({
   Name = "INFINITE JUMP",
   CurrentValue = false,
   Callback = function(Value) getgenv().InfiniteJumpEnabled = Value end,
})

MainTab:CreateInput({
   Name = "GRAVITY VALUE",
   PlaceholderText = "196.2",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      workspace.Gravity = tonumber(Text) or 196.2
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

MainTab:CreateToggle({
   Name = "SPIN ENABLE",
   CurrentValue = false,
   Callback = function(Value) getgenv().SpinEnabled = Value end,
})

MainTab:CreateButton({
   Name = "LOAD AIMBOT MOBILE",
   Callback = function()
      pcall(function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/DanielHubll/DanielHubll/refs/heads/main/Aimbot%20Mobile"))()
      end)
   end,
})

--================ PLAYER TAB =================

PlayerTab:CreateInput({
   Name = "Target Player Name",
   PlaceholderText = "Enter Name...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) TargetPlayerName = Text end,
})

PlayerTab:CreateButton({
   Name = "TELEPORT TO PLAYER",
   Callback = function()
      local name = TargetPlayerName:lower()
      for _, p in pairs(Players:GetPlayers()) do
         if p.Name:lower():find(name) or (p.DisplayName and p.DisplayName:lower():find(name)) then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
               Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
               break
            end
         end
      end
   end,
})

--================ VISUAL TAB =================

VisualTab:CreateToggle({
   Name = "ENABLE ESP",
   CurrentValue = false,
   Callback = function(Value) 
      getgenv().ESPEnabled = Value 
      if not Value then UpdateESP() end
   end,
})

VisualTab:CreateInput({
   Name = "ESP TEXT SIZE",
   PlaceholderText = "20",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      getgenv().ESPSize = tonumber(Text) or 20
   end,
})

VisualTab:CreateInput({
   Name = "FOV VALUE",
   PlaceholderText = "70 - 120",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      local val = tonumber(Text)
      if val then Camera.FieldOfView = val end
   end,
})

--================ LOGIC LOOPS =================

-- Infinite Jump
UIS.JumpRequest:Connect(function()
    if getgenv().InfiniteJumpEnabled and Player.Character then
        local h = Player.Character:FindFirstChildOfClass("Humanoid")
        if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- ESP Loop
task.spawn(function()
    while task.wait(0.5) do UpdateESP() end
end)

-- Spin Logic
RunService.RenderStepped:Connect(function()
    if getgenv().SpinEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(getgenv().SpinSpeed), 0)
    end
end)

-- Auto Click Logic (Speed Support)
task.spawn(function()
    while true do
        if getgenv().AutoClick then
            local delayTime = getgenv().AutoClickSpeed
            if delayTime <= 0 then delayTime = 0.01 end -- 0なら最速
            
            VirtualUser:Button1Down(Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2), Camera.CFrame)
            VirtualUser:Button1Up(Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2), Camera.CFrame)
            task.wait(delayTime)
        else
            task.wait(0.1)
        end
    end
end)
