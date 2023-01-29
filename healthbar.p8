pico-8 cartridge // http://www.pico-8.com
version 39
__lua__

function _init()
    init_health()
end


function _update()
   update_health()
end

function _draw()
    cls()
    draw_health()
end