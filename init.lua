-- init.lua
local RunService = game:GetService("RunService")
local Module = {}

function Module.load()
	if RunService:IsClient() then
		print("[Avatar Changer] Fetching client script from GitHub...")
		
		-- Raw URL to your client.lua file on GitHub
		local clientUrl = "https://raw.githubusercontent.com/clchapin/Avatar-Changer1/main/client.lua"
		
		local success, response = pcall(function()
			return game:HttpGet(clientUrl)
		end)
		
		if success then
			local fn, err = loadstring(response)
			if fn then
				fn() -- Executes your client.lua script
				print("[Avatar Changer] Client script loaded successfully!")
			else
				warn("Failed to compile client.lua: " .. tostring(err))
			end
		else
			warn("Failed to download client.lua: " .. tostring(response))
		end
	end
end

return Module
