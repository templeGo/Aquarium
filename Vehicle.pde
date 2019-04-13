class Vehicle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  color c;
  float maxspeed;
  float maxforce;
  float visibility;
  float boost;

  Vehicle(float x, float y){
    acceleration = new PVector(random(-1, 1), random(-1, 1));
    velocity = new PVector(0, 0);
    location = new PVector(x, y);
    r = 2.0;
    maxspeed = 2;
    maxforce = 0.1;
    boost = 1.5;
  }

  void update(){
    // applyforceのsteerに制限をかけているため、十分な大きさのvelocityが得られない。毎回基本サイズに調整が必要。
    velocity.normalize().mult(boost);
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
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
    PVector currentVelocity = new PVector(velocity.x, velocity.y);
    PVector predictLocation = PVector.add(location, currentVelocity);

    // randomWalkする
    PVector randomVector = PVector.random2D();
    PVector target = predictLocation.add(randomVector);
    // PVector target = predictLocation;


    return target;
  }

  PVector predictTarget(Vehicle vehicle){
    return new PVector();
  }

  void display() {
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
    steer.limit(maxforce*2);
    applyForce(steer);
  }
}
