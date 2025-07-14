local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local tool = Instance.new("Tool")
tool.Name = "Coords"
tool.RequiresHandle = false
tool.ToolTip = "Click to get your coordinates and copy to clipboard"
tool.Parent = player.Backpack

local function updateTooltip()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local pos = hrp.Position
        local coord = string.format("%.2f, %.2f, %.2f", pos.X, pos.Y, pos.Z)
        tool.ToolTip = "Click to get your coordinates and copy to clipboard (" .. coord .. ")"
    else
        tool.ToolTip = "Click to get your coordinates and copy to clipboard (No position)"
    end
end

local connection = RunService.Heartbeat:Connect(updateTooltip)

tool.Activated:Connect(function()
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local position = humanoidRootPart.Position
    local coord2 = tostring(position)
    
    setclipboard(coord2)
end)

tool.AncestryChanged:Connect(function()
    if not tool.Parent then
        connection:Disconnect()
    end
end)