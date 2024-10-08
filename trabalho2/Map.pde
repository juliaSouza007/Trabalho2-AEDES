import java.util.ArrayList; 

class Map {
  int chunkSize, tileSize;
  float offsetX, offsetY;
  HashMap<String, Chunk> chunks;
  ArrayList<Stone> stones;
  int stoneDistance = 5;

  Map(int chunkSize, int tileSize, PVector playerPosicao, int maxDist) {
    this.chunkSize = chunkSize;
    this.tileSize = tileSize;
    this.offsetX = 0;
    this.offsetY = 0;
    this.chunks = new HashMap<String, Chunk>();
    
    this.stones = new ArrayList<Stone>();
    generateStones(playerPosicao, maxDist);
  }

  void display() {
    //noStroke();
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

    for (Stone stone : stones) {
      stone.display();
    }
  }

  void drag(float _offsetX, float _offsetY) {
    offsetX += _offsetX;
    offsetY += _offsetY;
  }

  void reset() {
      offsetX = -width / 2;
      offsetY = -height / 2;
  }
  
  void reset(int gridX, int gridY) {
        offsetX = width / 2 - gridX * tileSize;
        offsetY = height / 2 - gridY * tileSize;
  }
  
  void setOffset(float newOffsetX, float newOffsetY) {
    offsetX = newOffsetX;
    offsetY = newOffsetY;
  }
  
  void generateStones(PVector playerPosicao, int maxDist) {
  // Gera pedras verdadeiras
  for (int i = 0; i < 5; i++) {
    stones.add(new Stone(playerPosicao, maxDist, true));
  }

  // Gera pedras falsas
  for (int i = 0; i < 5; i++) {
    stones.add(new Stone(playerPosicao, maxDist, false));
  }
}
  
  int gridPosX(int xScreen){
    return floor((-offsetX + xScreen) / tileSize);
  }
  
  int gridPosY(int yScreen){
    return floor((-offsetY + yScreen) / tileSize);
  }
  
  int screenPosX(int gridX) {
    return (gridX * tileSize + (int)offsetX) + tileSize/2;
  }
  
  int screenPosY(int gridY) {
    return (gridY * tileSize + (int)offsetY) + tileSize/2;
  }
  
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
}
