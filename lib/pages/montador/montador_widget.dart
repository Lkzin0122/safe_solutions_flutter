import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'montador_model.dart';
export 'montador_model.dart';

class MontadorWidget extends StatefulWidget {
  const MontadorWidget({super.key});

  static String routeName = 'Montador';
  static String routePath = '/montador';

  @override
  State<MontadorWidget> createState() => _MontadorWidgetState();
}

class _MontadorWidgetState extends State<MontadorWidget> {
  late MontadorModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MontadorModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget _buildCriterioItem(BuildContext context, String titulo, String descricao) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).alternate,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            descricao,
            style: FlutterFlowTheme.of(context).bodySmall.override(
              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
              letterSpacing: 0.0,
              useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetalheItem(BuildContext context, String label, String valor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w500,
              useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
            ),
          ),
          Flexible(
            child: Text(
              valor,
              textAlign: TextAlign.end,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                letterSpacing: 0.0,
                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
              ),
            ),
          ),
        ],
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 80.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Align(
                  alignment: const AlignmentDirectional(-1.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 60.0,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      context.pop();
                    },
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 390.0,
                        height: 149.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(0.0, -0.01),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/zqwlt240p7sd/image_17.png',
                                  width: 120.9,
                                  height: 109.3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 150.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0.0, 0.03),
                          child: Text(
                            'Montador de móveis',
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              fontSize: 11.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'Descrição do Orçamento',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context).titleMediumIsCustom,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Orçamento para a montagem de três móveis planejados de escritório, incluindo uma mesa de trabalho (dimensões: 180cm x 90cm), um armário (200cm x 150cm) e uma estante de livros (altura: 250cm, largura: 120cm). Os móveis serão entregues no local, e o serviço deve ser prestado no endereço fornecido.',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context).bodyMediumIsCustom,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Critérios de Orçamento',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context).titleMediumIsCustom,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildCriterioItem(
                              context,
                              'Ajustes e Reparos',
                              'Pequenos ajustes e correções necessárias',
                            ),
                            _buildCriterioItem(
                              context,
                              'Instalação de Mobiliário Corporativo',
                              'Montagem completa de móveis de escritório',
                            ),
                            _buildCriterioItem(
                              context,
                              'Desmontagem e Remontagem',
                              'Serviço de desmonte e nova montagem',
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Detalhes do Orçamento',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context).titleMediumIsCustom,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildDetalheItem(context, 'Tipo de Móvel', 'Móveis planejados de escritório'),
                            _buildDetalheItem(context, 'Quantidade de Móveis', '3 peças'),
                            _buildDetalheItem(context, 'Necessidade de Transporte', 'Não necessário'),
                            _buildDetalheItem(context, 'Localização', 'Endereço do cliente'),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Valor Total',
                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                        fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleMediumIsCustom,
                                      ),
                                    ),
                                    Text(
                                      'R\$ 1.200,00',
                                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                                        fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                                        color: FlutterFlowTheme.of(context).primary,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts: !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Prazo',
                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                        fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                                        fontSize: 15.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        useGoogleFonts: !FlutterFlowTheme.of(context).titleMediumIsCustom,
                                      ),
                                    ),
                                    Text(
                                      '08/11/2025',
                                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                                        fontFamily: FlutterFlowTheme.of(context).bodyLargeFamily,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        useGoogleFonts: !FlutterFlowTheme.of(context).bodyLargeIsCustom,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            Center(
                              child: FFButtonWidget(
                                onPressed: () {
                                  // Ação do botão de status
                                },
                                text: 'Verificar Status',
                                options: FFButtonOptions(
                                  width: 200,
                                  height: 50,
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                                  ),
                                  elevation: 3,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed(ContratosWidget.routeName);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Contratos',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
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
                    context.pushNamed(FaleConoscoWidget.routeName);
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
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
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
                    context.pushNamed(ProfileWidget.routeName);
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
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
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