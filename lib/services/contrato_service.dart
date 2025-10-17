import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/orcamento.dart';

class ContratoService {
  static const String _baseUrl = 'https://spring-aplication.onrender.com/contratos';

  static Future<List<Orcamento>> getContratosFinalizados(String cpf) async {
    try {
      final cpfLimpo = cpf.replaceAll(RegExp(r'[^0-9]'), '');
      final response = await http.get(
        Uri.parse('$_baseUrl/finalizados/$cpfLimpo'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Orcamento.fromJson(json)).toList();
      }
      throw Exception('Erro ao carregar contratos finalizados: ${response.statusCode}');
    } catch (e) {
      print('Erro ao buscar contratos finalizados: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  static Future<List<Orcamento>> getContratosEmAndamento(String cpf) async {
    try {
      final cpfLimpo = cpf.replaceAll(RegExp(r'[^0-9]'), '');
      final response = await http.get(
        Uri.parse('$_baseUrl/em-andamento/$cpfLimpo'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Orcamento.fromJson(json)).toList();
      }
      throw Exception('Erro ao carregar contratos em andamento: ${response.statusCode}');
    } catch (e) {
      print('Erro ao buscar contratos em andamento: $e');
      throw Exception('Erro de conexão: $e');
    }
  }

  static Future<List<Orcamento>> getContratosAceitos(String cpf) async {
    try {
      final cpfLimpo = cpf.replaceAll(RegExp(r'[^0-9]'), '');
      final response = await http.get(
        Uri.parse('$_baseUrl/aceitos/$cpfLimpo'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Orcamento.fromJson(json)).toList();
      }
      throw Exception('Erro ao carregar contratos aceitos: ${response.statusCode}');
    } catch (e) {
      print('Erro ao buscar contratos aceitos: $e');
      throw Exception('Erro de conexão: $e');
    }
  }
}