# EasyHttps
Roblox HttpService wrapper, very simple and easy to use.


API:                                                          

```lua
    :get(url, args).response()
```
: Returns the response of the url.

`.response:success()`: Returns the result of xpcall, its either success or failed.
`.response:get()`: Returns the decoded result.
`:post(url, body, ...).response()`: 
