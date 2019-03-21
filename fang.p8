pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
--project caleb: aka-fang
-- global section

 cls()

 px=60
 py=60

 bx=50
 by=50

 lft_edge=8
 rit_edge=112
 top_edge=8
 bot_edge=112

 edge_flag = false

 bulletone = {
   x = 32,
   y = 32,
   direc = "lt",
   -- lt rt up dn
   active = false,
   spd = 1,
   draw = function(self)
     circfill(self.x, self.y,1,10)
     --rectfill(self.x, self.y, (self.x)+3,(self.y)+3,9)
   end
 }

 baddy = {
   x = 50,
   y = 50,
   hit = false,
   play_death_sound = true
 }

 p = {
   dir = "lt"
 }

function isoverlap(ax,ay,bx,by,asiz,bsiz)
    
  if( (ax >= (bx-asiz)) and (ax <= (bx+bsiz)) and (ay >= (by-asiz)) and (ay <= (by+bsiz)) ) then
    return true
  else
    return false
  end
  
end

function update_baddy()

  if(isoverlap(bulletone["x"],bulletone["y"],baddy["x"],baddy["y"],3,8) ) then
    baddy["hit"] = true
  else
    baddy["hit"] = false
  end

  if(baddy["hit"]==true) then
    sfx(7)
  end

end

function _update()

 process_edge()

 process_movement()

 process_weapon_fire()

 update_bulletone(bulletone["direc"])

 update_baddy()
 
end

function _draw()
 cls() 
 spr(001,px,py)
 spr(003,bx,by)

 map(0,0,0,0,16,16)
 
 draw_bullets()

 printdebug()
end

function printdebug()
 --print("bullet active:",10,90)
 --print(bulletone["active"],70,90)
 
 --print ("overlap status:",10,90)
 --print (isoverlap(dbx-1,dby-1,bx,by,3,8),70,90)
 
 print ("hit baddy:",10,90)
 print (baddy["hit"],70,90)
end

function draw_bullets()

 if(bulletone["active"] ==true) then
   bulletone:draw()
 end

end

function update_bulletone(d)

  if(bulletone["active"] == true) then
    
    if(d == "lt") then
      bulletone["x"] = bulletone["x"] - bulletone["spd"]
    end

    if(d == "rt") then
      bulletone["x"] = bulletone["x"] + bulletone["spd"]
    end

    if(d == "up") then
      bulletone["y"] = bulletone["y"] - bulletone["spd"]
    end

    if(d == "dn") then
      bulletone["y"] = bulletone["y"] + bulletone["spd"]
    end
      
  end

end

function fire_bulletone(direc)

  sfx(6)

  bulletone["active"] = true
  bulletone["x"] = px
  bulletone["y"] = py
  bulletone["direc"] = direc

end

function process_movement()

 if( btn(0) ) then
  px = px-1
  p["dir"] = "lt"
 end
 
 if( btn(1) ) then
  px = px+1
  p["dir"] = "rt"
 end
 
 if( btn(2) ) then
  py = py-1
  p["dir"] = "up"
 end
 
 if( btn(3) ) then
  py = py+1
  p["dir"] = "dn"
 end

end

function process_weapon_fire()
  if(btnp(4)) then
    if(p["dir"] == "lt") fire_bulletone("lt")
    if(p["dir"] == "rt") fire_bulletone("rt")
    if(p["dir"] == "up") fire_bulletone("up")
    if(p["dir"] == "dn") fire_bulletone("dn")
  end
end

function process_edge()
 if(not btn(1) ) then
   edge_flag=false 
 end
 
 if(px == rit_edge) then
   px = px-1
   if(edge_flag == false) then
     sfx(5)
     edge_flag=true
   end
 end

 
 if(px == lft_edge) then
   px = px+1
   sfx(5)
 end
 
 if(py == bot_edge) then
   py = py-1
   sfx(5)
 end
 
 if(py == top_edge) then
   py = py+1
   sfx(5)
 end
end



__gfx__
00000000550ccc0067777777ffe888ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000005cc0c00d6666667fee8822f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700066666c0d0766077ee818122000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000660000ccd0066007ee888822000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770006606c88cd666666788999822000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000600800cd662266788a98822000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000668101d6682667f888822f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000006111ddddddd6ff8882ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
02cececececececececececececece0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0202020202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
001000001505015150182501835018450185501865018750180501815018250183501845018550186501875018050181501825018350184501855018650187501805018150182501835018450185501865018750
011000001805018150182501835018450185501865018750180501815018250183501845018550186501875018050181501825018350184501855018650187501805018150182501835018450185501865018750
001000000c7550c7550c7550c7550f7550f7550f7550f755117551175511755117550f7550f7550f7550f7550c7550c7550c7550c7550f7550f7550f7550f755117551175511755117550f7550f7550f7550f755
001000001605518075180751807518075160751607516075160751307513075130751307511075110751107511075130751307513075130751307513075130751307513075130751307513075160751607516075
001000001807518075240752407522075220751d0751f0751807518075240752407522075220751d0751f0751807518075240752407522075220751d0751f0751807518075240752407522075220751d0751f075
00010000171501c150231503215000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
000100003a05036050110500305000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400001d6501e6501e6501e6501e6501e6501d6501c6501c6501c6501c6401b6301a6201a610000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 41024344
00 01024344
00 01020344
00 01020344
03 01020304

