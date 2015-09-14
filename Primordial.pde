/********************************** //<>// //<>// //<>//
 Primordial
 Based on Swarm Processing Concept
 Siddharth Atre
 ***********************************/

import processing.pdf.*;
import java.util.Date;

PGraphics image;
color[] exportColors;


//Master Vars, Set by user.
final float G = 6.67 * pow(10, -11);
final int attract_count = 5;
final int emit_count = 4;
final int frame_max = 1000;
final int spawn_strength = (int) random(100, 200);
final boolean showMacroBodies = false;
final boolean showLiveAnimation = false;
float opacity = 2.5;
final boolean showPathTrace = false;
final String Framerate = "Framerate: ";
final String AVG_FRAMERATE = "Avg. Framerate was: ";
final int animationSwitchFrame = 500;
final boolean drawToGraphicsBuffer = false;
final boolean showSpawnAsLines = true;

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
int animationMode = 2;




//Objects
Attractor[] attractors = new Attractor[attract_count];
Emitter[] emitters = new Emitter[emit_count];

void setup() {
    image = createGraphics(width, height);

    if (!drawToGraphicsBuffer) {
        //size(width, height);
        fullScreen(P2D);
        pixelDensity(displayDensity());
        smooth(8);
        frameRate(60);
        background(back);
    } else {
        Date today = new Date();
        //image = createGraphics( 1800, 1200, PDF, "data/String-Theory-" + today.toString() + ".pdf");
        image.beginDraw();
        image.smooth(8);
        image.background(back);
    }

    //get the order of magnitude of the canvas' area.
    if ( drawToGraphicsBuffer ) {
        canvasAreaMagnitude = log(image.width * image.height ) / log( 10 );
    } else {
        canvasAreaMagnitude = log(width * height ) / log( 100 );
    }
    //calculate the stroke weight for the spawn to use.
    spawnStrokeWeight = (int) canvasAreaMagnitude * 0.45;
    println(canvasAreaMagnitude);
    println("Spawn Stroke Weight: " + spawnStrokeWeight);

    //setupExportColors();
    constructEmitterObjects(animationMode);

    for (int j = 0; j< attract_count; j++) {
        if (drawToGraphicsBuffer) {
            attractors[j] = new Attractor(random(50, 80), random(0, 10000), random(image.width), random(image.height));
        } else {
            attractors[j] = new Attractor(random(50, 80), random(0, 10000), random(width), random(height));
        }
    }
}

void draw() {
    avgFramerate = (frameRate + prevFramerate) / 2;
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

    if (drawToGraphicsBuffer) {
        if ( showLiveAnimation ) {
            if ( showPathTrace ) {
                image.noStroke();
                image.fill( back, 28 );
                image.rect( 0, 0, image.width, image.height );
            } else {
                image.background( back );
            }
        } else if ( !showLiveAnimation && showPathTrace ) {
            image.pushMatrix();
            image.noStroke();
            image.fill( back, 0.5 );
            image.rect(0, 0, image.width, image.height);
            image.popMatrix();
        }
    } else {
        if ( showLiveAnimation ) {
            if ( showPathTrace ) {
                noStroke();
                fill( back, 28 );
                rect( 0, 0, width, height );
            } else {
                background( back );
            }
        } else if ( !showLiveAnimation && showPathTrace ) {
            pushMatrix();
            noStroke();
            fill( back, 10 );
            rect(0, 0, width, height);
            popMatrix();
        }
    }

    frame++;
    frame_total++;
    for (int i = 0; i < emit_count; i++ ) {
        emitters[i].Update();
    }

    for ( int i = 0; i < attract_count; i++) {
        attractors[i].Update();
    }

    if (frame_total > frame_max) {
        if (drawToGraphicsBuffer ) {
            println("Avg Framerate: " + avgFramerate);
            image.endDraw();
            Date today = new Date();
            image.save("data/String-Theory-" + today.toString() + ".tif");
            exit();
        } else {
            println("Avg Framerate: " + avgFramerate);
            Date today = new Date();
            save("data/String-Theory-" + today.toString() + ".tif");
            exit();
        }
    }
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
            if (drawToGraphicsBuffer) {
                emitters[i] = new Emitter (random(20, 30), spawn_strength, random(image.width), random(image.height), (int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
            } else {
                emitters[i] = new Emitter (random(20, 30), spawn_strength, random(width), random(height), (int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
                //emitters[i] = new Emitter (random(20, 30), spawn_strength, random(image.width), random(image.height), exportColors[i%4]);
            }
        }
        break;

    case 2:
        background(0);
        for (int i = 0; i < emit_count; i ++ ) {
            if (drawToGraphicsBuffer) {
                emitters[i] = new Emitter (random(20, 30), spawn_strength, random(image.width), random(image.height), (int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
            } else {
                emitters[i] = new Emitter (random(20, 30), spawn_strength, random(width), random(height), (int)random(0, 255), (int)random(0, 255), (int)random(0, 255));
                //emitters[i] = new Emitter (random(20, 30), spawn_strength, random(image.width), random(image.height), exportColors[i%4]);
            }
        }
        break;

    case 1:
        background(255);
        for (int i = 0; i < emit_count; i ++ ) {
            if (drawToGraphicsBuffer) {
                emitters[i] = new Emitter (random(20, 30), spawn_strength, random(width), random(height), 0);
            } else {
                emitters[i] = new Emitter (random(20, 30), spawn_strength, random(image.width), random(image.height), 0);
            }
        }
        break;

    default:
        background(0);
        for (int i = 0; i < emit_count; i ++ ) {
            if (drawToGraphicsBuffer) {
                emitters[i] = new Emitter (random(20, 30), spawn_strength, random(width), random(height), 255);
            } else {
                emitters[i] = new Emitter (random(20, 30), spawn_strength, random(image.width), random(image.height), 255);
            }
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
        if ( drawToGraphicsBuffer ) {
            println("Avg Framerate: " + avgFramerate);
            image.endDraw();
            Date today = new Date();
            image.save("data/String-Theory-" + today.toString() + ".tif");
            exit();
        } else {
            println("Avg Framerate: " + avgFramerate);
            Date today = new Date();
            save("data/String-Theory-" + today.toString() + ".tif");
            exit();
        }
    }
}

void setupExportColors() {
    exportColors = new color[4];
    exportColors[0] = color(random(255), random(255), random(255), opacity);
    exportColors[1] = color(random(255), random(255), random(255), opacity);
    exportColors[2] = color(random(255), random(255), random(255), opacity);
    exportColors[3] = color(random(255), random(255), random(255), opacity);

    /*
    exportColors[0] = color(114, 57, 63, opacity); //purple-brown
     exportColors[1] = color(211, 201, 148, opacity); //light golden-brown
     exportColors[2] = color(64, 81, 93, opacity); //dark blue-gray
     exportColors[3] = color(255, 182, 194, opacity); //light pink
     */
}