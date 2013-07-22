xleft1 = 0;
xright1 = 128;
xleft2 = 160;
xright2 = 288;
xleft3 = 320;
xright3 = 448;
xleft4 = 480;
xright4 = 608;

ytop = 640;
ybottom = 768;

if(mouse_x>xleft1 && mouse_x<xright1 && mouse_y>ybottom && mouse_y<ytop) {

with CardMatrix[1] instance_destroy();

}

if(mouse_x>xleft2 && mouse_x<xright2 && mouse_y>ybottom && mouse_y<ytop) {

with CardMatrix[2] instance_destroy();

}

if(mouse_x>xleft3 && mouse_x<xright3 && mouse_y>ybottom && mouse_y<ytop) {

with CardMatrix[3] instance_destroy();

}

if(mouse_x>xleft4 && mouse_x<xright4 && mouse_y>ybottom && mouse_y<ytop) {

with CardMatrix[4] instance_destroy();

}
