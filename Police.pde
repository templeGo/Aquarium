class Police extends Vehicle{
    float boost = 1.2;
    color c = #FFFFFF;
    Police(float x, float y){
        super(x, y);
        maxforce = 0.1;
        visibility = 150;
    }

    void update(){
        velocity.add(acceleration);
        velocity.limit(maxspeed);
        location.add(velocity.mult(boost));
        acceleration.mult(0);
    }

    void applyForce(PVector force){
        super.applyForce(force);
    }

    void seek(PVector target){
        super.seek(target);
    }

    PVector randomWalk(){
        return super.randomWalk();
    }

    void separate(ArrayList<Police> polices){
        float desiredseparation = r*10;
        PVector sum = new PVector();
        int count = 0;
        for(Police other : polices){
        float d = PVector.dist(location, other.location);
        if((d > 0) && (d < desiredseparation)){
            PVector diff = PVector.sub(location, other.location);
            diff.normalize();
            diff.div(d);
            sum.add(diff);
            count++;
        }
        }

        if(count > 0){
        sum.div(count);
        sum.normalize();
        sum.mult(maxspeed);
        PVector steer = PVector.sub(sum, velocity); 
        steer.limit(maxforce); 
        applyForce(steer);
        }
    }

    void display(){
        float theta = velocity.heading() + PI/2;
        fill(c);
        noStroke();
        pushMatrix();
        translate(location.x,location.y);
        rotate(theta);
        beginShape();
        vertex(0, -r*2);
        vertex(-r, r*2);
        vertex(r, r*2);
        endShape(CLOSE);
        popMatrix();
    }

    void displayVisibility(float visibility){
        super.displayVisibility(visibility);
    }

    void gothroughwall(){
        super.gothroughwall();
    }

    void bounceOffwall(){
        super.bounceOffwall();
    }

    void keepAwayFromWall(float offset){
        super.keepAwayFromWall(offset);
    }
}