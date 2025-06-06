import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../controllers/filme_controller.dart';
import '../models/filme.dart';
import 'detalhes_filme_view.dart';
import 'editar_filme_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FilmeController _controller = FilmeController();
  List<Filme> filmes = [];

  @override
  void initState() {
    super.initState();
    carregarFilmes();
  }

  Future<void> carregarFilmes() async {
    final data = await _controller.listarFilmes();
    setState(() {
      filmes = data;
    });
  }

  Future<void> deletarFilme(int id) async {
    await _controller.deletarFilme(id);
    await carregarFilmes();
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
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              trailing: RatingBarIndicator(
                rating: filme.pontuacao,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 20.0,
                direction: Axis.horizontal,
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Wrap(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.info),
                        title: const Text('Exibir Dados'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (_) =>
                                DetalhesFilmeView(filme: filme),
                          ))
                              .then((_) {
                            carregarFilmes();
                          });
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Alterar'),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (_) =>
                                EditarFilmeView(filme: filme),
                          ))
                              .then((resultado) {
                            if (resultado == true) {
                              carregarFilmes();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
