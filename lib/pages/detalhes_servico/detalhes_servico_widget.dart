import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/models/servico.dart';
import 'package:flutter/material.dart';
import 'detalhes_servico_model.dart';
export 'detalhes_servico_model.dart';

class DetalhesServicoWidget extends StatefulWidget {
  const DetalhesServicoWidget({
    super.key,
    required this.servico,
  });

  final Servico servico;

  static String routeName = 'DetalhesServico';
  static String routePath = '/detalhes-servico';

  @override
  State<DetalhesServicoWidget> createState() => _DetalhesServicoWidgetState();
}

class _DetalhesServicoWidgetState extends State<DetalhesServicoWidget> {
  late DetalhesServicoModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetalhesServicoModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  IconData _getIconForCategory(String? categoria) {
    switch (categoria?.toLowerCase()) {
      case 'limpeza':
        return Icons.cleaning_services;
      case 'montagem':
        return Icons.build;
      case 'manutenção':
        return Icons.build_circle;
      case 'jardinagem':
        return Icons.grass;
      case 'pintura':
        return Icons.format_paint;
      default:
        return Icons.home_repair_service;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header com ícone e categoria
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
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity( 0.2),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Icon(
                              _getIconForCategory(widget.servico.categoriaServico),
                              size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            widget.servico.nomeServico,
                            style: FlutterFlowTheme.of(context).headlineMedium.override(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (widget.servico.categoriaServico != null)
                            Text(
                              widget.servico.categoriaServico!,
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white.withOpacity( 0.9),
                              ),
                            ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.0),

                    // Descrição
                    if (widget.servico.descricaoServico != null) ...[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8.0,
                              color: Color(0x0F000000),
                              offset: Offset(0.0, 4.0),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Descrição',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              widget.servico.descricaoServico!,
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                    ],

                    // Detalhes do Serviço
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8.0,
                            color: Color(0x0F000000),
                            offset: Offset(0.0, 4.0),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detalhes do Serviço',
                            style: FlutterFlowTheme.of(context).titleMedium.override(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          
                          if (widget.servico.localServico != null) ...[
                            Row(
                              children: [
                                Icon(Icons.location_on, size: 20.0, color: FlutterFlowTheme.of(context).primary),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Localização', style: FlutterFlowTheme.of(context).bodySmall.override(
                                        fontFamily: 'Montserrat', color: FlutterFlowTheme.of(context).secondaryText)),
                                      Text(widget.servico.localServico!, style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat', fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                          ],

                          if (widget.servico.valorEstimadoServico != null) ...[
                            Row(
                              children: [
                                Icon(Icons.attach_money, size: 20.0, color: FlutterFlowTheme.of(context).primary),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Valor Estimado', style: FlutterFlowTheme.of(context).bodySmall.override(
                                        fontFamily: 'Montserrat', color: FlutterFlowTheme.of(context).secondaryText)),
                                      Text('R\$ ${widget.servico.valorEstimadoServico!.toStringAsFixed(2)}', 
                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                          fontFamily: 'Montserrat', 
                                          color: FlutterFlowTheme.of(context).primary,
                                          fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                          ],

                          if (widget.servico.empresa != null) ...[
                            Row(
                              children: [
                                Icon(Icons.business, size: 20.0, color: FlutterFlowTheme.of(context).primary),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Empresa', style: FlutterFlowTheme.of(context).bodySmall.override(
                                        fontFamily: 'Montserrat', color: FlutterFlowTheme.of(context).secondaryText)),
                                      Text(widget.servico.empresa!.nomeEmpresa, style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat', fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                          ],

                          if (widget.servico.criteriosServico != null) ...[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.checklist, size: 20.0, color: FlutterFlowTheme.of(context).primary),
                                SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Critérios', style: FlutterFlowTheme.of(context).bodySmall.override(
                                        fontFamily: 'Montserrat', color: FlutterFlowTheme.of(context).secondaryText)),
                                      Text(widget.servico.criteriosServico!, style: FlutterFlowTheme.of(context).bodyMedium.override(
                                        fontFamily: 'Montserrat', fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: 24.0),

                    // Botão de Contato
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: FFButtonWidget(
                        onPressed: () {
                          context.pushNamed('FaleConosco');
                        },
                        text: 'Entrar em Contato',
                        options: FFButtonOptions(
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
