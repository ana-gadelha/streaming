import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../models/filme.dart';
import '../database/database_helper.dart';

class EditarFilmeView extends StatefulWidget {
  final Filme filme;

  const EditarFilmeView({super.key, required this.filme});

  @override
  State<EditarFilmeView> createState() => _EditarFilmeViewState();
}

class _EditarFilmeViewState extends State<EditarFilmeView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController tituloController;
  late TextEditingController generoController;
  late TextEditingController duracaoController;
  late TextEditingController descricaoController;
  late TextEditingController anoController;
  late TextEditingController urlImagemController;

  String? faixaSelecionada;
  double _pontuacaoSelecionada = 0.0;

  @override
  void initState() {
    super.initState();
    final filme = widget.filme;
    tituloController = TextEditingController(text: filme.titulo);
    generoController = TextEditingController(text: filme.genero);
    faixaSelecionada = filme.faixaEtaria;
    duracaoController = TextEditingController(text: filme.duracao);
    _pontuacaoSelecionada = filme.pontuacao;
    descricaoController = TextEditingController(text: filme.descricao);
    anoController = TextEditingController(text: filme.ano);
    urlImagemController = TextEditingController(text: filme.urlImagem);
  }

  void atualizarFilme() async {
    final filmeAtualizado = Filme(
      id: widget.filme.id,
      titulo: tituloController.text,
      genero: generoController.text,
      faixaEtaria: faixaSelecionada ?? '',
      duracao: duracaoController.text,
      pontuacao: _pontuacaoSelecionada,
      descricao: descricaoController.text,
      ano: anoController.text,
      urlImagem: urlImagemController.text,
    );

    await DatabaseHelper.instance.updateFilme(filmeAtualizado);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Filme atualizado com sucesso!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Filme'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o título' : null,
              ),
              TextFormField(
                controller: generoController,
                decoration: const InputDecoration(labelText: 'Gênero'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o gênero' : null,
              ),
              DropdownButtonFormField<String>(
                value: faixaSelecionada,
                onChanged: (value) => setState(() => faixaSelecionada = value),
                validator: (value) => value == null ? 'Selecione a faixa etária' : null,
                items: const ['Livre', '10 anos', '12 anos', '16 anos', '18 anos']
                    .map((faixa) => DropdownMenuItem(value: faixa, child: Text(faixa)))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Faixa Etária'),
              ),
              TextFormField(
                controller: duracaoController,
                decoration: const InputDecoration(labelText: 'Duração'),
                validator: (value) => value == null || value.isEmpty ? 'Informe a duração' : null,
              ),
              const SizedBox(height: 10),
              const Text('Pontuação:'),
              SmoothStarRating(
                allowHalfRating: true,
                onRatingChanged: (value) => setState(() => _pontuacaoSelecionada = value),
                starCount: 5,
                rating: _pontuacaoSelecionada,
                size: 40.0,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.star_half,
                defaultIconData: Icons.star_border,
                color: Colors.amber,
                borderColor: Colors.grey,
                spacing: 0.0,
              ),
              TextFormField(
                controller: descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Informe a descrição' : null,
              ),
              TextFormField(
                controller: anoController,
                decoration: const InputDecoration(labelText: 'Ano'),
                validator: (value) => value == null || value.isEmpty ? 'Informe o ano' : null,
              ),
              TextFormField(
                controller: urlImagemController,
                decoration: const InputDecoration(labelText: 'URL da Imagem'),
                validator: (value) => value == null || value.isEmpty ? 'Informe a URL' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    atualizarFilme();
                  }
                },
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
