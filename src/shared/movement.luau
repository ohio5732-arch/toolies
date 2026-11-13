local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local shared = {}

function shared.step(self: shared, deltaTime: number) 
  for _, player in Players:GetPlayers() do 
    self:calculateMovement(player, deltaTime)
  end
end

function shared.calculateMovement(self: shared, player: Player, deltaTime)
  local character = player.Character
  if not character then return end 

  local controllerManager = character.ControllerManager
  if not controllerManager then return end
  
  local moveDirection = character:GetAttribute("MoveDirection")
  if not moveDirection then return end 
  
  local hrp = character.HumanoidRootPart
  if not hrp then return end
  if character:GetAttribute("MovementEnabled") == false then return end

  local flat = Vector3.new(moveDirection.X,0,moveDirection.Z)

  if flat.Magnitude > 0.1 then 
    controllerManager.MovingDirection = flat
    controllerManager.FacingDirection = moveDirection
  else
    controllerManager.MovingDirection = Vector3.zero
  end
end

type shared = typeof(shared)

return shared :: shared
