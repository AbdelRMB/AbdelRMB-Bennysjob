--		  █████╗ ██████╗ ██████╗ ███████╗██╗     ██████╗ ███╗   ███╗██████╗
--		 ██╔══██╗██╔══██╗██╔══██╗██╔════╝██║     ██╔══██╗████╗ ████║██╔══██╗
--		 ███████║██████╔╝██║  ██║█████╗  ██║     ██████╔╝██╔████╔██║██████╔╝
--		 ██╔══██║██╔══██╗██║  ██║██╔══╝  ██║     ██╔══██╗██║╚██╔╝██║██╔══██╗
--		 ██║  ██║██████╔╝██████╔╝███████╗███████╗██║  ██║██║ ╚═╝ ██║██████╔╝
--		 ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝


local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle = nil
local isDead = false
local AbdelRMBUI = exports['AbdelRMBUI']:GetAbdelRMBUI()

Citizen.CreateThread(function()
	ESX = exports["es_extended"]:getSharedObject()

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- Benny's menu action

function OpenbennysActionsMenu()
	AbdelRMBUI.CreateMenu("bennys", "actions", "Menu d'actions", nil)

	AbdelRMBUI.Button("bennys_actions", "Liste de véhicules", function()
		OpenVehicleListMenu()
	end)

	AbdelRMBUI.Button("bennys_actions", "Tenue de travail", function()
		ChangeToWorkWear()
	end)

	AbdelRMBUI.Button("bennys_actions", "Tenue civile", function()
		ChangeToCivWear()
	end)

	AbdelRMBUI.Button("bennys_actions", "Coffre", function()
		OpenStockMenu()
	end)

	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
		AbdelRMBUI.Button("bennys_actions", "Actions de Patron", function()
			OpenBossMenu()
		end)
	end

	AbdelRMBUI.OpenMenu("bennys", "actions")
end

----------------------------------------------------------------------------------------------------------------------------------------
-- Benny's vehicules

function OpenVehicleListMenu()
	if Config.EnableSocietyOwnedVehicles then
		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
			AbdelRMBUI.CreateMenu("vehicle", "spawner", "Choisissez un véhicule", "bennys_actions")

			for i = 1, #vehicles, 1 do
				local vehicleLabel = GetDisplayNameFromVehicleModel(vehicles[i].model) ..
					' [' .. vehicles[i].plate .. ']'
				AbdelRMBUI.Button("vehicle_spawner", vehicleLabel, function()
					SpawnVehicle(vehicles[i])
				end)
			end

			AbdelRMBUI.Button("vehicle_spawner", "Revenir au menu principal", function()
				AbdelRMBUI.OpenMenu("bennys", "actions")
			end)

			AbdelRMBUI.OpenMenu("vehicle", "spawner")
		end, 'bennys')
	else
		OpenDefaultVehicleMenu()
	end
end

function SpawnVehicle(vehicleProps)
	ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
		ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
		local playerPed = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
	end)
	TriggerServerEvent('esx_society:removeVehicleFromGarage', 'bennys', vehicleProps)
end

function OpenDefaultVehicleMenu()
	AbdelRMBUI.CreateMenu("spawn", "vehicle", "Choisissez un véhicule", "bennys_actions")
	AbdelRMBUI.Button("spawn_vehicle", "Flatbed", function()
		SpawnServiceVehicle("flatbed")
		AbdelRMBUI.CloseMenu("spawn", "vehicle")
	end)
	AbdelRMBUI.Button("spawn_vehicle", "Tow Truck", function()
		SpawnServiceVehicle("towtruck2")
		AbdelRMBUI.CloseMenu("spawn", "vehicle")
	end)

	if Config.EnablePlayerManagement and ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'chief' or ESX.PlayerData.job.grade_name == 'experimente') then
		AbdelRMBUI.Button("spawn_vehicle", "SlamVan", function() SpawnServiceVehicle("slamvan3") end)
	end

	AbdelRMBUI.Button("spawn_vehicle", "Revenir au menu principal", function()
		AbdelRMBUI.OpenMenu("bennys", "actions")
	end)

	AbdelRMBUI.OpenMenu("spawn", "vehicle")
end

function SpawnServiceVehicle(model)
	ESX.Game.SpawnVehicle(model, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
		local playerPed = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
	end)
end

----------------------------------------------------------------------------------------------------------------------------------------
-- Benny's clothes

