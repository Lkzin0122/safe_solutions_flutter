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



class CompletedService {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final String completedDate;
  final double rating;

  CompletedService({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.completedDate,
    this.rating = 5.0,
  });

  static CompletedService fromServicoModel(dynamic servico) {
    return CompletedService(
      id: servico.id ?? '0',
      title: servico.nome ?? 'Serviço',
      description: servico.descricao ?? 'Descrição não disponível',
      icon: Icons.check_circle,
      completedDate: DateTime.now().toString().substring(0, 10),
    );
  }
}



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
  
  bool get showMontador => searchQuery.isEmpty || 'O Montador'.toLowerCase().contains(searchQuery.toLowerCase()) || 'montagem móveis'.toLowerCase().contains(searchQuery.toLowerCase());
  bool get showSuperClean => searchQuery.isEmpty || 'Super Clean'.toLowerCase().contains(searchQuery.toLowerCase()) || 'limpeza profissional'.toLowerCase().contains(searchQuery.toLowerCase());
  bool get showBratecno => searchQuery.isEmpty || 'Bratecno'.toLowerCase().contains(searchQuery.toLowerCase()) || 'manutenção hardware'.toLowerCase().contains(searchQuery.toLowerCase());
  
  int get activeServicesCount {
    int count = 0;
    if (!isServiceCompleted('montador') && showMontador) count++;
    if (!isServiceCompleted('super_clean') && showSuperClean) count++;
    if (!isServiceCompleted('bratecno') && showBratecno) count++;
    return count;
  }
  
  static Set<String> completedServiceIds = {};
  
 

  
  static void completeService(String serviceId, String completedDate) {
    completedServiceIds.add(serviceId);
    
    String title, description;
    IconData icon;
    
    switch (serviceId) {
      case 'montador':
        title = 'O Montador';
        description = 'Montagem de três móveis planejados de escritório concluída com sucesso.';
        icon = Icons.build;
        break;
      case 'super_clean':
        title = 'Super Clean';
        description = 'Limpeza profissional de espaço comercial concluída com excelência.';
        icon = Icons.cleaning_services;
        break;
      case 'bratecno':
        title = 'Bratecno';
        description = 'Manutenção de hardware realizada com sucesso, garantindo desempenho ideal.';
        icon = Icons.computer;
        break;
      default:
        title = 'Serviço';
        description = 'Serviço concluído com sucesso.';
        icon = Icons.check_circle;
    }
    
    final completedService = CompletedService(
      id: serviceId,
      title: title,
      description: description,
      icon: icon,
      completedDate: completedDate,
    );
    
    
  }
  
  static bool isServiceCompleted(String serviceId) {
    return completedServiceIds.contains(serviceId);
  }

  @override
  void initState(BuildContext context) {
    loadContratos();
  }
  
  Future<void> loadContratos() async {
    _isLoading = true;
    _error = null;
    
    try {
      _orcamentosEmAndamento = [];

      String? cpf = await _getCpfUsuario();
      
      if (cpf != null) {
        print('CPF encontrado: $cpf');
        
        // Carregar orçamentos
        final orcamentos = await OrcamentoService.getOrcamentosPorCpf(cpf);
        
        // Separar orçamentos por status
        _orcamentosEmAndamento = orcamentos.where((o) => 
          o.statusOrcamento == StatusEnum.EM_ANDAMENTO || 
          o.statusOrcamento == StatusEnum.ACEITO
        ).toList();
        
        _orcamentosFinalizados = orcamentos.where((o) => 
          o.statusOrcamento == StatusEnum.FINALIZADO
        ).toList();

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
