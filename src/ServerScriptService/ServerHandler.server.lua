game.ReplicatedStorage:WaitForChild("GetTools").OnServerInvoke = function(player)
	local items = {}
	
	for _, object in pairs(game.ServerStorage:WaitForChild("Items"):GetChildren()) do
		local itemProperties = {object.Name,object.Price.Value}
		table.insert(items,itemProperties)
	end
	
	return items
end

game.ReplicatedStorage:WaitForChild("ItemCheck").OnServerInvoke = function(player,itemName)
	if game.ServerStorage.PlayerData:FindFirstChild(player.Name).Inventory:FindFirstChild(itemName) then
		return true
	else
		return false
	end
end

game.ReplicatedStorage:WaitForChild("PurchaseItem").OnServerInvoke = function(player,itemName)
	local cash = player.leaderstats.Cash
	local item = game.ServerStorage.Items:FindFirstChild(itemName)
	
	if item then
		-- Item Exists
		if game.ServerStorage.PlayerData[player.Name].Inventory:FindFirstChild(itemName) then
			if game.ServerStorage.PlayerData[player.Name].Equipped.Value ~= itemName then
				-- Currently unequipped
				game.ServerStorage.PlayerData[player.Name].Equipped.Value = itemName
				return "Equipped"
			else
				game.ServerStorage.PlayerData[player.Name].Equipped.Value = ""
				return "Unequipped"
			end
		end
		
		if cash.Value >= item.Price.Value then
			cash.Value = cash.Value - item.Price.Value
			
			local itemValue = Instance.new("ObjectValue")
			itemValue.Name = itemName
			itemValue.Parent = game.ServerStorage.PlayerData[player.name].Inventory
			
			return true
		else
			
			return "NotEnoughCash"
		end
		
	else
		return "NoItem"
	end
end