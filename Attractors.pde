class Attractor {
    float size, strength, angle, speed;
    PVector pos, pos_old;
    boolean out_of_bounds = false;


    Attractor(float size, float strength, float x, float y) {
        this.size = size;
        this.strength = strength;
        pos =  new PVector(x, y);

        speed = random(2.4f, 3.0f);
        pos_old = new PVector(x, y);
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

        if ( showMacroBodies ) {
            if (drawToGraphicsBuffer) {
                image.noStroke();
                image.fill(255);
                image.ellipse(pos.x, pos.y, size, size);
            } else {
                noStroke();
                fill(255);
                ellipse(pos.x, pos.y, size, size);
            }
        }
        pos_old.set(pos);
    }
}