# EasyHttps
Roblox HttpService wrapper, very simple and easy to use.                                                
EasyHttps @ ItzMrRatsP

                                     
Get Method:
```lua
    :get(url, args).response() -- Returns the response from url result.
```

```lua
    .response():get() -- Returns the decoded result.
```

```lua
    .response():Success() -- Returns the result of get method, in "Success" or "Failure".
```

Post Method:
```lua
    :post(url, body).response() -- Post the body to url, and return the response from result.
```

```lua
    .response().success -- Returns the result of post method, in "Success" or "Failure".
```

```lua
    .response():get() -- Returns the result of xpcall, its either success or failed.
```
