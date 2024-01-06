game.ReplicatedFirst:RemoveDefaultLoadingScreen()

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
PlayerGui:SetTopbarTransparency(0)

local GUI = script.LoadingScreen:Clone()
GUI.Parent = PlayerGui

repeat wait(3) until game:IsLoaded()

GUI.Frame:TweenPosition(UDim2.new(0,0,1,0),"InOut","Sine",0.5)
wait(5)
GUI:Destroy()
