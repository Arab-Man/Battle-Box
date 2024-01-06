-- Define Variables

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerStorage = game:GetService("ServerStorage")

local MapsFolder = ServerStorage:WaitForChild("Maps")

local Status = ReplicatedStorage:WaitForChild("Status")

local GameLength = 150

local Reward = 10

-- Game Loop

while true do
	
	Status.Value = "Waiting for enough Players"
	
	repeat wait(1) until game.Players.NumPlayers >=2
	
	Status.Value = "Intermission"
	
	wait(30)
	
	local plrs = {}
	
	for i, player in pairs(game.Players:GetPlayers()) do
		if player then
			table.insert(plrs,player) -- add each player into plrs table
		end
	end
	
	wait(2)
	
	local AvailableMaps = MapsFolder:GetChildren()
	
	local ChosenMap = AvailableMaps[math.random(1,#AvailableMaps)]
	
	Status.Value = ChosenMap.Name.." Chosen"
	
	local ClonedMap = ChosenMap:Clone()
	ClonedMap.Parent = workspace
	
	-- Teleport players to map
	
	local SpawnPoints = ClonedMap:FindFirstChild("SpawnPoints")
	
	if not SpawnPoints then
		print("Spawnpoints not found")
	end
	
	local AvailableSpawnPoints = SpawnPoints:GetChildren()
	
	for i, player in pairs(plrs) do
		if player then
			character = player.Character
			
			if character then
				-- Teleport them
				
				character:FindFirstChild("HumanoidRootPart").CFrame = AvailableSpawnPoints[1].CFrame
				table.remove(AvailableSpawnPoints,1)
				
				
				-- Give them a sword
				local equipped = game.ServerStorage.PlayerData[player.Name].Equipped
				
				if equipped.Value ~= "" then
					local weapon = game.ServerStorage.Items[equipped.Value]:Clone()
					weapon.Parent = player.Backpack
				else
					local Sword = ServerStorage.Sword:Clone()
					Sword.Parent = player.Backpack 
				end
				
						
				local Sword = ServerStorage.Sword:Clone()
				Sword.Parent = player.Backpack
				
				local GameTag = Instance.new("BoolValue")
				GameTag.Name = "GameTag"
				GameTag.Parent = player.Character
				
			else
				-- There is no character
				if not player then
					table.remove(plrs,i)
				end
			end
		end
	end
	
	
	Status.Value = "Get ready to play!"
	
	wait(2)
	
	for i = GameLength,0,-1 do
		
		for x, player in pairs(plrs) do
			if player then
				
				
				character = player.Character
				
				if not character then
					--left the game
					table.remove(plrs,x)
				else
					if character:FindFirstChild("GameTag") then
						-- They are still alive
						print(player.Name.." is still in the game!")
					else
						-- They are dead
						table.remove(plrs,x)
						print(player.Name.." has been removed!")
					end
				end
			else
				table.remove(plrs,x)
				print(player.Name.." has been removed!")
			end
		end
		
		Status.Value = "There are "..i.." seconds remaining and "..#plrs.." players left"
		
		if #plrs == 1 then
			-- Last person standing
			Status.Value = "The winner is "..plrs[1].Name
			plrs[1].leaderstats.Cash.Value = plrs[1].leaderstats.Cash.Value + Reward
			break
		elseif #plrs == 0 then
			Status.Value = "Nobody won!"
			break
		elseif i == 0 then
			Status.Value = "Time is up!"
			break
		end
		
		wait(1)
	end
	
	print("End of game")
	
	wait(2)
	
	for i, player in pairs(game.Players:GetPlayers()) do
		character = player.Character
		
		if not character then
			-- Ignore them
		else
			if character:FindFirstChild("GameTag") then
				character.GameTag:Destroy()
			end
			
			for _, tool in pairs(player.Backpack:GetChildren()) do
				if tool:FindFirstChild("Price") then
					tool:Destroy()
				end
			end
			
			for _, tool in pairs(character:GetChildren()) do
				if tool:FindFirstChild("Price") then
					tool:Destroy()
				end
			end
			
		end
		
		player:LoadCharacter()
		
	end
	
	ClonedMap:Destroy()
	
	Status.Value = "Game ended!"
	
	wait(2)
	
end