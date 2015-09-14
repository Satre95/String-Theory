class Emitter {
    float size;
    PVector pos, pos_old;
    color species;
    boolean out_of_bounds = false, create = true;
    float speed, angle;
    int spawn_count;
    Spawn[] spawn;

    ///Constructor to create an emitter that outputs a color spawn.
    Emitter(float size, int spawn_count, float x, float y, int red, int green, int blue) {
        this.size = size;
        this.spawn_count = spawn_count;

        pos =  new PVector(x, y);
        pos_old = new PVector(x, y);

        species = color(red, green, blue);
        speed = random(1.7f, 2.5f);

        spawn = new Spawn[spawn_count];
        for ( int i = 0; i < spawn_count; i++) {
            spawn[i] = new Spawn(size / spawn_count, species, pos.x, pos.y, random(0, TWO_PI ) );
        }
    }

    ///Comstructor to create a new emitter with monochrome spawn
    Emitter( float size, int spawn_count, float x, float y, color whiteColor ) {
        this.size = size;
        this.spawn_count = spawn_count;
        this.species = color(whiteColor);
        this.pos = new PVector(x, y);
        this.pos_old = new PVector(x, y);

        this.speed = random( 5, 7 );
        this.spawn = new Spawn[spawn_count];
        for ( int i = 0; i < spawn_count; i++) {
            spawn[i] = new Spawn( size / spawn_count, species, pos.x, pos.y, random(0, TWO_PI ) );
        }
    }
    
    ////Constructor that takes in the spawn color as a color object.
    //Emitter(float size, int spawn_count, float x, float y, color theColor) {
    //    this.size = size;
    //    this.spawn_count = spawn_count;

    //    pos =  new PVector(x, y);
    //    pos_old = new PVector(x, y);

    //    species = theColor;
    //    speed = random(1.7f, 2.5f);

    //    spawn = new Spawn[spawn_count];
    //    for ( int i = 0; i < spawn_count; i++) {
    //        spawn[i] = new Spawn(size / spawn_count, species, pos.x, pos.y, random(0, TWO_PI ) );
    //    }
    //}


    void Update() {
        noiseSeed(E_noise_val);
        angle = noise(pos.x/noiseScale, pos.y/noiseScale) * noiseStrength;
        pos.x += cos(angle) * speed;
        pos.y += sin(angle) * speed;

        if (drawToGraphicsBuffer ) {
            if (pos.x > image.width || pos.x < 0 || pos.y > image.height || pos.y < 0) out_of_bounds = true;
            if (out_of_bounds) {
                pos.x = random(image.width);
                pos.y = random(image.height);
                out_of_bounds = false;
                pos_old.set(pos);
            }
        } else {
            if (pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0) out_of_bounds = true;
            if (out_of_bounds) {
                pos.x = random(width);
                pos.y = random(height);
                out_of_bounds = false;
                pos_old.set(pos);
            }
        }
        for (Attractor attractor : attractors ) {
            for (int j =0; j < spawn_count; j++) {
                float spawnX = spawn[j].pos.x;
                float spawnY = spawn[j].pos.y;
                float attractorX = attractor.pos.x;
                float attractorY = attractor.pos.y;

                if (dist(spawnX, spawnY, attractorX, attractorY) < attractor.size/3 || spawn[j].checkIfOutOfBounds() ) {
                    spawn[j] = new Spawn( size / spawn_count, species, pos.x, pos.y, random(0, TWO_PI ) );
                }
            }
        }


        if ( showMacroBodies ) {
            if (drawToGraphicsBuffer) {
                image.noStroke();
                image.fill(species);
                image.ellipse(pos.x, pos.y, size, size);
            } else {
                noStroke();
                fill(species);
                ellipse(pos.x, pos.y, size, size);
            }
        }

        pos_old.set(pos);
        Emit();
    }

    void Emit() {
        for ( Spawn aSpawn : spawn ) {
            aSpawn.Move();
        }
    }
}