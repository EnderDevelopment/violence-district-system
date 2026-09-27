fx_version 'cerulean'
game 'gta5'

description 'Violence District System'
version '1.0.0'

esx_legacy 'yes'

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

shared_scripts {
    'config.lua'
}

files {
    'database.sql'
}