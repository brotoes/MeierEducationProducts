// Background drawing of the health bar
x11 = 384;
x22 = (x11+(global.DefaultMyHealth*10));
y11 = 16;
y22 = 0;
draw_rectangle_color(x11,y11,x22,y22, c_black, c_black, c_black, c_black,0);
draw_rectangle_color(x11,y11,x22,y22, c_black, c_black, c_black, c_black,1);

// Foreground of the health bar (part that changes)
x1 = 384;
x2 = (x1+(global.MyHealth*10))
y1 = 16;
y2 = 0;
draw_rectangle_color(x1,y1,x2,y2, c_white, c_teal, c_teal, c_white,0);
draw_rectangle_color(x1,y1,x2,y2, c_black, c_black, c_black, c_black,1);

// Text explaining what the health bar, plus the little number describing how much health you have:

string1 = string(global.MyHealth);
string2 = string(global.DefaultMyHealth);
draw_text(244,0,"My Health");
draw_text_transformed(384,18,string1 + "/" + string2,1,1,0);

