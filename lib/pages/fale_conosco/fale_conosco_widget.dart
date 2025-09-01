import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final formKey = GlobalKey<FormState>();
  bool _showSuccessMessage = false;
  bool _isLoading = false;

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
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo no topo
                  Container(
                    width: double.infinity,
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 40.0, 24.0, 24.0),
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
                  // Seção de contato rápido
                  Container(
                    width: double.infinity,
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Contato Rápido',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).tertiary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                await launchUrl(Uri.parse('tel:+5511999999999'));
                              },
                              child: Container(
                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).success,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.phone, color: Colors.white, size: 20.0),
                                    SizedBox(width: 8.0),
                                    Text('Ligar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await launchUrl(Uri.parse('https://wa.me/5511999999999'));
                              },
                              child: Container(
                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF25D366),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.chat, color: Colors.white, size: 20.0),
                                    SizedBox(width: 8.0),
                                    Text('WhatsApp', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0),
                  
                  Text(
                    'Ou envie uma mensagem:',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Campo Nome
                  TextFormField(
                    controller: _model.nomeController,
                    focusNode: _model.nomeFocusNode,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Nome é obrigatório';
                      if (val.length < 2) return 'Nome deve ter pelo menos 2 caracteres';
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Nome Completo',
                      hintText: 'Digite seu nome completo',
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).tertiary, width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.person_outline, color: FlutterFlowTheme.of(context).secondaryText),
                    ),
                    textCapitalization: TextCapitalization.words,
                  ),
                  SizedBox(height: 16.0),
                  
                  // Campo Email
                  TextFormField(
                    controller: _model.emailController,
                    focusNode: _model.emailFocusNode,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Email é obrigatório';
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) return 'Digite um email válido';
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Digite seu email',
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).tertiary, width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.email_outlined, color: FlutterFlowTheme.of(context).secondaryText),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.0),
                  
                  // Campo Telefone
                  TextFormField(
                    controller: _model.telefoneController,
                    focusNode: _model.telefoneFocusNode,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Telefone é obrigatório';
                      if (val.length < 10) return 'Digite um telefone válido';
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                      hintText: '(11) 99999-9999',
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).tertiary, width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.phone_outlined, color: FlutterFlowTheme.of(context).secondaryText),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16.0),
                  
                  // Campo Mensagem
                  TextFormField(
                    controller: _model.mensagemController,
                    focusNode: _model.mensagemFocusNode,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Mensagem é obrigatória';
                      if (val.length < 10) return 'Mensagem deve ter pelo menos 10 caracteres';
                      return null;
                    },
                    maxLines: 4,
                    maxLength: 500,
                    decoration: InputDecoration(
                      labelText: 'Mensagem',
                      hintText: 'Descreva sua dúvida ou solicitação...',
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).tertiary, width: 2.0),
                      ),
                      alignLabelWithHint: true,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  SizedBox(height: 32.0),
                  
                  // Botão Enviar
                  SizedBox(
                    width: double.infinity,
                    child: FFButtonWidget(
                      onPressed: _isLoading ? null : () async {
                        if (formKey.currentState!.validate()) {
                          setState(() { _isLoading = true; });
                          HapticFeedback.lightImpact();
                          await Future.delayed(Duration(seconds: 1));
                          setState(() { _isLoading = false; _showSuccessMessage = true; });
                          await Future.delayed(Duration(seconds: 2));
                          if (mounted) context.pushNamed(ContratosWidget.routeName);
                        }
                      },
                      text: _isLoading ? 'Enviando...' : 'Enviar Mensagem',
                      icon: _isLoading 
                        ? SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2.0,
                            ),
                          )
                        : Icon(Icons.send, color: Colors.white),
                      options: FFButtonOptions(
                        height: 50.0,
                        color: FlutterFlowTheme.of(context).tertiary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  
                  // Mensagem de sucesso
                  if (_showSuccessMessage)
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).success,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle_outline, color: Colors.white, size: 24.0),
                          SizedBox(width: 12.0),
                          Expanded(
                            child: Text(
                              'Mensagem enviada com sucesso! Entraremos em contato em breve.',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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