local players = nil
local number = 1
local maxnumber = 0
local player = game.Players.LocalPlayer

script.Parent.Next.MouseButton1Click:connect(function(right)
	players = game.Players:GetChildren()
	number = number + 1
	if players[number] ~= nil then
		game.Workspace.CurrentCamera.CameraSubject = players[number].Character.Humanoid
		if players[number].Name ~= player.Name then
			script.Parent.PlayerName.Text = players[number].Name
		else 
			script.Parent.PlayerName.Text = "Nobody"
		end
	elseif players[number] == nil then
		number = 1
		game.Workspace.CurrentCamera.CameraSubject = players[number].Character.Humanoid
		if players[number].Name ~= player.Name then
			script.Parent.PlayerName.Text = players[number].Name
		else 
			script.Parent.PlayerName.Text = "Nobody"
		end
	end
end)

script.Parent.Previous.MouseButton1Click:connect(function(left)
	players = game.Players:GetChildren()
	maxnumber = #players
	number = number - 1
	if players[number] ~= nil then
		game.Workspace.CurrentCamera.CameraSubject = players[number].Character.Humanoid
		if players[number].Name ~= player.Name then
			script.Parent.PlayerName.Text = players[number].Name
		else 
			script.Parent.PlayerName.Text = "Nobody"
		end
	elseif players[number] == nil then
		number = maxnumber
		game.Workspace.CurrentCamera.CameraSubject = players[number].Character.Humanoid
		if players[number].Name ~= player.Name then
			script.Parent.PlayerName.Text = players[number].Name
		else 
			script.Parent.PlayerName.Text = "Nobody"
		end
	end
end)

script.Parent.Parent.SpectateButton.Spectate.MouseButton1Down:connect(function(click)
	if script.Parent.Parent.Active.Value == false then
		script.Parent.Parent.Active.Value = true
		script.Parent.Parent.ChangePlayer.Visible = true
	elseif script.Parent.Parent.Active.Value == true then
		script.Parent.Parent.Active.Value = false
		script.Parent.Parent.ChangePlayer.Visible = false
		script.Parent.PlayerName.Text = "Nobody"
		number = 1
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid

	end
end)

-- Made By JavaOfficialYT