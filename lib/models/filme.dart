class Filme {
  int? id;
  String titulo;
  String genero;
  String faixaEtaria;
  String duracao;
  double pontuacao;
  String descricao;
  String ano;
  String urlImagem;

  Filme({
    this.id,
    required this.titulo,
    required this.genero,
    required this.faixaEtaria,
    required this.duracao,
    required this.pontuacao,
    required this.descricao,
    required this.ano,
    required this.urlImagem,
  });

  // Converter Filme para Map (para salvar no banco)
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'titulo': titulo,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'descricao': descricao,
      'ano': ano,
      'urlImagem': urlImagem,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Converter Map para Filme (ao ler do banco)
  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map['id'],
      titulo: map['titulo'],
      genero: map['genero'],
      faixaEtaria: map['faixaEtaria'],
      duracao: map['duracao'],
      pontuacao: map['pontuacao'],
      descricao: map['descricao'],
      ano: map['ano'],
      urlImagem: map['urlImagem'],
    );
  }
}
