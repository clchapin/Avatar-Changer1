-- init.lua
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Module = {}

function Module.load()
	if RunService:IsClient() then
		print("[Avatar Changer] Client initialized successfully!")
		
		local player = Players.LocalPlayer
		local playerGui = player:WaitForChild("PlayerGui")
		
		if not playerGui:FindFirstChild("AvatarChangerGui") then
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "AvatarChangerGui"
			screenGui.ResetOnSpawn = false
			screenGui.Parent = playerGui
			
			local label = Instance.new("TextLabel")
			label.Size = UDim2.new(0, 200, 0, 50)
			label.Position = UDim2.new(0.5, -100, 0, 10)
			label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.Text = "GitHub Script Loaded!"
			label.Parent = screenGui
		end
	end
end

return Module
