-- Name: ESP
for _, plr in pairs(game.Players:GetPlayers()) do
	if plr ~= game.Players.LocalPlayer then
		local Billboard = Instance.new("BillboardGui")
		Billboard.Adornee = plr.Character:WaitForChild("Head")
		Billboard.Size = UDim2.new(0, 100, 0, 40)
		Billboard.StudsOffset = Vector3.new(0, 2, 0)
		Billboard.AlwaysOnTop = true

		local nameTag = Instance.new("TextLabel", Billboard)
		nameTag.Size = UDim2.new(1, 0, 1, 0)
		nameTag.Text = plr.Name
		nameTag.TextColor3 = Color3.new(1, 0, 0)
		nameTag.BackgroundTransparency = 1
		nameTag.TextStrokeTransparency = 0
		nameTag.TextScaled = true

		Billboard.Parent = plr.Character
	end
end

-- Name: Speed Hack
local h = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
h.WalkSpeed = 100
