import controlP5.*;
import java.util.*;

ControlP5 cp5;

static int SLIDER_HEIGHT = 20;
static int GUI_WIDTH = 250;

ArrayList<String> sliders = new ArrayList<String>();

ControlFont font;
int offset = 1;

RadioButton distance_function_btn;

public void Randomize(){
  for(int i = 0; i < sliders.size(); i++){
    cp5.getController(sliders.get(i)).setValue(random(-1, 1));
  }
}

void DrawGUI(){
  background(0);
  
  PFont pfont = createFont("Arial Bold",20,true);
  font = new ControlFont(pfont,241);
  
  cp5 = new ControlP5(this);
  
  // Randomize button
  cp5.addButton("Randomize")
   .setPosition(0,height-(25*offset))
   .setSize(GUI_WIDTH,25)
   ;
   
  cp5.getController("Randomize").getCaptionLabel()
  .setFont(font)
  .setSize(12)
  ;
  
  offset++;
  
  //Reset button
  cp5.addButton("Reset")
   .setPosition(0,height-(26*offset))
   .setSize(GUI_WIDTH,25)
   ;
   
  cp5.getController("Reset").getCaptionLabel()
  .setFont(font)
  .setSize(12)
  ;
  
  offset++;
  offset++;

  distance_function_btn = cp5.addRadioButton("radioButton")
                             .setPosition(10, height-(24*offset))
                             .setSize(15,15)
                             .setColorForeground(color(120))
                             .setColorActive(color(255))
                             .setColorLabel(color(255))
                             .setItemsPerRow(5)
                             .setSpacingColumn(50)
                             .addItem("d",1)
                             .addItem("d^2",2)
                             ; 
     
   distance_function_btn.activate(0);
   
   offset++;
   
   cp5.addTextlabel("label")
   .setText("Distance Function")
   .setPosition(0,height-(25*offset))
   .setFont(createFont("Arial Bold",12))
   ;
  
  offset += 3;
  
  // Force distance slider
  DrawSlider("force distance", height-(SLIDER_HEIGHT*offset), new PVector(0, 200), 80, false);
  
  //offset++;
  
  // G slider
  DrawSlider("G", height-(SLIDER_HEIGHT*offset), new PVector(0, 50), 0.5, false);
  
  offset++;
  
  // size slider
  DrawSlider("size", height-(SLIDER_HEIGHT*offset), new PVector(1, 10), 3, false);
  
  offset++;
  offset++;
  
  cp5.addSlider("Scroll")
     .setPosition(GUI_WIDTH,0)
     .setSize(20,height)
     .setRange(0,100)
     .setValue(0)
     .setLabelVisible(false)
     .setSliderMode(Slider.FLEXIBLE)
     .setHandleSize(height)
     ;
  
  for (int i = 0; i < particle_types.size(); i++){
    DrawSlider(particle_types.get(i).col_name + " count", height-(SLIDER_HEIGHT*offset-5), new PVector(1, 2000), 500, false);
    for (int j = 0; j < particle_types.size(); j++){
      DrawSlider(particle_types.get(i).col_name + "_" + particle_types.get(j).col_name, height-(SLIDER_HEIGHT*offset), rule_range, 0, true);
    }
    offset++;
  }
}

void DrawSlider(String name, float h, PVector range, float start_value, boolean randomize){
  
  if(randomize) { sliders.add(name); }
  
  cp5.addSlider(name)
     .setPosition(0, h)
     .setSize(GUI_WIDTH, SLIDER_HEIGHT)
     .setRange(range.x, range.y)
     .setValue(start_value)
     ;
     
  cp5.getController(name).getValueLabel()
     .align(ControlP5.RIGHT, ControlP5.CENTER)
     .setPaddingX(10)
     ;
     
  cp5.getController(name).getCaptionLabel()
  .align(ControlP5.LEFT, ControlP5.CENTER)
  .setPaddingX(10)
  .setFont(font)
  .toUpperCase(false)
  .setSize(10)
  ;
  
  offset++;
}

void ResetGUI(){
  for(int i = 0; i < sliders.size(); i++){
    cp5.getController(sliders.get(i)).setValue(0);
  }
}

void Scroll(){
  print("Scroll\n");
}

void UpdateGUI(){
  
}
