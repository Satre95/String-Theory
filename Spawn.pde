class Spawn {
    float size, speed, angle;
    color species;
    PVector pos, pos_old, acceler;
    PVector[] forces = new PVector[attract_count];

    Spawn( float size, color species, float x, float y, float angle ) {
        this.size = size;
        this.species = species;

        pos = new PVector (x, y);
        pos_old = new PVector(x, y);

        speed = random(1.9f, 3.0f);
        this.angle = angle;

        acceler = new PVector(0, 0);


        for (int i =0; i< attract_count; i++)
            forces[i] = new PVector(0, 0);
    }


    void Move() {
        UpdateForces();
        ApplyForce(forces);

        pos.x += cos(angle) * (speed+acceler.mag());
        pos.y += sin(angle) * (speed+acceler.mag());

        draw();

        pos_old.set(pos);
    }

    void draw() {
        if (drawToGraphicsBuffer) {
            image.strokeWeight(spawnStrokeWeight);
            image.stroke(species, opacity);
            if (showSpawnAsLines) {
                image.line(pos.x, pos.y, pos_old.x, pos_old.y);
            } else {
                image.point(pos.x, pos.y);
            }
        } else {
            strokeWeight(spawnStrokeWeight);
            stroke(species, opacity); //<>//
            if (showSpawnAsLines) {
                line(pos.x, pos.y, pos_old.x, pos_old.y);
            } else {
                point(pos.x, pos.y);
            }
        }
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

    boolean checkIfOutOfBounds() {
        if (drawToGraphicsBuffer) {
            return (pos.x > image.width || pos.x < 0 || pos.y > image.height || pos.y < 0);
        } else {
            return (pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0);
        }
    }
}