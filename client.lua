-- client.lua
-- This script is completely self-dependent: it creates the UI, handles dragging, and changes your avatar.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove old UI if it already exists (prevents duplicates when reloading)
if playerGui:FindFirstChild("AvatarChangerGui") then
	playerGui.AvatarChangerGui:Destroy()
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AvatarChangerGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Create Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 260, 0, 150)
mainFrame.Position = UDim2.new(0.5, -130, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Title Bar (Drag Handler)
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Avatar Switcher"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- TextBox
local textBox = Instance.new("TextBox")
textBox.Name = "UsernameTextBox"
textBox.Size = UDim2.new(0, 220, 0, 35)
textBox.Position = UDim2.new(0.5, -110, 0, 45)
textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "Enter Username..."
textBox.Text = ""
textBox.TextSize = 14
textBox.Font = Enum.Font.Gotham
textBox.Parent = mainFrame

local textBoxCorner = Instance.new("UICorner")
textBoxCorner.CornerRadius = UDim.new(0, 6)
textBoxCorner.Parent = textBox

-- Change Button
local actionButton = Instance.new("TextButton")
actionButton.Name = "ChangeButton"
actionButton.Size = UDim2.new(0, 220, 0, 35)
actionButton.Position = UDim2.new(0.5, -110, 0, 95)
actionButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
actionButton.Text = "Swap Outfit & Colors"
actionButton.TextSize = 14
actionButton.Font = Enum.Font.GothamBold
actionButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = actionButton

-- Draggable Window Logic
local dragging, dragStart, startPos

titleLabel.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Main Appearance Function
local function applyAppearance(targetUserId)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	local descSuccess, targetDesc = pcall(function()
		return Players:GetHumanoidDescriptionFromUserId(targetUserId)
	end)

	if not descSuccess or not targetDesc then
		warn("Could not retrieve avatar description for User ID: " .. tostring(targetUserId))
		return
	end

	pcall(function()
		humanoid:ApplyDescriptionReset(targetDesc)
	end)
end

-- Button Trigger
actionButton.MouseButton1Click:Connect(function()
	local username = textBox.Text
	if username == "" then return end
	
	actionButton.Text = "Loading..."
	
	task.spawn(function()
		local success, userId = pcall(function()
			return Players:GetUserIdFromNameAsync(username)
		end)
		
		if success and userId then
			applyAppearance(userId)
		else
			warn("User not found: " .. username)
		end
		
		actionButton.Text = "Swap Outfit & Colors"
	end)
end)

print("[Avatar Changer] UI successfully created by client.lua!")
