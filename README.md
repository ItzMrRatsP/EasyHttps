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
    .response():Success() -- Returns the result of xpcall, its either success or failed.
```

Post Method:
```lua
    :post(url, body).response() -- Post the body to url, and return the response from result.
```

```lua
    .response():Success() -- Returns the result of xpcall, its either success or failed.
```
