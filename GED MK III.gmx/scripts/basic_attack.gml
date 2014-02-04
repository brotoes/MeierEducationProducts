battle = instance_find(OBJ_battle_controller, 0)
persistent_variables = instance_find(OBJ_persistent_variables, 0)

strength = argument0
attacker = argument1
//TODO damage player with amount based on strength
battle.hp_current -= battle_round(strength * battle.player_dmg_mult)
attacker.flash = attacker.flash_time
attacker.flash_color = persistent_variables.element_colors[attacker.primary_element]
