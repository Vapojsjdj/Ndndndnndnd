-- Name: ESP
local running = true

local function createESP()
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
            local Billboard = Instance.new("BillboardGui")
            Billboard.Adornee = plr.Character.Head
            Billboard.Size = UDim2.new(0, 100, 0, 40)
            Billboard.StudsOffset = Vector3.new(0, 2, 0)
            Billboard.AlwaysOnTop = true
            Billboard.Name = "ESPBillboard"

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
    game.StarterGui:SetCore("SendNotification", {
        Title = "✅ ESP",
        Text = "تم تفعيل كشف اللاعبين",
        Duration = 3
    })
end

function stop()
    running = false
    -- حذف كل Billboards الخاصة بالـ ESP
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr.Character then
            local billboard = plr.Character:FindFirstChild("ESPBillboard")
            if billboard then
                billboard:Destroy()
            end
        end
    end
    game.StarterGui:SetCore("SendNotification", {
        Title = "❌ ESP",
        Text = "تم تعطيل كشف اللاعبين",
        Duration = 3
    })
end

createESP()

-- Name: Jump Hack
local running = true
local player = game.Players.LocalPlayer
local function setJumpPower()
    while running do
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = 150
        end
        wait(1)
    end
end

function stop()
    running = false
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.JumpPower = 50 -- القيمة الافتراضية المعتادة
        end
    end
    game.StarterGui:SetCore("SendNotification", {
        Title = "❌ القفز",
        Text = "تم تعطيل قفزة عالية",
        Duration = 3
    })
end

coroutine.wrap(setJumpPower)()

-- Name: Speed Hack
local running = true
local player = game.Players.LocalPlayer
local function setSpeed()
    while running do
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 100
        end
        wait(1)
    end
end

function stop()
    running = false
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16 -- القيمة الافتراضية المعتادة
        end
    end
    game.StarterGui:SetCore("SendNotification", {
        Title = "❌ السرعة",
        Text = "تم تعطيل السرعة",
        Duration = 3
    })
end

coroutine.wrap(setSpeed)()
