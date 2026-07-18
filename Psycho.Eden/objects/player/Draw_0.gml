draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

var _dy = camera_get_view_y(view_camera[0]);
#macro NEWLINE _dy += 20

draw_text(camera_get_view_x(view_camera[0]), _dy, Player_sm.state.name); NEWLINE;
draw_text(camera_get_view_x(view_camera[0]), _dy, {Vx: velocity_x}); NEWLINE;
draw_text(camera_get_view_x(view_camera[0]), _dy, {Vy: velocity_y}); NEWLINE;
draw_text(camera_get_view_x(view_camera[0]), _dy, {Vert: on_vertical}); NEWLINE;
draw_text(camera_get_view_x(view_camera[0]), _dy, {Hor: on_horizontal}); NEWLINE;
draw_text(camera_get_view_x(view_camera[0]), _dy, {Grounded: grounded}); NEWLINE;
draw_text(camera_get_view_x(view_camera[0]), _dy, {Bonk: bonk}); NEWLINE;
draw_text(camera_get_view_x(view_camera[0]), _dy, {Jump: jump_buffer}); NEWLINE;
draw_text(camera_get_view_x(view_camera[0]), _dy, {Dash: dash_buffer}); NEWLINE;
draw_text(camera_get_view_x(view_camera[0]), _dy, {Direction: face}); NEWLINE;