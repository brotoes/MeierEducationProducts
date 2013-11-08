bg = argument[0]

xscale = room_width/background_get_width(bg)
yscale = room_height/background_get_height(bg)

draw_background_ext(bg, 0, 0, xscale, yscale, 0, c_white, 1)
