# Trabalho2-AEDES

Trabalho 2
Objetivo
O objetivo deste trabalho é implementar um player que se movimenta pelo caminho mais rápido no mapa, utilizando o algoritmo de Dijkstra. O player deve ser capaz de se mover por diferentes tipos de terreno (grama, areia, água) e evitar obstáculos (pedras, cactus, corais). Um barco será colocado aleatoriamente no mapa, permitindo que o player navegue na água com velocidade dobrada. Adicionalmente, a implementação do algoritmo A* para a movimentação do player será recompensada com pontos extras.
Estrutura do Trabalho
O trabalho será realizado em grupos de 4 alunos e será avaliado em três aspectos: código, apresentação e relatório. A distribuição de pontos é a seguinte:

Código: 5 pontos
Apresentação: 5 pontos
Relatório: 5 pontos
Implementação do Algoritmo A*: 1 ponto extra
Implementação de um objetivo para o jogo: 1 ponto extra
Requisitos do Trabalho
Implementação do Player

#Crie uma classe `Player` que inclua atributos para posição, velocidade e um indicador de posse do barco.
Inicialize o player em uma posição padrão no mapa (por exemplo, no centro).
O player deve se mover do ponto inicial até o ponto clicado no mapa, utilizando o algoritmo de Dijkstra.
O player pode andar na grama e na areia, mas a velocidade na areia é reduzida pela metade. O player pode viajar na água apenas quando está de posse de um barco, viajando na água com o dobro da velocidade de quando anda na grama.
O player não pode atravessar obstáculos (pedras, cactus, corais).

Para a implementação da velocidade, considere que o movimento do player é de 1 bloco do grid por segundo quando na grama, 0,5 blocos no grid por segundo quando na areia e 2 blocos do grid por segundo quando na água com barco.
Implementação do Algoritmo de Dijkstra
Implemente o algoritmo de Dijkstra para calcular o caminho mais curto.
Utilize pesos para os diferentes tipos de terreno, o peso de uma aresta é dada pela média do peso do dois vértices que formam a aresta, O pedo do vértice é dado pelo tipo de terreno:
Água: 1 com barco e infinito sem barco
Grama: 2
Areia: 3
#Adicionar um Barco
Coloque um barco em uma posição aleatória do mapa, mas não mais distante do que 100 blocos do ponto inicial do player.
Se o player pegar o barco, ele pode se mover na água.
Ações no Mapa
Ao apertar a tecla 'P', o mapa deve ser centralizado no player.
Relatório
O relatório deve incluir:

#Introdução ao problema e descrição das funcionalidades implementadas.
Descrição detalhada da implementação do algoritmo de Dijkstra e suas adaptações.
Explicação de como a centralização foi implementada.
Explicação de trechos relevantes do código
Capturas de tela mostrando o funcionamento do código.
Reflexão sobre os desafios encontrados e como foram superados.
Apresentação
A apresentação deve ser feita por todos os membros do grupo, deverá ter duração de 10 minutos e deve incluir:

Visão geral do projeto e funcionalidades implementadas.
Demonstração do código funcionando.
Explicação do algoritmo de Dijkstra e, se implementado, explicação do algoritmo A*.
Discussão sobre o processo de desenvolvimento e lições aprendidas.


Anexo: Explicação do Mapa
class Map {
  // ...

  void display() {
    int startX = floor(-offsetX / chunkSize) - 1;
    int startY = floor(-offsetY / chunkSize) - 1;
    int endX = startX + ceil(width / chunkSize) + 2;
    int endY = startY + ceil(height / chunkSize) + 2;
  
    for (int x = startX; x < endX; x++) {
      for (int y = startY; y < endY; y++) {
        String key = x + "," + y;
        if (!chunks.containsKey(key)) {
          chunks.put(key, new Chunk(x, y));
        }
        chunks.get(key).display(offsetX, offsetY);
      }
    }
  }

  // ...
}

O método `display()` é responsável por desenhar os chunks na tela. Ele calcula quais chunks precisam ser exibidos com base no deslocamento atual e na resolução da tela. Vamos analisar o código passo a passo:

