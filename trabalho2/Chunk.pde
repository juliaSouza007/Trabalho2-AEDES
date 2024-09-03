class Chunk {
  int chunkX, chunkY;
  int[][] tiles;

  Chunk(int x, int y) {
    chunkX = x;
    chunkY = y;
    tiles = new int[chunkSize / tileSize][chunkSize / tileSize];
    generateChunk();
  }

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
  
  int getTile(int localX, int localY) {
    if (localX >= 0 && localX < tiles.length && localY >= 0 && localY < tiles[0].length) {
      return tiles[localX][localY];
    } else {
      return -1;
    }
  }

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
            fill(#79BCF5);
            break;
          case 1: // grama
            fill(#3FC636);
            break;
          case 2: // areia
            fill(#FAEEB1);
            break;
          case 3: // coral
            fill(#E1B1FA);
            break;
          case 4: // pedra
            fill(#7E858B);
            break;
          case 5: // cacto
            fill(#34D315);
            break;
        }

        rect(screenX, screenY, tileSize, tileSize);
      }
    }
  }
}
