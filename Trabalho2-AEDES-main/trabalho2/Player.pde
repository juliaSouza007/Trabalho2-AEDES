class Player {
  PVector position; // Posição do player no grid
  float speed; // Velocidade do player
  boolean pegouBarco; // Indica se o player tem um barco
  Stack<PVector> caminho;

  Player(int x, int y, Stack<PVector> caminho) {
    this.position = new PVector(x, y);
    this.speed = 1; // Velocidade padrão do player
    this.pegouBarco = false; // O player não tem um barco no início
    this.caminho = caminho;
  }

  void setCaminho(Stack<PVector> caminho) {
    this.caminho = caminho;
  }

  void display() {
    if (frameCount % 10 == 0) {
      if (!caminho.isEmpty()) {
        this.position = caminho.pop();
      }
    }
    fill(255, 0, 0);
    ellipse(map.screenPosX((int)position.x), map.screenPosY((int)position.y), 10, 10);
  }
  
  // Verifica se o player pegou o barco
  boolean verificarBarco() {
    if (pegouBarco && dist(position.x, position.y, position.x, position.y) < 5) {
      pegouBarco = true;
      println("Barco disponivel! Agora vc pode se mover na agua.");
    }
    return pegouBarco;
  }
}
