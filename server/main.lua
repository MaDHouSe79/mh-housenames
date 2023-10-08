--[[ ===================================================== ]] --
--[[            MH Housenames Script by MaDHouSe           ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()
local houses = {}

local function addHouse(house, nickname)
    houses[#houses + 1] = {
        name = house.name,
        label = house.label,
        price = house.price,
        nickname = nickname,
        owner = house.owned,
        tier = house.tier,
        coords = json.decode(house.coords),
        garage = house.garage
    }
end

local function getHouses()
    MySQL.Async.fetchAll("SELECT * FROM houselocations", {}, function(result)
        for k, v in pairs(result) do
            if v.owned then
                local rs = MySQL.Sync.fetchAll('SELECT * FROM player_houses WHERE house = ? ', {v.name});
                local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? ', {rs[1].citizenid});
                addHouse(v, player[1].name)
            else
                addHouse(v, "Realestate")
            end
        end
    end)
    Wait(1000)
    TriggerClientEvent("qb-housenames:client:GetAllHouses", -1, houses)
end

RegisterServerEvent('qb-housenames:server:GetAllHouses', function()
    houses = {}
    getHouses()
end)
