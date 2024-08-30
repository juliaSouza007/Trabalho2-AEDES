class Player {
  PVector position; // Posição do player no grid
  float speed; // Velocidade do player
  boolean pegouBarco; // Indica se o player tem um barco
  Stack<PVector> caminho;

  Player(int x, int y) {
    this.position = new PVector(x, y);
    // speed = segundos/grid
    this.speed = map.getTileValue(x, y); // Configura speed baseado em bloco inicial
    this.pegouBarco = false; // O player não tem um barco no início
    this.caminho = new Stack<PVector>(); // Player começa sem caminho
    
    do {
      this.position = new PVector(x, y);
    } while (map.getTileValue((int)position.x, (int)position.y) == 0);
  }

  void setCaminho(Stack<PVector> caminho) {
    this.caminho = caminho;
  }

  void display() {
    if (frameCount % (60 * this.speed) == 0) { // só se move de 60 em 60f -> 60 frames = 1 seg = 1 grid block
      if (!caminho.isEmpty()) {
        PVector s = caminho.pop();
        this.move((int)s.x, (int)s.y); // Chama move() para bloco atual no caminho
      }
    }
    noStroke();
    fill(255, 0, 0);
    ellipse(map.screenPosX((int)position.x), map.screenPosY((int)position.y), 10, 10);
  }
  
  boolean move(int x, int y){ // Altera velocidade e verifica disponibilidade do bloco, recebe x e y da nova grid position
    PVector newPos = new PVector(x, y); 
    int newPosTile = map.getTileValue((int)newPos.x, (int)newPos.y); // Tipo do novo bloco
    switch (newPosTile){
      case 0: // Água
        if (this.pegouBarco) this.speed = 0.5;
        else return false; // não tem barco não pode
        break;   
      case 1: // Grama
        this.speed = 1;
        break;     
      case 2: // Areia
        this.speed = 2;
        break;
      default:
        return false; // Qualquer outro tipo de bloco (obstáculos)
    }
    this.speed /= speedUp; // Mecanismo velocidade geral
    this.position = newPos; // Set nova position
    return true; // Pode ser usada para retornar algum aviso ao usuario
  }
  
  // Verifica se o player pegou o barco
  boolean verificarBarco() {
    float distancia = dist(position.x, position.y, barco.posicao.x, barco.posicao.y);
    if (!pegouBarco && distancia < 1) {
      pegouBarco = true;
      println("Barco disponivel! Agora vc pode se mover na agua.");
    }
    return pegouBarco;
  }
}
