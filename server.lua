--- ADD YOUR STEAM ID OR LICENSE FROM YOUR ADMINS!
local admins = {
    'steam:1100001089a8dbc', -- zharrane
    'license:8f82808713c1c38c68c33951d26430afdead5165', -- zharrane

}

function isAdmin(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterServerEvent("checkadmin")
AddEventHandler("checkadmin", function()
	local id = source
	if isAdmin(id) then
		TriggerClientEvent("setgroup", source)
	end
end)