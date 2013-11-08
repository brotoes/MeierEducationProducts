//destroy buttons
while (instance_number(OBJ_button) > 0) {
    with (instance_find(OBJ_button, 0)) instance_destroy()
}
//change menu to game menu
menu_controller = instance_find(OBJ_menu_controller, 0)
menu_controller.menu = MENU_GAME
