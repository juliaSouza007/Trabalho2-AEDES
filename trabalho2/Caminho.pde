import java.util.Stack;

// Definição da classe Caminho
class Caminho {
  int numVertices;
  int linha;
  int coluna;
  float[][] adj;
  PVector destino; // Posicao do destino no grid
  PVector origem; // Posicao da origem no grid

  // Construtor da classe Caminho
  Caminho(PVector destino, PVector origem) {
    this.destino = destino;
    this.origem = origem;
    inicializaMatriz();
    adicionaArestas();
    printMatriz();
    int iOrigem = iTerreno(this.origem.y, this.origem.x);
    int iDestino = iTerreno(this.destino.y, this.destino.x);
    println("origem: " + iOrigem + " destino: " + iDestino);
    //Dijkstra(iOrigem, iDestino);
  }

  // Obtem o tamanho da matriz, o numero de linhas, o numero de colunas e o numero de vertices
  void inicializaMatriz() {
    // Obtem o tamanho da matrizAdj por meio da diferença entre as coordenadas
    if (destino.x > origem.x) this.coluna = (int)destino.x-(int)origem.x+1;
    else this.coluna = (int)origem.x-(int)destino.x+1;
    if (destino.y > origem.y) this.linha = (int)destino.y-(int)origem.y+1;
    else this.linha = (int)origem.y-(int)destino.y+1;

    this.numVertices = this.linha*this.coluna;

    this.adj = new float[this.numVertices][this.numVertices];
  }

  void adicionaArestas() {
    for (int i = 0; i < numVertices; i++) {
      // Obtem a posicao do terreno analisado
      int posX = posXTerrenoGrid(i);
      int posY = posYTerrenoGrid(i);
      // Obtem o peso do terreno analisado
      float vPeso = pesoTerreno(posY, posX);
      // Terreno proximo e seu peso
      int viz = 0;
      float vizPeso = 0;

      // Adiciona arestas entre terrenos proximos
      // Se não é o final de uma linha
      if ((i+1)%coluna != 0) {
        // Obtem-se o vizinho da direita, seu peso e adiciona uma aresta entre ele e o terreno analisado
        viz = i+1;
        vizPeso = pesoTerreno(posY, (posX+1));
        adj[i][viz] = (vPeso+vizPeso)/2;
        adj[viz][i] = adj[i][viz];
        //println("["+i+"] ["+viz+"] = "+adj[i][viz]);
        //println("["+posY, posX+"]"+"["+posY, (posX+1)+"]");
      }
      // Se não é a última linnha
      if (i + coluna < numVertices) {
        // Obtem-se o vizinho de baixo, seu peso e adiciona uma aresta entre ele e o terreno analisado
        viz = i + coluna;
        vizPeso = pesoTerreno((posY+1), posX);
        adj[i][viz] = (vPeso+vizPeso)/2;
        adj[viz][i] = adj[i][viz];
        //println("["+i+"] ["+viz+"] = "+adj[i][viz]);
        //println("["+posY, posX+"]"+"["+(posY+1), posX+"]");
      }
    }
  }

  // Obtem a posicao X do terreno analisado em relacao ao ponto de origem
  int posXTerrenoGrid(int i) {
    // Determina a coluna atual
    int colunaAtual = i % this.coluna;

    // Obtem a posX da coluna atual no grid
    if (this.destino.x > this.origem.x) { // Se o destino está à direita da origem
      return (int)this.origem.x+colunaAtual;
    } else { // Se o destino está à esquerda da origem
      return (int)this.origem.x-(this.coluna-1 -colunaAtual);
    }
  }

  // Obtem a posicao Y do terreno analisado em relacao ao ponto de origem
  int posYTerrenoGrid(int i) {
    // Determina a linha atual
    int linhaAtual = i/this.coluna;

    // Obtem a posY da coluna atual no grid
    if (this.destino.y < this.origem.y) { // Se o destino está acima da origem
      return (int)this.origem.y-(this.linha-1-linhaAtual);
    } else { // Se o destino está abaixo da origem
      return (int)this.origem.y+linhaAtual;
    }
  }

