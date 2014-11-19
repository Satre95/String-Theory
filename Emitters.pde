class Emitter {
  float size;
  PVector pos, pos_old;
  color species;
  boolean out_of_bounds = false, create = true;
  float speed, angle;
  int spawn_count;
  Spawn[] spawn;
  
  Emitter(float temp_size, int temp_strength, float temp_x, float temp_y, int temp_red, int temp_green, int temp_blue) {
    size = temp_size;
    spawn_count = temp_strength;
    pos =  new PVector(temp_x, temp_y);
    species = color(temp_red, temp_green, temp_blue);
//    species = color(0);
    pos_old = new PVector(pos.x, pos.y);
    speed = random(1, 3);
    spawn = new Spawn[spawn_count];
    for(int i = 0; i< spawn_count; i++)
      spawn[i] = new Spawn(random(5, 10), species, random(pos.x - size, pos.x + size), random(pos.y - size, pos.y + size), random(0, TWO_PI));
  }

  void Update() {
    noiseSeed(E_noise_val);
    angle = noise(pos.x/noiseScale, pos.y/noiseScale) * noiseStrength;
    pos.x += cos(angle) * speed;
    pos.y += sin(angle) * speed;
    if (pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0) out_of_bounds = true;
    if (out_of_bounds) {
      pos.x = random(width);
      pos.y = random(height);
      out_of_bounds = false;
      pos_old.set(pos);
    }
    for(int i = 0; i< attract_count; i++) 
      for(int j =0; j < spawn_count; j++) 
        if(dist(spawn[j].pos.x, spawn[j].pos.y, attractors[i].pos.x, attractors[i].pos.y) < attractors[i].size/3)
          spawn[j] = new Spawn(random(5, 10), species, random(pos.x - size, pos.x + size), random(pos.y - size, pos.y + size), random(0, TWO_PI));
    strokeWeight(1);
    stroke(255);
    fill(species);
//    ellipse(pos.x, pos.y, size, size);
    pos_old.set(pos);
    Emit();
  }

  void Emit() {
    for (int k = 0; k < spawn_count; k++) {
      spawn[k].Move();
    }
  }
}

