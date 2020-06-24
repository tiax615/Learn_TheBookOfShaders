#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 circle(in float inPct,in float inRadius,vec3 inColor)
{
    // a. The DISTANCE from the pixel to the center
    // pct=distance(st,vec2(.5));
    
    // b. The LENGTH of the vector from the pixel to the center
    // vec2 toCenter=vec2(.5)-st;
    // pct=length(toCenter);
    
    // c. The SQUARE ROOT of the vector from the pixel to the center
    // vec2 tC=vec2(.5)-st;
    // pct=sqrt(tC.x*tC.x+tC.y*tC.y);
    
    // vec3 color=vec3(step(.5,pct));
    vec3 outColor=vec3(smoothstep(1.-inRadius-.001,1.-inRadius+.001,1.-inPct))*inColor;
    return outColor;
}

void main()
{
    vec2 st=gl_FragCoord.xy/u_resolution;
    float pct1=distance(st,vec2(.5)+vec2(sin(u_time)/2.));
    
    // 距离场
    // pct1 = distance(st,vec2(0.4)) + distance(st,vec2(0.6));
    // pct1 = distance(st,vec2(0.4)) * distance(st,vec2(0.6));
    // pct1 = min(distance(st,vec2(0.4)),distance(st,vec2(0.6)));
    // pct1 = max(distance(st,vec2(0.4)),distance(st,vec2(0.6)));
    // pct1 = pow(distance(st,vec2(0.4)),distance(st,vec2(0.6)));
    
    float pct2=distance(st,vec2(.2)+vec2(0,abs(sin(u_time)/2.)));
    float pct3=distance(st,vec2(.3)+vec2(abs(sin(u_time)/2.),0));

    vec3 color_circle1=circle(pct1,.1,vec3(abs(sin(u_time*3.5)),0,0));
    vec3 color_circle2=circle(pct2,.1,vec3(0,abs(sin(u_time*4.)),0));
    vec3 color_circle3=circle(pct3,.1,vec3(0,0,abs(sin(u_time*4.5))));
    vec3 color=color_circle1+color_circle2+color_circle3;

    gl_FragColor=vec4(color,1.);
}