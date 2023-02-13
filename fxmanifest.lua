fx_version("cerulean")
game("gta5")
author("Ádám#2456")

shared_scripts({ "@es_extended/imports.lua", "config.lua" })
client_script("client.lua")
server_script("server.lua")

files({
	"ui/dist/**",
})

ui_page("ui/dist/index.html")
-- ui_page("http://localhost:3000")
