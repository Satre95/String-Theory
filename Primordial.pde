/**********************************
 Primordial
 Based on Swarm Processing Concept
 Siddharth Atre
 ***********************************/
 
import processing.pdf.*;
 
//Master Vars, Set by user.
final float G = 6.67 * pow(10, -11);
final int attract_count = 5;
final int emit_count = 4;
final int frame_max = 2300;
final int spawn_strength = (int) random(100, 300);
final boolean showMacroBodies = false;
final boolean showLiveAnimation = false;
float opacity = 5;
final boolean showPathTrace = true;
final String Framerate = "Framerate: ";
final String AVG_FRAMERATE = "Avg. Framerate was: ";
final int animationSwitchFrame = 500;


//Other Behavioural vars, modified by program.

float spawnStrokeWeight = 1;
float canvasAreaMagnitude = 0;
int back = 0;

float noiseScale = 533.00;
float noiseStrength = 77.00;
//float noiseScale = 170.80;
//float noiseStrength = 20.00;

int A_noise_val = ((int)random(10000));
int E_noise_val = ((int)random(10000));


int frame = 0;
int frame_total=0;
float prevFramerate = 0;
float avgFramerate = 0;
/*
The various forms of representation of String Theory
 - 0 is white on black
 - 1 is black on white
 - 2 is color on black
 - 3 is color on white.
 */
int animationMode = 3;

boolean showSpawnAsLines = false;


//Objects
Attractor[] attractors = new Attractor[attract_count];
Emitter[] emitters = new Emitter[emit_count];

void setup() {
  println( "Starting Animation" );
  fullScreen(P2D);
  pixelDensity(displayDensity());
  smooth(8);
  frameRate(60);
  background(back);

  //get the order of magnitude of the canvas' area.
  canvasAreaMagnitude = log(width * height ) / log( 10 );
  //calculate the stroke weight for the spawn to use.
  spawnStrokeWeight = (int) canvasAreaMagnitude * 0.45;
  println(canvasAreaMagnitude);
  println("Spawn Stroke Weight: " + spawnStrokeWeight);
  
  constructEmitterObjects(animationMode);

  for (int j = 0; j< attract_count; j++) {
    attractors[j] = new Attractor(random(50, 80), random(0, 10000), random(width), random(height));
  }
}

void draw() {
    
    avgFramerate = (frameRate + prevFramerate) / 2;
//  println(Framerate + frameRate);
  switch(animationMode) {
    case 3:
      back = 255;
      opacity = 40;
      break;
    case 2:
      back = 0;
      opacity = 40;
      break;
    case 1:
      back = 255;
      opacity = 30;
      break;
    default:
      back = 0;
      opacity = 35;
      break;
  }
  
  if ( showLiveAnimation ) {
    if ( showPathTrace ) {
      noStroke();
      fill( back, 28 );
      rect( 0, 0, width, height );
    } else {
      background( back );
    }
  } else if( !showLiveAnimation && showPathTrace ) {
      pushMatrix();
      noStroke();
      fill( back, 0.5 );
      rect(0, 0, width, height);
      popMatrix();
  }

  frame++;
  frame_total++;
  for (int i = 0; i < emit_count; i++ ) {
    emitters[i].Update();
  }

  for ( int i = 0; i < attract_count; i++) {
    attractors[i].Update();
  }

  //  if (frame_total > frame_max) {
  //    save("Particulate.tif");
  //    exit();
  //  }
  /*
  if (frame > animationSwitchFrame) {
    //reset the Attractor and Emitter noise seeds.
    A_noise_val = (int)random(10000);
    E_noise_val = (int)random(10000);

    //change the animation mode.
    animationMode = ++animationMode % 4;
    
    //reconstruct the emitter and swarm agents.
    constructEmitterObjects( animationMode );
    
    frame = 0;
    
    println(AVG_FRAMERATE + avgFramerate );
  }
  */
  prevFramerate = frameRate;
}


/*
The various forms of representation of String Theory
 - 0 is white on black
 - 1 is black on white
 - 2 is color on black
 - 3 is color on white.
 */
 
void constructEmitterObjects( int aniMode ) {
  
  switch( aniMode ) {
    case 3:
      //reset the display
      background(255);
      for (int i = 0; i < emit_count; i ++ ) {
        emitters[i] = new Emitter (random(20, 30), spawn_strength, random(width), random(height), (int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
      }
      break;
      
    case 2:
      background(0);
      for (int i = 0; i < emit_count; i ++ ) {
        emitters[i] = new Emitter (random(20, 30), spawn_strength, random(width), random(height), (int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
      }
      break;
      
    case 1:
      background(255);
      for (int i = 0; i < emit_count; i ++ ) {
        emitters[i] = new Emitter (random(20, 30), spawn_strength, random(width), random(height), 0);
      }
      break;
  
    default:
      background(0);
      for (int i = 0; i < emit_count; i ++ ) {
        emitters[i] = new Emitter (random(20, 30), spawn_strength, random(width), random(height), 255); 
      }
      break; 
  }
}

void keyPressed() {
  if (key == '2') noiseScale += 10;
  if (key == '1') noiseScale -= 10;
  if (key == '0') noiseStrength +=5;
  if (key == '9') noiseStrength -= 5;
  println("Noise Scale: ", noiseScale);
  println("Noise Strength: ", noiseStrength);
  println("Attractor Noise Val: ", A_noise_val);
  println("Emitter Noise Val: ", E_noise_val);
  println("-----------------------------");
}

void keyReleased() {
  if (key == BACKSPACE) A_noise_val = (int)random(10000);
  if (key == ENTER || key == RETURN) E_noise_val = (int)random(10000);
  if (key == 'q') {
    save("Particulate.tif");
    println("Frame Count: ", frame_total);
    exit();
  }
  if( key == 's' ) {
      String imageName = "Particulate_" + frame_total + ".tif";
      save(imageName);
      println( "Saved image: " + imageName);
  }
}