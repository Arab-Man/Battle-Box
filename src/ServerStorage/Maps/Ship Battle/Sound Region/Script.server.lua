script.Parent.Touched:connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player:FindFirstChild("Stats") then
			player.Stats.Sound.Value = script.Parent.SoundID.Value
		end
	end
end)