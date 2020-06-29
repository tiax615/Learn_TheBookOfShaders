#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

// 矩形
float box(in vec2 _st,in vec2 _size)
{
  _size=vec2(0.5)-_size*0.5;
  vec2 uv=smoothstep(_size,_size+vec2(0.001),_st);
  uv*=smoothstep(_size,_size+vec2(0.001),vec2(1.0)-_st);
  return uv.x*uv.y;
}

// 十字形状
float cross(in vec2 _st,float _size)
{
  return box(_st,vec2(_size,_size/4.))+box(_st,vec2(_size/4.,_size));
}

// 根据弧度_angle构造旋转矩阵
mat2 rotate2d(float _angle)
{
  return mat2(cos(_angle),-sin(_angle),sin(_angle),cos(_angle));
}

mat2 scale(vec2 _scale)
{
  return mat2(_scale.x,0.0,0.0,_scale.y);
}

void main()
{
  vec2 st=gl_FragCoord.xy/u_resolution.xy;
  vec3 color=vec3(0.0);

  // 平移
  // To move the cross we move the space
  vec2 translate=vec2(cos(u_time),sin(u_time));
  st+=translate*0.35;

  // move space from the center to the vec2(0.0)
  // 将十字形状的中心从vec2(0.5)移到vec2(0.0)
  st-=vec2(0.5);
  // rotate the space
  // 将当前的坐标点乘旋转矩阵
  // st=rotate2d(sin(u_time)*PI)*st;
  // 缩放
  st=scale(vec2(sin(u_time)/2.0+1.0))*st;
  // 旋转
  st=rotate2d(u_time*5.)*st;
  // 将十字形状的中心从vec2(0.0)移到vec2(0.5)，原来的位置
  // move it back to the original place
  st+=vec2(0.5);


  // Show the coordinates of space on the background
  // 用颜色来显示坐标空间
  color=vec3(st.x,st.y,0.0);

  // Add the shape on the foreground
  // 将十字形状加入前景
  color+=vec3(cross(st,0.25));

  gl_FragColor=vec4(color,1.0);
}