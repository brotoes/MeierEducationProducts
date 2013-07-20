//Making colors everyday...
black = make_color(0,0,0);
white = make_color(255,255,255);
// Background drawing of the health bar

x11 = 936;
x22 = 944;
y22 = 448;
y11 = y22 - ((1/10)*global.ExperienceForNextLevel);

draw_rectangle_color(x11,y11,x22,y22,black,black,black,black,0);
draw_rectangle_color(x11,y11,x22,y22,black,black,black,black,1);

// Foreground of the health bar (part that changes)
x1 = 936;
x2 = 944;
y2 = 448;
y1 = y2 - ((1/10)*global.Experience);



draw_rectangle_color(x1,y1,x2,y2,white,cyan,cyan,white,0);
draw_rectangle_color(x1,y1,x2,y2,black,black,black,black,1);

// Text explaining this is an experience bar, plus the little number describing how much experience you have:

string1 = string(global.Experience);
string2 = string(global.ExperienceForNextLevel);
draw_text_transformed(918,448,"Experience",1,1,90);
draw_text_transformed(950,448,string1 + "/" + string2,1,1,90);