function ChangeToWorkWear()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		if skin.sex == 0 then
			local maleOutfit = {
				['tshirt_1'] = 15,
				['tshirt_2'] = 0,
				['torso_1'] = 65,
				['torso_2'] = 0,
				['decals_1'] = 0,
				['decals_2'] = 0,
				['arms'] = 26,
				['pants_1'] = 38,
				['pants_2'] = 0,
				['shoes_1'] = 12,
				['shoes_2'] = 6,
				['helmet_1'] = -1,
				['helmet_2'] = 0,
				['chain_1'] = 0,
				['chain_2'] = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, maleOutfit)
		else
			local femaleOutfit = {
				['tshirt_1'] = 3,
				['tshirt_2'] = 0,
				['torso_1'] = 65,
				['torso_2'] = 2,
				['decals_1'] = 0,
				['decals_2'] = 0,
				['arms'] = 36,
				['pants_1'] = 38,
				['pants_2'] = 0,
				['shoes_1'] = 27,
				['shoes_2'] = 0,
				['helmet_1'] = -1,
				['helmet_2'] = 0,
				['chain_1'] = 0,
				['chain_2'] = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, femaleOutfit)
		end
	end)
end

function ChangeToCivWear()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)
end

----------------------------------------------------------------------------------------------------------------------------------------
-- Benny's coffre

function OpenStockMenu()
	local storageName = 'bennys_stock'
	AbdelRMBUI.CloseMenu("bennys", "actions")
	exports.ox_inventory:openInventory('stash', storageName)
end

----------------------------------------------------------------------------------------------------------------------------------------
-- Benny's boss menu

function OpenBossMenu()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bennys' and ESX.PlayerData.job.grade_name == 'boss' then
        TriggerEvent('esx_society:openBossMenu', 'bennys', function(data, menu)
            menu.close()
        end, {wash = false})
    else
        TriggerEvent('AbdelRMB:Notify', 'Vous n\'êtes pas autorisé à accéder à ce menu', 'error', 3000)
    end
end



----------------------------------------------------------------------------------------------------------------------------------------
-- Benny's haverst menu

function OpenbennysHarvestMenu()
	AbdelRMBUI.CreateMenu("HarvestMenu", "mainMenu", "Benny's")

	AbdelRMBUI.Button("HarvestMenu_mainMenu", "Bouteille de gaz", function()
		TriggerServerEvent('AbdelRMB_bennysjob:startHarvest')
	end)
	AbdelRMBUI.Button("HarvestMenu_mainMenu", "Outil de réparation", function()
		TriggerServerEvent('AbdelRMB_bennysjob:startHarvest2')
	end)
	AbdelRMBUI.Button("HarvestMenu_mainMenu", "Outil de carosserie", function()
		TriggerServerEvent('AbdelRMB_bennysjob:startHarvest3')
	end)

	AbdelRMBUI.OpenMenu("HarvestMenu", "mainMenu")
end

----------------------------------------------------------------------------------------------------------------------------------------
-- Benny's craft menu


function OpenbennysCraftMenu()
	AbdelRMBUI.CreateMenu("Craft", "mainMenu", "Benny's | Craft")

	AbdelRMBUI.Button("Craft_mainMenu", "Chalumeau", function()
		TriggerServerEvent('AbdelRMB_bennysjob:startCraft')
	end)
	AbdelRMBUI.Button("Craft_mainMenu", "Kit de réparation", function()
		TriggerServerEvent('AbdelRMB_bennysjob:startCraft2')
	end)
	AbdelRMBUI.Button("Craft_mainMenu", "Kit de carosserie", function()
		TriggerServerEvent('AbdelRMB_bennysjob:startCraft3')
	end)

	AbdelRMBUI.OpenMenu("Craft", "mainMenu")
end

----------------------------------------------------------------------------------------------------------------------------------------
-- Benny's f6 menu

