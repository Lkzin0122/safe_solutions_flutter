import '/flutter_flow/flutter_flow_model.dart';
import '/index.dart';
import 'contratos_widget.dart' show ContratosWidget;
import 'package:flutter/material.dart';
import '../../services/orcamento_service.dart';
import '../../models/orcamento.dart';
import '../../storage/session_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContratosModel extends FlutterFlowModel<ContratosWidget> {
  bool isCompletedExpanded = false;
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  List<Orcamento> _orcamentosEmAndamento = [];
  List<Orcamento> _orcamentosFinalizados = [];

  bool _isLoading = false;
  String? _error;

  List<Orcamento> get orcamentosEmAndamento => _orcamentosEmAndamento;
  List<Orcamento> get orcamentosFinalizados => _orcamentosFinalizados;

  bool get isLoading => _isLoading;
  String? get error => _error;

  @override
  void initState(BuildContext context) {
    loadContratos(forceRefresh: true);
  }

  Future<void> loadContratos({bool forceRefresh = false}) async {
    _isLoading = true;
    _error = null;

    try {
      _orcamentosEmAndamento = [];
      _orcamentosFinalizados = [];

      String? cpf = await _getCpfUsuario();

      if (cpf != null) {
        print('CPF encontrado: $cpf');

        final orcamentos = await OrcamentoService.getOrcamentosPorCpf(cpf);

        _orcamentosEmAndamento = orcamentos.where((o) =>
          o.statusOrcamento == StatusEnum.EM_ANDAMENTO ||
          o.statusOrcamento == StatusEnum.ACEITO
        ).toList();

        _orcamentosFinalizados = orcamentos.where((o) =>
          o.statusOrcamento == StatusEnum.FINALIZADO
        ).toList();

        print('Orçamentos carregados: ${orcamentos.length}');
        print('Em andamento: ${_orcamentosEmAndamento.length}');
        print('Finalizados: ${_orcamentosFinalizados.length}');
      } else {
        _error = 'CPF do usuário não encontrado';
      }
    } catch (e) {
      _error = e.toString();
      print('Erro ao carregar orçamentos: $e');
    } finally {
      _isLoading = false;
    }
  }

  Future<String?> _getCpfUsuario() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cnpj = prefs.getString('user_cnpj');

      if (cnpj != null) {
        final response = await http.get(
          Uri.parse('https://spring-aplication.onrender.com/empresa/$cnpj'),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          final empresaData = json.decode(response.body);
          final cpf = empresaData['usuario']?['cpf'];
          if (cpf != null) {
            return cpf;
          }
        }
      }

      final userProfile = await SessionStorage.getUserProfile();
      if (userProfile?.personalCpf != null) {
        return userProfile!.personalCpf!;
      }

      return SessionStorage.userCpf;
    } catch (e) {
      print('Erro ao buscar CPF: $e');
      return null;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
  }

  List<Orcamento> get filteredOrcamentosEmAndamento {
    if (searchQuery.isEmpty) {
      return _orcamentosEmAndamento;
    }
    return _orcamentosEmAndamento.where((orcamento) =>
      (orcamento.servico?.nomeServico?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false) ||
      (orcamento.servico?.descricaoServico?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
    ).toList();
  }

  List<Orcamento> get filteredOrcamentosFinalizados {
    if (searchQuery.isEmpty) {
      return _orcamentosFinalizados;
    }
    return _orcamentosFinalizados.where((orcamento) =>
      (orcamento.servico?.nomeServico?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false) ||
      (orcamento.servico?.descricaoServico?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
    ).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
  }
}
