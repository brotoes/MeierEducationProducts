//script chooses what cards an enemy will play
//argument 0 is the id of the calling object

//at the moment, this is *really* rudimentary
caller = argument[0]
hand_listid = caller.hand_listid
cards_listid = ds_list_create()
first_card = ds_list_find_value(hand_listid, 0)
ds_list_add(cards_listid, first_card)
return cards_listid
