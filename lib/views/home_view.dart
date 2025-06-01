import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/filme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Filme> filmes = [];

  @override
  void initState() {
    super.initState();
    carregarFilmes();
  }

  Future<void> carregarFilmes() async {
    final data = await DatabaseHelper.instance.getFilmes();
    setState(() {
      filmes = data;
    });
  }

  Future<void> deletarFilme(int id) async {
    await DatabaseHelper.instance.deleteFilme(id);
    carregarFilmes();
  }

  @override
  Widget build(BuildContext context) {
    return filmes.isEmpty
        ? const Center(child: Text('Nenhum filme cadastrado'))
        : ListView.builder(
      itemCount: filmes.length,
      itemBuilder: (context, index) {
        final filme = filmes[index];
        return Dismissible(
          key: Key(filme.id.toString()),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            deletarFilme(filme.id!);
          },
          child: Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Image.network(
                filme.urlImagem,
                width: 50,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image),
              ),
              title: Text(filme.titulo),
              subtitle: Text('${filme.ano} • ${filme.genero}'),
              trailing: Text('${filme.pontuacao} ⭐'),
            ),
          ),
        );
      },
    );
  }
}
