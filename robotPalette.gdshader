shader_type canvas_item;
render_mode blend_mix;

uniform float amount = 0;



void fragment() {
// Input:2
	vec4 n_out2p0 = COLOR;


	vec3 n_out3p0;
// ColorFunc:3
	{
		vec3 c = vec3(n_out2p0.xyz);
		vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
		vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
		vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
		float d = q.x - min(q.w, q.y);
		float e = 1.0e-10;
		n_out3p0 = vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
	}


// VectorDecompose:4
	float n_out4p0 = n_out3p0.x;
	float n_out4p1 = n_out3p0.y;
	float n_out4p2 = n_out3p0.z;


// FloatParameter:6
	float n_out6p0 = amount;


// FloatOp:9
	float n_in9p1 = 200.00000;
	float n_out9p0 = n_out6p0 / n_in9p1;


// FloatOp:5
	float n_out5p0 = n_out4p0 + n_out9p0;


// VectorCompose:7
	vec3 n_out7p0 = vec3(n_out5p0, n_out4p1, n_out4p2);


	vec3 n_out8p0;
// ColorFunc:8
	{
		vec3 c = n_out7p0;
		vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
		vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
		n_out8p0 = c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
	}


// Output:0
	COLOR.rgb = n_out8p0;


}
