import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'fale_conosco_model.dart';
export 'fale_conosco_model.dart';

class FaleConoscoWidget extends StatefulWidget {
  const FaleConoscoWidget({super.key});

  static String routeName = 'faleConosco';
  static String routePath = '/faleConosco';

  @override
  State<FaleConoscoWidget> createState() => _FaleConoscoWidgetState();
}

class _FaleConoscoWidgetState extends State<FaleConoscoWidget> {
  late FaleConoscoModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showSuccessMessage = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FaleConoscoModel());
    _model.emailController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();
    _model.nomeController ??= TextEditingController();
    _model.nomeFocusNode ??= FocusNode();
    _model.telefoneController ??= TextEditingController();
    _model.telefoneFocusNode ??= FocusNode();
    _model.mensagemController ??= TextEditingController();
    _model.mensagemFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
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
          child: Column(
            children: [
              // Header com logo
              Container(
                width: double.infinity,
                height: 140.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Image.network(
                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/mor10gnszw4j/WhatsApp_Image_2025-05-31_at_12.34.51.jpeg',
                      width: 250.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 20, 24, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fale conosco e tire suas dúvidas',
                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      
                      // Campo Email
                      TextFormField(
                        controller: _model.emailController,
                        focusNode: _model.emailFocusNode,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                        ),
                      ),
                      SizedBox(height: 16),
                      
                      // Campo Nome
                      TextFormField(
                        controller: _model.nomeController,
                        focusNode: _model.nomeFocusNode,
                        decoration: InputDecoration(
                          hintText: 'Nome',
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                        ),
                      ),
                      SizedBox(height: 16),
                      
                      // Campo Telefone
                      TextFormField(
                        controller: _model.telefoneController,
                        focusNode: _model.telefoneFocusNode,
                        decoration: InputDecoration(
                          hintText: 'Telefone',
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                        ),
                      ),
                      SizedBox(height: 16),
                      
                      // Campo Mensagem
                      TextFormField(
                        controller: _model.mensagemController,
                        focusNode: _model.mensagemFocusNode,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Digite sua mensagem',
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 16),
                        ),
                      ),
                      SizedBox(height: 30),
                      
                      // Botão Enviar
                      FFButtonWidget(
                        onPressed: () async {
                          setState(() {
                            _showSuccessMessage = true;
                          });
                          await Future.delayed(Duration(seconds: 2));
                          setState(() {
                            _showSuccessMessage = false;
                          });
                        },
                        text: 'Enviar',
                        options: FFButtonOptions(
                          width: 120,
                          height: 50,
                          color: Color(0xFF234063),
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      
                      // Mensagem de sucesso
                      if (_showSuccessMessage)
                        Container(
                          margin: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
                          decoration: BoxDecoration(
                            color: Color(0xFF234063),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, color: Colors.green, size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Mensagem enviada com sucesso!',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                              ),
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
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.message_outlined,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        'Fale conosco',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              useGoogleFonts: !FlutterFlowTheme.of(context).bodySmallIsCustom,
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