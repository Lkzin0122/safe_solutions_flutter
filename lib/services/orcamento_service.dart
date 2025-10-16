import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/orcamento.dart';
import '../models/empresa.dart';

class OrcamentoService {
  static const String _baseUrl = 'http://localhost:8080/orcamento';

  // POST /orcamento/criar-solicitacao/ - Criar nova solicitação de orçamento
  static Future<Orcamento> criarSolicitacao(Orcamento orcamento) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/criar-solicitacao/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orcamento.toJson()),
      );

      if (response.statusCode == 201) {
        return Orcamento.fromJson(json.decode(response.body));
      }
      throw Exception('Erro ao criar solicitação: ${response.statusCode}');
    } catch (e) {
      print('Erro ao criar solicitação: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // GET /orcamento/getAll/{cpf} - Buscar orçamentos por CPF do usuário
  static Future<List<Orcamento>> getOrcamentosPorCpf(String cpf) async {
    try {
      final cpfLimpo = cpf.replaceAll(RegExp(r'[^0-9]'), '');
      final response = await http.get(
        Uri.parse('$_baseUrl/getAll/$cpfLimpo'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        try {
          final responseBody = response.body;
          if (responseBody.isEmpty || responseBody == '[]') {
            return [];
          }
          final List<dynamic> jsonList = json.decode(responseBody);
          return jsonList.map((json) => Orcamento.fromJson(json)).toList();
        } catch (parseError) {
          print('Erro ao fazer parse da resposta: $parseError');
          return [];
        }
      }
      throw Exception('Erro ao carregar orçamentos: ${response.statusCode}');
    } catch (e) {
      if (e.toString().contains('SocketException') || e.toString().contains('Connection')) {
        print('Erro de conexão: $e');
        throw Exception('Erro de conexão com o servidor');
      }
      print('Erro ao buscar orçamentos por CPF: $e');
      throw e;
    }
  }

  // GET /orcamento/{id} - Buscar todos os orçamentos
  static Future<List<Orcamento>> getAllOrcamentos() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/1'), // Usando endpoint com ID genérico
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Orcamento.fromJson(json)).toList();
      }
      throw Exception('Erro ao carregar orçamentos: ${response.statusCode}');
    } catch (e) {
      print('Erro ao buscar todos os orçamentos: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // Buscar orçamento específico por ID
  static Future<Orcamento> getOrcamentoPorId(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is List && responseData.isNotEmpty) {
          return Orcamento.fromJson(responseData.first);
        } else if (responseData is Map<String, dynamic>) {
          return Orcamento.fromJson(responseData);
        }
        throw Exception('Orçamento não encontrado');
      }
      throw Exception('Orçamento não encontrado: ${response.statusCode}');
    } catch (e) {
      print('Erro ao buscar orçamento por ID: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // GET /orcamento/pendentes/{cnpj} - Buscar orçamentos pendentes por CNPJ
  static Future<List<Orcamento>> getOrcamentosPendentes(String cnpj) async {
    try {
      final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
      final response = await http.get(
        Uri.parse('$_baseUrl/pendentes/$cnpjLimpo'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Orcamento.fromJson(json)).toList();
      }
      throw Exception('Erro ao carregar orçamentos pendentes: ${response.statusCode}');
    } catch (e) {
      print('Erro ao buscar orçamentos pendentes: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // GET /orcamento/andamento/{cnpj} - Buscar orçamentos em andamento por CNPJ
  static Future<List<Orcamento>> getOrcamentosEmAndamento(String cnpj) async {
    try {
      final cnpjLimpo = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
      final response = await http.get(
        Uri.parse('$_baseUrl/andamento/$cnpjLimpo'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Orcamento.fromJson(json)).toList();
      }
      throw Exception('Erro ao carregar orçamentos em andamento: ${response.statusCode}');
    } catch (e) {
      print('Erro ao buscar orçamentos em andamento: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // PUT /orcamento/Aceitar/{id} - Aceitar orçamento
  static Future<Orcamento> aceitarOrcamento(int id, AceitarOrcamentoRequest request) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/Aceitar/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return Orcamento.fromJson(json.decode(response.body));
      }
      throw Exception('Erro ao aceitar orçamento: ${response.statusCode}');
    } catch (e) {
      print('Erro ao aceitar orçamento: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // PUT /orcamento/Atualizar-Orcamento/{id} - Atualizar status do orçamento
  static Future<Orcamento> atualizarStatusOrcamento(int id) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/Atualizar-Orcamento/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return Orcamento.fromJson(json.decode(response.body));
      }
      throw Exception('Erro ao atualizar orçamento: ${response.statusCode}');
    } catch (e) {
      print('Erro ao atualizar orçamento: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // PUT /orcamento/Recusar/{id} - Recusar orçamento
  static Future<Orcamento> recusarOrcamento(int id, RecusarOrcamentoRequest request) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/Recusar/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        return Orcamento.fromJson(json.decode(response.body));
      }
      throw Exception('Erro ao recusar orçamento: ${response.statusCode}');
    } catch (e) {
      print('Erro ao recusar orçamento: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // PUT /orcamento/Finalizar/{id} - Finalizar orçamento
  static Future<Orcamento> finalizarOrcamento(int id, Empresa empresa) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/Finalizar/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(empresa.toJson()),
      );

      if (response.statusCode == 200) {
        return Orcamento.fromJson(json.decode(response.body));
      }
      throw Exception('Erro ao finalizar orçamento: ${response.statusCode}');
    } catch (e) {
      print('Erro ao finalizar orçamento: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // PUT /orcamento - Atualizar orçamento
  static Future<Orcamento> updateOrcamento(Orcamento orcamento) async {
    try {
      final response = await http.put(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orcamento.toJson()),
      );

      if (response.statusCode == 201) {
        return Orcamento.fromJson(json.decode(response.body));
      }
      throw Exception('Erro ao atualizar orçamento: ${response.statusCode}');
    } catch (e) {
      print('Erro ao atualizar orçamento: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  // DELETE /orcamento - Deletar orçamento
  static Future<bool> deleteOrcamento(Orcamento orcamento) async {
    try {
      final response = await http.delete(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(orcamento.toJson()),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Erro ao deletar orçamento: $e');
      throw Exception('Erro de conexão: $e');
    }
  }
}