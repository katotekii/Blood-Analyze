
fx_version 'adamant'

game 'gta5'

ui_page 'html/form.html'

lua54 'yes'

shared_script '@es_extended/imports.lua'
shared_script 'config.lua'

files {
	'html/form.html',
	'html/img/logo.png',
	'html/img/report.jpg',
	'html/css.css',
	'html/script.js',
	'html/jquery-3.4.1.min.js',
}

client_scripts{
    'config.lua',
    'client/main.lua',
}

server_scripts{
    'config.lua',
    'server/main.lua',
}
