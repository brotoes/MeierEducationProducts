//This button combines the cards the player has selected
//TODO: test for turn
//get hand list
deck = instance_find(OBJ_deck, 0)
persistent_variables = instance_find(OBJ_persistent_variables, 0)
battle_controller = instance_find(OBJ_battle_controller, 0)
hand_listid = deck.hand_listid
selected_listid = ds_list_create()
//walk through and add selected to a temporary list
for (i = 0; i < instance_number(OBJ_card_parent); i ++) {
    card = ds_list_find_value(hand_listid, i)
    if (card.selected) {
        ds_list_add(selected_listid, card)
        card.selected = false
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
    instance_create(0, 0, product)
    //delete precursor cards
    for (i = 0; i < ds_list_size(selected_listid); i ++) {
        precursor = ds_list_find_value(selected_listid, i)
        with (ds_list_find_value(selected_listid, i)) instance_destroy()
        precursor_index = ds_list_find_index(hand_listid, precursor)
        ds_list_delete(hand_listid, precursor_index)
    }
    //idea: should I delete cards event on unsuccessful combine?
}

//clean up and end turn
ds_list_destroy(selected_listid)
battle_controller.whose_turn ++
deck.ready_to_draw = true
