-- تعديل سرعة اللاعب
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- التأكد من وجود Humanoid
local humanoid = character:WaitForChild("Humanoid")

-- تعيين سرعة جديدة (مثلاً 100 بدلاً من 16)
humanoid.WalkSpeed = 100

-- إشعار
game.StarterGui:SetCore("SendNotification", {
	Title = "Speed Hack";
	Text = "تم تفعيل السرعة: 100";
	Duration = 4;
})
