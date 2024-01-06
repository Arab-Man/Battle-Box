function onPlayerEntered(newPlayer)

	local stats = Instance.new("IntValue")
	stats.Name = "Stats"

	local cash = Instance.new("StringValue")
	cash.Name = "Sound" 
	cash.Value = ""
	cash.Parent = stats
	stats.Parent = newPlayer
end



game.Players.ChildAdded:connect(onPlayerEntered)

