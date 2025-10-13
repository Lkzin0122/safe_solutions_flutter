import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class UsuarioService {
  static const String _baseUrl = 'http://10.0.2.2:8080/usuario'; // Para emulador Android

  // GET /usuario/email/{email} - Get user by email
  static Future<Usuario> getUsuarioByEmail(String email) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/email/$email'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      return Usuario.fromJson(json.decode(response.body));
    }
    throw Exception('Usuário não encontrado');
  }

  // PUT /usuario/{cpf} - Update user
  static Future<Usuario> updateUsuario(String cpf, Usuario usuario) async {
    // Clean CPF for URL
    final cpfLimpo = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    
    final response = await http.put(
      Uri.parse('$_baseUrl/$cpfLimpo'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario.toJson()),
    );
    
    if (response.statusCode == 200) {
      return Usuario.fromJson(json.decode(response.body));
    }
    throw Exception('Erro no servidor. Tente novamente.');
  }

  // POST /usuario/auth/solicitar-ativacao-email - Request email activation
  static Future<bool> solicitarAtivacaoEmail(String email) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/solicitar-ativacao-email'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body) == true;
    }
    throw Exception('Erro ao solicitar ativação de email');
  }

  // POST /usuario/auth/ativar-email - Activate email
  static Future<bool> ativarEmail(String email, String codigo) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/ativar-email'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'email_code': codigo}),
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body) == true;
    }
    throw Exception('Código inválido ou expirado');
  }
}