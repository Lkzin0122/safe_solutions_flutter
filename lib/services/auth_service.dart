import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/empresa.dart';
import '../services/profile_service.dart';

class AuthService {
  static const String _baseUrl = 'http://localhost:8080/empresa';

  static Future<Empresa> login(String cnpj, String senha) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/login/$cnpj?senha=$senha'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      final empresa = Empresa.fromJson(json.decode(response.body));
      await ProfileService.saveEmpresaData(empresa);
      await _saveLoginSession(cnpj);
      return empresa;
    } else if (response.statusCode == 401) {
      final error = json.decode(response.body);
      throw Exception(error['erro'] ?? 'CNPJ ou senha incorretos.');
    } else if (response.statusCode == 404) {
      throw Exception('Empresa não encontrada.');
    }
    throw Exception('Erro no servidor. Tente novamente.');
  }

  static Future<void> _saveLoginSession(String cnpj) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_cnpj', cnpj);
    await prefs.setBool('is_logged_in', true);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_cnpj');
    await prefs.remove('empresa_data');
    await prefs.remove('user_profile');
    await prefs.setBool('is_logged_in', false);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userCnpj = prefs.getString('user_cnpj');
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    return userCnpj != null && isLoggedIn;
  }

  static Future<bool> validarCodigo(String cnpj, String codigo) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login/validar-codigo/$cnpj'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'codigo': codigo}),
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body) == true;
    } else if (response.statusCode == 401) {
      throw Exception('Código inválido ou expirado.');
    }
    throw Exception('Erro ao validar código.');
  }

  static Future<void> reenviarCodigo(String cnpj) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login/reenviar-codigo/$cnpj'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode != 200) {
      throw Exception('Erro ao reenviar código.');
    }
  }
}