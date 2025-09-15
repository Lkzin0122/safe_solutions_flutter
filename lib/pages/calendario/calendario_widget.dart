import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
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
    initializeDateFormatting('pt_BR', null);
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
          margin: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: isToday 
                ? FlutterFlowTheme.of(context).primary 
                : hasServices 
                    ? FlutterFlowTheme.of(context).secondary.withOpacity(0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12.0),
            border: hasServices && !isToday 
                ? Border.all(color: FlutterFlowTheme.of(context).secondary, width: 1.5) 
                : null,
            boxShadow: isToday ? [
              BoxShadow(
                blurRadius: 4.0,
                color: FlutterFlowTheme.of(context).primary.withOpacity(0.3),
                offset: Offset(0.0, 2.0),
              )
            ] : null,
          ),
          child: InkWell(
            onTap: hasServices ? () => _showServicesForDate(date, servicesForDate) : null,
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              height: 48.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${date.day}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: isCurrentMonth 
                          ? (isToday ? Colors.white : FlutterFlowTheme.of(context).primaryText)
                          : FlutterFlowTheme.of(context).secondaryText,
                      fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                  if (hasServices)
                    Container(
                      width: 6.0,
                      height: 6.0,
                      margin: EdgeInsets.only(top: 4.0),
                      decoration: BoxDecoration(
                        color: isToday 
                            ? Colors.white 
                            : FlutterFlowTheme.of(context).secondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showPasswordDialog(String serviceId) {
    final passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirme sua senha'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Digite sua senha',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Serviço finalizado com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
              context.goNamed('contratos');
            },
            child: Text('Finalizar'),
          ),
        ],
      ),
    );
  }

  void _showServicesForDate(DateTime date, List<ScheduledService> services) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40.0,
              height: 4.0,
              margin: EdgeInsets.only(top: 12.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24.0,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Serviços do Dia',
                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          DateFormat('EEEE, dd/MM/yyyy', 'pt_BR').format(date),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
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
            SizedBox(height: 24.0),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x0F000000),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Icon(
                                service.icon,
                                color: FlutterFlowTheme.of(context).primary,
                                size: 24.0,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.title,
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    service.description,
                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 16.0,
                                    color: FlutterFlowTheme.of(context).secondary,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    service.time,
                                    style: FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            if (service.status == 'agendado')
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _showPasswordDialog(service.id);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  elevation: 2.0,
                                ),
                                child: Text(
                                  'Finalizar',
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 0,
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
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  FlutterFlowTheme.of(context).primary,
                  FlutterFlowTheme.of(context).secondary,
                ],
                stops: [0.0, 1.0],
                begin: AlignmentDirectional(-1.0, 0.0),
                end: AlignmentDirectional(1.0, 0),
              ),
            ),
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
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x1A000000),
                        offset: Offset(0.0, 2.0),
                      )
                    ],
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
                      hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20.0,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                
                SizedBox(height: 20.0),
                
                // Navegação do mês
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4.0,
                        color: Color(0x1A000000),
                        offset: Offset(0.0, 2.0),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _model.changeMonth(-1);
                            });
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            size: 24.0,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('MMMM yyyy', 'pt_BR').format(_model.selectedDate),
                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _model.changeMonth(1);
                            });
                          },
                          icon: Icon(
                            Icons.chevron_right,
                            size: 24.0,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      ),
                    ],
                  ),
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