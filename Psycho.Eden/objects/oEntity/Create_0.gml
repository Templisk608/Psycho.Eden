//Store collision instances
collision_list = ds_list_create();

//These act as counters and indicate collision direction
on_vertical   = 0;
on_horizontal = 0;

//Bind to entityCollision function
move_collide_state = method(id, move_collide_state);