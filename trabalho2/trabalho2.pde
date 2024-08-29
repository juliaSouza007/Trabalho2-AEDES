int chunkSize;
int tileSize;
boolean dragging;
Map map;
Caminho caminho;
Caminho caminhoBarco;
Barco barco;
Player player;
int x, y;
PVector destino;
PVector origem;

void setup() {
  size(800, 800);
  chunkSize = 100;
  tileSize = 20;
  dragging = false;
  x = 1000;
  y = 1000;
  destino = new PVector(x, y);
  origem = new PVector(x, y);
  map = new Map(chunkSize, tileSize);
  map.reset(x, y);
  caminho = new Caminho(destino, origem);
  caminhoBarco = new Caminho(destino, origem);
  player = new Player(x, y, caminho.caminho);

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

  if (!player.verificarBarco()) {
    barco.display();
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
    if (map.getTileValue((int)destino.x, (int)destino.y) == 0 && !player.pegouBarco) {
      caminhoBarco.setCaminho(barco.posicao, origem, player.pegouBarco);
      caminho.setCaminho(destino, barco.posicao, true);
      caminho.concatenaCaminho(caminhoBarco.caminho);
      player.setCaminho(caminho.caminho);
      println(player.pegouBarco);
    } else {
      caminho.setCaminho(destino, origem, player.pegouBarco);
      player.setCaminho(caminho.caminho);
      caminhoBarco.setCaminho(new PVector(0, 0), new PVector(0, 0), player.pegouBarco); // reseta o caminho ate o barco
    }
  } else dragging = false;
}

void keyPressed() {
  if (key == 'c' || key == 'C') map.reset();
  if (key == 'w' || key == 'W') player.position.y--;
  if (key == 's' || key == 'S') player.position.y++;
  if (key == 'a' || key == 'A') player.position.x--;
  if (key == 'd' || key == 'D') player.position.x++;
  
  if (key == 'p' || key == 'P') centralizarPlayer();
}
  
void centralizarPlayer() {
  // Calcular o offset para centralizar o player na tela
  float offsetX = width / 2 - player.position.x * tileSize;
  float offsetY = height / 2 - player.position.y * tileSize;
  
  // Atualizar a posição do mapa com o novo offset
  map.setOffset(offsetX, offsetY);
}
