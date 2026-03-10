shader_type canvas_item;

uniform vec4 picked_color : source_color = vec4(0.941, 0.298, 0.235, 1.0);

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    COLOR = tex * picked_color;
}