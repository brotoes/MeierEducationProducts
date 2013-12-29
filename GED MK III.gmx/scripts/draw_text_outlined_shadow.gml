var c;
c = draw_get_color();
//draw the shadow
draw_set_color(c_black)
draw_set_alpha(0.5)
draw_text(argument0 + 3, argument1 + 3, argument2)
draw_set_alpha(1)

//draw the outline
draw_set_color(argument4);
draw_text(argument0-1,argument1-1,argument2);
draw_text(argument0+1,argument1-1,argument2);
draw_text(argument0+1,argument1+1,argument2);
draw_text(argument0-1,argument1+1,argument2);
//draw the inside
draw_set_color(argument3);
draw_text(argument0,argument1,argument2);
//reset the drawing color (so there are no side-effects)
draw_set_color(c);
