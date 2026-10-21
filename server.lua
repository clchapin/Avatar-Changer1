-- server.lua
local ServerScript = {}

function ServerScript.init()
	print("[Server] Initialized successfully!")
	
	-- Example server-side logic (e.g., handling a RemoteEvent)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local event = Instance.new("RemoteEvent")
	event.Name = "ExampleEvent"
	event.Parent = ReplicatedStorage
	
	event.OnServerEvent:Connect(function(player)
		print("[Server] Received event from player:", player.Name)
	end)
end

return ServerScript
