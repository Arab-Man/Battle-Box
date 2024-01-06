local Debounce = false

script.Parent.Touched:connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and Debounce == false then
		Debounce = true
		hit.Parent.Humanoid:TakeDamage(20)
		wait(1)
		hit.Parent.Humanoid:TakeDamage(20)
		wait(1)
		hit.Parent.Humanoid:TakeDamage(20)
		wait(1)
		hit.Parent.Humanoid:TakeDamage(20)
		wait(1)
		hit.Parent.Humanoid:TakeDamage(20)
		wait(1)
		hit.Parent.Humanoid:TakeDamage(20)
		wait(1)
		Debounce = false
	end
end)
