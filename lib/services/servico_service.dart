import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/servico.dart';

class ServicoService {
  static const String _baseUrl = 'http://localhost:8080/servico';
  
  // Método para testar conectividade
  static Future<bool> testarConectividade() async {
    try {
      print('Testando conectividade com: $_baseUrl');
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 10));
      
      print('Status da resposta: ${response.statusCode}');
      print('Corpo da resposta: ${response.body}');
      
      return response.statusCode == 200;
    } catch (e) {
      print('Erro de conectividade: $e');
      return false;
    }
  }

  // GET /servico/listar - Get all active services
  static Future<List<Servico>> getServicosAtivos() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/listar'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Servico.fromJson(json)).toList();
      }
      throw Exception('Erro ao carregar serviços: ${response.statusCode}');
    } catch (e) {
      print('Erro ao buscar serviços: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // GET /servico - Get all services
  static Future<List<Servico>> getAllServicos() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Servico.fromJson(json)).toList();
      }
      throw Exception('Erro ao carregar serviços: ${response.statusCode}');
    } catch (e) {
      print('Erro ao buscar todos os serviços: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // GET /servico/{id} - Get service by ID
  static Future<Servico> getServicoById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        return Servico.fromJson(json.decode(response.body));
      }
      throw Exception('Serviço não encontrado');
    } catch (e) {
      print('Erro ao buscar serviço por ID: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // POST /servico/filtrar - Filter services
  static Future<List<Servico>> filtrarServicos(Filtros filtros) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/filtrar'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(filtros.toJson()),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Servico.fromJson(json)).toList();
      }
      throw Exception('Erro ao filtrar serviços: ${response.statusCode}');
    } catch (e) {
      print('Erro ao filtrar serviços: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // GET /servico/empresa/{cnpj} - Get services by company
  static Future<List<Servico>> getServicosByEmpresa(String cnpj) async {
    try {
      final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
      final response = await http.get(
        Uri.parse('$_baseUrl/empresa/$cnpjLimpo'),
        headers: {'Content-Type': 'application/json'},
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Servico.fromJson(json)).toList();
      }
      throw Exception('Erro ao carregar serviços da empresa: ${response.statusCode}');
    } catch (e) {
      print('Erro ao buscar serviços da empresa: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // POST /servico - Create service
  static Future<Servico> createServico(Servico servico, String cnpjEmpresa) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl?cnpjEmpresa=$cnpjEmpresa'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(servico.toJson()),
      );
      
      if (response.statusCode == 200) {
        return Servico.fromJson(json.decode(response.body));
      }
      throw Exception('Erro ao criar serviço: ${response.statusCode}');
    } catch (e) {
      print('Erro ao criar serviço: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // PUT /servico/{id} - Update service
  static Future<Servico> updateServico(int id, Servico servico) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(servico.toJson()),
      );
      
      if (response.statusCode == 200) {
        return Servico.fromJson(json.decode(response.body));
      }
      throw Exception('Erro ao atualizar serviço: ${response.statusCode}');
    } catch (e) {
      print('Erro ao atualizar serviço: $e');
      throw Exception('Erro de conexão: $e');
    }
  }
}