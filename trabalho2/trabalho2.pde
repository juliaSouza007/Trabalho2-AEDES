int chunkSize = 100;
int tileSize = 20;
boolean dragging = false;

Map map;
Caminho caminho;
Caminho caminhoBarco;
Barco barco;
Player player;

int x = 1000, y = 1000;
PVector destino = new PVector(x, y);
PVector origem = new PVector(x, y);

void setup() {
  size(800, 800);
  map = new Map(chunkSize, tileSize);
  map.reset(x, y);
  caminho = new Caminho(destino, origem, false);
  caminhoBarco = new Caminho(destino, origem, false);
  player = new Player(x, y, caminho);

  barco = new Barco(new PVector(x, y), 30);
}

void draw() {
  background(0);
  stroke(#B7BDC1);
  strokeWeight(0.5);
  map.display();
  caminho.desenhaCaminho();
  caminhoBarco.desenhaCaminho();
  player.display();

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

    origem =  player.position;

    // Verifica se o destino é água, se for o jogador vai para o barco pelo caminhio mais curto e depois vai para o destino
    if (map.getTileValue((int)destino.x, (int)destino.y) == 0) {
      caminhoBarco.setCaminho(barco.posicao, origem, barco.pegouBarco);
      caminho.setCaminho(destino, barco.posicao, barco.pegouBarco);
    } else {
      caminho.setCaminho(destino, origem, barco.pegouBarco);
      caminhoBarco.setCaminho(new PVector(0, 0), new PVector(0, 0), false);
      caminho.Dijkstra();
      player.caminho.caminho = caminho.caminho;
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
  if (key == 'w' || key == 'W') player.position.y--;
  if (key == 's' || key == 'S') player.position.y++;
  if (key == 'a' || key == 'A') player.position.x--;
  if (key == 'd' || key == 'D') player.position.x++;
}
