-- Core UI localscript

local availableTools = game.ReplicatedStorage:WaitForChild("GetTools"):InvokeServer()
local mainFrame = script.Parent:WaitForChild("MainFrame")
local safeArea = mainFrame:WaitForChild("SafeArea")
local itemInformation = safeArea:WaitForChild("ItemInformation")
local infoFrame = itemInformation.InfoFrame
local selectedItem = itemInformation.SelectedItem
local equippedItem = itemInformation.EquippedItem
local numberOfItems = #availableTools

local itemFrame = safeArea.ItemFrame
local shopButton = script.Parent:WaitForChild("ShopButton")
local buyButton = infoFrame.BuyButton
local equippedItemViewport = script.Parent:WaitForChild("EquippedItemViewport")
local itemViewport = itemInformation.ItemViewport


game.ReplicatedStorage.SendEquipped.OnClientEvent:Connect(function(equipped)
	equippedItem.Value = equipped
	if equippedItem.Value ~= "" then
		local fakeCam = Instance.new("Camera")
		fakeCam.Parent = equippedItemViewport
		local handle = game.ReplicatedStorage:WaitForChild("ToolModels"):FindFirstChild(equippedItem.Value.."Handle"):Clone()
		handle.Parent = equippedItemViewport
		equippedItemViewport.CurrentCamera = fakeCam
		fakeCam.CFrame = handle.CameraCFrame.Value
	end
end)

shopButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

local PADDING_X = 0.02
local DROPDOWN_Y = 0.2
local DROPDOWN_X = 0.25

local item1 = itemFrame:WaitForChild("Item1")

local box
local numRows = 1

for i = 1,numberOfItems,1 do
	
	if i == 1 then
		box = item1
	else
		
		box = item1:Clone()
		box.Name = "Item"..i
		box.Parent = itemFrame
		
		
		if (i-1) / (4*numRows) == 1 then
			-- New Row
			numRows = numRows + 1
			box.Position = UDim2.new(PADDING_X,0,box.Position.Y.Scale,0) + UDim2.new(0,0,DROPDOWN_Y*(numRows - 1))
		else 
			-- Add to the X only
			box.Position = itemFrame["Item"..(i-1)].Position + UDim2.new(DROPDOWN_X,0,0,0)
		end
		
	end
	
	box.MouseButton1Click:Connect(function()
		for _, v in pairs(itemViewport:GetChildren()) do
			if not v:IsA("Frame") then
				v:Destroy()
			end
		end
		
		local itemViewportCam = Instance.new("Camera")
		itemViewportCam.Parent = itemViewport
		
		local handle = game.ReplicatedStorage:WaitForChild("ToolModels"):FindFirstChild(availableTools[i][1].."Handle"):Clone()
		handle.Parent = itemViewport
		
		itemViewport.CurrentCamera = itemViewportCam
		itemViewportCam.CFrame = handle.CameraCFrame.Value
		
		local owned = game.ReplicatedStorage.ItemCheck:InvokeServer(availableTools[i][1])
		
		if equippedItem.Value == availableTools[i][1] then
			infoFrame.Cash.Text = "Owned"
			infoFrame.BuyButton.Text = "Unequip"
		elseif owned == true then
			infoFrame.Cash.Text = "Owned"
			infoFrame.BuyButton.Text = "Equip"
		else
			infoFrame.BuyButton.Text = "Buy"
			infoFrame.Cash.Text = "$"..availableTools [i][2]
		end
		
		infoFrame.ItemName.Text = availableTools[i][1]
		selectedItem.Value = availableTools[i][1]
		
		for _, v in pairs (itemFrame:GetChildren()) do
			if v:IsA("ImageButton") then
				v.BorderSizePixel = 0
			end
		end
		
		itemFrame["Item"..i].BorderSizePixel = 2
		
	end)
	
	local fakeCam = Instance.new("Camera")
	fakeCam.Parent = box.VPF
	local handle = game.ReplicatedStorage:WaitForChild("ToolModels"):FindFirstChild(availableTools[i][1].."Handle"):Clone()
	handle.Parent = box.VPF
	box.VPF.CurrentCamera = fakeCam
	fakeCam.CFrame = handle.CameraCFrame.Value
	itemFrame["Item"..i].ItemName.Text = availableTools[i][1]
	
end

buyButton.MouseButton1Click:Connect(function()
	local result = game.ReplicatedStorage.PurchaseItem:InvokeServer(selectedItem.Value)
	if result == true then
		buyButton.BackgroundColor3 = Color3.fromRGB(42,149,42)
		buyButton.Text = "Bought!"
		wait(0.5)
		buyButton.Text = "Equip"
		buyButton.BackgroundColor3 = Color3.fromRGB(55,193,55)
	elseif result == "NotEnoughCash" then
		buyButton.BackgroundColor3 = Color3.fromRGB(204,31,31)
		buyButton.Text = "Not Enough Cash!"
		wait(0.5)
		buyButton.Text = "Buy"
		buyButton.BackgroundColor3 = Color3.fromRGB(55,193,55)
	elseif result == "Equipped" then
		equippedItem.Value = selectedItem.Value
		buyButton.BackgroundColor3 = Color3.fromRGB(42,149,42)
		buyButton.Text = "Equipped"
		wait(0.5)
		buyButton.Text = "Unequip"
		buyButton.BackgroundColor3 = Color3.fromRGB(55,193,55)
	elseif result == "Unequipped" then
		equippedItem.Value = ""
		buyButton.BackgroundColor3 = Color3.fromRGB(42,149,42)
		buyButton.Text = "Unequipped"
		wait(0.5)
		buyButton.Text = "Equip"
		buyButton.BackgroundColor3 = Color3.fromRGB(55,193,55)
	end
end)


if equippedItem.Value ~= "" then
	local fakeCam = Instance.new("Camera")
	fakeCam.Parent = equippedItemViewport
	local handle = game.ReplicatedStorage:WaitForChild("ToolModels"):FindFirstChild(equippedItem.Value.."Handle"):Clone()
	handle.Parent = equippedItemViewport
	equippedItemViewport.CurrentCamera = fakeCam
	fakeCam.CFrame = handle.CameraCFrame.Value
end

equippedItem:GetPropertyChangedSignal("Value"):Connect(function()
	if equippedItem.Value ~= nil then
		
		for _, v in pairs(equippedItemViewport:GetChildren()) do
			if not v:IsA("Folder") then
				v:Destroy()
			end
		end
		
		local fakeCam = Instance.new("Camera")
		fakeCam.Parent = equippedItemViewport
		local handle = game.ReplicatedStorage:WaitForChild("ToolModels"):FindFirstChild(equippedItem.Value.."Handle"):Clone()
		handle.Parent = equippedItemViewport
		equippedItemViewport.CurrentCamera = fakeCam
		fakeCam.CFrame = handle.CameraCFrame.Value
	else
		for _, v in pairs(equippedItemViewport:GetChildren()) do
			if not v:IsA("Folder") then
				v:Destroy()
			end
		end
	end
end)