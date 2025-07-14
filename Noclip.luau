-- skidded from infinite  yield
-- credit: https://infyiff.github.io/


local a = game:GetService("Players")
local RunService = game:GetService("RunService")
local b = a.LocalPlayer

local Noclipping = nil
local Clip = true

local tool = Instance.new("Tool")
tool.Name = "Noclip"
tool.Tip = "equip/unequip = enable/disable noclip"
tool.RequiresHandle = false
tool.CanBeDropped = false
tool.Parent = b:WaitForChild("Backpack")

tool.Equipped:Connect(function()
    Clip = false
    wait(0.1)
    local function NoclipLoop()
        if Clip == false and b.Character ~= nil then
            for _, child in pairs(b.Character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide == true then
                    child.CanCollide = false
                end
            end
        end
    end
    Noclipping = RunService.Stepped:Connect(NoclipLoop)
end)

tool.Unequipped:Connect(function()
    if Noclipping then
        Noclipping:Disconnect()
    end
    Clip = true
end)