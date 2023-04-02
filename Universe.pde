import controlP5.*;
ControlP5 cp5;

static float G = 10;
static float MAX_SPEED = 5;

static int SLIDER_HEIGHT = 20;
static int GUI_WIDTH = 200;

ArrayList<Particle> particles = new ArrayList<Particle>(); 
ArrayList<Particle> yellow_group = new ArrayList<Particle>();
ArrayList<Particle> red_group = new ArrayList<Particle>();
ArrayList<Particle> green_group = new ArrayList<Particle>();
ArrayList<Particle> blue_group = new ArrayList<Particle>();

ControlFont font;
int offset = 1;

void DrawGUI(){
  background(0);
  
  PFont pfont = createFont("Arial Bold",20,true); // use true/false for smooth/no-smooth
  font = new ControlFont(pfont,241);
  
  cp5 = new ControlP5(this);
  
  offset++;
  
  DrawSlider("force distance", height-(SLIDER_HEIGHT*offset), new PVector(0, 200));
  
  offset++;
  offset++;
  
  DrawSlider("yellow_yellow", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("yellow_red", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("yellow_green", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("yellow_blue", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  
  offset++;
  
  DrawSlider("red_yellow", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("red_red", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("red_green", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("red_blue", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  
  offset++;
  
  DrawSlider("green_yellow", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("green_red", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("green_green", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("green_blue", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  
  offset++;
  
  DrawSlider("blue_yellow", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("blue_red", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("blue_green", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));
  DrawSlider("blue_blue", height-(SLIDER_HEIGHT*offset), new PVector(-1, 1));

}

void DrawSlider(String name, float h, PVector range){
  cp5.addSlider(name).setPosition(0, h).setSize(GUI_WIDTH, SLIDER_HEIGHT).setRange(range.x, range.y);//.setNumberOfTickMarks(200);
  cp5.getController(name).getValueLabel().align(ControlP5.RIGHT, ControlP5.CENTER).setPaddingX(10);
  cp5.getController(name).getCaptionLabel().align(ControlP5.LEFT, ControlP5.CENTER).setPaddingX(10);
  cp5.getController(name).getCaptionLabel().setFont(font).toUpperCase(false).setSize(10);
  offset++;
}


void setup(){
  
  frameRate(30);
  size(750, 500);
  background(0);
  noStroke();
  
  //GUI
  DrawGUI(); 
  
  yellow_group = CreateGroup(200, color(255,255,0), 5, 1);
  red_group = CreateGroup(200, color(255,0,0), 5, 1);
  green_group = CreateGroup(200, color(0,255,0), 5, 1);
  blue_group = CreateGroup(200, color(0,0,255), 5, 1);
}

float dist = 100;

void draw(){
  //if(frameCount % 2 == 0) { return; }
  
  background(0);
  fill(54, 57, 61);
  rect(0, 0, GUI_WIDTH, height);
  //float yellow_yellow = cp5.getController("yellow X yellow").getValue();
  dist = cp5.getController("force distance").getValue();
  
  Rule(yellow_group, yellow_group, cp5.getController("yellow_yellow").getValue() ,dist);
  Rule(yellow_group, red_group, cp5.getController("yellow_red").getValue() ,dist);
  Rule(yellow_group, green_group, cp5.getController("yellow_green").getValue() ,dist);
  Rule(yellow_group, blue_group, cp5.getController("yellow_blue").getValue() ,dist);
  
  Rule(red_group, yellow_group, cp5.getController("red_yellow").getValue() ,dist);
  Rule(red_group, red_group, cp5.getController("red_red").getValue() ,dist);
  Rule(red_group, green_group, cp5.getController("red_green").getValue() ,dist);
  Rule(red_group, blue_group, cp5.getController("red_blue").getValue() ,dist);
  
  Rule(green_group, yellow_group, cp5.getController("green_yellow").getValue() ,dist);
  Rule(green_group, red_group, cp5.getController("green_red").getValue() ,dist);
  Rule(green_group, green_group, cp5.getController("green_green").getValue() ,dist);
  Rule(green_group, blue_group, cp5.getController("green_blue").getValue() ,dist);
  
  Rule(blue_group, yellow_group, cp5.getController("blue_yellow").getValue() ,dist);
  Rule(blue_group, red_group, cp5.getController("blue_red").getValue() ,dist);
  Rule(blue_group, green_group, cp5.getController("blue_green").getValue() ,dist);
  Rule(blue_group, blue_group, cp5.getController("blue_blue").getValue() ,dist);
  
  
  
  //Rule(green_group, green_group, -0.32, dist);
  //Rule(green_group, red_group, -0.17, dist);
  //Rule(green_group, yellow_group, 0.34, dist);
  //Rule(red_group, red_group, -0.10, dist);
  //Rule(red_group, green_group, -0.34, dist);

  //Rule(yellow_group, green_group, -0.20, dist);
  
  for(int i = 0; i < particles.size(); i++){
    Particle p = particles.get(i);
    fill(p.col);
    ellipse(p.x, p.y, p.size, p.size);   
  }
  
  /*int sum = 0;
  for (int i = 0; i < red_group.size(); i++){
    if (red_group.get(i).x > 0  && red_group.get(i).x < width) {
      if(red_group.get(i).y > 0 && red_group.get(i).y < height) {
        sum++;
      }
    }
  }
  print(sum + "---");*/
}

ArrayList<Particle> CreateGroup(int amount, color col, float size, float mass){
  
  ArrayList<Particle> group = new ArrayList<Particle>();
  
  for(int i = 0; i < amount; i++){
    group.add(new Particle(random(GUI_WIDTH, width), random(0, height), col, size, mass)); //Random position
    //group.add(new Particle(width/2 + (i/100), height/2 + (i/100), col, size, mass)); //BIG BANG!
    particles.add(group.get(i));
  }
  return group;
}

void Rule(ArrayList<Particle> particles1, ArrayList<Particle> particles2, float g, float max_interaction_dist){
  Particle a = null;
  Particle b = null;
  
  for(int i = 0; i < particles1.size(); i++){
    float fx = 0;
    float fy = 0;
    for(int j = 0; j < particles2.size(); j++){
      a = particles1.get(i);
      b = particles2.get(j);
      
      float dx = a.x - b.x;
      float dy = a.y - b.y;
      float d = sqrt(pow(dx,2) + pow(dy,2));
      
      if(d > 0 && d < max_interaction_dist){
        float F = g * ((G * a.m * b.m) / pow(d,2));
        fx += (F * dx);
        fy += (F * dy);
      }
    }

    a.vx = (a.vx + fx) * a.speed; //Change x velocity
    a.vy = (a.vy + fy) * a.speed; //Change y velocity
    
    a.x += a.vx;
    a.y += a.vy;
    if(a.x <= GUI_WIDTH || a.x >= width) { a.vx *= -1; }
    if(a.y <= 0 || a.y >= height) { a.vy *= -1; } 
  }
}
