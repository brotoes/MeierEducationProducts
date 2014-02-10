battle = instance_find(obj_battle_con, 0)
strength = argument0
attacker = argument1
//TODO damage player with amount based on strength
battle.hp_current -= battle_round(strength * battle.player_dmg_mult)
attacker.flash = attacker.flash_time
attacker.flash_color = persvars.element_colors[attacker.primary_element]
