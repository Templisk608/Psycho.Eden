//Toggle fullscreen
if keyboard_check_pressed(vk_f11) {window_set_fullscreen(!window_get_fullscreen())}

//Don't bother showing if theres no player instance
if !instance_exists(oPlayer) exit;

//Continuously center player on the screen
cam_x = oPlayer.x - cam_width/2;
cam_y = oPlayer.y - cam_height/2;

//Constrain camera to the room borders
cam_x = clamp(cam_x, 0, room_width - cam_width);
cam_y = clamp(cam_y, 0, room_height - cam_height);

//Smooth camera on player rather than hard snapping
actualcam_x += (cam_x - actualcam_x) * cam_speed;
actualcam_y += (cam_y - actualcam_y) * cam_speed;

//Follow player
camera_set_view_pos(view_camera[0], actualcam_x, actualcam_y);