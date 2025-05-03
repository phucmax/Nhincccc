local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "phucmax",
    SubTitle = "Script Tổng Hợp",
    TabWidth = 150,
    Size = UDim2.fromOffset(450, 360),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.End
})

local RunService = game:GetService("RunService")

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 100, 0, 30)
fpsLabel.Position = UDim2.new(1, -110, 0, 10)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
fpsLabel.TextStrokeTransparency = 0
fpsLabel.TextScaled = true
fpsLabel.Font = Enum.Font.SourceSansBold
fpsLabel.Text = "FPS: 60"
fpsLabel.Parent = game:GetService("CoreGui"):FindFirstChildOfClass("ScreenGui") or Window -- Nếu có GUI gốc

local lastTime = tick()
local frameCount = 0
RunService.RenderStepped:Connect(function()
    frameCount += 1
    local now = tick()
    if now - lastTime >= 1 then
        fpsLabel.Text = "FPS: " .. frameCount
        frameCount = 0
        lastTime = now
    end
end)


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ControlGUI"
screenGui.Parent = game.CoreGui


local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://127891021541366" 
Sound.Volume = 100
Sound.PlayOnRemove = true 
Sound.Parent = game:GetService("SoundService")
Sound:Destroy() 

local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 45, 0, 45)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Image = "rbxassetid://135546946645914"
toggleButton.BackgroundTransparency = 1
toggleButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = toggleButton

local isFluentVisible = true
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    toggleButton.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = toggleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

toggleButton.MouseButton1Click:Connect(function()
    isFluentVisible = not isFluentVisible
    Window:Minimize(not isFluentVisible)
end)


local tabs = {
    {Name = "Script Tổng Hợp", Icon = "home"},
    {Name = "Script Bounty", Icon = "swords"},
    {Name = "Script FixLag", Icon = "cpu"},
    {Name = "Nhặt Trái", Icon = "apple"},
    {Name = "Hop Sever", Icon = "globe"},
}

local createdTabs = {}
for _, tab in pairs(tabs) do
    createdTabs[tab.Name] = Window:AddTab({
        Title = tab.Name,
        Icon = tab.Icon
    })
end


createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "min",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zunes-Bypassed/NOPE/main/Min.lua"))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "TuanAnhIOS",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhDzaiScript/TuanAnhIOS/refs/heads/main/TuanAnhIOS-Piaa.lua"))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "Turbo Lite",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/refs/heads/main/Main.lua"))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "mingaming",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinBE"))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "rubu",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/RubuRoblox/refs/heads/main/RubuBF"))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "rise",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TrashLua/BloxFruits/main/FreeScripts.lua"))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "speed hub",
    Description = "nhấn để chạy script",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "mizu",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet('https://github.com/diemquy/CutTayHub/blob/main/Cuttayhubreal.lua'))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "HiruHub",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NGUYENVUDUY1/Dev-Hiru/refs/heads/main/HiruHub.lua"))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "HOHO hub",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "AnDepZaiHub",
    Description = "nhấn để chạy script",
    Callback = function()
        repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
loadstring(game:HttpGet("https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHubBeta/refs/heads/main/AnDepZaiHubNewUpdated.lua"))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "Bluex",
    Description = "nhấn để chạy script",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua"))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "bapred",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/BapRed/main/BapRedHub"))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "w-azure",
    Description = "nhấn để chạy script",
    Callback = function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "redz hub",
    Description = "nhấn để chạy script",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/newredz/BloxFruits/refs/heads/main/Source.luau"))(Settings)
    end
})

createdTabs["Script Tổng Hợp"]:AddButton({
    Title = "TsuoHub",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))()
    end
})

createdTabs["Script Bounty"]:AddButton({
    Title = "auto Bounty ",
    Description = "nhấn để chạy script",
    Callback = function()
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/10f7f97cebba24a87808c36ebd345a97.lua"))()
    end
})

createdTabs["Script FixLag"]:AddButton({
    Title = "Turbo Lite Fix Lag",
    Description = "nhấn để chạy script ",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/main/FixLag.lua"))()
    end
})

createdTabs["Nhặt Trái"]:AddButton({
    Title = "Turbo Lite Nhặt Trái",
    Description = "Nhặt trái ",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/refs/heads/main/TraiCay.lua"))()
    end
})

createdTabs["Hop Sever"]:AddButton({
    Title = "Cuttay",
    Description = "Tìm server",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/diemquy/CutTayHub/main/Cuttayhubreal.lua'))()
    end
})

createdTabs["Hop Sever"]:AddButton({
    Title = "TeddyHop",
    Description = "Tìm server",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletgojo/Haidepzai/refs/heads/main/TeddyHop-FREE"))()
    end
})

createdTabs["Hop Sever"]:AddButton({
    Title = "Rip_indra hop",
    Description = "Tìm server",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibidip1/Hack/refs/heads/main/Rip_indra"))()
    end
})

createdTabs["Hop Sever"]:AddButton({
    Title = "boss đại bàng hop",
    Description = "Tìm server",
    Callback = function()
        -- Thêm lệnh để tìm server cho boss đại bàng
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibidip1/Hack/refs/heads/main/Tyrant%20of%20the%20Skies"))()
    end
})

createdTabs["Hop Sever"]:AddButton({
    Title = "boss hop",
    Description = "Tìm server",
    Callback = function()
        -- Thêm lệnh tìm server cho boss
        getgenv().Mode = "rip_indra" 
        getgenv().Team = "Marines"
        repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/f0952c4a5f3db9e01f4dbd099c1f9b3c.lua"))()
    end
})

local lastNotificationTime = 0
local notificationCooldown = 10
local currentTime = tick()

if currentTime - lastNotificationTime >= notificationCooldown then
    game.StarterGui:SetCore("SendNotification", {
        Title = "phucmaxtonghop", 
        Text = "Việt Nam muôn năm",
        Duration = 1,
        Icon = "rbxassetid://135546946645914" 
    })
    lastNotificationTime = currentTime
end
 