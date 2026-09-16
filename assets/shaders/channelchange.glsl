uniform vec2 u_pixelSize;
uniform vec2 u_UVs;
uniform vec2 texel;
uniform float strength;
uniform float scanx;
uniform Image perlin_tex;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords){
	float offset = (Texel(perlin_tex, vec2(u_UVs.x+scanx*u_pixelSize.x,u_UVs.y+texture_coords.y/texel.y*u_pixelSize.y)).x-0.5)*2.0;
	
	vec2 coords = vec2(mod(texture_coords.x - (offset * strength * texel.x),1.0),texture_coords.y);
    return color * Texel(texture, coords);
}