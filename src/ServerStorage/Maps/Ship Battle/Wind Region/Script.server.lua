script.Parent.Touched:Connect(function(hit)
	local force = Instance.new("BodyForce")
	force.Parent = hit.Parent.HumanoidRootPart
	force.Force = Vector3.new (-200,0,-200)
	wait(2)
	force:Destroy()
end)