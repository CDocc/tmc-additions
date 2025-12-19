fx_version 'cerulean'
games { 'gta5' }

author 'TMC Community'
description 'Additional bits and bobs for TMC Framework created by TMC Community Developers'

shared_scripts {
    'config.lua',
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

dependencies {
    'core'
}

lua54 'yes'
