void main() {
    
    vec2 position = v_tex_coord;

    vec3 color = vec3(position.x, position.y,0.50); // initialize color to black
    

    gl_FragColor = vec4(color,1.0);

}
