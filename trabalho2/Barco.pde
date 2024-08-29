class Barco {
  PVector posicao;

  Barco(PVector playerPosicao, int maxDist) {
    this.posicao = geraPosicaoAleatoria(playerPosicao, maxDist);
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
      //println("Tentando posicao: (" + x + ", " + y + ") com valor de tile: " + tileValue);
      
    } while (tileValue == 0);
    
    return new PVector(x, y);
  }
  
  void display() {
      fill(#555033);
      ellipse(map.screenPosX((int)posicao.x), map.screenPosY((int)posicao.y), 10, 10);
  }
}
