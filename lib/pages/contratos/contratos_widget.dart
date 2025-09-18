import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'contratos_model.dart';
import 'detalhes_servico_concluido_widget.dart';
export 'contratos_model.dart';

bool isUserLoggedIn() {
  return true;
}

class ContratosWidget extends StatefulWidget {
  const ContratosWidget({
    super.key,
    this.initialTab,
  });

  final int? initialTab;

  static String routeName = 'contratos';
  static String routePath = '/servicos';

  @override
  State<ContratosWidget> createState() => _ContratosWidgetState();
}

class _ContratosWidgetState extends State<ContratosWidget> {
  late ContratosModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContratosModel());
    
    // Se initialTab for 1, expandir automaticamente a seção de serviços concluídos
    if (widget.initialTab == 1) {
      _model.isCompletedExpanded = true;
    }
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!isUserLoggedIn()) {
        context.pushNamed('Login1');
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24.0),
          SizedBox(height: 8.0),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 8.0),
      child: Material(
        color: Colors.transparent,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: double.infinity,
            height: 120.0,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      imageUrl,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 16.0, 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'Montserrat',
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[600],
                    size: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedServiceCard({
    required CompletedService service,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 8.0),
      child: Material(
        color: Colors.transparent,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetalhesServicoConcluidoWidget(service: service),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
              child: Row(
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(
                      service.icon,
                      color: FlutterFlowTheme.of(context).secondary,
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
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          service.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: FlutterFlowTheme.of(context).success,
                              size: 16.0,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              'Concluído em ${service.completedDate}',
                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).success,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Logo padronizada
                Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.network(
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/mor10gnszw4j/WhatsApp_Image_2025-05-31_at_12.34.51.jpeg',
                        width: 250.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // Campo de busca e botão calendário
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
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
                              contentPadding: EdgeInsets.all(12.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: IconButton(
                          onPressed: () => context.pushNamed('Calendario'),
                          icon: Icon(Icons.calendar_month, color: Colors.white),
                          tooltip: 'Ver Calendário',
                        ),
                      ),
                    ],
                  ),
                ),

                // Título da seção
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 24.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Serviços em Andamento',
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      SizedBox(height: 8.0),
                      Container(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 6.0, 12.0, 6.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).success,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          _model.searchQuery.isEmpty 
                              ? '${3 - ContratosModel.completedServiceIds.length} Ativos'
                              : '${_model.activeServicesCount} Encontrados',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 10.0),

                // Cards de serviços (filtrados por busca)
                if (!ContratosModel.isServiceCompleted('montador') && _model.showMontador)
                  _buildServiceCard(
                    title: 'O Montador',
                    description:
                        'Serviços especializados de montagem de móveis para residências, escritórios e ambientes comerciais.',
                    imageUrl:
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/zqwlt240p7sd/image_17.png',
                    onTap: () => context.pushNamed('Montador'),
                  ),

                if (!ContratosModel.isServiceCompleted('super_clean') && _model.showSuperClean)
                  _buildServiceCard(
                    title: 'Super Clean',
                    description:
                        'Serviço de limpeza profissional com soluções completas e personalizadas para manter seu ambiente impecável.',
                    imageUrl:
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/dfq8wa491iyv/image_17_(1).png',
                    onTap: () => context.pushNamed('SuperClean'),
                  ),

                if (!ContratosModel.isServiceCompleted('bratecno') && _model.showBratecno)
                  _buildServiceCard(
                    title: 'Bratecno',
                    description:
                        'Manutenção de hardware projetada para garantir desempenho ideal e confiabilidade dos seus equipamentos.',
                    imageUrl:
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/42x886euiaf7/image_20_1.png',
                    onTap: () => context.pushNamed('Bratecno'),
                  ),

                SizedBox(height: 30.0),

                // Seção de Serviços Concluídos Expansível
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _model.isCompletedExpanded = !_model.isCompletedExpanded;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Serviços Concluídos',
                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Container(
                                padding: EdgeInsetsDirectional.fromSTEB(8.0, 4.0, 8.0, 4.0),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondary,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  _model.searchQuery.isEmpty 
                                      ? '${ContratosModel.completedServices.length} Concluídos'
                                      : '${_model.filteredCompletedServices.length} Encontrados',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            _model.isCompletedExpanded ? Icons.expand_less : Icons.expand_more,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Cards de serviços concluídos (expansível com animação)
                AnimatedCrossFade(
                  firstChild: SizedBox.shrink(),
                  secondChild: Column(
                    children: [
                      SizedBox(height: 10.0),
                      ..._model.filteredCompletedServices.map((service) => 
                        _buildCompletedServiceCard(service: service),
                      ).toList(),
                    ],
                  ),
                  crossFadeState: _model.isCompletedExpanded 
                      ? CrossFadeState.showSecond 
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 300),
                ),

                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
                offset: Offset(0.0, -2.0),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.description,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 24,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        'Serviços',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodySmallFamily,
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodySmallIsCustom,
                            ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed('FaleConosco');
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.message_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Fale conosco',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodySmallFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodySmallIsCustom,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed('Profile');
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Perfil',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodySmallFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodySmallIsCustom,
                              ),
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
