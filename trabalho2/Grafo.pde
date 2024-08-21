import java.util.Stack;

// Definição da classe Grafo
class Grafo {
  int numVertices;
  int linhas;
  int colunas;
  int[][] matrizAdj;
  PVector[] posicoes; // Posições das partículas (nós do grafo)
  PVector[] pesos; // Peso das partículas

  // Construtor da classe Grafo
  Grafo(int[][] adj, int linhas, int colunas) {
    this.numVertices = adj.length;
    this.linhas = linhas;
    this.colunas = colunas;
    matrizAdj = adj;
    pesos = new PVector[numVertices];
    inicializarPosicoes();
  }

  // Inicializa as posições das partículas em um círculo
  void inicializarPosicoes() {
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
  }
}
