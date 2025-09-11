import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'contratos_widget.dart' show ContratosWidget;
import 'package:flutter/material.dart';

class CompletedService {
  final String title;
  final String description;
  final IconData icon;
  final String completedDate;

  CompletedService({
    required this.title,
    required this.description,
    required this.icon,
    required this.completedDate,
  });
}



class ContratosModel extends FlutterFlowModel<ContratosWidget> {
  bool isCompletedExpanded = false;
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  
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
  
  static List<CompletedService> completedServices = [
    CompletedService(
      title: 'Instalação Elétrica Residencial',
      description: 'Instalação completa do sistema elétrico em residência de 3 quartos.',
      icon: Icons.electrical_services,
      completedDate: '15/12/2024',
    ),
    CompletedService(
      title: 'Manutenção de Ar Condicionado',
      description: 'Limpeza e manutenção preventiva de 4 unidades de ar condicionado.',
      icon: Icons.ac_unit,
      completedDate: '10/12/2024',
    ),
    CompletedService(
      title: 'Pintura Comercial',
      description: 'Pintura completa de escritório comercial de 200m².',
      icon: Icons.format_paint,
      completedDate: '05/12/2024',
    ),
    CompletedService(
      title: 'Instalação de Câmeras de Segurança',
      description: 'Sistema completo com 8 câmeras HD e monitoramento 24h.',
      icon: Icons.security,
      completedDate: '28/11/2024',
    ),
    CompletedService(
      title: 'Reforma de Banheiro',
      description: 'Reforma completa incluindo azulejos, louças e instalações hidráulicas.',
      icon: Icons.bathroom,
      completedDate: '20/11/2024',
    ),
  ];

  static void addCompletedService(CompletedService service) {
    completedServices.insert(0, service);
  }
  
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
      title: title,
      description: description,
      icon: icon,
      completedDate: completedDate,
    );
    
    completedServices.insert(0, completedService);
  }
  
  static bool isServiceCompleted(String serviceId) {
    return completedServiceIds.contains(serviceId);
  }

  @override
  void initState(BuildContext context) {}

  void updateSearchQuery(String query) {
    searchQuery = query;
  }

  List<CompletedService> get filteredCompletedServices {
    if (searchQuery.isEmpty) {
      return completedServices;
    }
    return completedServices.where((service) => 
      service.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
      service.description.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }



  @override
  void dispose() {
    searchController.dispose();
  }
}
