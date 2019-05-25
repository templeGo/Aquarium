class Soul{
    PVector location;
    int size;
    int life;
    boolean isDead = false;

    Soul(float x, float y){
        location = new PVector(x, y);
        size = 0;
        life = 255;
    }

    void update(){
        size += 1;
        life -= 5;
        if(life < 0){
            isDead = true;
        }
    }

    void display(){
        pushMatrix();
        translate(location.x, location.y);
        noFill();
        stroke(#7CB8FF, life);
        ellipse(0, 0, size, size);
        popMatrix();
    }
}