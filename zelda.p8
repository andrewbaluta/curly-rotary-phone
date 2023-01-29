pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
--main
function _init() 
	player={
		x=63,
		y=63,
		fx=false,
		speed=1,
		sprite=0,
		face=3,
		attack=false,
		asprite=38,
		ax=0,
		ay=0
	}
	box={
		x=32,
		y=32,
		x2=111-32,
		y2=111-32
	}
	world={
		x=0,
		y=0,
		xmin=0,
		ymin=0,
		xmax=255,
		ymax=255
	}
	cam={
		x=0,
		y=0
	}
	init_ani()
end


function _update()
	ani_nerd()
	
	move_player()


	--player actions
	if btn(5) then
		player.attack=true
		ani_attack()
	else 
		player.attack=false 
	end
end

function _draw()
	cls()
	camera(cam.x,cam.y)
	map(world.x,world.y)
	camera(0,0)
	spr(player.sprite,player.x,player.y,2,2,player.fx)
	if player.attack==true then
		spr(player.asprite,player.ax,player.ay,2,2,player.fx)
	end
	print(mget(flr((player.x+8)/16),flr((player.y+8)/16)))
	rect(box.x,box.y,box.x2+16,box.y2+16,11)
end

-->8
--player

function move_player()
-- player movement
	if btn(⬅️) then
		player.x-=player.speed
		player.fx=false
		player.face=0
	end
	if btn(⬆️) then
		player.y-=player.speed
		player.fx=false
		player.face=2
	end
	if btn(⬇️) then
		player.y+=player.speed
		player.fx=false
		player.face=3
	end
	if btn(➡️) then
		player.x+=player.speed
		player.fx=true
		player.face=1
	end

-- player bounding
	if player.x<box.x and cam.x>world.xmin then
		player.x=box.x
		cam.x-=player.speed
	elseif player.x>box.x2 and cam.x<world.xmax then
		player.x=box.x2
		cam.x+=player.speed
	end
	if cam.x<world.xmin then
		cam.x=world.xmin
	elseif cam.x>world.xmax then 
		cam.x=world.xmax
	end

	if player.y<box.y and cam.y>world.ymin then
		player.y=box.y
		cam.y-=player.speed
	elseif player.y>box.y2 and cam.y<world.ymax then
		player.y=box.y2
		cam.y+=player.speed
	end
	if cam.y<world.ymin then
		cam.y=world.ymin
	elseif cam.y>world.ymax then 
		cam.y=world.ymax
	end
end

-->8
--animation

function init_ani()
	ani_speed=5
	timer=0
	ani_down={
		sprite=0,
		first=0,
		last=2
	}
	ani_up={
		sprite=8,
		first=8,
		last=10
	}
	ani_side={
		sprite=4,
		first=4,
		last=6
	}
end

function ani_nerd()
	if btn(3) then --down
		if timer<ani_speed then
			timer+=1
		else
			if ani_down.sprite<ani_down.last then
				ani_down.sprite+=2
			else 
				ani_down.sprite=ani_down.first
			end
			timer=0
		end
		player.sprite=ani_down.sprite
	elseif btn(2) then --up
		if timer<ani_speed then
			timer+=1
		else
			if ani_up.sprite<ani_up.last then
				ani_up.sprite+=2
			else 
				ani_up.sprite=ani_up.first
			end
			timer=0
		end
		player.sprite=ani_up.sprite
	elseif btn(0) or btn(1) then --sides
		if timer<ani_speed then
			timer+=1
		else
			if ani_side.sprite<ani_side.last then
				ani_side.sprite+=2
			else 
				ani_side.sprite=ani_side.first
			end
			timer=0
		end
		player.sprite=ani_side.sprite	
	else 
		timer=0
		if player.face==3 then --down
			player.sprite=0
		elseif player.face==2 then --up
			player.sprite=8
		elseif player.face==0 or player.face==1 then --sides
			player.sprite=4
		end
	end
end

function ani_attack()
	if player.face==0 then --left
		player.sprite=34
		player.asprite=40
		player.ax=player.x-16
		player.ay=player.y
	elseif player.face==2 then --up
		player.sprite=36
		player.asprite=42
		player.ax=player.x
		player.ay=player.y-16
	elseif player.face==3 then --down
		player.sprite=32
		player.asprite=38
		player.ax=player.x
		player.ay=player.y+16
	elseif player.face==1 then --right
		player.sprite=34
		player.asprite=40
		player.ax=player.x+16
		player.ay=player.y
	end
end

-->8
--health
function init_health()
	max=6
	current=6
end

function update_health()
	print(mget(flr((player.x+8)/16),flr((player.y+8)/16)))
end

function draw_health()
-- full heart 12
-- half heart 13
-- empty heart 14
-- multicolor hear 15


end

