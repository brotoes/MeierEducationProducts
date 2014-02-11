used = argument0
avail = argument1
enemy_listid = argument2

count = instance_number(obj_enemy_par)

spacing = floor((avail - used) / max(count - 1, 1))

lpad = 0
if (count == 1 or count == 2) {
    lpad = floor(avail/(count + 2))
    spacing -= floor(lpad*2)
}

next_x = SCR_L_MARGIN + lpad

for (i = 0; i < ds_list_size(enemy_listid); i ++) {
    enemy = ds_list_find_value(enemy_listid, i)
    enemy.x = next_x
    next_x += spacing + sprite_get_bbox_right(enemy.sprite_index) - sprite_get_bbox_left(enemy.sprite_index)
    //if(spacing <= 0) {
        //enemy.stagger = true
        enemy.stagger_index = i
    //}
}
