import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'status_servico_model.dart';
export 'status_servico_model.dart';

class StatusServicoWidget extends StatefulWidget {
  const StatusServicoWidget({
    super.key,
    this.contratoId,
    this.nomeServico,
  });

  final String? contratoId;
  final String? nomeServico;

  static String routeName = 'status_servico';
  static String routePath = '/status_servico';

  @override
  State<StatusServicoWidget> createState() => _StatusServicoWidgetState();
}

class _StatusServicoWidgetState extends State<StatusServicoWidget> {
  late StatusServicoModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StatusServicoModel());
    _model.contratoSelecionado = widget.contratoId ?? 'CT-001';
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget _buildStatusStep(String title, String description, bool isCompleted, bool isActive) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isCompleted ? FlutterFlowTheme.of(context).success : 
                     isActive ? FlutterFlowTheme.of(context).primary : 
                     FlutterFlowTheme.of(context).alternate,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted ? Icons.check : Icons.circle,
              color: Colors.white,
              size: 16,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: isActive ? FlutterFlowTheme.of(context).primary : 
                           FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                Text(
                  description,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: Text(
          'Status do Serviço',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.fromSTEB(24, 20, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informações do contrato
              Container(
                width: double.infinity,
                padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contrato: ${_model.contratoSelecionado}',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Serviço: ${widget.nomeServico ?? 'Super Clean'}',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Data de início: 15/01/2024',
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Status atual
              Container(
                width: double.infinity,
                padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primary,
                      FlutterFlowTheme.of(context).tertiary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status Atual',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Em Execução',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Progresso do serviço
              Text(
                'Progresso do Serviço',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ),
                child: Column(
                  children: [
                    _buildStatusStep(
                      'Contrato Assinado',
                      'Contrato foi assinado e aprovado',
                      true,
                      false,
                    ),
                    _buildStatusStep(
                      'Agendamento Realizado',
                      'Data e horário foram definidos',
                      true,
                      false,
                    ),
                    _buildStatusStep(
                      'Serviço em Execução',
                      'Equipe está executando o serviço',
                      false,
                      true,
                    ),
                    _buildStatusStep(
                      'Finalização',
                      'Serviço será finalizado e entregue',
                      false,
                      false,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Informações adicionais
              Container(
                width: double.infinity,
                padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).info,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Previsão de conclusão: 20/01/2024\nResponsável: Equipe Super Clean',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Botão de contato
              FFButtonWidget(
                onPressed: () {
                  context.pushNamed(FaleConoscoWidget.routeName);
                },
                text: 'Entrar em Contato',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  elevation: 3,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}