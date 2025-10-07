import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/empresa.dart';

class EmpresaService {
  static const String _baseUrl = 'http://localhost:8080/empresa';

  static Future<Map<String, dynamic>?> getEmpresaData() async {
    final prefs = await SharedPreferences.getInstance();
    final empresaDataString = prefs.getString('empresa_data');
    
    if (empresaDataString != null) {
      return json.decode(empresaDataString);
    }
    return null;
  }

  static Future<String?> getCnpj() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_cnpj');
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // GET /empresa/{cnpj} - Get company by CNPJ
  static Future<Empresa> getEmpresa(String cnpj) async {
    final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    
    final response = await http.get(
      Uri.parse('$_baseUrl/$cnpjLimpo'),
      headers: {'Content-Type': 'application/json'},
    );
    
    if (response.statusCode == 200) {
      return Empresa.fromJson(json.decode(response.body));
    }
    throw Exception('Erro ao carregar dados da empresa');
  }

  // PUT /empresa/{cnpj} - Update company
  static Future<Empresa> updateEmpresa(String cnpj, Empresa empresa) async {
    final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    
    final response = await http.put(
      Uri.parse('$_baseUrl/$cnpjLimpo'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(empresa.toJson()),
    );
    
    if (response.statusCode == 200) {
      return Empresa.fromJson(json.decode(response.body));
    }
    throw Exception('Erro ao atualizar empresa');
  }
}