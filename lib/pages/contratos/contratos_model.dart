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

class OngoingService {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String route;

  OngoingService({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.route,
  });
}

class ContratosModel extends FlutterFlowModel<ContratosWidget> {
  bool isCompletedExpanded = false;
  
  static List<OngoingService> ongoingServices = [
    OngoingService(
      id: 'montador',
      title: 'Montador',
      description: 'Serviços de montagem e instalação profissional',
      imageUrl: 'https://images.unsplash.com/photo-1581092918056-0c4c3acd3789?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      route: 'montador',
    ),
    OngoingService(
      id: 'super_clean',
      title: 'Super Clean',
      description: 'Serviços de limpeza profissional e especializada',
      imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      route: 'super_clean',
    ),
    OngoingService(
      id: 'bratecno',
      title: 'Bratecno',
      description: 'Soluções tecnológicas e automação residencial',
      imageUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af2176?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      route: 'bratecno',
    ),
  ];
  
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
    final serviceIndex = ongoingServices.indexWhere((service) => service.id == serviceId);
    if (serviceIndex != -1) {
      final service = ongoingServices[serviceIndex];
      
      IconData icon;
      switch (serviceId) {
        case 'montador':
          icon = Icons.build;
          break;
        case 'super_clean':
          icon = Icons.cleaning_services;
          break;
        case 'bratecno':
          icon = Icons.settings;
          break;
        default:
          icon = Icons.check_circle;
      }
      
      final completedService = CompletedService(
        title: service.title,
        description: service.description,
        icon: icon,
        completedDate: completedDate,
      );
      
      ongoingServices.removeAt(serviceIndex);
      completedServices.insert(0, completedService);
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
