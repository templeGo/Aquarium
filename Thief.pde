class Thief extends Vehicle{
    boolean isDead = false;

    Thief(float x, float y){
        super(x, y);
        maxforce = 0.22;
        visibility = 230;
        c = #034DFF;
        // if(random(1) < 0.01){
        //     boost = 2.2;
        //     visibility = 100;
        //     c = #6800C7;
        // }
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
        float deadLine = 4;
        if(d < deadLine){
            isDead = true;
        }
    }

    void flock(ArrayList<Thief> thiefs) {
        separate(thiefs);
        align(thiefs); 
        // separateの効果が薄れるためcohesionコメントアウト
        // cohesion(thiefs);
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

    void align(ArrayList<Thief> thiefs){
        float neighbordist = r*20;
        PVector sum = new PVector();
        int count = 0;
        for (Thief other : thiefs) {
            float d = PVector.dist(location, other.location);
            if ((d > 0) && (d < neighbordist)) {
                sum.add(other.velocity);
                count++;
            }
        }
        if (count > 0) {
            sum.div((float)count);
            sum.normalize();
            sum.mult(maxspeed);
            PVector steer = PVector.sub(sum, velocity);
            steer.limit(maxforce);
            applyForce(steer);
        }
    }

    void cohesion(ArrayList<Thief> thiefs){
        float neighbordist = r*10;
        PVector sum = new PVector();
        int count = 0;
        for (Thief other : thiefs) {
            float d = PVector.dist(location, other.location);
            if ((d > 0) && (d < neighbordist)) {
                sum.add(other.location);
                count++;
            }
        }
        if (count > 0) {
            sum.div(count);
            seek(sum);
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

    void IsDead(){
        isDead = true;
    }
}
