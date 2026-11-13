local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local engine = require(ReplicatedStorage.engine)
engine:init(script.Parent.Parent.shared)
--engine:init(ServerScriptService.services)

engine:simulate()

local Inputs = script.Parent.Parent.Inputs

game.Players.PlayerAdded:Connect(function(player)
	local InputsClone = Inputs:Clone()
	InputsClone.Parent = player
end)

