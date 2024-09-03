class Stone {
  PVector posicao;
  boolean isReal;  // saber se a pedra é verdadeira ou falsa

  Stone(PVector playerPosicao, int maxDist, boolean isReal) {
    this.isReal = isReal;
    this.posicao = geraPosicaoAleatoria(playerPosicao, maxDist);
  }

  PVector geraPosicaoAleatoria(PVector playerPosicao, int maxDist) {
    int x, y;

    x = (int)playerPosicao.x + (int)random(-maxDist, maxDist);
    y = (int)playerPosicao.y + (int)random(-maxDist, maxDist);
      
    return new PVector(x, y);
  }

  void display() {
    if (isReal) {
      fill(#9950DB);  // cor da pedra real - lilas
    } else {
      fill(#340F55);  // cor da pedra falsa - "preto"
    }
    ellipse(map.screenPosX((int)posicao.x), map.screenPosY((int)posicao.y), 6, 6);
  }

  // Método para verificar colisão com o jogador
  boolean checkCollision(int playerX, int playerY) {
    return (int)posicao.x == playerX && (int)posicao.y == playerY;
  }
}
