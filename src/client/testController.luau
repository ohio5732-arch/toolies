local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local engine = require(ReplicatedStorage.engine)
local controller = {}

function controller.init(self: controller) 
  local player = Players.LocalPlayer
  local character = player.Character or player.CharacterAdded:Wait()

  local manager = character:WaitForChild("ControllerManager")
  local root = character:WaitForChild("HumanoidRootPart")

  RunService:SetPredictionMode(manager, Enum.PredictionMode.On)

  for _, ball in pairs(workspace.balls:GetChildren()) do 
    RunService:SetPredictionMode(ball, Enum.PredictionMode.On)
  end
end

type controller = typeof(controller)

return controller