1. As variáveis `startX`, `startY`, `endX` e `endY` são calculadas para determinar os limites dos chunks que precisam ser exibidos. Isso é feito dividindo as coordenadas de deslocamento pelo tamanho do chunk e arredondando para baixo (`floor`) ou para cima (`ceil`), dependendo da direção do deslocamento.
2. O código então entra em dois loops aninhados, iterando sobre as coordenadas dos chunks dentro dos limites calculados.
3. Para cada coordenada de chunk, é gerada uma chave (`key`) como uma string concatenando as coordenadas `x` e `y`.
4. Se o `HashMap` `chunks` não contiver a chave gerada, um novo objeto `Chunk` é criado com as coordenadas `x` e `y` e adicionado ao `HashMap`.
5. Em seguida, o método `display()` do objeto `Chunk` correspondente é chamado, passando as coordenadas de deslocamento `offsetX` e `offsetY`.

void drag(float _offsetX, float _offsetY) {
  offsetX += _offsetX;
  offsetY += _offsetY;
}

O método `drag()` é usado para atualizar as coordenadas de deslocamento, permitindo que o mapa seja "arrastado" horizontalmente e verticalmente. Ele simplesmente adiciona os valores `_offsetX` e `_offsetY` às coordenadas de deslocamento `offsetX` e `offsetY`, respectivamente.

int gridPosX(int xScreen) {
  return floor((-offsetX + xScreen) / tileSize);
}

int gridPosY(int yScreen) {
  return floor((-offsetY + yScreen) / tileSize);
}

Os métodos `gridPosX()` e `gridPosY()` são usados para converter coordenadas de tela em coordenadas de grid (tiles). Eles funcionam da seguinte maneira:

1. Para `gridPosX()`, o método subtrai `offsetX` de `xScreen` para obter a coordenada x relativa ao canto superior esquerdo do mapa.
2. Em seguida, divide esse valor por `tileSize` e arredonda para baixo usando `floor()`, obtendo a coordenada x do grid.
3. O processo é semelhante para `gridPosY()`, mas usando `offsetY` e `yScreen`.

int screenPosX(int gridX) {
  return (gridX * tileSize + (int)offsetX) + tileSize/2;
}

int screenPosY(int gridY) {
  return (gridY * tileSize + (int)offsetY) + tileSize/2;
}

Os métodos `screenPosX()` e `screenPosY()` fazem o oposto dos métodos anteriores, convertendo coordenadas de grid em coordenadas de tela. Eles funcionam da seguinte maneira:

1. Para `screenPosX()`, o método multiplica `gridX` por `tileSize` para obter a coordenada x do canto superior esquerdo do tile.
2. Em seguida, adiciona `offsetX` (convertido para inteiro) para obter a coordenada x relativa ao canto superior esquerdo do mapa.
3. Por fim, adiciona `tileSize/2` para obter a coordenada x do centro do tile.
4. O processo é semelhante para `screenPosY()`, mas usando `gridY` e `offsetY`.

int getTileValue(int gridX, int gridY) {
  int chunkX = floor(gridX * tileSize / (float) chunkSize);
  int chunkY = floor(gridY * tileSize / (float) chunkSize);
  String key = chunkX + "," + chunkY;
  
  if (!chunks.containsKey(key)) {
    chunks.put(key, new Chunk(chunkX, chunkY));
  }
  Chunk chunk = chunks.get(key);
  int localX = gridX % (chunkSize / tileSize);
  int localY = gridY % (chunkSize / tileSize);
  return chunk.getTile(localX, localY);
}

O método `getTileValue(int gridX, int gridY)` retorna o valor do tile em uma determinada posição no grid. Vamos analisar o código:

1. As coordenadas `chunkX` e `chunkY` do chunk que contém o tile são calculadas dividindo as coordenadas de grid pelo tamanho do chunk e arredondando para baixo.
2. Uma chave (`key`) é gerada como uma string concatenando `chunkX` e `chunkY`.
3. Se o `HashMap` `chunks` não contiver a chave gerada, um novo objeto `Chunk` é criado com as coordenadas `chunkX` e `chunkY` e adicionado ao `HashMap`.
4. O objeto `Chunk` correspondente é obtido do `HashMap` usando a chave.
5. As coordenadas locais `localX` e `localY` dentro do chunk são calculadas usando o operador de módulo (`%`).
6. Por fim, o método `getTile()` do objeto `Chunk` é chamado, passando `localX` e `localY`, e seu valor de retorno é retornado pelo método `getTileValue()`.

class Chunk {
  // ...

