--==================================================
-- MOBILE AUTO CLICK HUB (FULL VERSION / ALL IN ONE)
-- Rayfield Edition (Original Text & Manual Aimbot Load)
--==================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- 元のテキスト設定（一切変更なし）
local CORRECT_KEY   = "ntmr1031"
local LOADING_TITLE = "まんこ穴中出しセックス あーん///blせっくすいくいくおほおほ"
local TAB_NAME_1    = "まんこ"

local Window = Rayfield:CreateWindow({
   Name = "MOBILE AUTO CLICK HUB",
   LoadingTitle = LOADING_TITLE,
   LoadingSubtitle = "Ready to load modules...",
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

--================ MAIN TAB =================

MainTab:CreateToggle({
   Name = "AUTO CLICK",
   CurrentValue = false,
   Callback = function(Value) getgenv().AutoClick = Value end,
})

MainTab:CreateToggle({
   Name = "INFINITE JUMP",
   CurrentValue = false,
   Callback = function(Value) getgenv().InfiniteJumpEnabled = Value end,
})

-- 【リクエスト】ボタンを押した時だけAimbotを読み込む
MainTab:CreateButton({
   Name = "LOAD AIMBOT MOBILE",
   Callback = function()
      Rayfield:Notify({Title = "Loading", Content = "Starting Aimbot...", Duration = 2})
      pcall(function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/DanielHubll/DanielHubll/refs/heads/main/Aimbot%20Mobile"))()
      end)
   end,
})

MainTab:CreateToggle({
   Name = "SPIN",
   CurrentValue = false,
   Callback = function(Value) getgenv().SpinEnabled = Value end,
})

MainTab:CreateInput({
   Name = "SPIN SPEED",
   PlaceholderText = "99999",
   Callback = function(Text) getgenv().SpinSpeed = tonumber(Text) or 99999 end,
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
      if name == "" then return end
      local found = false
      for _, p in pairs(Players:GetPlayers()) do
         if p.Name:lower():find(name) or (p.DisplayName and p.DisplayName:lower():find(name)) then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
               Player.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
               found = true
               Rayfield:Notify({Title = "Success", Content = "Teleported to " .. p.Name, Duration = 2})
               break
            end
         end
      end
      if not found then Rayfield:Notify({Title = "Error", Content = "Player not found", Duration = 2}) end
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

VisualTab:CreateSlider({
   Name = "ESP TEXT SIZE",
   Range = {10, 50},
   Increment = 1,
   CurrentValue = 20,
   Callback = function(Value) getgenv().ESPSize = Value end,
})

VisualTab:CreateSlider({
   Name = "FOV CHANGER",
   Range = {70, 120},
   Increment = 1,
   CurrentValue = 70,
   Callback = function(Value) Camera.FieldOfView = Value end,
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
    while task.wait(0.5) do
        UpdateESP()
    end
end)

-- Spin Logic
RunService.RenderStepped:Connect(function()
    if getgenv().SpinEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(getgenv().SpinSpeed), 0)
    end
end)

-- Auto Click Logic
task.spawn(function()
    while task.wait(0.03) do
        if getgenv().AutoClick then
            VirtualUser:Button1Down(Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2), Camera.CFrame)
            VirtualUser:Button1Up(Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2), Camera.CFrame)
        end
    end
end)
