import '../models/filme.dart';
import '../service/filme_service.dart';

class FilmeController {
  final FilmeService _filmeService = FilmeService();

  Future<List<Filme>> listarFilmes() async {
    return await _filmeService.listarFilmes();
  }

  Future<void> adicionarFilme(Filme filme) async {
    await _filmeService.adicionarFilme(filme);
  }

  Future<void> atualizarFilme(Filme filme) async {
    await _filmeService.atualizarFilme(filme);
  }

  Future<void> deletarFilme(int id) async {
    await _filmeService.deletarFilme(id);
  }
}
