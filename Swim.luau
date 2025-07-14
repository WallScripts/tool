-- skidded from infite  yield
-- credit: https://infyiff.github.io/


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local tool = Instance.new("Tool")
tool.Name = "Swim"
tool.RequiresHandle = false
tool.ToolTip = "Click to swim in air / click again to disable"
tool.Parent = player.Backpack

local swimming = false
local oldgrav = workspace.Gravity
local swimbeat = nil
local gravReset = nil

tool.Activated:Connect(function()
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")
    if not humanoid then return end
    
    if not swimming then
        oldgrav = workspace.Gravity
        workspace.Gravity = 0
        
        local swimDied = function()
            workspace.Gravity = oldgrav
            swimming = false
        end
        
        gravReset = humanoid.Died:Connect(swimDied)
        
        local enums = Enum.HumanoidStateType:GetEnumItems()
        table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
        for i, v in pairs(enums) do
            humanoid:SetStateEnabled(v, false)
        end
        
        humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
        
        swimbeat = RunService.Heartbeat:Connect(function()
            pcall(function()
                character.HumanoidRootPart.Velocity = ((humanoid.MoveDirection ~= Vector3.new() or UserInputService:IsKeyDown(Enum.KeyCode.Space)) and character.HumanoidRootPart.Velocity or Vector3.new())
            end)
        end)
        
        swimming = true
        tool.Name = "Unswim"
    else
        workspace.Gravity = oldgrav
        swimming = false
        
        if gravReset then
            gravReset:Disconnect()
        end
        
        if swimbeat then
            swimbeat:Disconnect()
            swimbeat = nil
        end
        
        local enums = Enum.HumanoidStateType:GetEnumItems()
        table.remove(enums, table.find(enums, Enum.HumanoidStateType.None))
        for i, v in pairs(enums) do
            humanoid:SetStateEnabled(v, true)
        end
        
        tool.Name = "Swim"
    end
end)

tool.AncestryChanged:Connect(function()
    if not tool.Parent and swimming then
        workspace.Gravity = oldgrav
        swimming = false
        if gravReset then
            gravReset:Disconnect()
        end
        if swimbeat then
            swimbeat:Disconnect()
        end
    end
end)