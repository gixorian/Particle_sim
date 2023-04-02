public class Particle{

  float x,y;
  float vx, vy;
  float m;
  color col;
  float size;
  float speed = 0.5;
  
  Particle(float _x, float _y, color _col, float _size, float _m){
    x = _x;
    y = _y;
    m = _m;
    vx = 0;
    vy = 0;
    col = _col;
    size = _size;
  }
}
