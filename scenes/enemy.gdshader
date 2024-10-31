shader_type canvas_item;

uniform float progress : hint_range(0.0, 1.0) = 0.0;  // Parâmetro controlado pelo código

void fragment() {
    // Pega a cor original do nó
    vec4 original_color = texture(TEXTURE, UV);

    // Aplica um efeito de brilho baseado no "progress"
    vec4 glow_color = vec4(1.0, 1.0, 1.0, original_color.a);  // Brilho branco
    vec4 final_color = mix(original_color, glow_color, progress);  // Mistura com o brilho conforme o "progress"

    COLOR = final_color;
}
