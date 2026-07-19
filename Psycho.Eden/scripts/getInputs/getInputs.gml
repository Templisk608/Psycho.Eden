function getInputs(){
	var _x_axis = keyboard_check(ord("D")) - keyboard_check(ord("A")),
		_x_speed = _x_axis * move_acceleration,
		_jump_press = keyboard_check_pressed(vk_space),
		_jump_held = keyboard_check(vk_space),
		_down_held = keyboard_check(ord("S")),
		_dash_press = keyboard_check_pressed(vk_shift),
		_dir = 0;
	
	if _x_axis != 0 {
		_dir = _x_axis;
		face = _dir; //Last direction we faced
	}
	
	if jump_buffer <= 0 && _jump_press {
		jump_buffer = C_JUMP_BUFFER_FRAMES;
	}
	
	if dash_buffer <= 0 && _dash_press {
		dash_buffer = C_DASH_BUFFER_FRAMES;
	}
	
	inputs = {_x_axis, _x_speed, _jump_press, _jump_held, _down_held, _dash_press, _dir};
		
	return inputs;
}