int chunkSize = 100;
int tileSize = 20;
boolean dragging = false;

Map map;

int x = 0, y = 0;

void setup() {
  size(800, 800);
  map = new Map(chunkSize, tileSize);
  map.reset(0, 0);
}

void draw() {
  background(0);
  stroke(#B7BDC1);
  strokeWeight(0.5);
  map.display();
  fill(255,0,0);
  ellipse(map.screenPosX(x), map.screenPosY(y), 10, 10);
}

void mouseDragged() {
  dragging = true;
  map.drag(mouseX - pmouseX, mouseY - pmouseY);
}

void mouseReleased() {
  if(!dragging){
    int x = map.gridPosX(mouseX);
    int y = map.gridPosY(mouseY);
    int v = map.getTileValue(x, y);
    println("valor: " + str(x) + ", " + str(y));
    switch(v) {
          case 0: // água
            println("água");
            break;
          case 1: // grama
            println("grama");
            break;
          case 2: // areia
            println("areia");
            break;
          case 3: // coral
            println("coral");
            break;
          case 4: // pedra
            println("pedra");
            break;
          case 5: // cacto
            println("cacto");
            break;
    }
  }
  else dragging = false;
}

void keyPressed() {
  if (key == 'c' || key == 'C') map.reset();
  if (key == 'w' || key == 'W') y--;
  if (key == 's' || key == 'S') y++;
  if (key == 'a' || key == 'A') x--;
  if (key == 'd' || key == 'D') x++;
}