  void generateChunk() {
    for (int x = 0; x < chunkSize / tileSize; x++) {
      for (int y = 0; y < chunkSize / tileSize; y++) {
        float noise = noise((chunkX * chunkSize + x * tileSize) * 0.01, (chunkY * chunkSize + y * tileSize) * 0.01);
        if (noise < 0.3) {
          tiles[x][y] = 0; // água
        } else if (noise < 0.6) {
          tiles[x][y] = 1; // grama
        } else {
          tiles[x][y] = 2; // areia
        }

        // Adicionar obstáculos
        if (random(1) < 0.005) {
          if (tiles[x][y] == 0) tiles[x][y] = 3; // coral
          else if (tiles[x][y] == 1) tiles[x][y] = 4; // pedra
          else if (tiles[x][y] == 2) tiles[x][y] = 5; // cacto
        }
      }
    }
  }
  // ...
}

O método `generateChunk()` é responsável por preencher a matriz `tiles` do chunk com valores que representam diferentes tipos de terreno e obstáculos. Vamos analisar o código:

1. O método usa dois loops aninhados para iterar sobre cada posição na matriz `tiles`.
2. Para cada posição, é calculado um valor de ruído de Perlin usando a função `noise()`. As coordenadas passadas para essa função são as coordenadas globais do tile, multiplicadas por um fator de escala (0.01 neste caso).
3. O valor de ruído é usado para determinar o tipo de terreno naquela posição. Se o ruído for menor que 0.3, a posição é preenchida com o valor 0 (água). Se estiver entre 0.3 e 0.6, é preenchida com o valor 1 (grama). Caso contrário, é preenchida com o valor 2 (areia).
4. Depois de determinar o tipo de terreno, o código verifica se um obstáculo deve ser adicionado naquela posição. Isso é feito gerando um número aleatório entre 0 e 1 usando a função `random(1)`. Se o número gerado for menor que 0.005 (0.5% de chance), um obstáculo é adicionado.
5. O tipo de obstáculo a ser adicionado depende do tipo de terreno na posição. Se for água, é adicionado um coral (valor 3). Se for grama, é adicionada uma pedra (valor 4). Se for areia, é adicionado um cacto (valor 5).

int getTile(int localX, int localY) {
  if (localX >= 0 && localX < tiles.length && localY >= 0 && localY < tiles[0].length) {
    return tiles[localX][localY];
  } else {
    return -1;
  }
}

O método `getTile(int localX, int localY)` retorna o valor do tile em uma posição local dentro do chunk. Ele verifica se as coordenadas locais `localX` e `localY` estão dentro dos limites da matriz `tiles`. Se estiverem, retorna o valor do tile naquela posição (`tiles[localX][localY]`). Caso contrário, retorna -1, indicando que as coordenadas estão fora dos limites.

void display(float offsetX, float offsetY) {
  for (int x = 0; x < chunkSize / tileSize; x++) {
    for (int y = 0; y < chunkSize / tileSize; y++) {
      float screenX = chunkX * chunkSize + x * tileSize + offsetX;
      float screenY = chunkY * chunkSize + y * tileSize + offsetY;

      if (screenX + tileSize < 0 || screenX > width || screenY + tileSize < 0 || screenY > height) {
        continue;
      }

      switch(tiles[x][y]) {
        case 0: // água
          fill(50, 50, 200);
          break;
        case 1: // grama
          fill(0, 255, 0);
          break;
        case 2: // areia
          fill(255, 255, 50);
          break;
        case 3: // coral
          fill(200, 0, 255);
          break;
        case 4: // pedra
          fill(128);
          break;
        case 5: // cacto
          fill(0, 128, 0);
          break;
      }
      rect(screenX, screenY, tileSize, tileSize);
    }
  }
}

O método `display(float offsetX, float offsetY)` é responsável por desenhar os tiles do chunk na tela. Vamos analisar o código:

1. O método usa dois loops aninhados para iterar sobre cada posição na matriz `tiles`.
2. Para cada posição, as coordenadas de tela `screenX` e `screenY` são calculadas com base nas coordenadas do chunk, na posição local do tile dentro do chunk, no tamanho do tile e no deslocamento fornecido (`offsetX` e `offsetY`).
3. Em seguida, o código verifica se o tile está dentro dos limites da tela. Se estiver fora dos limites, o loop continua para a próxima iteração usando a instrução `continue`.
4. Se o tile estiver dentro dos limites da tela, o código entra em uma instrução `switch` que determina a cor de preenchimento com base no valor do tile.
5. Dependendo do valor do tile, uma cor diferente é definida usando a função `fill()`.
6. Por fim, um retângulo preenchido com a cor selecionada é desenhado na posição `screenX`, `screenY`, com o tamanho `tileSize` x `tileSize`.


