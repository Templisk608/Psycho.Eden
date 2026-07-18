//Update states at the beginning
Player_sm.Update();

//Run movement stuff
platformer_movement();

//Debug
show_debug_message(string(Player_sm.state.name));

//Run collision code
move_collide_state(velocity_x, velocity_y);