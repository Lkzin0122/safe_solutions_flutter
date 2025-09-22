import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
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
    final startDate = firstDayOfMonth.subtract(Duration(days: firstDayOfMonth.weekday % 7));
    
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            color: Color(0x1A000000),
            offset: Offset(0.0, 4.0),
          )
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1.0,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: 42,
        itemBuilder: (context, index) {
          final date = startDate.add(Duration(days: index));
          final isCurrentMonth = date.month == _model.selectedDate.month;
          final isToday = date.day == now.day && date.month == now.month && date.year == now.year;
          final servicesForDate = _model.getServicesForDate(date);
          final hasServices = servicesForDate.isNotEmpty;

          return Container(
            decoration: BoxDecoration(
              color: isToday 
                  ? FlutterFlowTheme.of(context).primary 
                  : hasServices 
                      ? FlutterFlowTheme.of(context).secondary.withOpacity(0.1)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
              border: hasServices && !isToday 
                  ? Border.all(color: FlutterFlowTheme.of(context).secondary, width: 2.0) 
                  : null,
              boxShadow: isToday ? [
                BoxShadow(
                  blurRadius: 6.0,
                  color: FlutterFlowTheme.of(context).primary.withOpacity(0.4),
                  offset: Offset(0.0, 3.0),
                )
              ] : null,
            ),
            child: InkWell(
              onTap: hasServices ? () => _showServicesForDate(date, servicesForDate) : null,
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${date.day}',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: isCurrentMonth 
                            ? (isToday ? Colors.white : FlutterFlowTheme.of(context).primaryText)
                            : FlutterFlowTheme.of(context).secondaryText.withOpacity(0.5),
                        fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    if (hasServices)
                      Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.only(top: 4.0),
                        decoration: BoxDecoration(
                          color: isToday 
                              ? Colors.white 
                              : FlutterFlowTheme.of(context).secondary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2.0,
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0.0, 1.0),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showPasswordDialog(String serviceId, String serviceTitle) {
    final passwordController = TextEditingController();
    bool isLoading = false;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  Icons.lock,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 20.0,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'Confirme sua senha',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Para finalizar o serviço "$serviceTitle", digite sua senha:',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Montserrat',
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  hintText: 'Digite sua senha',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).primary,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context),
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: isLoading ? null : () async {
                if (passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, digite sua senha'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                
                setState(() => isLoading = true);
                
                // Simula validação da senha
                await Future.delayed(Duration(seconds: 1));
                
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 8.0),
                        Text('Serviço finalizado com sucesso!'),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                );
                
                // Remove o serviço da lista
                setState(() {
                  CalendarioModel.scheduledServices.removeWhere((s) => s.id == serviceId);
                });
                
                context.goNamed('Contratos');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: isLoading 
                  ? SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text('Finalizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showServicesForDate(DateTime date, List<ScheduledService> services) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28.0),
            topRight: Radius.circular(28.0),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 50.0,
              height: 5.0,
              margin: EdgeInsets.only(top: 16.0, bottom: 24.0),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).alternate,
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).primary,
                          FlutterFlowTheme.of(context).secondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 28.0,
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
                            fontWeight: FontWeight.bold,
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
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8.0,
                          color: Color(0x0F000000),
                          offset: Offset(0.0, 4.0),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 56.0,
                                height: 56.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Icon(
                                  service.icon,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 28.0,
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
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
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
                          SizedBox(height: 20.0),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 18.0,
                                      color: FlutterFlowTheme.of(context).secondary,
                                    ),
                                    SizedBox(width: 6.0),
                                    Text(
                                      service.time,
                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).secondary,
                                        fontWeight: FontWeight.bold,
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
                                    _showPasswordDialog(service.id, service.title);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: FlutterFlowTheme.of(context).primary,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    elevation: 4.0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check_circle, size: 18.0),
                                      SizedBox(width: 6.0),
                                      Text(
                                        'Finalizar',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
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

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Botão de voltar
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.arrow_back, size: 24),
                  ),
                ),
                // Campo de busca estilizado
                Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.0,
                        color: Color(0x1A000000),
                        offset: Offset(0.0, 4.0),
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
                      prefixIcon: Container(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          Icons.search,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 24.0,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20.0),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                
                SizedBox(height: 24.0),
                
                // Navegação do mês estilizada
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                        FlutterFlowTheme.of(context).secondary.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: FlutterFlowTheme.of(context).primary.withOpacity(0.3),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _model.changeMonth(-1);
                            });
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            size: 28.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('MMMM yyyy', 'pt_BR').format(_model.selectedDate),
                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: FlutterFlowTheme.of(context).primary.withOpacity(0.3),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _model.changeMonth(1);
                            });
                          },
                          icon: Icon(
                            Icons.chevron_right,
                            size: 28.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20.0),
                
                // Cabeçalho dos dias da semana
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb']
                        .map((day) => Expanded(
                              child: Center(
                                child: Text(
                                  day,
                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                
                SizedBox(height: 12.0),
                
                // Grid do calendário
                _buildCalendarGrid(),
                
                SizedBox(height: 24.0),
                
                // Lista de serviços do mês
                if (_model.filteredServices.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                          FlutterFlowTheme.of(context).secondary.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Serviços do Mês (${_model.filteredServices.length})',
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ..._model.filteredServices.map((service) => Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8.0,
                          color: Color(0x0F000000),
                          offset: Offset(0.0, 4.0),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Icon(
                            service.icon, 
                            color: FlutterFlowTheme.of(context).primary,
                            size: 30.0,
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                service.description, 
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).secondaryText,
                                ),
                              ),
                              SizedBox(height: 8.0),
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
                                      Icons.calendar_today, 
                                      size: 16.0, 
                                      color: FlutterFlowTheme.of(context).secondary,
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      '${DateFormat('dd/MM').format(service.date)} às ${service.time}',
                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ] else
                  Container(
                    padding: EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Icon(
                            Icons.calendar_month, 
                            size: 40.0, 
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Nenhum serviço encontrado',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Não há serviços agendados para este período',
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
          ),
        ),
      ),
    );
  }
}