# Hard Dependencies
- [ox_inventory](https://github.com/overextended/ox_inventory)
- [es_extended](https://github.com/overextended/es_extended)
# Soft Dependencies
- [rprogress](https://github.com/overextended/es_extended)
- [qtarget](https://github.com/overextended/qtarget)

If you don't want these 2 scripts you'll need to edit script
## In server/main.lua you have 2 items for blood (1st item that drops when somebody dies and 2nd is analized blood) name them however you want 
You also need to add these 2 items in ox_inventory/data/items.lua
```lua
['blood'] = { -- name must be the same as in server side
  label = 'Krv',
  weight = 40,
  stack = true,
  close = true,
	},
['analizedblood'] = { -- name must be the same as in server side
  label = 'Analized Blod',
  weight = 10,
  stack = true,
  close = true,
  client = {
    --event = "open:evidence" -- if you use older version then uncomment this and comment export
    export = "open:evidence"
  },
},
```
