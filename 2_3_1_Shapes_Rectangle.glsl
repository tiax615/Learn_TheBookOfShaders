#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// 绘制矩形，整个屏幕
void drawRectangleFull(in float inPct)
{
    vec2 st=gl_FragCoord.xy/u_resolution.xy;
    vec3 color=vec3(0.);
    
    vec2 pct=vec2(inPct);
    
    vec2 bl=step(vec2(.1),st);// bottom-left
    vec2 tr=step(vec2(.1),1.-st);// top-right
    // vec2 bl=smoothstep(vec2(0.),vec2(0.1),st); // bottom-left，使用smoothstep模糊边界
    // vec2 tr=smoothstep(vec2(0.),vec2(0.1),1.0-st); // top-right，使用smoothstep模糊边界
    // vec2 bl=floor(st+pct); // 使用floor
    // vec2 tr=floor(1.-st+pct); // 使用floor
    
    color=vec3(bl.x*bl.y*tr.x*tr.y);
    
    gl_FragColor=vec4(color,1.);
}

// 绘制矩形，指定矩形四边的偏移，和颜色
vec3 drawRectangle(in vec4 inOffset,in vec3 inColor)
{
    vec2 st=gl_FragCoord.xy/u_resolution.xy;
    vec3 color=vec3(0.);
    
    vec2 pct=vec2(inOffset);
    
    vec2 tr=step(inOffset.yx,1.-st);// top-right
    vec2 bl=step(inOffset.wz,st);// bottom-left
    
    vec3 outColor=vec3(bl.x*bl.y*tr.x*tr.y)*inColor;
    
    return outColor;
}

void main()
{
    vec3 bk=vec3(249,242,224)/255.;
    vec3 red=vec3(179,33,34)/255.;
    vec3 yellow=vec3(251,190,40)/255.;
    vec3 blue=vec3(0,94,155)/255.;
    
    // 背景
    vec3 rect_bk=drawRectangle(vec4(0),bk);
    
    // 红黄蓝色块
    vec3 rect_red=drawRectangle(vec4(0,.7,.6,0),red-bk);
    vec3 rect_yellow=drawRectangle(vec4(0,0,.6,.9),yellow-bk);
    vec3 rect_blue=drawRectangle(vec4(.9,0,0,.7),blue-bk);
    
    // 黑色横
    vec3 bu1=drawRectangle(vec4(.16,0,.8,0),vec3(-1.));
    vec3 bu2=drawRectangle(vec4(.4,0,.56,0),vec3(-1.));
    vec3 bu3=drawRectangle(vec4(.86,0,.1,0),vec3(-1.));
    
    // 黑色竖
    vec3 bv1=drawRectangle(vec4(0,.88,.6,.08),vec3(-1.));
    vec3 bv2=drawRectangle(vec4(0,.66,0,.3),vec3(-1.));
    vec3 bv3=drawRectangle(vec4(0,.3,0,.66),vec3(-1.));
    vec3 bv4=drawRectangle(vec4(0,.1,0,.86),vec3(-1.));
    
    // 黑色色块集合
    vec3 rect_black=bu1+bu2+bu3+bv1+bv2+bv3+bv4;
    
    vec3 color=rect_bk+rect_red+rect_yellow+rect_blue+rect_black;
    gl_FragColor=vec4(color,1.);
}