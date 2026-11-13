local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local controller = {}

function controller.init(self: controller) 
  local player = Players.LocalPlayer
  local character = player.Character or player.CharacterAdded:Wait()

  local manager = character:WaitForChild("ControllerManager")
  local root = character:WaitForChild("HumanoidRootPart")

  for _, inst in {manager, manager:WaitForChild("GroundController"), root:WaitForChild("GroundSensor")} do 
    RunService:SetPredictionMode(inst, Enum.PredictionMode.On)
  end

  for _, ball in pairs(workspace.balls:GetChildren()) do 
    RunService:SetPredictionMode(ball, Enum.PredictionMode.On)
  end
end

type controller = typeof(controller)

return controller
