if (global.EnemyHealth < 1) {
            show_message("You won! # +1000 Experience # +10 Gold");
            global.Experience += 1000;
            global.Gold += 10;
            if (global.Experience == global.ExperienceForNextLevel) {
            
                global.ExperienceForNextLevel = (global.ExperienceForNextLevel * 4);
                global.MyLevel +=1;
                room_goto(Level_Up_Room);
                }
            SCR_ResetToBattle();
            exit;
}
if (global.TurnNumber % 2 !=0) {
instance_create(0,0,OBJ_EnemyAttack2);
}

if (global.MyHealth < 1) {
    show_message("You lost!")
    SCR_ResetToBattle();
}


