-- GUI Toggle & Fast Run Script (Force Push 60)
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Tạo ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FastRunGui"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Menu chính (Bo tròn & Zero Gap)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 150, 0, 50)
MainFrame.Position = UDim2.new(0.5, -75, 0.8, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Bo tròn góc (UICorner)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = Tool.UDim.new(0, 10) -- Bo tròn theo ý thích
UICorner.Parent = MainFrame

-- Nút bấm Chạy Nhanh (Lực đẩy 60)
local FastRunBtn = Instance.new("TextButton")
FastRunBtn.Name = "FastRunBtn"
FastRunBtn.Size = UDim2.new(1, 0, 1, 0) -- Zero Gap (Lấp đầy Frame)
FastRunBtn.BackgroundTransparency = 1
FastRunBtn.Text = "FORCE PUSH (60)"
FastRunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FastRunBtn.Font = Enum.Font.GothamBold
FastRunBtn.TextSize = 14
FastRunBtn.Parent = MainFrame

-- Hàm xử lý lực đẩy
local function ApplyForce()
    local BV = Instance.new("BodyVelocity")
    BV.MaxForce = Vector3.new(100000, 0, 100000) -- Chỉ đẩy theo phương ngang
    BV.Velocity = HumanoidRootPart.CFrame.LookVector * 60 -- Lực đẩy tới 60
    BV.Parent = HumanoidRootPart
    
    wait(0.1) -- Thời gian đẩy ngắn để tạo cảm giác lướt
    BV:Destroy()
end

-- Kích hoạt khi nhấn nút
FastRunBtn.MouseButton1Click:Connect(function()
    ApplyForce()
end)

-- Kích hoạt bằng phím tắt (Ví dụ: phím Q)
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Q then
        ApplyForce()
    end
end)

print("Script Loaded: Force Push 60 with Rounded Zero Gap GUI")
