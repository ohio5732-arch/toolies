local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local managment = require(ReplicatedStorage.shared.mechanics.managment)
local dribble = {}

function dribble.step(self: dribble)
  for _, player in Players:GetPlayers() do 
    local ball = managment:getClosestBall(player)
    local dir = managment:getCharacterMovementDirection(player)
    
    if managment:isCloseEnough(ball, player) then 
      managment:setBallOwner(player, ball)
    else
      if managment:isOwner(player, ball) then 
        managment:setBallOwner(nil, ball)
      end
    end

    local isOwner = managment:isOwner(player, ball)
    local reach = managment:canReach(ball, player)
    local input = managment:getMovementDirection(player)
    local inputMagnitude = Vector2.new(input.X,input.Y).Magnitude

    managment:enableAssistance(player, ball, isOwner and not reach)

    if isOwner and reach then 
      ball.AssemblyLinearVelocity = dir * 23 * inputMagnitude
    end
  end
end 

type dribble = typeof(dribble)

return dribble :: dribble
