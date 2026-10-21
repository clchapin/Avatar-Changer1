-- init.lua (Loader)
local RunService = game:GetService("RunService")

local Module = {}

function Module.load()
	if RunService:IsServer() then
		print("[Loader] Loading Server Script...")
		local serverScript = require(script.Server) -- Or load via raw GitHub URL if using loadstring
		serverScript.init()
		
	elseif RunService:IsClient() then
		print("[Loader] Loading Client Script...")
		local clientScript = require(script.Client)
		clientScript.init()
	end
end

return Module
