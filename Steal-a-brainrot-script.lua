local HttpService = game:GetService("HttpService")

local PASSWORD_URL = "https://raw.githubusercontent.com/Vapojsjdj/Ndndndnndnd/refs/heads/main/Password.txt"
local PASSWORD = nil

local success, response = pcall(function()
	return game:HttpGet(PASSWORD_URL)
end)

if success then
	PASSWORD = response:match("^%s*(.-)%s*$") -- نحيد المسافات البيضاء
else
	warn("🔴 فشل في تحميل كلمة السر من الرابط الخارجي")
	PASSWORD = "خطأ" -- كلمة بديلة
end
local HOURS_VALID = 10 -- مدة الصلاحية بالساعات

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- التحقق من الوقت
local startTime = tick()

local function isSessionValid()
	return tick() - startTime < (HOURS_VALID * 3600)
end

-- نافذة كلمة السر
local PassGui = Instance.new("ScreenGui", PlayerGui)
PassGui.Name = "PasswordUI"
local PassFrame = Instance.new("Frame", PassGui)
PassFrame.Size = UDim2.new(0, 250, 0, 150)
PassFrame.Position = UDim2.new(0.5, -125, 0.5, -75)
PassFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
PassFrame.Active = true
PassFrame.Draggable = true
Instance.new("UICorner", PassFrame)

local PassBox = Instance.new("TextBox", PassFrame)
PassBox.Size = UDim2.new(0.8, 0, 0, 40)
PassBox.Position = UDim2.new(0.1, 0, 0.2, 0)
PassBox.PlaceholderText = "اكتب كلمة السر"
PassBox.Text = ""
PassBox.Font = Enum.Font.GothamBold
PassBox.TextSize = 18
PassBox.TextColor3 = Color3.new(1,1,1)
PassBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
Instance.new("UICorner", PassBox)

local Submit = Instance.new("TextButton", PassFrame)
Submit.Size = UDim2.new(0.8, 0, 0, 40)
Submit.Position = UDim2.new(0.1, 0, 0.6, 0)
Submit.Text = "دخول"
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 18
Submit.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
Submit.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Submit)

Submit.MouseButton1Click:Connect(function()
	if PassBox.Text == PASSWORD then
		PassGui:Destroy()
		loadMainUI()
	end
end)

-------------------------------
-- 🔒 الواجهة الرئيسية
-------------------------------
function loadMainUI()
	if not isSessionValid() then
		Player:Kick("انتهت صلاحية الواجهة.")
		return
	end

	local ScreenGui = Instance.new("ScreenGui", PlayerGui)
	ScreenGui.Name = "HacksControlUI"
	ScreenGui.ResetOnSpawn = false

	local Frame = Instance.new("ScrollingFrame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 380)
Frame.Position = UDim2.new(0, 30, 0.5, -230)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.Active = true
Frame.Draggable = true
Frame.CanvasSize = UDim2.new(0, 0, 0, 0)
Frame.ScrollBarThickness = 6
Frame.ScrollingDirection = Enum.ScrollingDirection.Y
Frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", Frame)
local UIS = game:GetService("UserInputService")

local dragging = false
local dragStart
local startPos

Frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch and dragging then
		local delta = input.Position - dragStart
		Frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)
