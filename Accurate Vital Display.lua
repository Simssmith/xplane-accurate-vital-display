-- Author: Sims Smith https://www.youtube.com/channel/UCIdStqXIqKFNO__DAa_lj2g
-- Version 0.1
-- Date: 2017-11-15
-- Source repo https://github.com/Simssmith/xplane-accurate-vital-display

-- This script is provided under friendly MIT License Copyright 2017 Sims Smith
-- Read MIT License https://opensource.org/licenses/MIT

-- Work in Progress.  Click on "HIDE" or "SHOW" to change the state
-- Working on scalable version and support reposition.

require "graphics"
--require "bit"

dataref("xp_psi", "sim/flightmodel/position/psi")
dataref("xp_elevation", "sim/flightmodel/position/elevation")
dataref("xp_indicated_airspeed", "sim/flightmodel/position/indicated_airspeed")
dataref("xp_vh_ind_fpm2", "sim/flightmodel/position/vh_ind_fpm2")
dataref("xp_fps", "sim/operation/misc/frame_rate_period")

avd_lastClickX = 640 / 2
avd_lastClickY = 480 / 2

local show_AVD 	= true
local left_x 	= 300
local x_inc 	= 75
local top_y 	= 145
local y_inc 	= 25

local label_y   = 150
local label_y_inc = 50
local vital_inc = 100

local fps_refresh_internval = 3
local fps_display = 0
local fps_sum = 0
local fps_iter = 0

function avd_on_draw(avd_wnd, avd_x, avd_y)
	-- color (defined by it's RGB values)
	glColor3f(1,1,1)
    fps_sum = fps_sum + string.format("%03.0f",1 / xp_fps)
	fps_iter = fps_iter +  1
	
	--Only refresh every nth  sec
    current_mod = os.time() % fps_refresh_internval
	if current_mod == 0 and do_display == 1 then
	    fps_display = fps_sum / fps_iter	
		fps_display = string.format("%03.0f",fps_display)
		fps_sum = 0
		fps_iter = 0
		do_display = 0
    end
	
	if current_mod ~= 0 then 
		do_display = 1
	end
	draw_string_Times_Roman_24(avd_x, avd_y + (label_y_inc * .25), "FPS")
	draw_string_Times_Roman_24(avd_x + vital_inc, avd_y + (label_y_inc * .25), fps_display)

	draw_string_Times_Roman_24(avd_x, avd_y + (label_y_inc * 4), "HDG")
	ez_xp_psi = string.format("%03.0f",xp_psi);
	draw_string_Times_Roman_24(avd_x + vital_inc, avd_y + (label_y_inc * 4), ez_xp_psi)

	draw_string_Times_Roman_24(avd_x, avd_y + (label_y_inc * 2), "ALT")
	ez_xp_elevation = string.format("%05.0f",xp_elevation * 3.28084)
	draw_string_Times_Roman_24(avd_x + vital_inc, avd_y + (label_y_inc * 2), ez_xp_elevation)

	draw_string_Times_Roman_24(avd_x, avd_y + (label_y_inc * 3), "SPD")
	ez_xp_indicated_airspeed = string.format("%03.0f",xp_indicated_airspeed);
	if (ez_xp_indicated_airspeed == "-00") then
		ez_xp_indicated_airspeed = "0";
	end
	draw_string_Times_Roman_24(avd_x + vital_inc, avd_y + (label_y_inc * 3), ez_xp_indicated_airspeed)
	
	draw_string_Times_Roman_24(avd_x, avd_y + (label_y_inc * 1), "VVI")
	ez_xp_vh_ind_fpm2 = string.format("%03.0f",xp_vh_ind_fpm2);
	--quick hack to keep VVI 0 when parked.;
	if ez_xp_vh_ind_fpm2 == "-0" or ez_xp_vh_ind_fpm2 == "-00" or ez_xp_vh_ind_fpm2 == "000" then
		ez_xp_vh_ind_fpm2 = "0";
	end
	draw_string_Times_Roman_24(avd_x + vital_inc, avd_y + (label_y_inc * 1), ez_xp_vh_ind_fpm2)

end

-- x and y are relative from the origin of the window, i.e. the lower left
function avd_on_click(avd_wnd, avd_x, avd_y)
    avd_lastClickX = avd_x
    avd_lastClickY = avd_y
end

-- When on_close it called, it is illegal to do anything with the wnd variable
-- It is also not allowed to create new windows in on_close!
function avd_on_close(avd_wnd)
end

-- width, height, decoration style as per XPLMCreateWindowEx. 1 for solid background, 3 for transparent
avd_wnd = float_wnd_create(180, 240, 1, false)
float_wnd_set_title(avd_wnd, "AVD")
float_wnd_set_ondraw(avd_wnd, "avd_on_draw")
float_wnd_set_onclick(avd_wnd, "avd_on_click")
float_wnd_set_onclose(avd_wnd, "avd_on_close")

--do_every_draw("vital_refresh()")
