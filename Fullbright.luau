local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

local tool = Instance.new("Tool")
tool.Name = "Fullbright"
tool.ToolTip = "click to enable/disable fullblight"
tool.RequiresHandle = false
tool.Parent = player.Backpack

local enabled = false
local connection

local originalSettings = {
    Brightness = Lighting.Brightness,
    Ambient = Lighting.Ambient,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    TimeOfDay = Lighting.TimeOfDay,
    ShadowSoftness = Lighting.ShadowSoftness,
    GlobalShadows = Lighting.GlobalShadows
}

local function enableFullbright()
    connection = RunService.Heartbeat:Connect(function()
        if enabled then
            Lighting.Brightness = 2
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            Lighting.TimeOfDay = "14:00:00"
            Lighting.ShadowSoftness = 0
            Lighting.GlobalShadows = false
        end
    end)
end

local function disableFullbright()
    if connection then
        connection:Disconnect()
    end
    
    for setting, value in pairs(originalSettings) do
        Lighting[setting] = value
    end
end

tool.Activated:Connect(function()
    if enabled then
        disableFullbright()
    else
        enableFullbright()
    end
    enabled = not enabled
end)
