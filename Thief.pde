class Thief extends Vehicle{
    color c = #034DFF;
    boolean isDead = false;
    float boost = 1;

    Thief(float x, float y){
        super(x, y);
        maxforce = 0.22;
        visibility = 230;
        if(random(1) < 0.01){
            boost = 2.2;
            visibility = 100;
            c = #6800C7;
        }
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

    PVector predictTarget(Vehicle vehicle){
        PVector target = new PVector();

        // thief->policeのベクトル
        PVector diff = PVector.sub(vehicle.location, location);
        // policeとの距離
        float d = diff.mag();

        // 検死
        Autopsy(d);
        
        if(d < visibility){
            // 近づくほどspeedを増やす
            float m = map(d,0,visibility,maxspeed,0);
            target.add(diff.mult(-1));
        }
        
        return target;
    }

    void Autopsy(float d){
        float deadLine = 3;
        if(d < deadLine){
            isDead = true;
        }
    }

    void separate(ArrayList<Thief> thiefs){
        float desiredseparation = r*10;
        PVector sum = new PVector();
        int count = 0;
        for(Thief other : thiefs){
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
        vertex(0, r*3);
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

    void IsDead(){
        isDead = true;
    }
}