local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
	local UIListLayout = Instance.new("UIListLayout", Frame)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 10)

	local Title = Instance.new("TextLabel", Frame)
	Title.Text = "💻 قائمة الهاكات"
	Title.TextSize = 20
	Title.Font = Enum.Font.GothamBold
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(1, 0, 0, 40)

	-- زر الإخفاء
	local HideButton = Instance.new("TextButton", Frame)
	HideButton.Text = "👁️ إخفاء القائمة"
	HideButton.Size = UDim2.new(1, -20, 0, 35)
	HideButton.Position = UDim2.new(0, 10, 0, 0)
	HideButton.BackgroundColor3 = Color3.fromRGB(100, 60, 60)
	HideButton.TextColor3 = Color3.new(1,1,1)
	HideButton.Font = Enum.Font.GothamBold
	HideButton.TextSize = 16

	HideButton.MouseButton1Click:Connect(function()
		Frame.Visible = not Frame.Visible
	end)

	-- 📦 واجهة منظمة لإضافة هاكات
	local hacks = {}

	function addHack(label, onStart, onStop)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, -20, 0, 30)
		btn.Position = UDim2.new(0, 10, 0, 0)
		btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 14
		btn.Text = label
		btn.Parent = Frame

		local active = false
		btn.MouseButton1Click:Connect(function()
			active = not active
			if active then
				btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
				btn.Text = "✅ إيقاف " .. label
				onStart()
			else
				btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				btn.Text = label
				onStop()
			end
		end)
	end

	-- ☑️ اختراق الجدران
	local function toggleNoClip(state)
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("BasePart") and obj.Position.Y > -10 then
				pcall(function()
					obj.CanCollide = not state
				end)
			end
		end
	end
	addHack("🧱 اختراق الجدران", function() toggleNoClip(true) end, function() toggleNoClip(false) end)

	-- ☑️ تتبع
	local followCon
	addHack("👣 تتبع تلقائي", function()
		followCon = RunService.Heartbeat:Connect(function()
			local target = getNearestPlayer()
			local myChar = Player.Character
			if target and myChar and myChar:FindFirstChild("Humanoid") then
				myChar.Humanoid:MoveTo(target.Character.HumanoidRootPart.Position)
			end
		end)
	end, function()
		if followCon then followCon:Disconnect() end
	end)

	-- ☑️ ضرب تلقائي
	local attacking = false
	addHack("👊 ضرب تلقائي", function()
		attacking = true
		task.spawn(function()
			while attacking do
				VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, game, 0)
				wait(0.1)
				VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, game, 0)
				wait(0.2)
			end
		end)
	end, function()
		attacking = false
	end)

	-- ☑️ نقل لأقرب
	local tpCon
	addHack("📍 انتقل لأقرب لاعب", function()
		tpCon = RunService.Heartbeat:Connect(function()
			local target = getNearestPlayer()
			if target and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
				Player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
			end
		end)
	end, function()
		if tpCon then tpCon:Disconnect() end
	end)

	-- ☑️ هروب من الأقرب
	local runCon
	addHack("🏃 الهروب من الأقرب", function()
		runCon = RunService.Heartbeat:Connect(function()
			local target = getNearestPlayer()
			local char = Player.Character
			if target and char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
				local away = (char.HumanoidRootPart.Position - target.Character.HumanoidRootPart.Position).Unit * 20
				char.Humanoid:MoveTo(char.HumanoidRootPart.Position + away)
			end
		end)
	end, function()
		if runCon then runCon:Disconnect() end
	end)
-- 💡 إضافات جديدة:
-- تلبورت لأعلى
addHack("🔝 الانتقال لأعلى", function()
	local char = Player.Character
	if char and char:FindFirstChild("HumanoidRootPart") then
		char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 100, 0)
	end
end, function() end)

-- قفز لانهائي
local jumpConn
addHack("🪂 قفز لانهائي", function()
	jumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
		local char = Player.Character
		if char and char:FindFirstChild("Humanoid") then
			char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end, function()
	if jumpConn then
		jumpConn:Disconnect()
	end
end)

-- سرعة خارقة
local normalWalkSpeed = 16
addHack("💨 سرعة خارقة", function()
	local char = Player.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = 100
	end
end, function()
	local char = Player.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = normalWalkSpeed
	end
end)
	-- 🔄 إضافة هاكات مستقبلية هنا:
	-- addHack("🚀 طيران", function() ... end, function() ... end)
	-- addHack("🔍 ESP", function() ... end, function() ... end)
	-- addHack("💨 سرعة", function() ... end, function() ... end)
end

-- أقرب لاعب
function getNearestPlayer()
	local nearest, shortest = nil, math.huge
	local myChar = Player.Character
	if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
	local myPos = myChar.HumanoidRootPart.Position

	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local dist = (plr.Character.HumanoidRootPart.Position - myPos).Magnitude
			if dist < shortest then
				shortest = dist
				nearest = plr
			end
		end
	end
	return nearest
end
