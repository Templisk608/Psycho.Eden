function platformer_movement(){
	
	//Take in input
	getInputs();
	
	//Always apply gravity
	velocity_y = min(velocity_y + C_GRAVITY, C_TERMINAL_VELOCITY);
	
	if (jump_buffer > 0) {
		//Countdown
		jump_buffer--;
	}
	
	//Horizontal movement
	if (dash_buffer > 0) {
		//Countdown
		dash_buffer--;
	}
	
	//State cases
	switch (string(Player_sm.state.name)) {
		
		case "dash":
			velocity_x = face * move_speed * 2;
			break;
			
		case "crouch":
			velocity_x = 0;
			break;
			
		default:
			if (inputs._x_axis != 0) {
			    velocity_x = clamp(velocity_x + inputs._x_speed, -move_speed, move_speed);
			}
	
			else {
			    velocity_x -= sign(velocity_x) * min(abs(velocity_x), C_MOVE_FRICTION);
			}
	}
}