import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'suporte_model.dart';
export 'suporte_model.dart';

class SuporteWidget extends StatefulWidget {
  const SuporteWidget({super.key});

  static String routeName = 'suporte';
  static String routePath = '/suporte';

  @override
  State<SuporteWidget> createState() => _SuporteWidgetState();
}

class _SuporteWidgetState extends State<SuporteWidget> {
  late SuporteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SuporteModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
            size: 30.0,
          ),
        ),
        title: Text(
          'Suporte',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.support_agent,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 28.0,
                            ),
                            SizedBox(width: 12.0),
                            Text(
                              'Central de Suporte',
                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Estamos aqui para ajudar você! Nossa equipe de suporte está disponível para esclarecer dúvidas e resolver problemas relacionados aos nossos serviços.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                lineHeight: 1.5,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20.0),
                
                Text(
                  'Como podemos ajudar?',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                ),
                
                SizedBox(height: 16.0),
                
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: FlutterFlowTheme.of(context).success,
                          size: 24.0,
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Telefone',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              '(11) 99999-9999',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              'Segunda a Sexta: 8h às 18h',
                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 12.0),
                
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: FlutterFlowTheme.of(context).info,
                          size: 24.0,
                        ),
                        SizedBox(width: 12.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'E-mail',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              'suporte@safesolutions.com',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              'Resposta em até 24h',
                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).secondaryText,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20.0),
                
                Text(
                  'Perguntas Frequentes',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                ),
                
                SizedBox(height: 16.0),
                
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Como solicitar um serviço?',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Acesse a seção "Serviços" no menu principal e escolha o serviço desejado. Preencha o formulário com suas informações e aguarde o contato da nossa equipe.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                lineHeight: 1.4,
                              ),
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Como acompanhar meu pedido?',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Você pode acompanhar o status do seu pedido na seção "Contratos" do aplicativo. Lá você encontrará todas as informações sobre o andamento do serviço.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                lineHeight: 1.4,
                              ),
                        ),
                      ],
                    ),
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