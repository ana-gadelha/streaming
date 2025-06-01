import '../dao/filme_dao.dart';
import '../models/filme.dart';

class FilmeService {
  final FilmeDao _filmeDao = FilmeDao();

  // Adicionar filme
  Future<void> adicionarFilme(Filme filme) async {
    await _filmeDao.inserirFilme(filme);
  }

  // Listar filmes
  Future<List<Filme>> listarFilmes() async {
    return await _filmeDao.listarFilmes();
  }

  // Atualizar filme
  Future<void> atualizarFilme(Filme filme) async {
    await _filmeDao.atualizarFilme(filme);
  }

  // Deletar filme
  Future<void> deletarFilme(int id) async {
    await _filmeDao.deletarFilme(id);
  }
}
