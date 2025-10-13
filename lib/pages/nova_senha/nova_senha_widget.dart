import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/services/recuperacao_senha_service.dart';
import 'package:flutter/material.dart';
import 'nova_senha_model.dart';
export 'nova_senha_model.dart';

class NovaSenhaWidget extends StatefulWidget {
  const NovaSenhaWidget({super.key, required this.email});

  final String email;
  static String routeName = 'NovaSenha';
  static String routePath = '/nova-senha';

  @override
  State<NovaSenhaWidget> createState() => _NovaSenhaWidgetState();
}

class _NovaSenhaWidgetState extends State<NovaSenhaWidget> {
  late NovaSenhaModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _model = NovaSenhaModel();
    _model.senhaController ??= TextEditingController();
    _model.confirmarSenhaController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _atualizarSenha() async {
    final senha = _model.senhaController?.text ?? '';
    final confirmarSenha = _model.confirmarSenhaController?.text ?? '';

    if (senha.isEmpty || confirmarSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos'), backgroundColor: Colors.red),
      );
      return;
    }

    if (senha != confirmarSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('As senhas não coincidem'), backgroundColor: Colors.red),
      );
      return;
    }

    if (senha.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('A senha deve ter pelo menos 8 caracteres'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _loading = true);

    final result = await RecuperacaoSenhaService.atualizarSenha(widget.email, senha);

    setState(() => _loading = false);

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Senha atualizada com sucesso!'), backgroundColor: Colors.green),
      );
      context.goNamed('Login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message']), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,

        body: SafeArea(
          child: SingleChildScrollView(
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
                            width: 250.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Criar Nova Senha',
                        style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Digite sua nova senha. Ela deve ter pelo menos 8 caracteres.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      SizedBox(
                        width: 370.0,
                        child: TextFormField(
                          controller: _model.senhaController,
                          obscureText: !_model.senhaVisibility,
                          decoration: InputDecoration(
                            labelText: 'Nova Senha',
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
                            suffixIcon: InkWell(
                              onTap: () => setState(() => _model.senhaVisibility = !_model.senhaVisibility),
                              child: Icon(
                                _model.senhaVisibility ? Icons.visibility : Icons.visibility_off,
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      SizedBox(
                        width: 370.0,
                        child: TextFormField(
                          controller: _model.confirmarSenhaController,
                          obscureText: !_model.confirmarSenhaVisibility,
                          decoration: InputDecoration(
                            labelText: 'Confirmar Senha',
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
                            suffixIcon: InkWell(
                              onTap: () => setState(() => _model.confirmarSenhaVisibility = !_model.confirmarSenhaVisibility),
                              child: Icon(
                                _model.confirmarSenhaVisibility ? Icons.visibility : Icons.visibility_off,
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      FFButtonWidget(
                        onPressed: _loading ? null : _atualizarSenha,
                        text: _loading ? 'Atualizando...' : 'Atualizar Senha',
                        options: FFButtonOptions(
                          width: 370.0,
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