  // Obtem o indice do terreno na matrizAdj
  int iTerreno(float posY, float posX) {
    // Determina a coluna atual
    int colunaAtual;
    if (this.destino.x > this.origem.x) { // Se o destino estiver à direita da origem
      colunaAtual = (int)(posX-this.origem.x);
    } else { // Se o destino estiver à esquerda da origem
      colunaAtual = this.coluna-1-(int)(this.origem.x - posX);
    }

    // Determina a linha atual
    int linhaAtual;
    if (this.destino.y < this.origem.y) { // Se o destino estiver acima da origem
      linhaAtual = (this.linha-1)+(int)(posY - this.origem.y);
    } else { // Se o destino estiver abaixo da origem
      linhaAtual = (int)(posY-this.origem.y);
    }

    // Determina o indice do terreno na matrizAdj
    return linhaAtual*this.coluna+colunaAtual;
  }

  float pesoTerreno(int posX, int posY) {
    int v = map.getTileValue(posY, posX);
    float vPeso = 0;
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
      vPeso = Float.MAX_VALUE;
      break;
    case 4: // pedra
      vPeso = Float.MAX_VALUE;
      break;
    case 5: // cacto
      vPeso = Float.MAX_VALUE;
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
    println("origem.x: " + str(origem.y) + ", origem.y: " + str(origem.x));
    println("destino.x: " + str(destino.y) + ", destino.y: " + str(destino.x));
  }

  // Algoritmo de Dijkstra para encontrar o caminho mais curto a partir da origem até o destino
  void Dijkstra(int origem, int destino) {
    float[] menoresDist = new float[numVertices]; // Array para armazenar as menores distâncias conhecidas da origem até cada vértice
    int[] anterior = new int[numVertices]; // Array para armazenar o vértice anterior no caminho mais curto até cada vértice

    // Inicializa os arrays com valores iniciais
    for (int v = 0; v < numVertices; v++) {
      menoresDist[v] = Float.MAX_VALUE; // Inicializa todas as distâncias como infinito
      anterior[v] = -1; // Define o vértice anterior como -1 (ainda não definido)
    }

    menoresDist[origem] = 0; // A distância da origem para ela mesma é 0

    int[] Q = new int[numVertices]; // Array para controlar os vértices visitados

    // Loop principal do algoritmo de Dijkstra
    for (int i = 0; i < numVertices; i++) {
      int u = -1;
      float uDist = Float.MAX_VALUE;

      // Encontra o vértice u não visitado com a menor distância atual
      for (int v = 0; v < numVertices; v++) {
        if (Q[v] == 0 && menoresDist[v] < uDist) {
          u = v;
          uDist = menoresDist[v];
        }
      }

      Q[u] = 1; // Marca o vértice u como visitado

      // Atualiza as distâncias dos vértices adjacentes ao vértice u
      for (int v = 0; v < numVertices; v++) {
        if (u == v || adj[u][v] == 0) continue; // Se v é u ou não há aresta entre u e v, continua para o próximo v

        float alt = uDist + adj[u][v]; // Calcula a possível nova distância até v

        // Se encontrar um caminho mais curto até v, atualiza menoresDist e anterior
        if (alt < menoresDist[v]) {
          menoresDist[v] = alt;
          anterior[v] = u;
        }
      }
    }

    // Reconstrói o caminho mais curto usando a pilha e desenha o caminho encontrado
    Stack<Integer> caminho = new Stack<Integer>(); // Pilha para armazenar o caminho do destino até a origem
    caminho.push(destino); // Inicia com o vértice de destino
    int v = anterior[destino]; // Obtém o vértice anterior ao destino

    // Preenche a pilha com os vértices do caminho mais curto
    while (v >= 0) {
      caminho.push(v);
      v = anterior[v];
    }

    desenhaCaminho(caminho); // Chama a função desenhar para visualizar o caminho encontrado
  }

  void desenhaCaminho(Stack<Integer> caminho) {
    textAlign(CENTER);
    // Desenha as arestas
    stroke(0);
    strokeWeight(1);
    for (int i = 0; i < numVertices; i++) {
      for (int j = i + 1; j < numVertices; j++) {
        stroke(0);
        if (caminho.contains(i) && caminho.contains(j)) stroke(255, 0, 0);
        strokeWeight(adj[i][j]);
        if (adj[i][j] > 0) {
          line(map.screenPosX(posYTerrenoGrid(i)), map.screenPosY(posXTerrenoGrid(i)), map.screenPosX(posYTerrenoGrid(j)), map.screenPosY(posXTerrenoGrid(i)));
        }
      }
    }
  }
}
