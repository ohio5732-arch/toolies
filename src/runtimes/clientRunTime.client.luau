local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local engine = require(ReplicatedStorage.engine)
engine:init(script.Parent.Parent.shared)
engine:init(Players.LocalPlayer.PlayerScripts.controllers)

engine:simulate()
