function platformer_movement(){
	
	//Always apply gravity
	velocity_y = min(velocity_y + C_GRAVITY, C_TERMINAL_VELOCITY);
	
	//Need to adjust buffers here since getting input is state-conditional
	if (dash_buffer > 0) {
		//Countdown
		dash_buffer--;
	}

	if (jump_buffer > 0) {
		//Countdown
		jump_buffer--;
	}
	
	//Horizontal movement
	if (inputs._x_axis != 0) {
		velocity_x = clamp(velocity_x + inputs._x_speed, -move_speed, move_speed);
	}
	
	else {
		velocity_x -= sign(velocity_x) * min(abs(velocity_x), C_MOVE_FRICTION);
	}
}