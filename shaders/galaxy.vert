#version 430
precision mediump float;

layout (location = 0) in vec4 a_position;
layout (location = 1) in vec4 a_speed;
layout (location = 2) in vec4 a_color;

out float v_brightness;
out vec4 v_color;

uniform mat4 u_mvp;

void main()
{
	v_brightness = length(vec3(a_speed));
	v_color = a_color;
	gl_Position = u_mvp * vec4(a_position.xyz, 1.);
}
