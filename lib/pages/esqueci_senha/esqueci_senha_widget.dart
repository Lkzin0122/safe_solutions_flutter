import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/services/recuperacao_senha_service.dart';
import 'package:flutter/material.dart';
import 'esqueci_senha_model.dart';
export 'esqueci_senha_model.dart';

class EsqueciSenhaWidget extends StatefulWidget {
  const EsqueciSenhaWidget({super.key});

  static String routeName = 'EsqueciSenha';
  static String routePath = '/esqueci-senha';

  @override
  State<EsqueciSenhaWidget> createState() => _EsqueciSenhaWidgetState();
}

class _EsqueciSenhaWidgetState extends State<EsqueciSenhaWidget> {
  late EsqueciSenhaModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _model = EsqueciSenhaModel();
  }

  void _enviarEmail() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Digite um email válido'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _loading = true);
    
    final result = await RecuperacaoSenhaService.validarEmailUsuario(_emailController.text);
    
    setState(() => _loading = false);
    
    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
      context.pushNamed('ValidarCodigo', extra: _emailController.text);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,

        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 140.0,
                      margin: const EdgeInsets.only(top: 50.0),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 16.0,
                            top: 16.0,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 30.0,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.network(
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/mor10gnszw4j/WhatsApp_Image_2025-05-31_at_12.34.51.jpeg',
                                width: constraints.maxWidth > 600 ? 250.0 : constraints.maxWidth * 0.6,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: 400),
                      padding: EdgeInsets.all(constraints.maxWidth > 600 ? 32.0 : 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recuperar Senha',
                            style: FlutterFlowTheme.of(context).headlineMedium.override(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Digite seu email cadastrado para receber o código de recuperação de senha.',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              controller: _emailController,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context).primaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const SizedBox(height: 24.0),
                          SizedBox(
                            width: double.infinity,
                            child: FFButtonWidget(
                              onPressed: _loading ? null : _enviarEmail,
                              text: _loading ? 'Enviando...' : 'Recuperar Senha',
                              options: FFButtonOptions(
                                height: 44.0,
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                                elevation: 3.0,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}