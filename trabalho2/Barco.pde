class Barco {
  PVector posicao;
  boolean pegouBarco;

  Barco(PVector playerPosicao, int maxDist) {
    this.posicao = geraPosicaoAleatoria(playerPosicao, maxDist);
    this.pegouBarco = false;
  }

  // limitacao de distancia
  PVector geraPosicaoAleatoria(PVector playerPosicao, int maxDist) {
    int x, y;
    int tileValue;
    
    // verifica se a posicao nao eh agua
    do {
      x = (int)playerPosicao.x + (int)random(-maxDist, maxDist);
      y = (int)playerPosicao.y + (int)random(-maxDist, maxDist);
      
      tileValue = map.getTileValue(x, y);
      println("Tentando posicao: (" + x + ", " + y + ") com valor de tile: " + tileValue);
      
    } while (tileValue == 0);
    
    return new PVector(x, y);
  }
  
  void display() {
    if (!pegouBarco) {
      fill(#555033);
      ellipse(map.screenPosX((int)posicao.x), map.screenPosY((int)posicao.y), 10, 10);
    }
  }

  // Verifica se o player pegou o barco
  boolean verificarBarco(PVector playerPosicao) {
    if (!pegouBarco && dist(playerPosicao.x, playerPosicao.y, posicao.x, posicao.y) < 5) {
      pegouBarco = true;
      println("Barco disponivel! Agora vc pode se mover na agua.");
    }
    return pegouBarco;
  }
}
