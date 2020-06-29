#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main()
{
  vec2 st=gl_FragCoord.xy/u_resolution.xy;
  st.x*=u_resolution.x/u_resolution.y;
  vec3 color=vec3(0.0);
  float d=0.0;

  // Remap the space to -1. to 1.
  st=st*2.0-1.0;

  // Number of sides of your shape
  int N=3;

  // Angle and radius from the current pixel
  float a=atan(st.x,st.y)+PI;
  float r=TWO_PI/float(N);

  // Shaping function that modulate the distance
  d=cos(floor(0.5+a/r)*r-a)*length(st);

  color=vec3(1.0-smoothstep(0.4,0.41,d));
  // color=vec3(d);

  gl_FragColor=vec4(color,1.0);
}