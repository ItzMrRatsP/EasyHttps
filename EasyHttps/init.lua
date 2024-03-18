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

+ added support for arguments on :get() method.
+ added support for arguments on :post() method
# arguments type must be an table.
# fixed few bugs.
- removed google method after short research on the performance.
--]]

--[[
update 1.11:
+ added response.get() for post method.
# replaced response.success() from function to string response.success
--]]

-- thanks to dylwithit for rewritting some parts of the script.

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local Janitor = require(script.Packages.Janitor)

local EXTERNAL_URL = "roproxy"
local DEBUG_STRING = "url: %s, response: %s, body: %s, latency: %ss"
local ARGUMENT_SUPPORT = "table"

local EasyHttps = {}

if RunService:IsClient() then
    return setmetatable(EasyHttps, {}),
        warn(`Warning: {HttpService.Name} only works on **server**, move everything from client to server..`)
end

type Arguments = { any } | nil

function EasyHttps.new()
    local self = {}

    self.debugmode = false
    self.autoclean = false

    self.get = EasyHttps.get
    self.post = EasyHttps.post
    self.unpack = EasyHttps.unpack

    self.janitor = Janitor.new()

    return table.freeze(self)
end

function EasyHttps:unpack(arguments)
    if arguments == nil then
        return ""
    end
    if typeof(arguments) ~= ARGUMENT_SUPPORT then
        return warn("Argument type must be an table.")
    end
    return table.unpack(arguments)
end

function EasyHttps:get(url: string, arguments: Arguments)
    local http = {}
    local startTime = os.time()

    local success, result = xpcall(function()
        return HttpService:GetAsync(url:gsub("roblox", EXTERNAL_URL):format(self.unpack(self, arguments))) -- make sure to use %s for every replacement
    end, warn)

    http.response = function()
        local response = {}
		response.success = if success then "Success" else "Failure"

        response.get = function()
            if response.success == "Success" then
                return HttpService:JSONDecode(result)
            end
        end

        if self.debugmode then
            print(DEBUG_STRING:format(url, result, self.unpack(self, arguments), (os.time() - startTime) % 60))
        end
        return response
    end

    return http
end

function EasyHttps:post(url: string, arguments: Arguments, content_type: Enum.HttpContentType, compress: boolean)
    local http = {}
	local startTime = os.time()
	
    local success, result = xpcall(function()
        HttpService:PostAsync(url:gsub("roblox", EXTERNAL_URL), HttpService:JSONEncode(arguments), content_type or Enum.HttpContentType.ApplicationJson, compress or false)
    end, warn)

    http.response = function()
        local response = {}
		response.success = if success then "Success" else "Failure"

        response.get = function()
            if response.success == "Success" then
                return HttpService:JSONDecode(result)
            end
        end

        if self.debugmode then
            print(DEBUG_STRING:format(url, result, self.unpack(self, arguments), (os.time() - startTime) % 60))
        end
        return response
    end

    return http
end

-- Finale.
return EasyHttps.new()
