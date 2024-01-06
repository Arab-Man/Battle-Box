minutesAfterMidnight = 0
while true do
	minutesAfterMidnight = minutesAfterMidnight + 1
	game.Lighting:SetMinutesAfterMidnight(minutesAfterMidnight)
	wait(.1)
end