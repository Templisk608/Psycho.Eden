//Update states
Player_sm.Update();

//Run movement stuff
platformer_movement();

//Run collision code
move_collide_state(velocity_x, velocity_y);