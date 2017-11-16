-- Author: Sims Smith https://www.youtube.com/channel/UCIdStqXIqKFNO__DAa_lj2g
-- Version 0.1
-- Date: 2017-11-15

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

do_on_mouse_click("toogle_display()")
do_every_draw("vital_refresh()")
