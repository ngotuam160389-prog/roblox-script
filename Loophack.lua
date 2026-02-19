local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- Thiết lập các giá trị bạn muốn
local targetSpeed = 24
local targetJump = 50

RunService.Stepped:Connect(function()
    if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = localPlayer.Character.Humanoid
        
        -- Luôn gán lại giá trị để duy trì vòng lặp
        humanoid.WalkSpeed = targetSpeed
        humanoid.JumpPower = targetJump
        
        -- Đảm bảo Humanoid sử dụng JumpPower thay vì JumpHeight
        humanoid.UseJumpPower = true
    end
end)
