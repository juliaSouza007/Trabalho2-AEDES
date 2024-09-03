void telaInicial () {
  noStroke();

  tela(width/2, height-100);

  play.Show();
  play.Selecionado();

  exit.Show();
  exit.Selecionado();

  // Texto
  textFont(fonte, 70);
  fill(#4B240B);
  textAlign(CENTER);
  text("TETRA", width/2, 150);
  text("TACTICS", width/2, 220);
  
  textFont(fonte, 20);
  fill(#4B240B);
  textAlign(CENTER);
  text("OBJETIVO:", width/2, 300);
  text("Pegar as 5 pedras verdadeiras (roxas),", width/2, 330);
  text("sem pegar nenhuma pedra falsa (pretas)", width/2, 350);
  
  text("REGRAS:", width/2, 400);
  text("- Player se move pelo caminho mais curto", width/2, 430);
  text("( cuidado com pedras falsas pelo caminho... )", width/2, 450);
  text("- Basta clicar no lugar que o player se move", width/2, 470);
  text("- Ao clicar 'p' o jogo eh centralizado no jogador", width/2, 490);
  text("- O mapa eh infinito!", width/2, 510);
  
  textFont(fonte, 25);
  fill(#4B240B);
  textAlign(CENTER);
  text("QUE TACTICS ESTEJA COM VOCE!", width/2, 580);
}
