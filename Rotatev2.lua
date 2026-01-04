local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Thiết lập GUI
ScreenGui.Parent = game.CoreGui
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 100, 0, 45)
ToggleButton.Position = UDim2.new(0.5, -50, 0.1, 0)
ToggleButton.Text = "Rotate: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 16
ToggleButton.Active = true
ToggleButton.Draggable = true -- Cho phép di chuyển nút

UICorner.Parent = ToggleButton

-- Biến logic
local active = false
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- Xử lý Bật/Tắt
ToggleButton.MouseButton1Click:Connect(function()
    active = not active
    if active then
        ToggleButton.Text = "Rotate: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
    else
        ToggleButton.Text = "Rotate: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

-- Vòng lặp xoay nhân vật
RunService.RenderStepped:Connect(function()
    if active then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local rootPart = char.HumanoidRootPart
            local lookVector = camera.CFrame.LookVector
            local targetRotation = math.atan2(-lookVector.X, -lookVector.Z)
            rootPart.CFrame = CFrame.new(rootPart.Position) * CFrame.Angles(0, targetRotation, 0)
        end
    end
end)
