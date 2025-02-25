client_script '@yarn/client.lua'
server_script '@yarn/server.lua'

--		  █████╗ ██████╗ ██████╗ ███████╗██╗     ██████╗ ███╗   ███╗██████╗ 
--		 ██╔══██╗██╔══██╗██╔══██╗██╔════╝██║     ██╔══██╗████╗ ████║██╔══██╗
--		 ███████║██████╔╝██║  ██║█████╗  ██║     ██████╔╝██╔████╔██║██████╔╝
--		 ██╔══██║██╔══██╗██║  ██║██╔══╝  ██║     ██╔══██╗██║╚██╔╝██║██╔══██╗
--		 ██║  ██║██████╔╝██████╔╝███████╗███████╗██║  ██║██║ ╚═╝ ██║██████╔╝
--		 ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═════╝ 

fx_version 'cerulean'
game 'gta5'

author 'AbdelRMB'
description 'ESX/OX Benny\'s Job'

version '1.1.0'

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
    'AbdelRMBUI'
}

server_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'server/main.lua'
}
