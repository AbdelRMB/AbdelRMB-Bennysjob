--		  █████╗ ██████╗ ██████╗ ███████╗██╗     ██████╗ ███╗   ███╗██████╗
--		 ██╔══██╗██╔══██╗██╔══██╗██╔════╝██║     ██╔══██╗████╗ ████║██╔══██╗
--		 ███████║██████╔╝██║  ██║█████╗  ██║     ██████╔╝██╔████╔██║██████╔╝
--		 ██╔══██║██╔══██╗██║  ██║██╔══╝  ██║     ██╔══██╗██║╚██╔╝██║██╔══██╗
--		 ██║  ██║██████╔╝██████╔╝███████╗███████╗██║  ██║██║ ╚═╝ ██║██████╔╝
--		 ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝

PlayersHarvesting  = {}
PlayersHarvesting2 = {}
PlayersHarvesting3 = {}
PlayersCrafting    = {}
PlayersCrafting2   = {}
PlayersCrafting3   = {}
ESX                = exports["es_extended"]:getSharedObject()

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'bennys', Config.MaxInService)
end

TriggerEvent('esx_society:registerSociety', 'bennys', 'bennys', 'society_bennys', 'society_bennys', 'society_bennys',
	{ type = 'private' })

local function Harvest(source)
	SetTimeout(4000, function()
		if PlayersHarvesting[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count

			if GazBottleQuantity >= 5 then
				TriggerEvent('AbdelRMB:Notify', 'Vous n\'avez pas assez de place pour plus de bouteilles de gaz !',
					'error', 5000)
			else
				xPlayer.addInventoryItem('gazbottle', 1)
				Harvest(source)
			end
		end
	end)
end


RegisterServerEvent('AbdelRMB_bennysjob:startHarvest')
AddEventHandler('AbdelRMB_bennysjob:startHarvest', function()
	local _source = source
	PlayersHarvesting[_source] = true
	TriggerClientEvent('AbdelRMB:Notify', _source, 'Récupération de bouteilles de gaz commencée', 'info', 5000)
	Harvest(source)
end)

RegisterServerEvent('AbdelRMB_bennysjob:stopHarvest')
AddEventHandler('AbdelRMB_bennysjob:stopHarvest', function()
	local _source = source
	if PlayersHarvesting[_source] then
		TriggerClientEvent('AbdelRMB:Notify', _source, 'Récolte de bouteilles de gaz arrêtée', 'info', 5000)
	end
	PlayersHarvesting[_source] = false
end)

local function Harvest2(source)
	SetTimeout(4000, function()
		if PlayersHarvesting2[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local FixToolQuantity = xPlayer.getInventoryItem('fixtool').count

			if FixToolQuantity >= 5 then
				TriggerClientEvent('AbdelRMB:Notify', source,
					'Vous n\'avez pas assez de place pour plus d\'outils de réparation !', 'error', 5000)
			else
				xPlayer.addInventoryItem('fixtool', 1)
				Harvest2(source)
			end
		end
	end)
end


RegisterServerEvent('AbdelRMB_bennysjob:startHarvest2')
AddEventHandler('AbdelRMB_bennysjob:startHarvest2', function()
	local _source = source
	PlayersHarvesting2[_source] = true
	TriggerClientEvent('AbdelRMB:Notify', _source, 'Récupération d\'outil de réparation commencée', 'info', 5000)
	Harvest2(_source)
end)

RegisterServerEvent('AbdelRMB_bennysjob:stopHarvest2')
AddEventHandler('AbdelRMB_bennysjob:stopHarvest2', function()
	local _source = source
	if PlayersHarvesting2[_source] then
		TriggerClientEvent('AbdelRMB:Notify', _source, 'Récupération d\'outil de réparation arrêtée', 'info', 5000)
	end
	PlayersHarvesting2[_source] = false
end)

local function Harvest3(source)
	SetTimeout(4000, function()
		if PlayersHarvesting3[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local CaroToolQuantity = xPlayer.getInventoryItem('carotool').count

			if CaroToolQuantity >= 5 then
				TriggerClientEvent('AbdelRMB:Notify', source, 'Vous n\'avez pas assez de place pour plus d\'outils de carrosserie !', 'error', 5000)
			else
				xPlayer.addInventoryItem('carotool', 1)
				Harvest3(source)
			end
		end
	end)
end


RegisterServerEvent('AbdelRMB_bennysjob:startHarvest3')
AddEventHandler('AbdelRMB_bennysjob:startHarvest3', function()
	local _source = source
	PlayersHarvesting3[_source] = true
	TriggerClientEvent('AbdelRMB:Notify', _source, 'Récupération d\'outils de carrosserie commencée', 'info', 5000)
	Harvest3(_source)
end)


RegisterServerEvent('AbdelRMB_bennysjob:stopHarvest3')
AddEventHandler('AbdelRMB_bennysjob:stopHarvest3', function()
	local _source = source
	if PlayersHarvesting3[_source] then
		TriggerClientEvent('AbdelRMB:Notify', _source, 'Récupération d\'outil de carrosserie arrêtée', 'info', 5000)
	end
	PlayersHarvesting3[_source] = false
end)

local function Craft(source)
	SetTimeout(4000, function()
		if PlayersCrafting[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local GazBottleQuantity = xPlayer.getInventoryItem('gazbottle').count

			if GazBottleQuantity <= 0 then
				TriggerClientEvent('AbdelRMB:Notify', source, 'Vous n\'avez pas assez de bouteilles de gaz !', 'error', 5000)
			else
				xPlayer.removeInventoryItem('gazbottle', 1)
				xPlayer.addInventoryItem('blowpipe', 1)
				Craft(source)
			end
		end
	end)
end

RegisterServerEvent('AbdelRMB_bennysjob:startCraft')
AddEventHandler('AbdelRMB_bennysjob:startCraft', function()
	local _source = source
	PlayersCrafting[_source] = true
	TriggerClientEvent('AbdelRMB:Notify', _source, 'Assemblage du chalumeau en cours...', 'info', 5000)
	Craft(_source)
end)


RegisterServerEvent('AbdelRMB_bennysjob:stopCraft')
AddEventHandler('AbdelRMB_bennysjob:stopCraft', function()
	local _source = source
	if PlayersCrafting[_source] then
		TriggerClientEvent('AbdelRMB:Notify', _source, 'Assemblage du chalumeau arrêté', 'info', 5000)
	end
	PlayersCrafting[_source] = false
end)

local function Craft2(source)
	SetTimeout(4000, function()
		if PlayersCrafting2[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local FixToolQuantity = xPlayer.getInventoryItem('fixtool').count

			if FixToolQuantity <= 0 then
				TriggerClientEvent('AbdelRMB:Notify', source, 'Vous n\'avez pas assez d\'outil de réparation !', 'error', 5000)
			else
				xPlayer.removeInventoryItem('fixtool', 1)
				xPlayer.addInventoryItem('fixkit', 1)
				Craft2(source)
			end
		end
	end)
end

RegisterServerEvent('AbdelRMB_bennysjob:startCraft2')
AddEventHandler('AbdelRMB_bennysjob:startCraft2', function()
	local _source = source
	PlayersCrafting2[_source] = true
	TriggerClientEvent('AbdelRMB:Notify', _source, 'Assemblage du Kit de réparation...', 'info', 5000)
	Craft2(_source)
end)

RegisterServerEvent('AbdelRMB_bennysjob:stopCraft2')
AddEventHandler('AbdelRMB_bennysjob:stopCraft2', function()
	local _source = source
	if PlayersCrafting2[_source] then
		TriggerClientEvent('AbdelRMB:Notify', _source, 'Assemblage du Kit de réparation arrêté', 'info', 5000)
	end
	PlayersCrafting2[_source] = false
end)

local function Craft3(source)
	SetTimeout(4000, function()
		if PlayersCrafting3[source] == true then
			local xPlayer = ESX.GetPlayerFromId(source)
			local CaroToolQuantity = xPlayer.getInventoryItem('carotool').count

			if CaroToolQuantity <= 0 then
				TriggerClientEvent('AbdelRMB:Notify', source, 'Vous n\'avez pas assez d\'outil de carrosserie !', 'error', 5000)
			else
				xPlayer.removeInventoryItem('carotool', 1)
				xPlayer.addInventoryItem('carokit', 1)
				Craft3(source)
			end
		end
	end)
end

RegisterServerEvent('AbdelRMB_bennysjob:startCraft3')
AddEventHandler('AbdelRMB_bennysjob:startCraft3', function()
	local _source = source
	PlayersCrafting3[_source] = true
	TriggerClientEvent('AbdelRMB:Notify', _source, 'Assemblage du Kit de carrosserie...', 'info', 5000)
	Craft3(_source)
end)

RegisterServerEvent('AbdelRMB_bennysjob:stopCraft3')
AddEventHandler('AbdelRMB_bennysjob:stopCraft3', function()
	local _source = source
	if PlayersCrafting3[_source] then
		TriggerClientEvent('AbdelRMB:Notify', _source, 'Assemblage du Kit de carrosserie arrêté', 'info', 5000)
	end
	PlayersCrafting3[_source] = false
end)


ESX.RegisterUsableItem('blowpipe', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('blowpipe', 1)

	TriggerClientEvent('AbdelRMB_bennysjob:onHijack', _source)
	TriggerClientEvent('AbdelRMB:Notify', _source, 'Vous avez utilisé un chalumeau', 'info', 5000)
end)


ESX.RegisterUsableItem('fixkit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fixkit', 1)

	TriggerClientEvent('AbdelRMB_bennysjob:onFixkit', _source)
	TriggerClientEvent('AbdelRMB:Notify', _source, 'Vous avez utilisé un Kit de réparation', 'info', 5000)
end)

ESX.RegisterUsableItem('carokit', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('carokit', 1)

	TriggerClientEvent('esx_bennyscjob:onCarokit', _source)
	TriggerClientEvent('AbdelRMB:Notify', _source, 'Vous avez utilisé un Kit de carrosserie', 'info', 5000)
end)

ESX.RegisterServerCallback('AbdelRMB_bennysjob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({ items = items })
end)
