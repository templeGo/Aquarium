import java.util.Iterator;

ArrayList<Thief> thiefs = new ArrayList<Thief>();
ArrayList<Police> polices = new ArrayList<Police>();

float worldRecord = 80;
color BGC = #01000B;

void setup(){
  size(1300, 800);
  background(BGC);
  thiefs.add(new Thief(random(width), random(height)));
  polices.add(new Police(random(width), random(height)));
}

void draw(){
  background(BGC);
  if(mousePressed){
    thiefs.add(new Thief(mouseX, mouseY));
  }

  Iterator<Thief> it = thiefs.iterator();
  while(it.hasNext()){
    Thief thief = it.next();
    PVector target = thief.randomWalk();
    for(Police police : polices){
      target.add(thief.predictTarget(police));
    }
    thief.flock(thiefs);
    thief.seek(target);
    thief.update();
    thief.keepAwayFromWall(50);
    thief.bounceOffwall();
    thief.display();

    if(thief.isDead){
      it.remove();
    }
  }

  for(Police police : polices){
    PVector target = police.randomWalk();
    for(Thief thief : thiefs){
      float distance = PVector.sub(thief.location, police.location).mag();
      if(distance < worldRecord){
        worldRecord = distance;
        target = thief.location;
      }
    }
    police.separate(polices);
    police.seek(target);
    police.update();
    police.keepAwayFromWall(50);
    police.bounceOffwall();
    police.display();

    worldRecord = police.visibility;
  }
  
}

void mousePressed(){
  thiefs.add(new Thief(mouseX, mouseY));
}

void keyPressed(){
  if((keyPressed == true) && (key == 'r')){
    polices.add(new Police(random(width), random(height)));
  }
}
