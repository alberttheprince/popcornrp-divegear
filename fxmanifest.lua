fx_version 'cerulean'
game 'gta5'

description 'items to help players breathe and move underwater'
repository 'https://github.com/alberttheprince/popcornrp-divegear'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua',
}

server_script 'server/main.lua'

client_script 'client/main.lua'


lua54 'yes'
use_experimental_fxv2_oal 'yes'