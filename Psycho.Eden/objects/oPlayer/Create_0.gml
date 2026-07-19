event_inherited();

velocity_x = 0;
velocity_y = 0;
jump_buffer = 0;
dash_buffer = 0;
hasDash = false;
hasJump = false;
grounded = false;
bonk = false;
face = 1;
getInputs();

//Create a state machine and define states below
Player_sm = new StateMachine();

#region //Grounded states
groundedState = new State("grounded")
	.setUpdate(function() {
		
		//Reset jump and dash
		hasDash = true;
		hasJump = true;
		
		//Set y to terminal velocity for consistent fall_spd
		//velocity_y = 1;
		
		//**************Need to clean this up***********************/
		//If jump is pressed on drop-down plat, drop down
		if inputs._down_held && inputs._jump_held {
			
			hasJump = false;
			y += C_COLLISION_ONE_WAY_MOVE;
			//Setting yprev is how we phase through the platform
			yprevious += C_COLLISION_ONE_WAY_MOVE;
			
			//Ensure y velocity is non-zero and positive
			velocity_y = max(C_COLLISION_ONE_WAY_BUFFER, velocity_y);
		}
		//**********************************************************/
		
		//Set dash state transition
		if (inputs._dash_press && hasDash) {
			Player_sm.changeState("dash");
		}
		
		//Set fall state transition 
		if (!grounded) {
			Player_sm.changeState("fall");
		}
		
		//Set jump state transition
		if (inputs._jump_press && hasJump) {
			Player_sm.changeState("jump");
		}
	});
 
idleState = new State("idle", groundedState)
	.setUpdate(function() {
		
		//Reset jump buffer on enter (from "fall")
		jump_buffer = 0;
		
		//Set walk state transition
		if inputs._x_axis != 0 {
			Player_sm.changeState("walk");
		}
		
		//Set crouch state transition
		if inputs._down_held {
			Player_sm.changeState("crouch");
		}
	
	});

walkState = new State("walk", groundedState)
	.setUpdate(function() {
		
		//Set idle state transition
		if inputs._x_axis == 0 {
			Player_sm.changeState("idle");
		}
		
		//Set crouch state transition
		if inputs._down_held {
			Player_sm.changeState("crouch");
		}
		
	});
	
crouchState = new State("crouch", groundedState)
	.setUpdate(function () {
		
		//Kills horizontal movement
		
		//Set idle state transition 
		if !inputs._down_held {
			Player_sm.changeState("idle");
		}
	});
#endregion

#region //Airborne states
airborneState = new State("airborne")
	.setUpdate(function() {
		
		hasJump = false;
		
		//Slow down horizontal speed a tiny bit to feel floatier
		velocity_x *= move_air_control;
		
		//Set dash state transition
		if (inputs._dash_press && hasDash) {
			Player_sm.changeState("dash");
		}
		
		//Set idle state transition
		if (grounded) {
			Player_sm.changeState("idle");
		}
		
		if (on_horizontal != 0) {
			Player_sm.changeState("wallCling");
		}
	});
	
jumpState = new State("jump", airborneState)
	.setUpdate(function() {

		//While in jump
		if (jump_buffer > 0) {
			velocity_y = -jump_strength;
			on_vertical = 0; //grounded wouldn't update in time, would keep us glued and cause state stutter
		}
		
		//Exit jump
		if (jump_buffer <= 0) || bonk || (!inputs._jump_held) {
			velocity_y *= C_VARIABLE_JUMP_FRICTION;
			Player_sm.changeState("fall");				
		}
	
	});
	
fallState = new State("fall", airborneState)
	.setUpdate(function() {
		//
	});

clingState = new State("wallCling", airborneState)
	.setUpdate(function() {
	
		hasDash = true;
		
		if inputs._jump_press {
			// Wall jump
			var _jump_angle = 90 + sign(on_horizontal) * jump_wall_angle;
			velocity_x = lengthdir_x(jump_wall_strength, _jump_angle);
			velocity_y = lengthdir_y(jump_wall_strength, _jump_angle);
			on_horizontal = 0;
		}
		
		if bonk {
			velocity_y *= C_VARIABLE_JUMP_FRICTION;
		}
				
		else if (velocity_y > 0) { // Sliding down a wall reduces velocity
			velocity_y = min(velocity_y, C_TERMINAL_VELOCITY * C_ON_WALL_FRICTION);
		}
		
		if (on_horizontal == 0) {
			Player_sm.changeState("fall");
		}
		
		if (grounded) {
			Player_sm.changeState("idle");
		}
		
	});

#endregion

#region //Dash State
dashState = new State("dash")
	.setUpdate(function () {
		
		//Countdown
		hasJump = false;
		hasDash = false;
		
		if dash_buffer > 0 {
			velocity_y = -0.6; //Gravity being applied will cancel this out to 0, weird ik
		}
		
		//Exit dash
		if dash_buffer <= 0 {
			
			if grounded {
				Player_sm.changeState("idle");
			}
			
			else {
				Player_sm.changeState("fall");
			}
		}
	});
#endregion

//Attack to be in a concurrent machine for ease

Player_sm.addState(groundedState).addState(idleState).addState(walkState).addState(crouchState);
Player_sm.addState(airborneState).addState(jumpState).addState(fallState).addState(clingState);
Player_sm.addState(dashState);

//Start in idle to avoid buggy behavior
Player_sm.changeState("idle");