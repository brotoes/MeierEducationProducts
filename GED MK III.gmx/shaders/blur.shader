//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.	
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    //this will be our RGBA sum
    vec4 sum = vec4(0.0);
    
    //apply blurring, using a 9-tap filter with predefined gaussian weights
    
    sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - 4.0, v_vTexcoord.y - 4.0)) * 0.0162162162;
    sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - 3.0, v_vTexcoord.y - 3.0)) * 0.0540540541;
    sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - 2.0, v_vTexcoord.y - 2.0)) * 0.1216216216;
    sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x - 1.0, v_vTexcoord.y - 1.0)) * 0.1945945946;

    sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x, v_vTexcoord.y)) * 0.2270270270;

    sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + 1.0, v_vTexcoord.y + 1.0)) * 0.1945945946;
    sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + 2.0, v_vTexcoord.y + 2.0)) * 0.1216216216;
    sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + 3.0, v_vTexcoord.y + 3.0)) * 0.0540540541;
    sum += texture2D(gm_BaseTexture, vec2(v_vTexcoord.x + 4.0, v_vTexcoord.y + 4.0)) * 0.0162162162;

    //discard alpha for our simple demo, multiply by vertex color and return
    gl_FragColor = v_vColour * vec4(sum.rgb, 1.0);
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}

