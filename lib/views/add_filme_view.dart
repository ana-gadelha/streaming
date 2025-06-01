import 'package:flutter/material.dart';
import '../models/filme.dart';
import '../database/database_helper.dart';

class AddFilmeView extends StatefulWidget {
  const AddFilmeView({super.key});

  @override
  State<AddFilmeView> createState() => _AddFilmeViewState();
}

class _AddFilmeViewState extends State<AddFilmeView> {
  // Controllers dos campos de texto
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController generoController = TextEditingController();
  final TextEditingController faixaEtariaController = TextEditingController();
  final TextEditingController duracaoController = TextEditingController();
  final TextEditingController pontuacaoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController anoController = TextEditingController();
  final TextEditingController urlImagemController = TextEditingController();

  // Função para salvar no banco
  void salvarFilme() async {
    final filme = Filme(
      titulo: tituloController.text,
      genero: generoController.text,
      faixaEtaria: faixaEtariaController.text,
      duracao: duracaoController.text,
      pontuacao: double.tryParse(pontuacaoController.text) ?? 0.0,
      descricao: descricaoController.text,
      ano: anoController.text,
      urlImagem: urlImagemController.text,
    );

    await DatabaseHelper.instance.insertFilme(filme);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filme cadastrado com sucesso!')),
    );

    // Limpa os campos após salvar
    tituloController.clear();
    generoController.clear();
    faixaEtariaController.clear();
    duracaoController.clear();
    pontuacaoController.clear();
    descricaoController.clear();
    anoController.clear();
    urlImagemController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: tituloController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: generoController,
            decoration: const InputDecoration(labelText: 'Gênero'),
          ),
          TextField(
            controller: faixaEtariaController,
            decoration: const InputDecoration(labelText: 'Faixa Etária'),
          ),
          TextField(
            controller: duracaoController,
            decoration: const InputDecoration(labelText: 'Duração'),
          ),
          TextField(
            controller: pontuacaoController,
            decoration: const InputDecoration(labelText: 'Pontuação (0.0 até 10.0)'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: descricaoController,
            decoration: const InputDecoration(labelText: 'Descrição'),
            maxLines: 3,
          ),
          TextField(
            controller: anoController,
            decoration: const InputDecoration(labelText: 'Ano'),
          ),
          TextField(
            controller: urlImagemController,
            decoration: const InputDecoration(labelText: 'URL da Imagem'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: salvarFilme,
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
