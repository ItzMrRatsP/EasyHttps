--[[
EasyHttps is ultimate way of using HTTPService, this module can save you alot of time getting requests and everything
Remember, This module is on it early stages and there will be updates constantly.

.response().success() returns true, false value
.response().get() returns open value
.request(url, args) send new request to the url, args(arguments)
.send(url, body) ** post data
you can use any url, the "roblox" replacement is only used for roblox apis.
"externalurl" is gonna replace "api.roblox.com" to "api.externalurl.com", because roblox doesn't allow access to it api
--]]

--[[
update 1.1:

added support for arguments on :get() method.
added support for arguments on :post() method
arguments type must be an table.
fixed few bugs.
removed google method after short research on the performance.
--]]

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local EasyHttps = {}

if (RunService:IsClient()) then
	return setmetatable(EasyHttps, {}), warn(`Warning: {HttpService.Name} only works on **server**, move everything from client to server..`)
end

type Arguments = {any} | nil

function EasyHttps.new()
	local self = {}
	self.__index = self
	self.__newindex = function()
		warn("this is a **read-only** table")
	end

	self.debugmode = false
	self.autoclean = false

	self.externalurl = "roproxy"
	self.debugstring = "url: %s, response: %s, body: %s, latency: %ss"
	self.argumentsupport = "table"
	
	self.janitor = require(script.Packages.Janitor).new()

	return setmetatable(EasyHttps, self)
end

function EasyHttps.unpack(self, arguments)
	if (arguments == nil) then return "" end
	if (typeof(arguments) ~= self.argumentsupport) then return warn("Argument type must be an table.") end
	return table.unpack(arguments)
end

function EasyHttps:get(url: string, arguments: Arguments)
	local http = {}
	local startTime = os.time()
	
	local success, result = xpcall(function()
		return HttpService:GetAsync(url:gsub("roblox", self.externalurl):format(self.unpack(self, arguments))) -- make sure to use %s for every replacement
	end, warn)

	http.response = function()
		local response = {}

		response.success = function()
			if (success) then
				return "Success"
			end

			return "Failed"
		end

		response.get = function()
			if (response.success() == "Success") then
				return HttpService:JSONDecode(result)
			end
		end
		
		if self.debugmode then print(self.debugstring:format(url, result, self.unpack(self, arguments), (os.time() - startTime) % 60)) end
		return response
	end

	return http
end

function EasyHttps:post(url: string, arguments: Arguments, content_type: Enum.HttpContentType, compress: boolean)
	local http = {}
	local success, result = xpcall(function()
		HttpService:PostAsync(url:gsub("roblox", self.externalurl), HttpService:JSONEncode(arguments), content_type or Enum.HttpContentType.ApplicationJson, compress or false)
	end, warn)

	http.response = function()
		local response = {}

		response.success = function()
			if (success) then
				return "Success"
			end

			return "Failed"
		end

		if self.debugmode then print(self.debugstring:format(tostring(url), result, arguments, "")) end
		return response
	end

	return http
end

-- Finale.
return EasyHttps.new()
