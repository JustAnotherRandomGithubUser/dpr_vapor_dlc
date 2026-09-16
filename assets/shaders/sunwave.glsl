uniform vec2 texel;
uniform float timer;
uniform float frequency;
uniform float amp;

vec4 effect(vec4 drawcolor, Image texture, vec2 texture_coords, vec2 screen_coords)
{
	vec2 coord = texture_coords;
	coord.x = coord.x + (sin(timer/30.0 + coord.y/(texel.y*frequency)) * texel.x * 1.0) * amp;
    return drawcolor * Texel(texture, coord);
}