return {
    {
        name = "🚀 Teleport إلى أقرب لاعب",
        flag = "_G.TeleportEnabled",
        code = [[
            while _G.TeleportEnabled do
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer
                local function getCharacter(p)
                    return p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                end
                local function getNearest()
                    local nearest, dist = nil, math.huge
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and getCharacter(p) then
                            local d = (p.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                            if d < dist then
                                dist = d
                                nearest = p
                            end
                        end
                    end
                    return nearest
                end
                local target = getNearest()
                if target and getCharacter(LocalPlayer) then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
                end
                task.wait(0.5)
            end
        ]]
    },
    {
        name = "🧱 اختراق الجدران",
        flag = "_G.NoclipEnabled",
        code = [[
            local char = game.Players.LocalPlayer.Character
            while _G.NoclipEnabled do
                for _, part in pairs(workspace:GetDescendants()) do
                    if part:IsA("BasePart") and not part:IsDescendantOf(char) then
                        pcall(function()
                            part.CanCollide = false
                            part.Transparency = 0.5
                            part.Material = Enum.Material.ForceField
                        end)
                    end
                end
                task.wait(1)
            end
        ]]
    },
}
