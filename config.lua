--		  █████╗ ██████╗ ██████╗ ███████╗██╗     ██████╗ ███╗   ███╗██████╗ 
--		 ██╔══██╗██╔══██╗██╔══██╗██╔════╝██║     ██╔══██╗████╗ ████║██╔══██╗
--		 ███████║██████╔╝██║  ██║█████╗  ██║     ██████╔╝██╔████╔██║██████╔╝
--		 ██╔══██║██╔══██╗██║  ██║██╔══╝  ██║     ██╔══██╗██║╚██╔╝██║██╔══██╗
--		 ██║  ██║██████╔╝██████╔╝███████╗███████╗██║  ██║██║ ╚═╝ ██║██████╔╝
--		 ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ 

Config                            = {}

Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.Vehicles = {
	'adder',
	'asea',
	'asterope',
	'banshee',
	'buffalo'
}

Config.Zones = {

	bennysActions = {
		Pos   = { x = -207.349457, y = -1341.481323, z = 34.00 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	Garage = {
		Pos   = { x = -223.331863, y = -1333.833008, z = 30.0 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	Craft = {
		Pos   = { x = -199.3, y = -1315.55, z = 30.0 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	VehicleSpawnPoint = {
		Pos   = { x = -180.82, y = -1301.84, z = 30.0 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = { x = -189.82, y = -1284.03, z = 30.0 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	}
}
