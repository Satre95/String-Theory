/**********************************
 Primordial
 Based on Swarm Processing Concept
 Siddharth Atre
 ***********************************/
//Master Vars
final int res = 1024;
final color back = color(0);
final float G = 6.67 * pow(10, -11);
int attract_count = 12;
int emit_count = 8;
float noiseScale = 533.80;
float noiseStrength = 77.00;
int A_noise_val = ((int)random(10000));
int E_noise_val = ((int)random(10000));
final float opacity = 100;
int frame = 0;
int frame_total=0;

//Objects
Attractor[] attractors = new Attractor[attract_count];
Emitter[] emitters = new Emitter[emit_count];

void setup() {
  size(res, res, P2D);
  smooth();
  background(back);
  for (int i=0; i < emit_count; i++)
    //    emitters[i] = new Emitter (random(10, 20), (int)random(800, 1000), random(width), random(height), (int)random(100, 255), 50, 27);
    emitters[i] = new Emitter (random(10, 20), (int)random(800, 1000), random(width), random(height), (int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
  for (int j = 0; j< attract_count; j++)
    attractors[j] = new Attractor(random(50, 80), random(0, 10000), random(width), random(height), (color)random(0, 255));
}

void draw() {
  background(back);
  frame++;
  frame_total++;
  for (int i =0; i < emit_count; i++) {
    emitters[i].Update();
  }
  for (int j = 0; j < attract_count; j++) {
    attractors[j].Update();
  }
  if (frame_total > 2000) {
    save("Particulate12.tif");
    exit();
  }
  if (frame > 2500) {
    A_noise_val = (int)random(10000);
    E_noise_val = (int)random(10000);
    frame = 0;
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
    save("Particulate12.tif");
    println("Frame Count: ", frame_total);
    exit();
  }
}

