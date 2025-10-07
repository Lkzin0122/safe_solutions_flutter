import '/flutter_flow/flutter_flow_model.dart';
import 'calendario_widget.dart' show CalendarioWidget;
import 'package:flutter/material.dart';

class ScheduledService {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String time;
  final IconData icon;
  final String status;

  ScheduledService({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.icon,
    required this.status,
  });
}

class CalendarioModel extends FlutterFlowModel<CalendarioWidget> {
  final TextEditingController searchController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String searchQuery = '';
  
  static List<ScheduledService> scheduledServices = [
    ScheduledService(
      id: 'montador_001',
      title: 'O Montador',
      description: 'Montagem de móveis planejados - Sala de estar',
      date: DateTime.now().add(Duration(days: 2)),
      time: '09:00',
      icon: Icons.build,
      status: 'agendado',
    ),
    ScheduledService(
      id: 'clean_001',
      title: 'Super Clean',
      description: 'Limpeza profissional - Escritório comercial',
      date: DateTime.now().add(Duration(days: 5)),
      time: '14:00',
      icon: Icons.cleaning_services,
      status: 'agendado',
    ),
    ScheduledService(
      id: 'bratecno_001',
      title: 'Bratecno',
      description: 'Manutenção de computadores - 3 equipamentos',
      date: DateTime.now().add(Duration(days: 7)),
      time: '10:30',
      icon: Icons.computer,
      status: 'agendado',
    ),
    ScheduledService(
      id: 'montador_002',
      title: 'O Montador',
      description: 'Montagem de guarda-roupa - Quarto principal',
      date: DateTime.now().add(Duration(days: 10)),
      time: '08:00',
      icon: Icons.build,
      status: 'agendado',
    ),
    ScheduledService(
      id: 'clean_002',
      title: 'Super Clean',
      description: 'Limpeza pós-obra - Apartamento 2 quartos',
      date: DateTime.now().add(Duration(days: 15)),
      time: '13:00',
      icon: Icons.cleaning_services,
      status: 'agendado',
    ),
  ];

  List<ScheduledService> get filteredServices {
    if (searchQuery.isEmpty) {
      return scheduledServices.where((service) => 
        service.date.month == selectedDate.month && 
        service.date.year == selectedDate.year
      ).toList();
    }
    
    return scheduledServices.where((service) {
      final matchesSearch = service.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                           service.description.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesMonth = service.date.month == selectedDate.month && 
                          service.date.year == selectedDate.year;
      return matchesSearch && matchesMonth;
    }).toList();
  }

  List<ScheduledService> getServicesForDate(DateTime date) {
    return filteredServices.where((service) => 
      service.date.day == date.day &&
      service.date.month == date.month &&
      service.date.year == date.year
    ).toList();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
  }

  void changeMonth(int monthOffset) {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + monthOffset, 1);
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchController.dispose();
  }
}
