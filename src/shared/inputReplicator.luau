local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local shared = {}

function shared.step(self: shared)
	local isServer = RunService:IsServer()
	for _, player in Players:GetPlayers() do
		if not (isServer or player == Players.LocalPlayer) then continue end

		local character = player.Character
		local hrp = character and character.PrimaryPart
		if not hrp then continue end

		local humanoid = character.Humanoid
    if not humanoid then continue end

		if hrp:GetAttribute("MoveDirection") ~= humanoid.MoveDirection then -- skip redundant writes
			hrp:SetAttribute("MoveDirection", humanoid.MoveDirection)
		end
	end
end

type shared = typeof(shared)

return shared :: shared
