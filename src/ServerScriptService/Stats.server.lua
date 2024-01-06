local dataStores = game:GetService("DataStoreService"):GetDataStore("CashDataStore")
local defaultCash = 50
local playersleft = 0

game.Players.PlayerAdded:Connect(function(player)
	
	playersleft = playersleft + 1
	
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local cash = Instance.new("IntValue")
	cash.Name = "Cash"
	cash.Value = 0
	cash.Parent = leaderstats
	
	local playerData = Instance.new("Folder")
	playerData.Name = player.Name
	playerData.Parent = game.ServerStorage.PlayerData
	
	local equipped = Instance.new("StringValue")
	equipped.Name = "Equipped"
	equipped.Parent = playerData
	
	local inventory = Instance.new("Folder")
	inventory.Name = "Inventory"
	inventory.Parent = playerData
	
	
	player.CharacterAdded:Connect(function(character)
		character.Humanoid.WalkSpeed = 20
		character.Humanoid.Died:Connect(function()
			-- Whenever sombody dies, this event will run
			
			if character.Humanoid and character.Humanoid:FindFirstChild("creator") then
				game.ReplicatedStorage.Status.Value = tostring(character.Humanoid.creator.Value).." Killed "..player.Name
			end
			if character:FindFirstChild("GameTag") then
				character.GameTag:Destroy()
			end
			
			player:LoadCharacter()
		end)
		
	end)
	
	-- Data Stores
	
	local player_data
	local weaponsData
	local equippedData
	
	pcall(function()
		player_data = dataStores:GetAsync(player.UserId.."-Cash")
	end)
	
	pcall(function()
		weaponsData = dataStores:GetAsync(player.UserId.."-Weps")
	end)
	
	pcall(function()
		equippedData = dataStores:GetAsync(player.UserId.."-EquippedValue")
	end)
	
	if player_data ~= nil then
		-- Player has saved data, load it in
		cash.Value = player_data
	else
		-- New player
		cash.Value = defaultCash
	end
	
	if weaponsData then
		
		-- For loop through the weapons saved
		for _, weapon in pairs(weaponsData) do
			if game.ServerStorage.Items:FindFirstChild(weapon) then
				local weaponClone = game.ServerStorage.Items[weapon]:Clone()
				weaponClone.Parent = inventory
				print(weapon.." loaded in!")
			end
		end
		
		if equippedData then
			equipped.Value = equippedData
			player:WaitForChild("PlayerGui")
			game.ReplicatedStorage.SendEquipped:FireClient(player,equippedData)
		end
	else
		print("No weapons data")
	end
	
end)

local bindableEvent = Instance.new("BindableEvent")




game.Players.PlayerRemoving:Connect(function(player)
	
	
	pcall(function()
		dataStores:SetAsync(player.UserId.."-Cash",player.leaderstats.Cash.Value)
	end)	
	
	pcall(function()
		local weapons = game.ServerStorage.PlayerData[player.Name].Inventory:GetChildren()
		local weaponsTable = {}
		
		for _, v in pairs(weapons) do
			table.insert(weaponsTable,v.Name)
		end
		
		dataStores:SetAsync(player.UserId.."-Weps",weaponsTable)
		
		if game.ServerStorage.PlayerData[player.Name].Equipped.Value ~= nil then
			local equippedVal = game.ServerStorage.PlayerData[player.Name].Equipped
			dataStores:SetAsync(player.UserId.."-EquippedValue",equippedVal.Value)
		end
	end)
	
	print("Saved weapons and points")
	
	playersleft = playersleft - 1
	bindableEvent:Fire()
		
end)

game:BindToClose(function()
	-- This will be triggered upon shutdown
	while playersleft > 0 do
		bindableEvent.Event:Wait()
	end
end)