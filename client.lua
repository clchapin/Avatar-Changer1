-- client.lua
local ClientScript = {}

function ClientScript.init()
	print("[Client] Initialized successfully!")
	
	-- Example client-side logic
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local event = ReplicatedStorage:WaitForChild("ExampleEvent", 5)
	
	if event then
		-- Fire the server event as an example
		event:FireServer()
	end
end

return ClientScript
