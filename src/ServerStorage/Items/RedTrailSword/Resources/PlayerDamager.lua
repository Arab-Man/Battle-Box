--TheNexusAvenger
--Centralizes player damaging.

local PlayerDamager = {}

local Debris = game:GetService("Debris")

--Returns whether damage can be done to a humanoid.
function PlayerDamager:CanDamageHumanoid(DamagingPlayer,Humanoid)
	local HitPlayer = game.Players:GetPlayerFromCharacter(Humanoid.Parent)
	if HitPlayer and DamagingPlayer ~= HitPlayer and HitPlayer.TeamColor == DamagingPlayer.TeamColor and not HitPlayer.Neutral then
		return false
	end
	
	return true
end

--Damages the humanoid.
function PlayerDamager:DamageHumanoid(DamagingPlayer,Humanoid,Damage,ToolName)
	--Check if it can be damaged.
	if not PlayerDamager:CanDamageHumanoid(DamagingPlayer,Humanoid) or not Humanoid.Parent then
		return
	end
	
	--Damage the humanoid.
	Humanoid:TakeDamage(Damage)
	
	--Create the tag.
	local CreatorTag = Instance.new("ObjectValue")
	CreatorTag.Name = "creator"
	CreatorTag.Value = DamagingPlayer
	CreatorTag.Parent = Humanoid
	Debris:AddItem(CreatorTag,3)
end

return PlayerDamager
