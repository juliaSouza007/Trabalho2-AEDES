int chunkSize = 100;
int tileSize = 20;
boolean dragging = false;

Map map;
Caminho caminho;
Caminho caminhoBarco;
Barco barco;

int x = 1000, y = 1000;
PVector destino = new PVector();
PVector origem = new PVector();

void setup() {
  size(800, 800);
  map = new Map(chunkSize, tileSize);
  map.reset(x, y);
  caminho = new Caminho(destino, origem, false);
  caminhoBarco = new Caminho(destino, origem, false);

  barco = new Barco(new PVector(x, y), 30);
}

void draw() {
  background(0);
  stroke(#B7BDC1);
  strokeWeight(0.5);
  map.display();
  fill(255, 0, 0);
  ellipse(map.screenPosX(x), map.screenPosY(y), 10, 10);
  caminho.desenhaCaminho();
  caminhoBarco.desenhaCaminho();

  barco.display();

  if (barco.verificarBarco(new PVector(x, y))) {
    // codigo que deixa o jogador andar na agua
  }
}

void mouseDragged() {
  dragging = true;
  map.drag(mouseX - pmouseX, mouseY - pmouseY);
}

void mouseReleased() {
  if (!dragging) {

    // Pega as coordenadas do destino
    destino.x = map.gridPosX(mouseX);
    destino.y = map.gridPosY(mouseY);
    // Pega as coordenadas do ponto de origem (player)
    origem.x = x;
    origem.y = y;

    // Verifica se o destino é água, se for o jogador vai para o barco pelo caminhio mais curto e depois vai para o destino
    if (map.getTileValue((int)destino.x, (int)destino.y) == 0) {
      caminhoBarco.setCaminho(barco.posicao, origem, barco.pegouBarco);
      caminho.setCaminho(destino, barco.posicao, barco.pegouBarco);
    } else {
      caminho.setCaminho(destino, origem, barco.pegouBarco);
      caminhoBarco.setCaminho(new PVector(0,0), new PVector(0,0), false);
    }

    /*int v = map.getTileValue((int)destino.x, (int)destino.y);
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
     }*/
  } else dragging = false;
}

void keyPressed() {
  if (key == 'c' || key == 'C') map.reset();
  if (key == 'w' || key == 'W') y--;
  if (key == 's' || key == 'S') y++;
  if (key == 'a' || key == 'A') x--;
  if (key == 'd' || key == 'D') x++;
}
