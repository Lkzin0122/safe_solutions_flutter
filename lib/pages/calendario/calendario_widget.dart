import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'calendario_model.dart';
export 'calendario_model.dart';

class CalendarioWidget extends StatefulWidget {
  const CalendarioWidget({super.key});

  static String routeName = 'calendario';
  static String routePath = '/calendario';

  @override
  State<CalendarioWidget> createState() => _CalendarioWidgetState();
}

class _CalendarioWidgetState extends State<CalendarioWidget> {
  late CalendarioModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarioModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget _buildCalendarGrid() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(_model.selectedDate.year, _model.selectedDate.month, 1);
    final lastDayOfMonth = DateTime(_model.selectedDate.year, _model.selectedDate.month + 1, 0);
    final startDate = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));
    
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        final date = startDate.add(Duration(days: index));
        final isCurrentMonth = date.month == _model.selectedDate.month;
        final isToday = date.day == now.day && date.month == now.month && date.year == now.year;
        final servicesForDate = _model.getServicesForDate(date);
        final hasServices = servicesForDate.isNotEmpty;

        return Container(
          margin: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: isToday ? FlutterFlowTheme.of(context).primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
            border: hasServices ? Border.all(color: FlutterFlowTheme.of(context).secondary, width: 2.0) : null,
          ),
          child: InkWell(
            onTap: hasServices ? () => _showServicesForDate(date, servicesForDate) : null,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${date.day}',
                  style: TextStyle(
                    color: isCurrentMonth 
                        ? (isToday ? Colors.white : Colors.black)
                        : Colors.grey,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                if (hasServices)
                  Container(
                    width: 6.0,
                    height: 6.0,
                    margin: EdgeInsets.only(top: 2.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showServicesForDate(DateTime date, List<ScheduledService> services) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Serviços - ${DateFormat('dd/MM/yyyy').format(date)}',
              style: FlutterFlowTheme.of(context).headlineSmall,
            ),
            SizedBox(height: 16.0),
            ...services.map((service) => Container(
              margin: EdgeInsets.only(bottom: 8.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: FlutterFlowTheme.of(context).alternate),
              ),
              child: Row(
                children: [
                  Icon(service.icon, color: FlutterFlowTheme.of(context).primary),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(service.title, style: FlutterFlowTheme.of(context).titleSmall),
                        Text(service.description, style: FlutterFlowTheme.of(context).bodySmall),
                        Text('${service.time}', style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).primary,
                          fontWeight: FontWeight.w600,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          title: Text(
            'Calendário de Serviços',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Campo de busca
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                  ),
                  child: TextField(
                    controller: _model.searchController,
                    onChanged: (value) {
                      setState(() {
                        _model.updateSearchQuery(value);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar serviços...',
                      prefixIcon: Icon(Icons.search, color: FlutterFlowTheme.of(context).secondaryText),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.0),
                    ),
                  ),
                ),
                
                SizedBox(height: 20.0),
                
                // Navegação do mês
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _model.changeMonth(-1);
                        });
                      },
                      icon: Icon(Icons.chevron_left, size: 30.0),
                    ),
                    Text(
                      DateFormat('MMMM yyyy', 'pt_BR').format(_model.selectedDate),
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _model.changeMonth(1);
                        });
                      },
                      icon: Icon(Icons.chevron_right, size: 30.0),
                    ),
                  ],
                ),
                
                SizedBox(height: 16.0),
                
                // Cabeçalho dos dias da semana
                Row(
                  children: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb']
                      .map((day) => Expanded(
                            child: Center(
                              child: Text(
                                day,
                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                
                SizedBox(height: 8.0),
                
                // Grid do calendário
                _buildCalendarGrid(),
                
                SizedBox(height: 20.0),
                
                // Lista de serviços filtrados
                if (_model.filteredServices.isNotEmpty) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Serviços do Mês',
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  ..._model.filteredServices.map((service) => Container(
                    margin: EdgeInsets.only(bottom: 12.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(service.icon, color: FlutterFlowTheme.of(context).primary),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(service.title, style: FlutterFlowTheme.of(context).titleMedium),
                              Text(service.description, style: FlutterFlowTheme.of(context).bodySmall),
                              SizedBox(height: 4.0),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16.0, color: FlutterFlowTheme.of(context).secondaryText),
                                  SizedBox(width: 4.0),
                                  Text(
                                    '${DateFormat('dd/MM').format(service.date)} às ${service.time}',
                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ] else
                  Container(
                    padding: EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Icon(Icons.calendar_month, size: 64.0, color: FlutterFlowTheme.of(context).secondaryText),
                        SizedBox(height: 16.0),
                        Text(
                          'Nenhum serviço encontrado',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}