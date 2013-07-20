
// Background drawing of the health bar
black = make_color(0,0,0);
x11 = 384;
x22 = (x11+(global.DefaultMyHealth*10));
y11 = 16;
y22 = 0;
draw_rectangle_color(x11,y11,x22,y22,black,black,black,black,0);
draw_rectangle_color(x11,y11,x22,y22,black,black,black,black,1);

// Foreground of the health bar (part that changes)
x1 = 384;
x2 = (x1+(global.MyHealth*10))
y1 = 16;
y2 = 0;
cyan = make_color(31,124,230);
white = make_color(255,255,255);
draw_rectangle_color(x1,y1,x2,y2,white,cyan,cyan,white,0);
draw_rectangle_color(x1,y1,x2,y2,black,black,black,black,1);

// Text explaining what the health bar, plus the little number describing how much health you have:

string1 = string(global.MyHealth);
string2 = string(global.DefaultMyHealth);
draw_text(244,0,"My Health");
draw_text_transformed(384,18,string1 + "/" + string2,1,1,0);

