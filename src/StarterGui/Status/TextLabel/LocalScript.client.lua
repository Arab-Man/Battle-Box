local Status = game:WaitForChild("ReplicatedStorage"):WaitForChild("Status")

script.Parent.Text = Status.Value

Status:GetPropertyChangedSignal("Value"):Connect(function()
	
	script.Parent.Text = Status.Value
	
end)