function requireAll()

    require('src/startup/resources')

    require('src/utilities/cam')
    require('src/utilities/shake')
    require('src/utilities/utils')
    --require('src/utilities/')
    --require('src/utilities/')

    require('src/player')
    require('src/update')
    require('src/draw')

    require('src/enemies/enemy')
    require('src/enemies/skeleton')
    --require('src/enemies/')

    require('src/worlds/loadMap')
    require('src/worlds/npc')

    require('src/ui/menu')
    require('src/ui/hud')
    require('src/ui/pause')
end