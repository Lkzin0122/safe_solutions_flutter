import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'servicos_model.dart';
export 'servicos_model.dart';

class ServicosWidget extends StatefulWidget {
  const ServicosWidget({super.key});

  static String routeName = 'servicos';
  static String routePath = '/servicospage';

  @override
  State<ServicosWidget> createState() => _ServicosWidgetState();
}

class _ServicosWidgetState extends State<ServicosWidget> {
  late ServicosModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ServicosModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget _buildServiceCard(String title, String description, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Icon(
                icon,
                size: 30.0,
                color: FlutterFlowTheme.of(context).primary,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              title,
              style: FlutterFlowTheme.of(context).titleMedium.override(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: FlutterFlowTheme.of(context).bodySmall.override(
                fontFamily: 'Montserrat',
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,

        body: SafeArea(
          child: Column(
            children: [
              // Botão de voltar
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.arrow_back, size: 22),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).primary,
                              FlutterFlowTheme.of(context).secondary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.home_repair_service,
                              size: 48.0,
                              color: Colors.white,
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Nossos Serviços',
                              style: FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Soluções completas para sua casa',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 24.0),
                      
                      // Serviços Grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.85,
                        children: [
                          _buildServiceCard(
                            'Super Clean',
                            'Limpeza completa e profissional',
                            Icons.cleaning_services,
                            () => context.goNamed('SuperClean'),
                          ),
                          _buildServiceCard(
                            'Montador',
                            'Montagem de móveis e equipamentos',
                            Icons.build,
                            () => context.goNamed('montador'),
                          ),
                          _buildServiceCard(
                            'Calendário',
                            'Agende e gerencie seus serviços',
                            Icons.calendar_today,
                            () => context.goNamed('calendario'),
                          ),
                          _buildServiceCard(
                            'Fale Conosco',
                            'Entre em contato conosco',
                            Icons.message,
                            () => context.goNamed('faleConosco'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
