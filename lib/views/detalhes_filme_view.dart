import 'package:flutter/material.dart';
import '../models/filme.dart';

class DetalhesFilmeView extends StatelessWidget {
  final Filme filme;

  const DetalhesFilmeView({super.key, required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(filme.titulo),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  filme.urlImagem,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const SizedBox(height: 16),
              Text('Título: ${filme.titulo}', style: const TextStyle(fontSize: 18)),
              Text('Gênero: ${filme.genero}'),
              Text('Faixa Etária: ${filme.faixaEtaria}'),
              Text('Duração: ${filme.duracao}'),
              Text('Pontuação: ${filme.pontuacao.toStringAsFixed(1)}'),
              Text('Ano: ${filme.ano}'),
              const SizedBox(height: 10),
              const Text('Descrição:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(filme.descricao),
            ],
          ),
        ),
      ),
    );
  }
}
