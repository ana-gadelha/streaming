import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../models/filme.dart';
import '../database/database_helper.dart';


class AddFilmeView extends StatefulWidget {
  const AddFilmeView({super.key});

  @override
  State<AddFilmeView> createState() => _AddFilmeViewState();
}

class _AddFilmeViewState extends State<AddFilmeView> {
  final _formKey = GlobalKey<FormState>();
  // Controllers dos campos de texto
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController generoController = TextEditingController();
  final TextEditingController faixaEtariaController = TextEditingController();
  final TextEditingController duracaoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController anoController = TextEditingController();
  final TextEditingController urlImagemController = TextEditingController();

  String? faixaSelecionada;
  double _pontuacaoSelecionada = 0.0;

  // Função para salvar no banco
  void salvarFilme() async {
    final filme = Filme(
      titulo: tituloController.text,
      genero: generoController.text,
      faixaEtaria: faixaSelecionada ?? '',
      duracao: duracaoController.text,
      pontuacao: _pontuacaoSelecionada,
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
    descricaoController.clear();
    anoController.clear();
    urlImagemController.clear();

    setState(() {
      _pontuacaoSelecionada = 0.0;
      faixaSelecionada = null;
    }); // Atualiza a tela para refletir a nova lista de filmes.
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey, //formulário com validação
        child: Column(
          children: [
            TextFormField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Informe o título' : null,
            ),
            TextFormField(
              controller: generoController,
              decoration: const InputDecoration(labelText: 'Gênero'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Informe o gênero' : null,
            ),
            DropdownButtonFormField<String>(
              value: faixaSelecionada,
              onChanged: (value) {
                setState(() {
                  faixaSelecionada = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Selecione a faixa etária' : null,
              items: const ['Livre','10 anos', '12 anos', '16 anos', '18 anos']
                .map((faixa) => DropdownMenuItem(
                  value: faixa,
                  child: Text(faixa),
                )).toList(),
              decoration: const InputDecoration(labelText: 'Faixa Etária'),
            ),
            TextFormField(
              controller: duracaoController,
              decoration: const InputDecoration(labelText: 'Duração (Ex: 1h e 40m)'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Informe quanto tempo tem o filme' : null,
            ),
            const SizedBox(height: 10),
            const Text('Pontuação (de 0 a 5 estrelas):'),
            SmoothStarRating(
              allowHalfRating: true,
              onRatingChanged: (value) {
                setState(() {
                  _pontuacaoSelecionada = value;
                });
              },
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
              validator: (value) =>
                  value == null || value.isEmpty ? 'Informe a descrição' : null,
            ),
            TextFormField(
              controller: anoController,
              decoration: const InputDecoration(labelText: 'Ano'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Informe o ano' : null,
            ),
            TextFormField(
              controller: urlImagemController,
              decoration: const InputDecoration(labelText: 'URL da Imagem'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Informe a URL da imagem' : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  salvarFilme();
                }
              },
            child: const Text('Salvar'),
            ),
          ],
        ),
      )
    );
  }
}