__gfx__
00000888888000000000088888800000000000888800000000000000000000000000088888800000000008888880000000000000000000000000000000000000
00008888888800000000888888880000000444488888000000000888800000000000888888880000000088888888000008808800088088000880880008808800
00f0844444480f0000f0844444480f000044444488f88800004444888880000000f0888888880f0000f0888888880f0088888880888800808008008088889980
00f0444444440f0000f0444444440f00000444444ff88880044444488f88800000f8888888888f0000f8888888888f0088888880888800808000008088889980
00ff4ffffff4ff0000ff4ffffff4ff00500ffff4fff8808000444444ff88880000f4888888884f0000f4888888884f0008888800088008000800080008899800
00ff4f4ff4f4ff0000ff4f4ff4f4ff005fff4ff4ff44800000ffff4fff88080000ff44888844ff0000ff44888844ff0000888000008080000080800000898000
000ffffffffff500000ffffffffff500500ffffff4440000fff4ff4ff4480000000f44488444f000000f44488444f00000080000000800000008000000080000
00088ff44ff8850000008ff44ff85500500ffff88880000050ffffff444000000005844444485000000584444448500000000000000000000000000000000000
055555ffff8855500055555fff888f005f5558888888500050ffff88880000000055888888855000000558888888550000000000000000000000000000000000
55f555588888f550055f555588888f005f55888fff8555005f55fff8855800000055888888855f0000f558888888550000000000000000000000000000000000
5fff55f5588fff5005fff55f558850005055888fff5555005f58fff5555500000005588888855f0000f558888885500000000000000000000000000000000000
55f555f85555fff0055f555f8555800050005888ff55550050588ff555558000000885555558ff0000ff85555558800000000000000000000000000000000000
55f555f558888f00055f555f55888000500005558855800050058885555880000008888888888000000888888888800000000000000000000000000000000000
555555f8888800000555555f88850000000008888888880050855558888855000005558888840000000058888855500000000000000000000000000000000000
0fffff500555000000fffff005550000000000055550000005588888888555000005555005500000000005500555500000000000000000000000000000000000
00005550000000000000000005550000000000555550000000555000005550000000550000000000000000000055000000000000000000000000000000000000
00055088888000000000000000000000000588888800000000000005550000000000000000000000000000000000000000000000000000000000000000000000
005f58888888000000000088880000000f0888888800000000000005550000000000000000000000000000000000000000000000000000000000000000000000
055f88444488800000044448888800000f5888888880000000000005550000000000000000000000000000000000000000000000000000000000000000000000
55ff8444444880f00044444488f880000ff888888880f00000000005550000000000000000000000000000000000000000000000000000000000000000000000
55ff4fffff448ff0000444444ff8800005f48888884ff00000000005550000000000000000000000000000500000000000000000000000000000000000000000
055f4f4ff4f48f00000ffff4fff8880005f44888444f000f00000005550000000000000000000000000005550000000000000000000000000000000000000000
00558ff44ffff0008fff4ff4ff44888005584484448f00f500000005550000000000000000000000000005550000000000000000000000000000000000000000
000588f44ff55000800ffffff44400800558844448555f5500000005550000000000000000000000000005550000000000000000000000000000000000000000
0000888fff5555008ffffff888880000005888888855f55500000005550000000000005555555555000005550000000000000000000000000000000000000000
00005888885555008ffff5555558800000588888885f555500000005550000000000055555555555000005550000000000000000000000000000000000000000
00008585555558008f8ff555555580000085888888f5555000000000500000000000005555555555000005550000000000000000000000000000000000000000
0000885585558800800085555555880005885555555f550000000000000000000000000000000000000005550000000000000000000000000000000000000000
000558855ff588508805588855588880558888888888f00000000000000000000000000000000000000005550000000000000000000000000000000000000000
00555088fff885550005555588888855555000088885500000000000000000000000000000000000000005550000000000000000000000000000000000000000
0000080ffff855550055888888888555000000000055550000000000000000000000000000000000000005550000000000000000000000000000000000000000
00000888888800000555500000005550000000000055550000000000000000000000000000000000000888888800000000000000000000000000000000000000
99999999999999999999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999999999999999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999999933335599999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999999333333559999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999993335333555999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999933333353555599000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999933533333355599000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999933333333355599000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999933335333335599000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999933333333355599000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999935333335355599000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999993333333355999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999999333335559999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999999933355599999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999999994449999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99999999999999999999999444999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
97979797000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76969969000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99dd9d99000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99955d67000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76d55999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
99dd9599000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
76969d67000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
97979979000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0101010101010101010101010000000001010101010101010101010100000000010101010101020202020202000000000101010111111212121212020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000001010101010101010000000000000000010101010101010100000000000000000101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4040404040424342436060606060606060404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404243525352534040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4042435253424342434040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4052534243525352534040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040405253424342434040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040525352534040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040424342434243404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040525352535253404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