function OpenMobilebennysActionsMenu()
	AbdelRMBUI.CreateMenu("F6", "mainMenu", "Benny's")
	AbdelRMBUI.CreateMenu("F6", "facture", "Donner une facture", "mainMenu")


	AbdelRMBUI.Button("F6_mainMenu", "Facture", function()
		AbdelRMBUI.OpenMenu("F6", "facture")
	end)

	AbdelRMBUI.Button("F6_mainMenu", "Nétoyer le véhicule", function()
		local playerPed = PlayerPedId()
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(playerPed)

		if IsPedSittingInAnyVehicle(playerPed) then
			TriggerEvent('AbdelRMB:Notify', 'Vous êtes dans un véhicule !', 'error', 5000)
			return
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)

				SetVehicleDirtLevel(vehicle, 0)
				ClearPedTasksImmediately(playerPed)

				TriggerEvent('AbdelRMB:Notify', 'Véhicule nétoyé !', 'success', 5000)
			end)
		else
			TriggerEvent('AbdelRMB:Notify', 'Aucun véhicule à proximité !', 'error', 5000)
		end
	end)

	AbdelRMBUI.Button("F6_mainMenu", "Supprimer le véhicule", function()
		local playerPed = PlayerPedId()

		if IsPedSittingInAnyVehicle(playerPed) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if GetPedInVehicleSeat(vehicle, -1) == playerPed then
				TriggerEvent('AbdelRMB:Notify', 'Véhicule supprimé !', 'success', 5000)
				ESX.Game.DeleteVehicle(vehicle)
			else
				TriggerEvent('AbdelRMB:Notify', 'Vous devez être conducteur !', 'error', 5000)
			end
		else
			local vehicle = ESX.Game.GetVehicleInDirection()
			local coords = GetEntityCoords(playerPed)

			if DoesEntityExist(vehicle) then
				TriggerEvent('AbdelRMB:Notify', 'Véhicule supprimé !', 'success', 5000)
				ESX.Game.DeleteVehicle(vehicle)
			else
				TriggerEvent('AbdelRMB:Notify', 'Aucun véhicule à proximité !', 'error', 5000)
			end
		end
	end)

	AbdelRMBUI.Button("F6_mainMenu", "Remorquage", function()
		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, true)
		local towmodel = GetHashKey('flatbed')
		local isVehicleTow = IsVehicleModel(vehicle, towmodel)

		if isVehicleTow then
			local targetVehicle = ESX.Game.GetVehicleInDirection()

			if CurrentlyTowedVehicle == nil then
				if targetVehicle ~= 0 then
					if not IsPedInAnyVehicle(playerPed, true) then
						if vehicle ~= targetVehicle then
							AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false,
								false, false, 20, true)
							CurrentlyTowedVehicle = targetVehicle
							TriggerEvent('AbdelRMB:Notify', 'Véhicule remorqué avec succès !', 'success', 5000)
						else
							TriggerEvent('AbdelRMB:Notify', 'Vous ne pouvez pas remorquer votre propre dépanneuse !',
								'error', 5000)
						end
					end
				else
					TriggerEvent('AbdelRMB:Notify', 'Aucun véhicule à proximité à remorquer !', 'error', 5000)
				end
			else
				AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false,
					false, false, 20, true)
				DetachEntity(CurrentlyTowedVehicle, true, true)

				CurrentlyTowedVehicle = nil
				TriggerEvent('AbdelRMB:Notify', 'Véhicule détaché avec succès !', 'success', 5000)
			end
		else
			TriggerEvent('AbdelRMB:Notify', 'Vous devez être dans un flatbed pour remorquer un véhicule !', 'error', 5000)
		end
	end)

	local invoiceAmount = 0

	AbdelRMBUI.Input("F6_facture", "Entrez un montant :", "0", 'number', function(value)
		invoiceAmount = tonumber(value) or 0
		print("Montant saisi :", invoiceAmount)
	end)

	AbdelRMBUI.Button("F6_facture", "Envoyer la facture", function()
		local playerPed = PlayerPedId()
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		if invoiceAmount == nil or invoiceAmount <= 0 then
			TriggerEvent('AbdelRMB:Notify', 'Montant invalide !', 'error', 5000)
			return
		end

		if closestPlayer == -1 or closestDistance > 3.0 then
			TriggerEvent('AbdelRMB:Notify', 'Aucun joueur à proximité !', 'error', 5000)
		else
			TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_bennys', 'Bennys',
				invoiceAmount)
			TriggerEvent('AbdelRMB:Notify', 'Facture envoyée avec succès !', 'success', 5000)
		end
	end)

	AbdelRMBUI.Button("F6_facture", "Revenir au menu principal", function()
		AbdelRMBUI.OpenMenu("F6", "mainMenu")
	end)


	AbdelRMBUI.OpenMenu("F6", "mainMenu")
end

----------------------------------------------------------------------------------------------------------------------------------------
-- Benny's use hijack

