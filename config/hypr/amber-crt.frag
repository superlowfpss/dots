#version 120

uniform sampler2D tex;
varying vec2 v_texcoord;

void main() {
    vec4 c = texture2D(tex, v_texcoord);
    
    // Яркость (стандартная формула)
    float gray = dot(c.rgb, vec3(0.299, 0.587, 0.114));
    
    // Янтарный цвет
    float brightness = pow(gray, 1.1);
    vec3 amber = vec3(1.0, 0.7, 0.15) * brightness;
    
    // Сканирующие линии (опционально)
    // float scanline = sin(v_texcoord.y * 1080.0 * 3.14159) * 0.15 + 0.85;
    // amber *= scanline;
    
    gl_FragColor = vec4(amber, c.a);
}
