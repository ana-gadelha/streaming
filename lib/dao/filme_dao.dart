import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/filme.dart';

class FilmeDao {
  static const String _nomeTabela = 'filmes';

  // Inicializa o banco de dados
  Future<Database> _getDatabase() async {
    final caminho = await getDatabasesPath();
    final caminhoBanco = join(caminho, 'filmes.db');

    return openDatabase(
      caminhoBanco,
      version: 1,
      onCreate: (db, versao) {
        return db.execute('''
          CREATE TABLE $_nomeTabela (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            genero TEXT,
            faixaEtaria TEXT,
            duracao TEXT,
            pontuacao REAL,
            descricao TEXT,
            ano TEXT,
            urlImagem TEXT
          )
        ''');
      },
    );
  }

  // Inserir filme
  Future<int> inserirFilme(Filme filme) async {
    final db = await _getDatabase();
    return await db.insert(_nomeTabela, filme.toMap());
  }

  // Buscar todos os filmes
  Future<List<Filme>> listarFilmes() async {
    final db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_nomeTabela);

    return List.generate(maps.length, (i) {
      return Filme.fromMap(maps[i]);
    });
  }

  // Atualizar filme
  Future<int> atualizarFilme(Filme filme) async {
    final db = await _getDatabase();
    return await db.update(
      _nomeTabela,
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }

  // Deletar filme
  Future<int> deletarFilme(int id) async {
    final db = await _getDatabase();
    return await db.delete(
      _nomeTabela,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
