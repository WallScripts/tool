local Players = game:GetService("Players")
local player = Players.LocalPlayer

local tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Tp"
tool.ToolTip = "click to teleport(mouse)"

tool.Activated:Connect(function()
    local mouse = player:GetMouse()
    local targetPosition = mouse.Hit.Position + Vector3.new(0, 2.5, 0)
    player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
end)

tool.Parent = player.Backpack
