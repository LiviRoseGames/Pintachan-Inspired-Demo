shader_type canvas_item;

uniform vec4 picked_color : source_color;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    vec3 complement = vec3(1.0) - picked_color.rgb;

    COLOR = vec4(tex.rgb * complement, tex.a);
}