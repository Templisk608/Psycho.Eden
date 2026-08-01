function StateMachine () constructor{
//State variable to hold the current state we're in
    state = undefined
	
	//State struct to store all the states
	states = {}
	
	//Method to run the update function stored in the current state assigned to the state variable
	static Update = function() {
		//Check if state is an instance made by the state constructor, ensuring theres an update function
		if (is_instanceof(state, State)) {
			//Ensure the update function is actually a function and not undefined incase we didn't assign a function to it
			if (is_method(state.update)) {
				//If there is a parent state, run the parent logic first
				if (state.parent) {
					state.parent.update();
				}
				//Then run the child logic
				state.update();
			}
		}
	}
	
	//Method to add new states to the state struct, rather than directly setting states
	static addState = function(_state){
		//If we access the struct and the key doesn't already exist, accessor returns undefined
		//Ensure a state doesn't already exist in the struct
		if (!is_undefined(states[$ _state.name])) {
			//Debug message for now, but we can overwrite or exit the functionS
			show_debug_message($"You already have a {_state.name} state!");
		}
		
		//Add the state to the struct
		states[$ _state.name] = _state;
		
		//Check if there is a state already in the struct. If not, this must be the first/starting state
		if (is_undefined(state)){
			//Store state in state variable
			state = _state;
		}
		
		return self;
	}
	
	//Method to change between states
	static changeState = function(_name){
		//Check if state exists, if so, set current state to it
		if (!is_undefined(states[$ _name])){
			state = states[$ _name];
		}
		
		//If it doesn't exist, throw debug message
		else{
			show_debug_message("Tried changing to a non-existent state!");
		}
	}	
}

function State(_name, _parent = undefined) constructor {
    name = _name;
	parent = _parent;
	update = undefined;
	
	//Method to let us pass a function the state will run
	static setUpdate = function(_update_func){
		update = _update_func;
		return self;
	}
}