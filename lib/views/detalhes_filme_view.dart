import 'package:flutter/material.dart';
import '../models/filme.dart';

class DetalhesFilmeView extends StatelessWidget {
  final Filme filme;

  const DetalhesFilmeView({super.key, required this.filme});

  // Função auxiliar para criar a linha de estrelas de avaliações
  Widget _buildRatingStars(double pontuacao) {
    print('--- DENTRO DE _buildRatingStars ---');
    print('Recebido pontuacao: $pontuacao');
    if (pontuacao.isNaN || pontuacao < 0) { // Proteção básica
      print('Pontuação inválida, retornando estrelas vazias.');
      // Retorna 5 estrelas vazias se a pontuação for inválida
      return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (i) => Icon(Icons.star_border, color: Colors.grey, size: 20))
      );
    }
    int numeroDeEstrelasCheias = pontuacao.round();
    print('Calculado numeroDeEstrelasCheias: $numeroDeEstrelasCheias');
    print('---------------------------------');

    List<Widget> stars = [];

    for (int i = 0; i < 5; i++) {
      if (i < numeroDeEstrelasCheias) {
        stars.add(Icon(Icons.star, color: Colors.amber[700], size: 20));
      } else {
        stars.add(Icon(Icons.star_border, color: Colors.amber[700], size: 20));
      }
      // Adiciona um pequeno espaço entre as estrelas, exceto para a última
      if (i < 4) {
        stars.add(const SizedBox(width: 2.0));
      }
    }
    return Row(mainAxisSize: MainAxisSize.min, children: stars); // mainAxisSize.min para não ocupar espaço desnecessário
  }

  @override
  Widget build(BuildContext context) {
    // Adicione os prints aqui como pedi na mensagem anterior para depuração:
    print('--- DADOS DO FILME (Build Method) ---');
    print('Título: ${filme.titulo}');
    print('Pontuação Original (filme.pontuacao): ${filme.pontuacao}');
    print('------------------------------------');

    return Scaffold(
      appBar: AppBar(
        title: Text(filme.titulo), //Mantém o título de acordo com o código original
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView( //Se o conteúdo for extenso essa função permite a rolagem da tela
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Faz os filhos da Column esticarem na largura
          children: [
            // 1. Imagem Centralizada
            Center(
              child: Image.network(
                filme.urlImagem,
                height: 280, // ajuste da imagem se for necessário
                fit: BoxFit.contain, // BoxFit.contain para mostrar a imagem inteira
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 280,
                  // Define uma largura para o placeholder caso a imagem não carregue
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      Icons.movie_creation_outlined,
                      color: Colors.grey[400],
                      size: 60,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24), // Espaçamento após a imagem

            // 2. Linha de Detalhes: (Título, Gênero, Duração) à esquerda, (Ano, Faixa Etária, Pontuação) à direita
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Alinha o conteúdo no topo de cada coluna
              children: [
                // Coluna da Esquerda
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alinha os textos à esquerda dentro da coluna
                    children: [
                      Text(
                        filme.titulo,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        filme.genero,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        filme.duracao,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54
                        ),
                      ),
                    ],  //children
                  ),
                ),
                const SizedBox(width: 16), // Espaçamento entre as colunas

                // Coluna da Direita
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end, // Alinha os textos à direita
                    children: [
                      Text(
                        filme.ano.toString(),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        filme.faixaEtaria,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54
                        ),
                      ),
                      const SizedBox(height: 6),
                      
                      _buildRatingStars(filme.pontuacao)

                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24), // Espaçamento antes da descrição

            // 3. Descrição Centralizada
            Text(
              filme.descricao,
              textAlign: TextAlign.left, // Centraliza o texto da descrição
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}