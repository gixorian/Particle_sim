static float MAX_SPEED = 5;

static int CANVAS_WIDTH = 500;
static int CANVAS_HEIGHT = 500;

PVector max_canvas_size = new PVector();
PVector min_max_width = new PVector();
PVector min_max_height = new PVector();

float G = 1;
float F = 0;

ArrayList<Particle> particles = new ArrayList<Particle>(); 
ArrayList<Particle> yellow_group = new ArrayList<Particle>();
ArrayList<Particle> red_group = new ArrayList<Particle>();
ArrayList<Particle> green_group = new ArrayList<Particle>();
ArrayList<Particle> blue_group = new ArrayList<Particle>();

PVector rule_range = new PVector(-1, 1);
boolean dist_function_d = true;

void Reset(){
  
  particles.clear();
  ResetGUI();
  
  yellow_group = CreateGroup((int)cp5.getController("yellow count").getValue(), color(255,255,0), 3, 1);
  red_group = CreateGroup((int)cp5.getController("red count").getValue(), color(255,0,0), 3, 1);
  green_group = CreateGroup((int)cp5.getController("green count").getValue(), color(0,255,0), 3, 1);
  blue_group = CreateGroup((int)cp5.getController("blue count").getValue(), color(0,0,255), 3, 1);
}

void setup(){
  
  frameRate(60);
  size(1050, 800);
  background(0);
  noStroke();
  stroke(0);
  
  max_canvas_size.x = width - GUI_WIDTH;
  max_canvas_size.y = height;
  
  min_max_width.x = (GUI_WIDTH + (int)(( max_canvas_size.x - CANVAS_WIDTH ) / 2 ));
  min_max_width.y = (width - (int)(( max_canvas_size.x - CANVAS_WIDTH ) / 2 ));
  
  min_max_height.x = (int)(( max_canvas_size.y - CANVAS_HEIGHT ) / 2 );
  min_max_height.y = (height - (int)(( max_canvas_size.x - CANVAS_HEIGHT ) / 2 ));
  
  DrawGUI(); 

  Reset();
}

float dist = 100;

void draw(){
  //if(frameCount % 10 == 0) { return; }
  //print(frameRate + "\n");
  background(0);
  
  noFill();
  stroke(255);
  strokeWeight(5);
  rect(min_max_width.x, min_max_height.x, CANVAS_WIDTH, CANVAS_HEIGHT);
  
  dist = cp5.getController("force distance").getValue();
  G = cp5.getController("G").getValue();
  
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
  
  for(int i = 0; i < particles.size(); i++){
    Particle p = particles.get(i);
    fill(p.col);
    stroke(0);
    strokeWeight(1);
    ellipse(p.x, p.y, cp5.getController("size").getValue(), cp5.getController("size").getValue() );//p.size, p.size);   
  }
  
  fill(54, 57, 61);
  rect(0, 0, GUI_WIDTH, height);
}

ArrayList<Particle> CreateGroup(int amount, color col, float size, float mass){
  
  ArrayList<Particle> group = new ArrayList<Particle>();
  
  for(int i = 0; i < amount; i++){
    group.add(new Particle(random(min_max_width.x, min_max_width.y), random(min_max_height.x, min_max_height.y), col, size, mass)); //Random position
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
        if (distance_function_btn.getItem(0).getValue() == 1) { F = g * ((G * a.m * b.m) / d); }
        else { F = g * ((G * a.m * b.m) / pow(d,2)); }
        fx += (F * dx);
        fy += (F * dy);
      }
    }

    a.vx = (a.vx + fx) * a.speed; //Change x velocity
    a.vy = (a.vy + fy) * a.speed; //Change y velocity
    
    a.x += a.vx;
    a.y += a.vy;
    
    if(a.x <= min_max_width.x  || a.x >= min_max_width.y) { a.vx *= -5; }
    if(a.y <= min_max_height.x || a.y >= min_max_height.y ) { a.vy *= -5; } 
  }
}
