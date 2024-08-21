int chunkSize = 100;
int tileSize = 20;
boolean dragging = false;

Map map;

int x = 1000, y = 1000;
PVector destino = new PVector();
PVector origem = new PVector(0, 0);
int[][] adj;

void setup() {
  size(800, 800);
  map = new Map(chunkSize, tileSize);
  map.reset(x, y);
}

void draw() {
  background(0);
  stroke(#B7BDC1);
  strokeWeight(0.5);
  map.display();
  fill(255, 0, 0);
  ellipse(map.screenPosX(x), map.screenPosY(y), 10, 10);
}

void mouseDragged() {
  dragging = true;
  map.drag(mouseX - pmouseX, mouseY - pmouseY);
}

void mouseReleased() {
  if (!dragging) {
    destino.x = map.gridPosX(mouseX);
    destino.y = map.gridPosY(mouseY);

    origem.x = x;
    origem.y = y;

    int linha = 1, coluna = 1;

    // Tamanho da matriz adj
    if (destino.x > origem.x) linha = (int)destino.x-(int)origem.x+1;
    else linha = (int)origem.x-(int)destino.x+1;

    if (destino.y > origem.y) coluna = (int)destino.y-(int)origem.y+1;
    else coluna = (int)origem.y-(int)destino.y+1;

    adj = new int[linha][coluna];

    int v;

    for (int j = 0; j < coluna; j++) {
      for (int i = 0; i < linha; i++) {
        v = map.getTileValue(x + i, y - j);
        println((x + i) + ", " + (y - j));

        switch(v) {
         case 0: // água
         adj[i][j] = 0;
         break;
         case 1: // grama
         adj[i][j] = 2;
         break;
         case 2: // areia
         adj[i][j] = 3;
         break;
         case 3: // coral
         adj[i][j] = 0;
         break;
         case 4: // pedra
         adj[i][j] = 0;
         break;
         case 5: // cacto
         adj[i][j] = 0;
         break;
         }
      }
    }

    println("Tamnho matriz");
    println("linha: " + str(linha) + ", coluna:" + str(coluna));

    v = map.getTileValue((int)destino.x, (int)destino.y);
    println("destino.x: " + str(destino.x) + ", destino.y: " + str(destino.y) +"\n");
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
  } else dragging = false;
}

void keyPressed() {
  if (key == 'c' || key == 'C') map.reset();
  if (key == 'w' || key == 'W') y--;
  if (key == 's' || key == 'S') y++;
  if (key == 'a' || key == 'A') x--;
  if (key == 'd' || key == 'D') x++;
}
