#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;// 画布尺寸（宽，高）
uniform vec2 u_mouse;// 鼠标位置（在屏幕上哪个像素）
uniform float u_time;// 时间（加载后的秒数）

// Plot a line on Y using a value between 0.0-1.0
// Plot 绘制
// st.y在pct附近时，不为0。否则为0
float plot(vec2 st,float pct)
{
    return smoothstep(pct-.02,pct,st.y)-smoothstep(pct,pct+.02,st.y);
}

void main()
{
    vec2 st=gl_FragCoord.xy/u_resolution;
    
    float y=st.x;
    // float y=pow(st.x,5.);
    // float y=step(0.5,st.x); // 插值，arg2>arg1?0.0:1.0
    // float y=smoothstep(0.1,0.9,st.x); // 平滑插值，根据arg3在[arg1,arg2]插值
    // float y=smoothstep(0.2,0.5,st.x)-smoothstep(0.5,0.8,st.x);
    
    vec3 color=vec3(y);
    
    // Plot a line
    float pct=plot(st,y);
    color=(1.-pct)*color+pct*vec3(0.,1.,0.);
    
    gl_FragColor=vec4(color,1.);
}