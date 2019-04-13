class Vehicle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxspeed;
  float maxforce;
  float visibility;

  Vehicle(float x, float y){
    acceleration = new PVector(random(-1, 1), random(-1, 1));
    velocity = new PVector(0, 0);
    location = new PVector(x, y);
    r = 3.0;
    maxspeed = 4;
    maxforce = 0.1;
  }

  void update(){
    
  }

  void applyForce(PVector force){
    acceleration.add(force);
  }

  void seek(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }

  PVector randomWalk(){
    PVector currentVelocity = velocity;

    currentVelocity.normalize();
    PVector predictLocation = PVector.add(location, currentVelocity.mult(2));

    // randomWalkする
    PVector randomVector = PVector.random2D();
    float r = 3;
    randomVector.setMag(r);

    PVector target = predictLocation.add(randomVector);

    return target;
  }

  PVector predictTarget(Vehicle vehicle){
    return new PVector();
  }

  void display() {
    
  }

  void displayVisibility(float visibility){
    PVector pos = location;
    noFill();
    stroke(0);
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0, 0, visibility, visibility);
    popMatrix();
  }

  void gothroughwall(){
    if(location.x > width){
      location.x = 0;
    }else if(location.x < 0){
      location.x = width;
    }

    if(location.y > height){
      location.y = 0;
    }else if(location.y < 0){
      location.y = height;
    }
  }

  void bounceOffwall(){
    float offset = 1;
    if(location.x >= width - offset){
      location.x = width - offset;
    }else if(location.x <= offset){
      location.x = offset;
    }

    if(location.y >= height - offset){
      location.y = height - offset;
    }else if(location.y < offset){
      location.y = offset;
    }
  }


  void keepAwayFromWall(float offset){
    PVector desired = new PVector(0, 0);
    if(location.x > width - offset){
      desired = new PVector(-maxspeed, velocity.y);
    }else if(location.x < offset){
      desired = new PVector(maxspeed, velocity.y);
    }

    if(location.y > height - offset){
      desired = new PVector(velocity.x, -maxspeed);
    }else if(location.y < offset){
      desired = new PVector(velocity.x, maxspeed);
    }

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
}
