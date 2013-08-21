//This button combines the cards the player has selected

//get hand list
deck = instance_find(OBJ_deck, 0)
persistent_variables = instance_find(OBJ_persistent_variables, 0)
battle_controller = instance_find(OBJ_battle_controller, 0)
hand_listid = deck.hand_listid
selected_listid = ds_list_create()
//walk through and add selected to a temporary list
for (i = 0; i < ds_list_size(hand_listid); i ++) {
    card = ds_list_find_value(hand_listid, i)
    if (card.selected) {
        ds_list_add(selected_listid, card)
    }
}
//use list as key for combos array
ds_list_sort(selected_listid, true)
key0 = ds_list_find_value(selected_listid, 0)
key1 = ds_list_find_value(selected_listid, 1)
key2 = ds_list_find_value(selected_listid, 2)
key3 = ds_list_find_value(selected_listid, 3)
key4 = ds_list_find_value(selected_listid, 4)
//add the card created to hand if it exists, otherwise, do nothing
if (array_isSet(persistent_variables.combos_arrayid, key0, key1, key2, key3, key4)) {
    product = array_get(persistent_variables.combos_arrayid, key0, key1, key2, key3, key4)
    ds_list_add(hand_listid, product)
    leftmost_selection = ds_list_find_value(selected_listid, 0)
    instance_create(leftmost_selection.x, leftmost_selection.y + 50, product)
    //delete product cards
    for (i = 0; i < ds_list_size(selected_listid); i ++) {
        with (ds_list_find_value(selected_listid, i)) instance_destroy()
    }
    //NOTE: should I delete cards event on unsuccessful combine?
    //move cards over to fill space
}

//clean up and end turn
ds_list_destroy(selected_listid)
battle_controller.whose_turn ++
battle_controller.turn_available = true