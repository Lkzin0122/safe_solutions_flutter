import 'package:dio/dio.dart';
import '../models/usuario.dart';

class UsuarioService {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:8080/usuario'));

  Future<Usuario?> buscarPorEmail(String email) async {
    try {
      final response = await dio.get('/email/$email');
      if (response.statusCode == 200) {
        return Usuario.fromJson(response.data);
      }
    } catch (e) {
      print('Erro ao buscar usuário: $e');
    }
    return null;
  }

  Future<Usuario?> buscarPorCpf(String cpf) async {
    try {
      final response = await dio.get('/cpf/$cpf');
      if (response.statusCode == 200) {
        return Usuario.fromJson(response.data);
      }
    } catch (e) {
      print('Erro ao buscar usuário: $e');
    }
    return null;
  }

  Future<bool> atualizarUsuario(String cpf, Usuario usuario) async {
    try {
      final response = await dio.put('/$cpf', data: usuario.toJson());
      return response.statusCode == 200;
    } catch (e) {
      print('Erro ao atualizar usuário: $e');
      return false;
    }
  }
}