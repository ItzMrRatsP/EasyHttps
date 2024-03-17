# EasyHttps
Roblox HttpService wrapper, very simple and easy to use.


API
Get Method:
```lua
    :get(url, args).response() -- Returns the response from url result.
```
```lua
    .response():get() -- Returns the decoded result.
```
```lua
    .response():Success() -- Returns an string from xpcall result, Its either "Success" or "Failed". 
```

``: Returns the result of xpcall, its either success or failed.
`.response:get()`: 
`:post(url, body, ...).response()`: 
