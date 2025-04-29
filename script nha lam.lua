local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "PHUCMAX HUB",
    SubTitle = "Script Tổng Hợp",
    TabWidth = 150,
    Size = UDim2.fromOffset(560, 360),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.End
})

-- Tạo GUI điều khiển toggle
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ControlGUI"
screenGui.Parent = game.CoreGui

local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 45, 0, 45)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Image = "rbxassetid://114009263825021"
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

-- Tab Tổng Hợp
local generalTab = Window:AddTab({
    Title = "Script Tổng Hợp",
    Icon = "package"
})

generalTab:AddParagraph({
    Title = "Chú Ý",
    Content = "Không được dùng quá nhiều script cùng một lúc"
})

generalTab:AddButton({Title = "TsuoHub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))() end})
generalTab:AddButton({Title = "Xero Hub", Callback = function() getgenv().Team = "Marines"; getgenv().Hide_Menu = false; getgenv().Auto_Execute = false; loadstring(game:HttpGet("https://raw.githubusercontent.com/Xero2409/XeroHub/refs/heads/main/main.lua"))() end})
generalTab:AddButton({Title = "Redz Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/newredz/BloxFruits/refs/heads/main/Source.luau"))() end})
generalTab:AddButton({Title = "Hoho Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))() end})
generalTab:AddButton({Title = "W-Azure", Callback = function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))() end})
generalTab:AddButton({Title = "Turbo Lite", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/refs/heads/main/Main.lua"))() end})
generalTab:AddButton({Title = "Tuấn Anh IOS Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhDzaiScript/TuanAnhIOS/refs/heads/main/TuanAnhIOS-Piaa.lua"))() end})

-- Tab Script Việt Nam
local scripvnTab = Window:AddTab({
    Title = "Script VN",
    Icon = "package"
})

scripvnTab:AddParagraph({
    Title = "Chú Ý",
    Content = "Không được dùng quá nhiều script cùng một lúc"
})

scripvnTab:AddButton({Title = "RUBU", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/RubuRoblox/refs/heads/main/RubuBF"))() end})
scripvnTab:AddButton({Title = "AnDepZaiHub", Callback = function() repeat wait() until game:IsLoaded() and game.Players.LocalPlayer; loadstring(game:HttpGet("https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHubBeta/refs/heads/main/AnDepZaiHubNewUpdated.lua"))() end})
scripvnTab:AddButton({Title = "Min", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Zunes-Bypassed/NOPE/main/Min.lua"))() end})
scripvnTab:AddButton({Title = "BapRed", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/BapRed/main/BapRedHub"))() end})

-- Tab Auto Bounty
local bountyTab = Window:AddTab({
    Title = "Script Auto Bounty",
    Icon = "sword"
})

bountyTab:AddButton({
    Title = "Auto Bounty Full Config",
    Callback = function()
        repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
        getgenv().Team = "Pirates"
        getgenv().Config = {
            ["Safe Health"] = {50},
            ["Custom Y Run"] = {Enabled = true, ["Y Run"] = 5000},
            ["Hunt Method"] = {
                ["Use Move Predict"] = true,
                ["Hit and Run"] = true,
                ["Aimbot"] = true,
                ["ESP Player"] = true,
                ["Max Attack Time"] = 60
            },
            ["Shop"] = {["Random Fruit"] = false, ["Store Fruit"] = true, ["Zoro Sword"] = false},
            ["Setting"] = {
                ["World"] = 3,
                ["White Screen"] = false,
                ["Click Delay"] = 0.1,
                ["Url"] = "Your_Webhook_Url",
                ["Chat"] = {Enabled = true, Wait = 350, Massage = {"Lion Hub On Top", "Get Best Script g g / lionhub"}}
            },
            ["Skip"] = {["Avoid V4"] = false},
            ["Spam All Skill On V4"] = {
                Enabled = true,
                ["Weapons"] = {"Melee", "Sword", "Gun", "Blox Fruit"}
            },
            Items = {
                Use = {"Melee", "Sword"},
                Melee = {
                    Enable = true,
                    Delay = 0.6,
                    Skills = {
                        Z = {Enable = true, HoldTime = 0.3},
                        X = {Enable = true, HoldTime = 0.2},
                        C = {Enable = true, HoldTime = 0.5}
                    }
                },
                Sword = {
                    Enable = true,
                    Delay = 0.5,
                    Skills = {
                        Z = {Enable = true, HoldTime = 1},
                        X = {Enable = true, HoldTime = 0}
                    }
                },
                Gun = {
                    Enable = false,
                    Delay = 0.2,
                    Skills = {
                        Z = {Enable = false, HoldTime = 0.1},
                        X = {Enable = false, HoldTime = 0.1}
                    }
                },
                ["Blox Fruit"] = {
                    Enable = true,
                    Delay = 0.4,
                    Skills = {
                        Z = {Enable = true, HoldTime = 0.1},
                        X = {Enable = true, HoldTime = 0.1},
                        C = {Enable = true, HoldTime = 0.15},
                        V = {Enable = false, HoldTime = 0.2},
                        F = {Enable = true, HoldTime = 0.1}
                    }
                }
            }
        }
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/10f7f97cebba24a87808c36ebd345a97.lua"))()
    end
})

bountyTab:AddButton({
    Title = "Lion Auto Bounty",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/l1siGJS1/raw"))()
    end
})
