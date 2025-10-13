import 'package:http/http.dart' as http;
import 'dart:convert';

class RecuperacaoSenhaService {
  static const String baseUrl = 'http://localhost:8080/usuario';

  static Future<Map<String, dynamic>> validarEmailUsuario(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/validar-email-usuario?email=$email'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Email de recuperação enviado!'};
      } else {
        return {'success': false, 'message': 'Email não encontrado'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Erro de conexão'};
    }
  }

  static Future<Map<String, dynamic>> validarToken(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/validar-token?token=$token'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Token válido'};
      } else {
        return {'success': false, 'message': 'Token expirado'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Erro de conexão'};
    }
  }

  static Future<Map<String, dynamic>> atualizarSenha(String email, String novaSenha) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$email/senha'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'novaSenha': novaSenha}),
      );
      
      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Senha atualizada!'};
      } else {
        return {'success': false, 'message': 'Erro ao atualizar senha'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Erro de conexão'};
    }
  }
}