class Spawn {
  float size, speed, angle;
  color species;
  PVector pos, pos_old, acceler;
  PVector[] forces = new PVector[attract_count];
  boolean alive = true;
/*Implement death and rebirth for swarm agents when they are absorbed
Also for when they cross the screen boundary*/

  Spawn(float temp_size, color temp_species, float temp_x, float temp_y, float temp_angle) {
    size = temp_size;
    species = temp_species;
    pos = new PVector (temp_x, temp_y);
    pos_old = new PVector(pos.x, pos.y);
    speed = random(3, 5);
    angle = temp_angle;
    acceler = new PVector(0, 0);
    for (int i =0; i< attract_count; i++)
      forces[i] = new PVector(0, 0);
  }

  void Move() {
    UpdateForces();
    ApplyForce(forces);
    if (alive) {
      pos.x += cos(angle) * (speed+acceler.mag());
      pos.y += sin(angle) * (speed+acceler.mag());
      stroke(species, opacity);
      strokeWeight(2);
//      line(pos.x, pos.y, pos_old.x, pos_old.y);
      point(pos.x, pos.y);
    }
    if (pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0) alive = false;

    pos_old.set(pos);
  }

  void UpdateForces() {
    for (int i = 0; i< attract_count; i++) {
      PVector temp = attractors[i].pos.get();
      float force = (G * attractors[i].size * size) / pow(dist(pos.x, pos.y, attractors[i].pos.x, attractors[i].pos.y), 2);
      PVector.sub(attractors[i].pos, pos, temp);
      temp.setMag(force);
      forces[i].set(temp);
      
    }
  }

  void ApplyForce(PVector force[]) {
    PVector net_force = new PVector(0, 0); 
    for (int h = 0; h<attract_count; h++)
      net_force.add(force[h]); 
    angle = net_force.heading();
    net_force.div(size);
    acceler.add(net_force);
  }
}

