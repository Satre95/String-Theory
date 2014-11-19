class Attractor {
  float size, strength, angle, speed;
  PVector pos, pos_old;
  color type;
  boolean out_of_bounds = false;


  Attractor(float temp_size, float temp_strength, float temp_x, float temp_y, color temp_type) {
    size = temp_size;
    strength = temp_strength;
    pos =  new PVector(temp_x, temp_y);
    type = temp_type;
    speed = random(3, 5);
    pos_old = new PVector(pos.x, pos.y);
  }

  void Update() {
    noiseSeed(A_noise_val);
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
    strokeWeight(3);
    stroke(type);
    fill(0);
//    ellipse(pos.x, pos.y, size, size);
    pos_old.set(pos);
  }
}

