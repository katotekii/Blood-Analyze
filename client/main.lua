local opened = false

AddEventHandler('esx:onPlayerDeath', function()
	TriggerServerEvent("create:drop") -- this sall drop item when you die, didn't tested
end)

local function thread()  
    CreateThread(function()
        while true do 
            Wait(0)
            if IsControlJustReleased(0, 177) then
                SendNUIMessage({type = "close"})
                ClearPedTasks(PlayerPedId())
                opened = false
                break 
            end
        end
    end)
end

if Config.UseExport then 
    exports('open:evidence',function (data,slot)
        exports.ox_inventory:useItem(data, function(data)
            if data then
                if not opened then
                    local id = exports.ox_inventory:Search(1, GlobalState.AnalizedBlood)
                    for _, v in pairs(id) do
                        SendNUIMessage({
                            type = "showReport",
                            evidence = json.encode(v.metadata)
                        })
                    end
                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)  
                    ESX.ShowNotification("BACKSPACE to close")
                    thread()
                    opened = true
                end
            end
        end)
    end)
else
    AddEventHandler("open:evidence", function() -- event for item
        if not opened then
            local id = exports.ox_inventory:Search(1, GlobalState.AnalizedBlood)
            for _, v in pairs(id) do
                SendNUIMessage({
                    type = "showReport",
                    evidence = json.encode(v.metadata)
                })
            end
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)  
            ESX.ShowNotification("BACKSPACE to close")
            thread()
            opened = true
        end
    end)
end


AddEventHandler("analizeblood", function()
    exports.rprogress:Custom(
        {
            Async = true,
            Duration = 1000,
            Label = "ANALIZING BLOOD...",
            Easing = "easeLinear",
            DisableControls = {
                Mouse = false,
                Player = true,
                Vehicle = false
            }
        },
        function(e)
    end) 
    Wait(1000)
    local id = exports.ox_inventory:Search(1, GlobalState.blood)
    for _, v in pairs(id) do
        TriggerServerEvent("giveanalizedblood", v.metadata)
    end
end)

exports["qtarget"]:AddCircleZone("analizeblood", vector3(367.08, -1592.64, 25.8), 0.25, { -- zone in gabz's Davis Departmant
	name ="analizeblood",
	useZ = true,
	debugPoly=false,
	}, {
	options = {
		{
			event = "analizeblood",
			icon = "fas fa-laptop-medical",
			label = "Analize Blood",
			job = 	{
				['police'] = 1 -- put your job and grade you want
			},
            item = GlobalState.blood,
		},
	},
	distance = 2.1
})
