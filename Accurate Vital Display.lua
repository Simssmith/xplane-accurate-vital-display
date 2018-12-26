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

function AVD_Toggle()
	if show_AVD == true then
		show_AVD = false
	else
		show_AVD = true
	end
end

function print_Vital()
	-- color (defined by it's RGB values)
	glColor3f(1,1,1)
	draw_string_Times_Roman_24(left_x, label_y + (label_y_inc * 4), "HDG")
	ez_xp_psi = string.format("%03.0f",xp_psi);
	draw_string_Times_Roman_24(left_x + vital_inc, label_y + (label_y_inc * 4), ez_xp_psi)

	draw_string_Times_Roman_24(left_x, label_y + (label_y_inc * 2), "ALT")
	ez_xp_elevation = string.format("%05.0f",xp_elevation * 3.28084)
	draw_string_Times_Roman_24(left_x + vital_inc, label_y + (label_y_inc * 2), ez_xp_elevation)

	draw_string_Times_Roman_24(left_x, label_y + (label_y_inc * 3), "SPD")
	ez_xp_indicated_airspeed = string.format("%03.0f",xp_indicated_airspeed);
	draw_string_Times_Roman_24(left_x + vital_inc, label_y + (label_y_inc * 3), ez_xp_indicated_airspeed)
	
	draw_string_Times_Roman_24(left_x, label_y + (label_y_inc * 1), "VVI")
	ez_xp_vh_ind_fpm2 = string.format("%03.0f",xp_vh_ind_fpm2);
	if ez_xp_vh_ind_fpm2 == "-0" then
		ez_xp_vh_ind_fpm2 = "0";
	end
	draw_string_Times_Roman_24(left_x + vital_inc, label_y + (label_y_inc * 1), ez_xp_vh_ind_fpm2)

end

function avd_on_draw(avd_wnd, avd_x, avd_y)
	-- color (defined by it's RGB values)
	glColor3f(1,1,1)
	draw_string_Times_Roman_24(avd_x, avd_y + (label_y_inc * 4), "HDG")
	ez_xp_psi = string.format("%03.0f",xp_psi);
	draw_string_Times_Roman_24(avd_x + vital_inc, avd_y + (label_y_inc * 4), ez_xp_psi)

	draw_string_Times_Roman_24(avd_x, avd_y + (label_y_inc * 2), "ALT")
	ez_xp_elevation = string.format("%05.0f",xp_elevation * 3.28084)
	draw_string_Times_Roman_24(avd_x + vital_inc, avd_y + (label_y_inc * 2), ez_xp_elevation)

	draw_string_Times_Roman_24(avd_x, avd_y + (label_y_inc * 3), "SPD")
	ez_xp_indicated_airspeed = string.format("%03.0f",xp_indicated_airspeed);
	draw_string_Times_Roman_24(avd_x + vital_inc, avd_y + (label_y_inc * 3), ez_xp_indicated_airspeed)
	
	draw_string_Times_Roman_24(avd_x, avd_y + (label_y_inc * 1), "VVI")
	ez_xp_vh_ind_fpm2 = string.format("%03.0f",xp_vh_ind_fpm2);
	if ez_xp_vh_ind_fpm2 == "-0" then
		ez_xp_vh_ind_fpm2 = "0";
	end
	draw_string_Times_Roman_24(avd_x + vital_inc, avd_y + (label_y_inc * 1), ez_xp_vh_ind_fpm2)

        graphics.set_color(1, 1, 1, 1)
	graphics.set_width(2)

	graphics.draw_line(avd_x, avd_y, avd_x + x_inc, avd_y)
	graphics.draw_line(avd_x, avd_y + y_inc, avd_x + x_inc, avd_y + y_inc)

	graphics.draw_line(avd_x, avd_y, avd_x, avd_y + y_inc)
	graphics.draw_line(avd_x + x_inc, avd_y, avd_x + x_inc, avd_y + y_inc)

        -- Trying to get the toggle button to work but not yet.
        if (avd_lastClickX > avd_x and avd_lastClickX < avd_x + x_inc) then
		if (avd_lastClickY > avd_y and avd_lastClickY < avd_y + y_inc) then
			AVD_Toggle()
		end
	end

	if (show_AVD == true) then
		glColor3f(1,1,1)
		draw_string_Times_Roman_24(avd_x + 5, avd_y + 4, "HIDE")
		glColor3f(0,0,0)
		draw_string_Times_Roman_24(avd_x + 7, avd_y + 6, "HIDE")
	else	
		glColor3f(0,0,0)
		draw_string_Times_Roman_24(avd_x + 1, avd_y + 2, "SHOW")
		glColor3f(255,128,0)
		draw_string_Times_Roman_24(avd_x + 3, avd_y + 4, "SHOW")
	end
end

function display_action_button()
	graphics.set_color(1, 1, 1, 1)
	graphics.set_width(2)

	graphics.draw_line(left_x, top_y, left_x + x_inc, top_y)
	graphics.draw_line(left_x, top_y + y_inc, left_x + x_inc, top_y + y_inc)

	graphics.draw_line(left_x, top_y, left_x, top_y + y_inc)
	graphics.draw_line(left_x + x_inc, top_y, left_x + x_inc, top_y + y_inc)

	if (show_AVD == true) then
		glColor3f(1,1,1)
		draw_string_Times_Roman_24(left_x+5, label_y, "HIDE")
		glColor3f(0,0,0)
		draw_string_Times_Roman_24(left_x+7, label_y + 2, "HIDE")
	else	
		glColor3f(0,0,0)
		draw_string_Times_Roman_24(left_x+1, label_y - 2, "SHOW")
		glColor3f(255,128,0)
		draw_string_Times_Roman_24(left_x+3, label_y, "SHOW")
	end
end

function toogle_display()
	--Mouse is over "Show/Hide" Text
	if (MOUSE_X > left_x and MOUSE_X < left_x + x_inc) then
		if (MOUSE_Y > top_y and MOUSE_Y < top_y + y_inc) then
			AVD_Toggle()
		end
	end
end

function vital_refresh()
	if show_AVD == true then
		print_Vital()
	else
		--do nothing empty screen
	end

	display_action_button()
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
avd_wnd = float_wnd_create(200, 240, 1)
float_wnd_set_title(avd_wnd, "Accurate Vital Display")
float_wnd_set_ondraw(avd_wnd, "avd_on_draw")
float_wnd_set_onclick(avd_wnd, "avd_on_click")
float_wnd_set_onclose(avd_wnd, "avd_on_close")

do_on_mouse_click("toogle_display()")
do_every_draw("vital_refresh()")


