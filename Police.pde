class Police extends Vehicle{
    Police(float x, float y){
        super(x, y);
        maxforce = 0.1;
        maxspeed = 4;
        visibility = 150;
        boost = 2;
        c = #FFFFFF;
    }

    void update(){
        super.update();
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

    PVector avoidMouse(PVector mouse){
        PVector target = new PVector();

        // police->mouse
        PVector diff = PVector.sub(mouse, location);
        // mouseとの距離
        float d = diff.mag();

        int avoidRange = 20;
        
        if(d < avoidRange){
            target.add(diff.mult(-maxspeed)).mult(1);
        }
        
        return target;
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
        super.display();
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
