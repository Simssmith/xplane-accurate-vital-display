require "graphics"
require "radio"
require "bit"

dataref("xp_psi", "sim/flightmodel/position/psi")
dataref("xp_elevation", "sim/flightmodel/position/elevation")
dataref("xp_indicated_airspeed", "sim/flightmodel/position/indicated_airspeed")
dataref("xp_vh_ind_fpm2", "sim/flightmodel/position/vh_ind_fpm2")




function print_HSA()
	-- first you have to set the color (defined by it's RGB values)
	glColor3f(1,1,1)
	
	-- then you can print
	draw_string_Times_Roman_24(300, 200, "HDG")
	ez_xp_psi = string.format("%2.0f",xp_psi);
	draw_string_Times_Roman_24(400, 200, ez_xp_psi)

	draw_string_Times_Roman_24(300, 250, "ALT")
	ez_xp_elevation = string.format("%5.0f",xp_elevation * 3.28084);
	draw_string_Times_Roman_24(400, 250, ez_xp_elevation)

	draw_string_Times_Roman_24(300, 300, "SPD")
	ez_xp_indicated_airspeed = string.format("%2.0f",xp_indicated_airspeed);
	draw_string_Times_Roman_24(400, 300, ez_xp_indicated_airspeed)
	
	draw_string_Times_Roman_24(300, 350, "VVI")
	ez_xp_vh_ind_fpm2 = string.format("%2.0f",xp_vh_ind_fpm2);
	if ez_xp_vh_ind_fpm2 == "-0" then
		ez_xp_vh_ind_fpm2 = "0";
	end
	draw_string_Times_Roman_24(400, 350, ez_xp_vh_ind_fpm2)
end

do_every_draw("print_HSA()")
