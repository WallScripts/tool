local Players = game:GetService("Players")
local player = Players.LocalPlayer

local speed = 32

local tool = Instance.new("Tool")
tool.Name = "Speed"
tool.RequiresHandle = false
tool.ToolTip = "click to change speed to " .. speed .. " / click again to go back to normal"
tool.Parent = player.Backpack

local enabled = false
local originalSpeed

tool.Activated:Connect(function()
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if enabled then
        humanoid.WalkSpeed = originalSpeed
    else
        originalSpeed = humanoid.WalkSpeed
        humanoid.WalkSpeed = speed
    end
    
    enabled = not enabled
end)