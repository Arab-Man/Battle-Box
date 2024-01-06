local player = game.Players.LocalPlayer

function fadeout(sound)
for i = 50,1,-1 do
	sound.Volume = i * 0.01
	wait(0.03)
end	
end

function fadein(sound)
for i = 1,50, 1 do
	sound.Volume = i * 0.01
	wait(0.02)
end	
end

player:FindFirstChild("Stats").Sound.Changed:connect(function(changered)

fadeout(script.Parent.Audio)
wait(1)
script.Parent.Audio.SoundId = changered

script.Parent.Audio:Stop()
script.Parent.Audio.Looped = true
wait()
script.Parent.Audio:Play()

fadein(script.Parent.Audio)
	
end)