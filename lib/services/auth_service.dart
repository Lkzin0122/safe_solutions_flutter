import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/empresa.dart';
import '../services/profile_service.dart';

class AuthService {
  static const String _baseUrl = 'http://localhost:8080/empresa'; // Para emulador Android

  static Future<Empresa> login(String cnpj, String senha) async {
    try {
      final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
      print('=== LOGIN DEBUG FLUTTER ===');
      print('CNPJ original: $cnpj');
      print('CNPJ limpo: $cnpjLimpo');
      print('Senha: $senha');
      print('URL: $_baseUrl/login/$cnpjLimpo?senha=$senha');
      
      final response = await http.get(
        Uri.parse('$_baseUrl/login/$cnpjLimpo?senha=$senha'),
        headers: {'Content-Type': 'application/json'},
      );
      
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      
      if (response.statusCode == 200) {
        final empresa = Empresa.fromJson(json.decode(response.body));
        await ProfileService.saveEmpresaData(empresa);
        await _saveLoginSession(cnpjLimpo);
        return empresa;
      } else if (response.statusCode == 401) {
        try {
          final error = json.decode(response.body);
          throw Exception(error['erro'] ?? 'CNPJ ou senha incorretos.');
        } catch (e) {
          throw Exception('CNPJ ou senha incorretos.');
        }
      } else if (response.statusCode == 404) {
        throw Exception('Empresa não encontrada.');
      } else {
        throw Exception('Erro no servidor (${response.statusCode}). Tente novamente.');
      }
    } catch (e) {
      print('Erro no login: $e');
      if (e.toString().contains('Exception:')) {
        rethrow;
      }
      throw Exception('Erro de conexão. Verifique sua internet.');
    }
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
    final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    final response = await http.post(
      Uri.parse('$_baseUrl/login/validar-codigo/$cnpjLimpo'),
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
    final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    final response = await http.post(
      Uri.parse('$_baseUrl/login/reenviar-codigo/$cnpjLimpo'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode != 200) {
      throw Exception('Erro ao reenviar código.');
    }
  }
}