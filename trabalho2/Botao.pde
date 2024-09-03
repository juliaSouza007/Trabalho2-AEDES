class Botao {
  int x, y, l, h;
  color cor, corAtual;
  color sombra, sombraAtual;
  String texto;
  color corTexto, corTextoAtual;
  color corHightLight = 0, sombraHightLight = 225, corTextoHightLight = 255;
  int textoSize;
  boolean pressed;

  Botao(int x, int y, int l, int h, color cor, color sombra, String texto, color corTexto, int textoSize) {
    this.x = x;
    this.y = y;
    this.l = l;
    this.h = h;
    this.cor = cor;
    this.corAtual = cor;
    this.sombra = sombra;
    this.sombraAtual = sombra;
    this.texto = texto;
    this.corTexto = corTexto;
    this.corTextoAtual = corTexto;
    this.textoSize = textoSize;
    this.pressed = false;
  }

  void Show() {
    
    // Sombra do botao
    fill(sombraAtual);
    rect(x, y+h/4, l, h);
    rect(x+l, y+h/2, l/16, h/2);
    rect(x-l/16, y+h/2, l/16, h/2);

    // Botao
    fill(corAtual);
    rect(x, y, l, h);
    rect(x+l, y+h/4, l/16, h/2);
    rect(x-l/16, y+h/4, l/16, h/2);

    // Texto
    textFont(fonte, 50);
    fill(corTextoAtual);
    textSize(textoSize);
    text(texto, x+l/2, y+h/2+h/4);
  }

  void Selecionado() { 
    // Botao selecionado
    // Verifica se o mouse está em cima do botao
    if ((mouseX >= x && mouseX <= x+l) && (mouseY >= y && mouseY <= y+h)) {
      corAtual = corHightLight;
      sombraAtual = sombraHightLight;
      corTextoAtual = corTextoHightLight;
      
      if(mousePressed) {
        pressed = true;
      } 
    } else {
      corAtual = cor;
      sombraAtual = sombra;
      corTextoAtual = corTexto;
    }
  }
}
