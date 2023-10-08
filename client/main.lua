--[[ ===================================================== ]] --
--[[            MH Housenames Script by MaDHouSe           ]] --
--[[ ===================================================== ]] --
local QBCore = exports['qb-core']:GetCoreObject()
local allHouses = {}
local PlayerData = {}
local blips = {}

local function DeleteAllBlips()
    for k, blip in pairs(blips) do
        RemoveBlip(blip)
    end
end

local function CreateHouseBlip(label, coords)
    if Config.ShowBlips then
        local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(blip, 40)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 0)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(label)
        EndTextCommandSetBlipName(blip)
        blips[#blips + 1] = blip
        return blip
    end
end

local function CreateHouseBlips()
    for id, house in pairs(allHouses) do
        CreateHouseBlip(house.label, house.coords.enter)
    end
end

local function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
    local p = GetGameplayCamCoords()
    local dist = #(p - vector3(x, y, z))
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    SetTextScale(scaleX * scale, scaleY * scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x, y, z + 2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

local function CreateDisPlay(house)
    local info, street, owner = "", "", ""
    street = Lang:t('info.street', {
        street = house.label
    }) .. '\n'
    nickname = Lang:t('info.owner', {
        owner = house.nickname
    }) .. '\n'
    info = string.format("%s", street .. nickname)
    return info
end

local function DisplayHouseText()
    local pl = GetEntityCoords(PlayerPedId())
    for id, house in pairs(allHouses) do
        if #(pl - vector3(house.coords.enter.x, house.coords.enter.y, house.coords.enter.z)) <
            Config.DrawHouseNameDistance then
            local display = CreateDisPlay(house)
            Draw3DText(house.coords.enter.x + Config.HouseNameOffSet, house.coords.enter.y + Config.HouseNameOffSet,
                house.coords.enter.z - 2, display, 0, Config.TextScale, Config.TextScale)
            if house.nickname == Config.JobLabel then
                if #(pl - vector3(house.coords.enter.x, house.coords.enter.y, house.coords.enter.z)) <
                    Config.DrawButtonDictance then
                    Draw3DText(house.coords.enter.x + Config.HouseNameOffSet,
                        house.coords.enter.y + Config.HouseNameOffSet, house.coords.enter.z - 2.2,
                        Lang:t('info.forsale', {
                            amount = house.price
                        }) .. '\n' .. Lang:t('info.buy'), 0, Config.TextScale, Config.TextScale)
                    if IsControlJustReleased(0, Config.InteractButton) then
                        allHouses = {}
                        Wait(500)
                        TriggerServerEvent("qb-houses:server:buyHouse2", house)
                        TriggerServerEvent("qb-housenames:server:GetAllHouses")
                    end
                end
            end
        end
    end
end

local function DeleteSigns()
    local sign = GetClosestObjectOfType(908.92, -608.87, 57.68, 1.0, GetHashKey(1295978393), false, false, false)
    DeleteObject(sign)
    local sign2 = GetClosestObjectOfType(935.04, -628.0, 57.6, 1.0, GetHashKey(2013260172), false, false, false)
    DeleteObject(sign2)
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    TriggerServerEvent("qb-housenames:server:GetAllHouses")
    DeleteSigns()
    CreateHouseBlips()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    DeleteAllBlips()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteAllBlips()
    end
end)

AddEventHandler('onResourceStart', function(resource)
    TriggerServerEvent("qb-housenames:server:GetAllHouses")
    DeleteSigns()
    CreateHouseBlips()
end)

AddEventHandler('onResourceStop', function(resource)
    allHouses = {}
end)

RegisterNetEvent('qb-housenames:client:RefreshHouses', function()
    allHouses = {}
    DeleteAllBlips()
    TriggerServerEvent("qb-housenames:server:GetAllHouses")
    CreateHouseBlips()
end)

RegisterNetEvent("qb-housenames:client:GetAllHouses", function(houses)
    DeleteAllBlips()
    allHouses = houses
    CreateHouseBlips()
end)

CreateThread(function()
    while true do
        DisplayHouseText()
        Wait(0)
    end
end)
