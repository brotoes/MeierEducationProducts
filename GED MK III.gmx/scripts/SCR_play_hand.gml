//This button plays the hand that the player has selected
deck = instance_find(OBJ_deck, 0)
battle_controller = instance_find(OBJ_battle_controller, 0)
persistent_variables = instance_find(OBJ_persistent_variables, 0)
//compile a list of all selected cards
selected_listid = ds_list_create()
for (i = 0; i < instance_number(OBJ_card_parent); i ++) {
    card = instance_find(OBJ_card_parent, i)
    if (card.selected) {
        ds_list_add(selected_listid, card.object_index)
        card.selected = false
        //TODO: remove selected cards from hand
    }    
}

ds_list_sort(selected_listid, true)
key0 = ds_list_find_value(selected_listid, 0)
key1 = ds_list_find_value(selected_listid, 1)
key2 = ds_list_find_value(selected_listid, 2)
key3 = ds_list_find_value(selected_listid, 3)
key4 = ds_list_find_value(selected_listid, 4)

to_play = OBJ_card_dud

if (array_isSet(persistent_variables.combos_arrayid,
    key0, key1, key2, key3, key4)) {
    to_play = array_get(persistent_variables.combos_arrayid,
        key0, key1, key2, key3, key4)
} else if (ds_list_size(selected_listid) == 1) {
    to_play = ds_list_find_value(selected_listid, 0)
}

//TODO: have this line check for the whole script
//TODO: or card damage type
if (battle_controller.target != OBJ_null) {
    //play card stored in to_play
    //TODO: figure out a better damage formula
    //TODO: attacks that damage multiple enemies should do so
    target = battle_controller.target
    to_play = instance_create(0, 0, to_play)
    target.hp_current -= to_play.strength
    
    //animate attack
    //Idea: choose a better location over the middle for the animation
    animation_x = target.x + sprite_get_width(target.sprite_index)/2
    animation_x -= sprite_get_width(to_play.animation_sprite)/2
    animation_y = target.y + sprite_get_height(target.sprite_index)/2
    animation_y -= sprite_get_width(to_play.animation_sprite)/2
    animation = instance_create(animation_x, animation_y, OBJ_animation)
    animation.animation_sprite = to_play.animation_sprite
    
    with (to_play) instance_destroy()
    
    //delete cards from room and hand and put them in the deck
    for (i = 0; i < ds_list_size(selected_listid); i ++) {
        to_destroy = ds_list_find_value(selected_listid, i)
        ds_list_add(deck.deck_listid, to_destroy)
        destroy_index = ds_list_find_index(deck.hand_listid, to_destroy)
        ds_list_delete(deck.hand_listid, destroy_index)
        instance_to_destroy = instance_find(to_destroy, 0)
        with (instance_to_destroy) instance_destroy()
    }
    //clean up and end turn
    ds_list_destroy(selected_listid)
    battle_controller.whose_turn ++
    //deck.ready_to_draw = true
}
