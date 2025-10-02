import 'dart:convert';
import 'package:http/http.dart' as http;
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
      return empresa;
    } else if (response.statusCode == 401) {
      final error = json.decode(response.body);
      throw Exception(error['erro'] ?? 'CNPJ ou senha incorretos.');
    } else if (response.statusCode == 404) {
      throw Exception('Empresa não encontrada.');
    }
    throw Exception('Erro no servidor. Tente novamente.');
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