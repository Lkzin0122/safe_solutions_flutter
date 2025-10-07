import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/empresa.dart';

class EmpresaService {
  static const String _baseUrl = 'http://localhost:8080/empresa';

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
    throw Exception('Empresa não encontrada');
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