
// Background drawing of the health bar
black = make_color(0,0,0);
x11 = 384;
x22 = (x11+(global.DefaultEnemyHealth*10));
y11 = 48;
y22 = 32;
draw_rectangle_color(x11,y11,x22,y22,black,black,black,black,0);
draw_rectangle_color(x11,y11,x22,y22,black,black,black,black,1);

// Foreground of the health bar (part that changes)
x1 = 384;
x2 = (x1+(global.EnemyHealth*10))
y1 = 48;
y2 = 32;
red = make_color(255,26,26);
white = make_color(255,255,255);
draw_rectangle_color(x1,y1,x2,y2,black,red,red,black,0);
draw_rectangle_color(x1,y1,x2,y2,black,black,black,black,1);

// Text explaining what the health bar, plus the little number describing how much health you have:

string1 = string(global.EnemyHealth);
string2 = string(global.DefaultEnemyHealth);
draw_text(244,32,"Enemy Health");
draw_text_transformed(384,48,string1 + "/" + string2,1,1,0);

