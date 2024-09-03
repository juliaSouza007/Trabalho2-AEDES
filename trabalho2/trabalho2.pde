int chunkSize;
int tileSize;
boolean dragging;

Map map;
Caminho caminho;
Caminho caminhoBarco;
Barco barco;
Player player;
Stone stone;

// Fontes
PFont fonte;

// Botoes
Botao play;
Botao exit;
Botao restart;
Botao back;

int x, y;
PVector destino;
PVector origem;
int speedUp = 15; // Aumentar velocidade geral, 1 para Normal
boolean tp = false; // teleport
int pedrasColetadas = 0;
boolean gameOver = false;
boolean ganhou = false;

void setup() {
  size(800, 800);
  chunkSize = 100;
  tileSize = 20;
  dragging = false;
  x = 1000;
  y = 1000;
  destino = new PVector(x, y);
  origem = new PVector(x, y);
  map = new Map(chunkSize, tileSize, new PVector(x, y), 10);
  map.reset(x, y);
  player = new Player(x, y);

  barco = new Barco(new PVector(x, y), 30);

  // Fonte
  fonte = createFont("Minecraft.ttf", 50);

  // Botoes
  play = new Botao(width/2-180/2, height-180, 180, 45, #795126, #34210C, "PLAY", #FFC85A, 30);
  exit = new Botao(width/2-180/2, height-110, 180, 35, #795126, #34210C, "EXIT", #FFC85A, 25);
  restart = new Botao(width/2-145, height-140, 135, 45, #795126, #34210C, "RESTART", #FFC85A, 25);
  back = new Botao(width/2+20, height-140, 125, 45, #795126, #34210C, "EXIT", #FFC85A, 25);

  telaInicial();
}

void draw() {
  background(0);
  stroke(#B7BDC1);
  strokeWeight(0.5);
  map.display();

  if (play.pressed && !gameOver) {

    collectStone(player, map);

    if (caminho != null) caminho.desenhaCaminho();
    if (caminhoBarco != null) caminhoBarco.desenhaCaminho();

    player.display();

    if (!player.verificarBarco()) {
      barco.display();
    }

    for (Stone stone : map.stones) {
      if (stone.checkCollision((int)player.position.x, (int)player.position.y)) {
        stone.display();
      }
    }

    if (ganhou) {
      telaFinal();
    }
  } else if (gameOver) {
    telaFinal();
  } else {
    telaInicial();
  }

  if (exit.pressed) {
    exit();
  }
}

void mouseDragged() {
  dragging = true;
  map.drag(mouseX - pmouseX, mouseY - pmouseY);
}

void mouseReleased() {
  if (!dragging) {
    if (tp) { // Sistema de teletransporte só para testes
      player.position = new PVector(map.gridPosX(mouseX), map.gridPosY(mouseY));
      tp = false;
    }

    // Pega as coordenadas do destino
    destino.x = map.gridPosX(mouseX);
    destino.y = map.gridPosY(mouseY);

    origem =  player.position;

    // Verifica se o destino é água, se for o jogador vai para o barco pelo caminhio mais curto e depois vai para o destino
    if (map.getTileValue((int)destino.x, (int)destino.y) == 0 && !player.pegouBarco) {
      // Acha o caminho mais curto da origem ate o barco
      caminhoBarco = new Caminho(barco.posicao, origem, player.pegouBarco);
      // Acha o caminho mais curto do barco ate o destino considerando que o player pode andar na agua
      caminho = new Caminho(destino, barco.posicao, true);
      // Junta os dois caminhos encontrados
      caminho.concatenaCaminho(caminhoBarco.caminho);
      player.setCaminho(caminho.caminho);
    } else if (true) {
      // Acha o caminho mais curto da origem ao destino
      caminho = new Caminho(destino, origem, player.pegouBarco);
      player.setCaminho(caminho.caminho);
      caminhoBarco = null; // Resseta o caminho do barco
    }
  } else dragging = false;
}

void keyPressed() {

  if (key == 'c' || key == 'C') {
    map.reset(x, y);
    caminho = null;
    caminhoBarco = null;
    player = new Player(x, y);
    barco = new Barco(new PVector(x, y), 30);
  }

  // Chama move() para realizar o check de bloco
  if (key == 'w' || key == 'W') player.move((int)player.position.x, (int)player.position.y-1);
  if (key == 's' || key == 'S') player.move((int)player.position.x, (int)player.position.y+1);
  if (key == 'a' || key == 'A') player.move((int)player.position.x-1, (int)player.position.y);
  if (key == 'd' || key == 'D') player.move((int)player.position.x+1, (int)player.position.y);

  if (key == 'p' || key == 'P') centralizarPlayer();

  if (key == 't') tp = true;
}

void centralizarPlayer() {
  // Calcular o offset para centralizar o player na tela
  float offsetX = width / 2 - player.position.x * tileSize;
  float offsetY = height / 2 - player.position.y * tileSize;

  // Atualizar a posição do mapa com o novo offset
  map.setOffset(offsetX, offsetY);
}

void collectStone(Player player, Map map) {
  for (int i = map.stones.size() - 1; i >= 0; i--) {  // Itera de trás para frente para evitar problemas de remoção
    Stone stone = map.stones.get(i);
    if (stone.checkCollision((int)player.position.x, (int)player.position.y)) {
      if (stone.isReal) {
        println("Pedra verdadeira coletada!");
        pedrasColetadas++;
        if (pedrasColetadas == 5) {
          ganhou = true;
        }
      } else {
        println("Você perdeu!");
        gameOver = true;
      }
      map.stones.remove(i);  // Remove a pedra da lista após ser coletada
    }
  }
}
