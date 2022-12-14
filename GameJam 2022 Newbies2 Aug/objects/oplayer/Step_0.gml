
//PLAYER INPUT
key_left = keyboard_check(vk_left)||keyboard_check(ord("A")) * sign(oC_LEFT.tempCount)
//produces 1 or 0 if pressing left or not
key_right = keyboard_check (vk_right)||keyboard_check(ord("D")) * sign(oC_RIGHT.tempCount)
//vis a vis key_left
key_jump = keyboard_check_pressed(vk_up)||keyboard_check_pressed(ord("W")) * sign(oC_UP.count);
//checks if pressed, not holding
key_down = keyboard_check(vk_down)||keyboard_check(ord("S")) * sign(oC_DOWN.tempCount);

grounded =	place_meeting(x, y + 1, oBarrier)


//CALCULATE MOVEMENT
var move = key_right - key_left;
//produces 1 if right, -1 if left
hsp = move * walksp;
//produces 1, 0, -1 multiplied by constant 
vsp = vsp + grv;
//y-position changes according to gravity
if (place_meeting(x, y + 1, oBarrier)) && (key_jump)
{
	 if oC_UP.count > 0{ 
	   oC_UP.count -= 1
	   }
	vsp -= jump_vel;
	audio_play_sound(sfx_Jump,9,false)
}
//if player is touching barrier and key_jump is true, increase vsp to 5

//HORIZONTAL COLLISION
if (place_meeting (x + hsp, y, oBarrier))
{
	while (!place_meeting(x + 2*sign(hsp), y, oBarrier))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
}
//if object is approaching a barrier, before the object reaches the barrier, decrease the distance b/w
//the barrier and object by one pixel. upon reaching barrier, stop horizontal movement
x = x + hsp;
//changes x-position as hsp is added

//VERTICAL COLLISION
if (place_meeting (x, y + vsp, oBarrier))
{
	while (!place_meeting(x, y + 2*sign(vsp), oBarrier))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
}
//if object is approaching a barrier, before the object reaches the barrier, decrease the distance b/w
//the barrier and object by one pixel. upon reaching barrier, stop vertical movement
y = y + vsp;
//changes y-position as vsp is added

//ANIMATION
if (!place_meeting (x, y + 1, oBarrier))
{
	sprite_index = player_Jump2;
	if (sign(vsp) > 0) 
	{
		sprite_index = player_Fall; 
		image_speed = 0;
	}
}
//if sprite is contacting oBarrier, jump anim plays, image speed multiplies fps by 1
else
{
	image_speed = 1;
	if (hsp == 0)
	{
		sprite_index = player_Idle;
		mask_index = player_Idle;
		
	}
	else
	{
		sprite_index = player_Run;
	}
}
//elif hsp is 0 play idle anim, if not, play run anim
if (key_down)
{
	sprite_index = player_Duck;
	mask_index = player_Duck;
}


if (hsp != 0) image_xscale = sign(hsp);
//returns x-sizing according to hsp
