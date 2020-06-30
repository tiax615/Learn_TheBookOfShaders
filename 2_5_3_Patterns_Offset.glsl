#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

vec2 brickTile(vec2 _st,float _zoom)
{
  _st*=_zoom;

  // Here is where the offset is happening
  // 偏移，区分奇偶行
  // mod(_st.y,2.0)，奇数行返回1.0，偶数行返回0.0
  // _st.x+=step(1.,mod(_st.y,2.0))*0.5;

  // 偶数行左移，奇数行右移
  // u_time/1.0能被2整除时，不做x方向的移动
  _st.x+=(step(1.,mod(_st.y,2.0))*-2.0+1.0)*u_time*step(1.,mod(u_time/1.0,2.0));

  // 偶数列下移，奇数列上移
  // u_time/1.0不能被2整除时，不做y方向的移动
  _st.y+=(step(1.,mod(_st.x,2.0))*-2.0+1.0)*u_time*step(mod(u_time/1.0,2.0),1.);

  return fract(_st);
}

float box(vec2 _st,vec2 _size)
{
  _size=vec2(0.5)-_size*0.5;
  vec2 uv=smoothstep(_size,_size+vec2(1e-4),_st);
  uv*=smoothstep(_size,_size+vec2(1e-4),vec2(1.0)-_st);
  return uv.x*uv.y;
}

float circle(in vec2 _st,in float _radius)
{
  vec2 l=_st-vec2(0.5);
  // return 1.0-smoothstep(_radius-(_radius*0.01),_radius+(_radius*0.01),dot(l,l)*4.0);
  return smoothstep(_radius-(_radius*0.03),_radius+(_radius*0.03),dot(l,l)*4.0);
}

void main(void)
{
  vec2 st=gl_FragCoord.xy/u_resolution.xy;
  vec3 color=vec3(0.0);

  // Modern metric brick of 215mm x 102.5mm x 65mm
  // http://www.jaharrison.me.uk/Brickwork/Sizes.html
  // st/=vec2(2.15,0.65)/1.5;

  // Apply the brick tilling
  st=brickTile(st,10.0);

  // color=vec3(box(st,vec2(0.9)));
  color=vec3(circle(st,0.5));

  // Uncomment to see the space coordinates
  // color=vec3(st,0.0);

  gl_FragColor=vec4(color,1.0);
}