RegisterNetEvent('AbdelRMB_bennysjob:onHijack')
AddEventHandler('AbdelRMB_bennysjob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('veh_unlocked'))
				else
					ESX.ShowNotification(_U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- Benny's use crokit

RegisterNetEvent('AbdelRMB_bennysjob:onCarokit')
AddEventHandler('AbdelRMB_bennysjob:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('body_repaired'))
			end)
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------
-- Benny's use fixkit

RegisterNetEvent('AbdelRMB_bennysjob:onFixkit')
AddEventHandler('AbdelRMB_bennysjob:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('veh_repaired'))
			end)
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('AbdelRMB_bennysjob:hasEnteredMarker', function(zone)
	if zone == 'NPCJobTargetTowable' then

	elseif zone == 'bennysActions' then
		CurrentAction     = 'bennys_actions_menu'
		CurrentActionMsg  = 'Appuyer sur E pour ouvrir le menu Benny\'s'
		CurrentActionData = {}
	elseif zone == 'Garage' then
		CurrentAction     = 'bennys_harvest_menu'
		CurrentActionMsg  = 'Appuyer sur E pour ouvrir le menu de récolte'
		CurrentActionData = {}
	elseif zone == 'Craft' then
		CurrentAction     = 'bennys_craft_menu'
		CurrentActionMsg  = 'Appuyer sur E pour ouvrir le menu de craft'
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle     = GetVehiclePedIsIn(playerPed, false)

			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = 'Appuyer sur E pour ranger le véhicule'
			CurrentActionData = { vehicle = vehicle }
		end
	end
end)

AddEventHandler('AbdelRMB_bennysjob:hasExitedMarker', function(zone)
	if zone == 'Craft' then
		TriggerServerEvent('AbdelRMB_bennysjob:stopCraft')
		TriggerServerEvent('AbdelRMB_bennysjob:stopCraft2')
		TriggerServerEvent('AbdelRMB_bennysjob:stopCraft3')
	elseif zone == 'Garage' then
		TriggerServerEvent('AbdelRMB_bennysjob:stopHarvest')
		TriggerServerEvent('AbdelRMB_bennysjob:stopHarvest2')
		TriggerServerEvent('AbdelRMB_bennysjob:stopHarvest3')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('AbdelRMB_bennysjob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bennys' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('press_remove_obj')
		CurrentActionData = { entity = entity }
	end
end)

AddEventHandler('AbdelRMB_bennysjob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.bennysActions.Pos.x, Config.Zones.bennysActions.Pos.y,
		Config.Zones.bennysActions.Pos.z)

	SetBlipSprite(blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Benny\'s')
	EndTextCommandSetBlipName(blip)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bennys' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k, v in pairs(Config.Zones) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y,
						v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'bennys' then
			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k, v in pairs(Config.Zones) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('AbdelRMB_bennysjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('AbdelRMB_bennysjob:hasExitedMarker', LastZone)
			end
		end
	end
end)

Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_toolchest_01'
	}

	while true do
		Citizen.Wait(500)

		local playerPed       = PlayerPedId()
		local coords          = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i = 1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('AbdelRMB_bennysjob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('AbdelRMB_bennysjob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)


local notificationShown = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			if not notificationShown then
				TriggerEvent('AbdelRMB:Notify', CurrentActionMsg, 'info', 2000)
				notificationShown = true
			end
			if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'bennys' then
				if CurrentAction == 'bennys_actions_menu' then
					OpenbennysActionsMenu()
				elseif CurrentAction == 'bennys_harvest_menu' then
					OpenbennysHarvestMenu()
				elseif CurrentAction == 'bennys_craft_menu' then
					OpenbennysCraftMenu()
				elseif CurrentAction == 'delete_vehicle' then
					if Config.EnableSocietyOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'bennys', vehicleProps)
					else
						local vehicle = CurrentActionData.vehicle
						if
							GetEntityModel(vehicle) == GetHashKey('flatbed') or
							GetEntityModel(vehicle) == GetHashKey('towtruck2') or
							GetEntityModel(vehicle) == GetHashKey('slamvan3')
						then
							TriggerServerEvent('esx_service:disableService', 'bennys')
						end
					end

					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					TriggerEvent('AbdelRMB:Notify', 'Véhicule supprimé', 'success', 3000)
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
					TriggerEvent('AbdelRMB:Notify', 'Entité supprimée', 'success', 3000)
				end

				CurrentAction = nil
			end
		end

		if IsControlJustReleased(0, 167) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'bennys' then
			OpenMobilebennysActionsMenu()
		end
	end
end)


AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)
