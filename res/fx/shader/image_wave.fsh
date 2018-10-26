uniform float time;
uniform bool enable_mask;
uniform bool enable_gray;
uniform vec2 resolution;
uniform vec2 wave_factor;

varying vec2 v_texCoord;

void main()
{
	float gridx = 10.0;
	float gridy = 10.0;
	float xslide = gl_FragCoord.x / gridx;
	float yslide = gl_FragCoord.y / gridy;

	vec2 uv = v_texCoord.xy;

	float mask = 1.0;
	if(enable_mask)
		mask = texture2D(CC_Texture1, uv).a;

	vec2 tex_uv = uv + vec2(cos(xslide * time) * mask * wave_factor.x, cos(yslide * time) * mask * wave_factor.y);

	vec4 oriColor = texture2D(CC_Texture0, tex_uv);

	if(enable_gray)
	{
        float gray = dot(oriColor.rgb, vec3(0.2, 0.5, 0.2));
        gl_FragColor = vec4(gray, gray, gray, oriColor.a);
	}else{
		gl_FragColor = oriColor;
	}
}
