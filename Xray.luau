local Players = game:GetService("Players")
local player = Players.LocalPlayer

local tool = Instance.new("Tool")
tool.Name = "X-RayTool"
tool.Tip = "click to enable/disable"
tool.RequiresHandle = false
tool.Parent = player.Backpack

local originalTransparency = {}

local function enableXRay()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsDescendantOf(player.Character) then
            originalTransparency[part] = part.Transparency
            part.Transparency = 0.5
        end
    end
end

local function disableXRay()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsDescendantOf(player.Character) then
            part.Transparency = originalTransparency[part] or 0
        end
    end
end

local xRayEnabled = false
tool.Activated:Connect(function()
    if xRayEnabled then
        disableXRay()
    else
        enableXRay()
    end
    xRayEnabled = not xRayEnabled
end)