import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/filme.dart';

class DatabaseHelper {
  // Singleton: só uma instância do banco no app inteiro
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // Nome do banco
  static const String _dbName = 'filmes.db';
  static const int _dbVersion = 1;
  static const String _tableName = 'filmes';

  // Abrir ou criar o banco
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(_dbName);
    return _database!;
  }

  // Caminho onde o banco será salvo
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _createDB,
    );
  }

  // Criar a tabela no banco
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        genero TEXT NOT NULL,
        faixaEtaria TEXT NOT NULL,
        duracao TEXT NOT NULL,
        pontuacao REAL NOT NULL,
        descricao TEXT NOT NULL,
        ano TEXT NOT NULL,
        urlImagem TEXT NOT NULL
      )
    ''');
  }

  // 🔹 Inserir um filme
  Future<int> insertFilme(Filme filme) async {
    final db = await instance.database;
    return await db.insert(_tableName, filme.toMap());
  }

  // 🔹 Listar todos os filmes
  Future<List<Filme>> getFilmes() async {
    final db = await instance.database;
    final result = await db.query(_tableName);
    return result.map((map) => Filme.fromMap(map)).toList();
  }

  // 🔹 Atualizar um filme
  Future<int> updateFilme(Filme filme) async {
    final db = await instance.database;
    return await db.update(
      _tableName,
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }

  // 🔹 Deletar um filme
  Future<int> deleteFilme(int id) async {
    final db = await instance.database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 🔹 Fechar o banco quando não estiver mais usando
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
