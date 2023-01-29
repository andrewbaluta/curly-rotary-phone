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
-->8
function init_health()
	health=100
end

function update_health()
	health-=.1
	barw=36*health/100
end

function draw_health()
	rect(44,60,84,68,6)
	rectfill(46,62,46+barw,66,10)
	print(health)
end
