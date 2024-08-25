import java.util.Stack;

// Definição da classe Caminho
class Caminho {
  int numVertices;
  int linha;
  int coluna;
  float[][] adj;
  PVector[] posicoes; // Posições dos terrenos no grid
  //PVector[] pesos; // Peso dos terrenos
  PVector destino; // Posicao do destino no grid
  PVector origem; // Posicao da origem no grid

  // Construtor da classe Caminho
  Caminho(PVector destino, PVector origem) {
    this.destino = destino;
    this.origem = origem;
    //this.pesos = new PVector[numVertices];
    this.adj = inicializaMatriz();
    adicionaArestas();
    printMatriz();
    //inicializarPosicoes();
  }

  // Obtem o tamanho da matriz, o numero de linhas, o numero de colunas e o numero de vertices
  float[][] inicializaMatriz() {
    // Obtem o tamanho da matrizAdj por meio da diferença entre as coordenadas
    if (destino.x > origem.x) this.coluna = (int)destino.x-(int)origem.x+1;
    else this.coluna = (int)origem.x-(int)destino.x+1;
    if (destino.y > origem.y) this.linha = (int)destino.y-(int)origem.y+1;
    else this.linha = (int)origem.y-(int)destino.y+1;

    this.numVertices = this.linha*this.coluna;

    return new float[this.numVertices][this.numVertices];
  }

  void adicionaArestas() {
    for (int i = 0; i < numVertices; i++) {
      // Obtem a posicao do terreno analisado
      int posX = posXTerrenoGrid(i);
      int posY = posYTerrenoGrid(i);
      //println("y[" +i +"] "+posY);
      // Obtem o valor do terreno analisado
      int vPeso = pesoTerreno(posY, posX);
      // Peso de um terreno proximo
      int viz = 0, vizPeso = 0;

      // Adiciona arestas entre terrenos proximos
      // Se tiver um vizinho à direita, adiciona aresta
      if ((i+1)%coluna != 0) {
        viz = i+1;
        vizPeso = pesoTerreno(posY, posX+1); // Obtem o peso do vizinho
        adj[i][viz] = (float)(vPeso+vizPeso)/2;
        adj[viz][i] = adj[i][viz];
        println("["+i+"] ["+viz+"] = "+adj[i][viz]);
        println("["+posY, posX+"]"+"["+posY, (posX+1)+"]");
      }
      // Se tiver um vizinho abaixo, adiciona aresta
      if (i + coluna < numVertices) {
        viz = i + coluna;
        vizPeso = pesoTerreno(posY+1, posX);
        adj[i][viz] = (vPeso+vizPeso)/2;
        adj[viz][i] = adj[i][viz];
        println("["+i+"] ["+viz+"] = "+adj[i][viz]);
        println("["+posY, posX+"]"+"["+(posY+1), posX+"]");
      }
    }
  }

  /* Para acessar as coordenadas de um terreno dentro do espaço entre a
   origem e o destino, foram feitas contas (difíceis de explicar), mas
   que fazem sentido no contexto do grid
   */
  // Obtem a posicao X do terreno analisado em relacao ao ponto de origem
int posXTerrenoGrid(int i) {
    // Determina a coluna atual com base no índice i
    int colunaAtual = i % this.coluna;

    // Calcula a posição X da coluna atual
    if (this.destino.x > this.origem.x) { // Se o destino está à direita da origem
        return (int) this.origem.x + colunaAtual;
    } else { // Se o destino está à esquerda da origem
        return (int) this.origem.x - (this.coluna - 1 - colunaAtual);
    }
}

  // Obtem a posicao Y do terreno analisado em relacao ao ponto de origem
  int posYTerrenoGrid(int i) {
    int linhaAtual = i/this.coluna;
    
    // Verifica se a linha está dentro da faixa do grid
    //if (linhaAtual >= this.linha || linhaAtual < 0) return 0;

    // Calcula a posição Y da linha atual
    return (int) this.origem.y + (this.destino.y < this.origem.y ? -(this.linha - 1 - linhaAtual) : linhaAtual);
} 

  int pesoTerreno(int posX, int posY) {
    int v = map.getTileValue(posX, posY);
    int vPeso = 0;
    switch(v) {
    case 0: // água
      vPeso = 1;
      break;
    case 1: // grama
      vPeso = 2;
      break;
    case 2: // areia
      vPeso = 3;
      break;
    case 3: // coral
      vPeso = Integer.MAX_VALUE;
      break;
    case 4: // pedra
      vPeso = Integer.MAX_VALUE;
      break;
    case 5: // cacto
      vPeso = Integer.MAX_VALUE;
      break;
    }
    return vPeso;
  }

  void printMatriz() {
    for (int i = 0; i < numVertices; i++) {
      for (int j = 0; j < numVertices; j++) {
        print(adj[i][j] + " | ");
      }
      println();
    }
    println("linha: " + str(linha) + ", coluna:" + str(coluna));
    println("origem.x: " + str(origem.x) + ", origem.y: " + str(origem.y));
    println("destino.x: " + str(destino.x) + ", destino.y: " + str(destino.y));
  }


  // Inicializa as posições das partículas em um círculo
  /* void inicializarPosicoes() {
   for (int i = 0; i < linhas; i++) {
   for (int j = 0; j < colunas; j++) {
   
   if (this.matrizAdj[i][j] == 0 || this.matrizAdj[i][j+1])
   float x = (this.matrizAdj[i][j] + this.matrizAdj[i][j+1])/2;
   float y = (this.matrizAdj[i][j] + this.matrizAdj[i+j][j])/2;
   pesos[i] = new PVector(x, y);
   }
   }
   // Posição fixa do vértice 0
   posicoes[0] = new PVector(width / 2, height / 2);
   velocidades[0] = new PVector(0, 0);
   } */
}
