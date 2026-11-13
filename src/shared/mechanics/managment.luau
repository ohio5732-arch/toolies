local Players = game:GetService("Players")

local managment = {}

type queueArgs = {
  action: string,
  time: number?,
}

local actions = {"dribble","pass"}

function managment.step(self: managment) 
  for _, player in Players:GetPlayers() do 
    self:logActionInputs(player)
  end
end

function managment.logActionInputs(self: managment, player: Player) 
  local inputContexts: InputContext = player.Inputs.GameplayContext
  local MovementAction = inputContexts.MovementAction:GetState()
  --if not inputContexts or MovementAction then print("no") return end 

  local character = player.Character
  if not character then return end 

  local hrp = character.HumanoidRootPart
  if not hrp then return end 

  character:SetAttribute("FMoveDir",MovementAction or Vector2.new(0,0))
  print(MovementAction)
end

function managment.getCharacterMovementDirection(self: managment, player: Player) 
  local character = player.Character
  if not character then return end 

  local hrp = character.HumanoidRootPart
  if not hrp then return end

  return character:GetAttribute("MoveDirection")
end

function managment.getMovementDirection(self: managment, player: Player) 
  local character = player.Character
  if not character then 
    return
  end
  
  local hrp = character.HumanoidRootPart
  if not hrp then return end 

  return character:GetAttribute("FMoveDir")
end

function managment.logQueue(self: managment, player: Player, args: queueArgs) 
  local character = player.Character
  if not character then return end 

  character:SetAttribute("QTime_"..args.action,args.time)
end

function managment.unlogQueue(self: managment, player: Player, action: string) 
  local character = player.Character
  if not character then return end 

  character:SetAttribute("QTime_"..action, nil)
end

function managment.getCurrentQueueInput(self: managment, player: Player)
	local character = player.Character
	if not character then return end

	local front, frontTime = nil, math.huge
	for _, action in actions do
		local t = character:GetAttribute("QTime_"..action)
		if t then
			if time() - t > 0.6 then
				self:unlogQueue(player,action)
			elseif t < frontTime then
				front, frontTime = action, t
			end
 		end
	end
	
	return front
end

function managment.isInputQueueReady(self: managment, player: Player, args: queueArgs) 
    return self:getCurrentQueueInput(player) == args.action
end 

function managment.hasPendingQueue(self: managment, player: Player) 
  return self:getCurrentQueueInput(player) ~= nil
end

function managment.setBallOwner(self: managment, player: Player, ball: BasePart) 
  ball:SetAttribute("Owner", player.UserId)
end

function managment.isOwner(self: managment, player: Player, ball: BasePart) 
  return ball:GetAttribute("Owner") == player.UserId
end

function managment.isCloseEnough(self: managment, ball: BasePart, player: Player) 
  local character = player.Character
  if not character then return end 

  local hrp = character.HumanoidRootPart
  if not hrp then return end 

  local toBall = (ball.Position - hrp.Position).Magnitude
  return toBall < 10
end

function managment.canReach(self: managment, ball: BasePart, player: Player) 
  local character = player.Character
  if not character then return end 

  local hrp = character.HumanoidRootPart
  if not hrp then return end 

  local toBall = Vector3.new(ball.Position.X - hrp.Position.X,0,ball.Position.Z - hrp.Position.Z)
  return toBall.Magnitude < 3 and toBall.Unit:Dot(hrp.CFrame.LookVector) > 0.5
end

function managment.overrideMovement(self: managment, player: Player, value: boolean) 
  local character = player.Character
  if not character then return end 

  character:SetAttribute("MovementEnabled", not value)
end

function managment.enableAssistance(self: managment, player: Player, ball: BasePart, value: boolean) 
  local character = player.Character
  if not character then return end 

  local controllerManager = character.ControllerManager
  if not controllerManager then return end 

  local hrp = character.HumanoidRootPart
  if not hrp then return end 

  local toBall = ball.Position - hrp.Position
  local flat = Vector3.new(toBall.X,0,toBall.Z)
  if not value then return end 
  print("on")

  self:overrideMovement(player, value)

  controllerManager.MovingDirection = flat.Unit
  controllerManager.FacingDirection = flat.Unit
end

function managment.getClosestBall(self: managment, player: Player) 
  local character = player.Character
  if not character then return end 

  local hrp = character.HumanoidRootPart
  if not hrp then return end 

  local closestBall = nil 
  local closestDistance = math.huge
  for _, ball: BasePart in workspace.balls:GetChildren() do 
    local distance = (ball.Position - hrp.Position).Magnitude
    if distance < closestDistance then 
      closestBall = ball 
      closestDistance = distance
    end
  end

  return closestBall
end

type managment = typeof(managment)

return managment :: managment
