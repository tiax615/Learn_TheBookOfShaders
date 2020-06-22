#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution; // 画布尺寸（宽，高）
uniform vec2 u_mouse; // 鼠标位置（在屏幕上哪个像素）
uniform float u_time; // 时间（加载后的秒数）

void main()
{
    vec2 st=gl_FragCoord.xy/u_resolution;
    vec2 mouse_position=u_mouse/u_resolution;
    // gl_FragColor=vec4(abs(sin(u_time))*st.x,abs(sin(u_time*1.3))*st.y,abs(sin(u_time*1.6)),1.);
    gl_FragColor=vec4(mouse_position.x,mouse_position.y,0.,1.);
}