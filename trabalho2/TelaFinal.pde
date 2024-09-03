void telaFinal() {
  if (restart.pressed == false && back.pressed == false) {
    noStroke();
    textAlign(CENTER);

    tela(width/2, height-100);

    restart.Show();
    restart.Selecionado();
    if (restart.pressed) {
      map.reset(x, y);
      caminho = null;
      caminhoBarco = null;
      player = new Player(x, y);
      barco = new Barco(new PVector(x, y), 30);
    }

    back.Show();
    back.Selecionado();
    if (back.pressed) {
      exit();
    }

    if (ganhou) {
      textFont(fonte, 48);
      fill(#4B240B);
      text("PARABENS", width/2, 160);

      text("Voce ganhou!!", width/2, 300);
    } else {
      textFont(fonte, 48);
      fill(#4B240B);
      text("POXA :(", width/2, 160);

      text("Perdeu parceiro.", width/2, 300);
      text("Seja mais atento", width/2, 350);
      text("da proxima!", width/2, 400);
    }
  }
}

void tela(int largura, int altura) {
  rectMode(CENTER);

  // Sombra
  fill(#AA8F45);
  rect(width/2, height/2+25, largura, altura);
  rect(width/2-largura/2, height/2+25, 50, altura-50);
  rect(width/2+largura/2, height/2+25, 50, altura-50);
  rect(width/2-largura/2, height/2+25, 100, altura-100);
  rect(width/2+largura/2, height/2+25, 100, altura-100);

  //Fundo
  fill(#FAE2A2);
  rect(width/2, height/2, largura, altura);
  rect(width/2-largura/2, height/2, 50, altura-50);
  rect(width/2+largura/2, height/2, 50, altura-50);
  rect(width/2-largura/2, height/2, 100, altura-100);
  rect(width/2+largura/2, height/2, 100, altura-100);

  rectMode(0);
}
