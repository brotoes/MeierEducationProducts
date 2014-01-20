used = argument0
avail = argument1

count = instance_number(OBJ_enemy_parent)

spacing = floor((avail - used) / max(count - 1, 1))

lpad = 0
if (count == 1 or count == 2) {
    lpad = floor(avail/(count + 2))
    spacing -= floor(lpad*2)
}

next_x = SCR_L_MARGIN + lpad
for (i = 0; i < count; i ++) {
    enemy = instance_find(OBJ_enemy_parent, i)
    enemy.x = next_x
    next_x += spacing + sprite_get_bbox_right(enemy.sprite_index) - sprite_get_bbox_left(enemy.sprite_index)
}
