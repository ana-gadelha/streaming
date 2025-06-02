import 'package:flutter/material.dart';
import 'add_filme_view.dart';
import 'home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0; // 0 = Listagem | 1 = Cadastro

  final List<Widget> pages = const [
    HomeView(),
    AddFilmeView(),
  ];

  final List<String> titles = const [
    'Filmes',
    'Cadastrar Filme',
  ];

  // 🔥 Função para mostrar o AlertDialog com os nomes da equipe
  void _showEquipeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Equipe'),
        content: const Text('Ana Maria\nLeonardo Vilar\nPaulo Lacerda'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showEquipeDialog,
          ),
        ],
      ),
      body: pages[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Alterna entre Home e Cadastro
            currentIndex = currentIndex == 0 ? 1 : 0;
          });
        },
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        child: Icon(
          currentIndex == 0 ? Icons.add : Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
