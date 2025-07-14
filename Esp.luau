local Players = game:GetService("Players")
local player = Players.LocalPlayer

local tool = Instance.new("Tool")
tool.Name = "ESP"
tool.ToolTip = "(lag) click do enable/disable esp"
tool.RequiresHandle = false
tool.Parent = player.Backpack

local enabled = false
local highlights = {}
local connections = {}

local function createHighlight(character)
    if highlights[character] then return end

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = character

    highlights[character] = highlight
end

local function removeHighlight(character)
    if highlights[character] then
        highlights[character]:Destroy()
        highlights[character] = nil
    end
end

local function enableESP()
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            createHighlight(otherPlayer.Character)
        end
    end

    connections[1] = Players.PlayerAdded:Connect(function(otherPlayer)
        if enabled then
            otherPlayer.CharacterAdded:Connect(function(character)
                if enabled then
                    createHighlight(character)
                end
            end)
        end
    end)

    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            connections[otherPlayer] = otherPlayer.CharacterAdded:Connect(function(character)
                if enabled then
                    createHighlight(character)
                end
            end)
        end
    end

    connections[2] = Players.PlayerRemoving:Connect(function(otherPlayer)
        if otherPlayer.Character then
            removeHighlight(otherPlayer.Character)
        end
    end)
end

local function disableESP()
    for character, highlight in pairs(highlights) do
        highlight:Destroy()
    end
    highlights = {}

    for _, connection in pairs(connections) do
        connection:Disconnect()
    end
    connections = {}
end

tool.Activated:Connect(function()
    if enabled then
        disableESP()
    else
        enableESP()
    end
    enabled = not enabled
end)
