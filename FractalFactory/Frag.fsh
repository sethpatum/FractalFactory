
void main() {
    int iterations = 256;
    
    vec2 position = v_tex_coord; // gets the location of the current pixel in the intervals [0..1] [0..1]
    position.x -= xoff;
    position.y -= yoff;
    
    position.y = 1.0 - position.y;
    
    vec2 z =  position;
    
    float zoom = psca*scale;
    //if(zoom > 50000.0) {
     //   zoom = 50000.0;
    //}
    
    z *= 2.0/zoom;
    z -= vec2(1.5,1.0);
    
    float aspectRatio = (u_sprite_size.x) / (u_sprite_size.y);
    //z.x *= aspectRatio;
    
    vec2 c = z;
    
    float it = 0.0; // Keep track of what iteration we reached
    for (int i = 0;i < iterations; ++i) {
        // zn = zn-1 ^ 2 + c
        
        // (x + yi) ^ 2 = x ^ 2 - y ^ 2 + 2xyi
        z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y);
        z += c;
        
        if (dot(z,z) > 4.0) { // dot(z,z) == length(z) ^ 2 only faster to compute
            break;
        }
        
        it += 1.0;
    }
    
    vec3 color = vec3(0.0,0.0,0.0); // initialize color to black
    
    if (it < float(iterations)) {
        color.x = sin(float(it) / 3.0);
        color.y = cos(float(it) / 6.0);
        color.z = cos(float(it) / 12.0 + 3.14 / 4.0);
    }
    
    gl_FragColor = vec4(color,1.0);
}
