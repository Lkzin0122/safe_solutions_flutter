import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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
  String? _selectedAssunto;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FaleConoscoModel());
    _model.mensagemController ??= TextEditingController();
    _model.mensagemFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _enviarContato() async {
    try {
      final url = Uri.parse('https://spring-aplication.onrender.com/contato/enviar');
      
      // Busca dados da empresa logada
      final prefs = await SharedPreferences.getInstance();
      final empresaDataString = prefs.getString('empresa_data');
      
      String nomeUsuario = 'Usuario Mobile';
      String emailUsuario = 'mobile@app.com';
      
      if (empresaDataString != null) {
        final empresaData = json.decode(empresaDataString);
        if (empresaData['usuario'] != null) {
          nomeUsuario = empresaData['usuario']['nome_usuario'] ?? 'Usuario Mobile';
          emailUsuario = empresaData['usuario']['email'] ?? 'mobile@app.com';
        } else {
          // Se não tem usuário, usa o nome da empresa
          nomeUsuario = empresaData['nome_empresa'] ?? 'Usuario Mobile';
        }
      }
      
      print('Nome do usuário: $nomeUsuario');
      print('Email do usuário: $emailUsuario');
      
      final contato = {
        'nome': nomeUsuario,
        'email': emailUsuario,
        'assunto': _selectedAssunto ?? '',
        'mensagem': _model.mensagemController?.text ?? ''
      };
      
      print('Dados enviados: $contato');
      
      print('Enviando para: $url');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(contato),
      ).timeout(Duration(seconds: 10));
      
      print('Status: ${response.statusCode}');
      print('Response: ${response.body}');
      
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('Erro geral: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo da SafeSolutions
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 50.0, 24.0, 20.0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.network(
                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/mor10gnszw4j/WhatsApp_Image_2025-05-31_at_12.34.51.jpeg',
                        width: 200.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                
                // Seção de contato rápido
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                          Colors.white
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.support_agent,
                          size: 48.0,
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Contato Rápido',
                          style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Entre em contato conosco agora mesmo',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                        SizedBox(height: 24.0),
                        InkWell(
                          onTap: () async {
                            await launchUrl(Uri.parse('https://wa.me/5511978803756'));
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF25D366),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF25D366).withOpacity(0.3),
                                  blurRadius: 6.0,
                                  offset: Offset(0.0, 3.0),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.chat, color: Colors.white, size: 20.0),
                                SizedBox(width: 8.0),
                                Text(
                                  'WhatsApp',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
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

                // Divider com texto
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 20.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: FlutterFlowTheme.of(context).alternate)),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                        child: Text(
                          'Ou envie uma mensagem',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: FlutterFlowTheme.of(context).alternate)),
                    ],
                  ),
                ),

                // Campo Assunto
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 16.0),
                  child: DropdownButtonFormField<String>(
                    value: _selectedAssunto,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Assunto é obrigatório';
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Assunto',
                      hintText: 'Selecione o assunto',
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 2.0),
                      ),
                      prefixIcon: Icon(Icons.subject, color: FlutterFlowTheme.of(context).secondaryText),
                    ),
                    items: ['Elogio', 'Reclamação', 'Informação'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedAssunto = newValue;
                      });
                    },
                  ),
                ),

                // Campo Mensagem
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 32.0),
                  child: TextFormField(
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
                        borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary, width: 2.0),
                      ),
                      alignLabelWithHint: true,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),

                // Botão Enviar
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FFButtonWidget(
                      onPressed: _isLoading ? null : () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          HapticFeedback.lightImpact();

                          try {
                            await _enviarContato();
                            setState(() {
                              _isLoading = false;
                              _showSuccessMessage = true;
                            });

                            _model.mensagemController?.clear();
                            setState(() {
                              _selectedAssunto = null;
                            });

                            await Future.delayed(Duration(seconds: 2));
                            if (mounted) {
                              setState(() {
                                _showSuccessMessage = false;
                              });
                            }
                          } catch (e) {
                            setState(() {
                              _isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Mensagem enviada com sucesso!'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            _model.mensagemController?.clear();
                            setState(() {
                              _selectedAssunto = null;
                            });
                          }
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
                        height: 44.0,
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),

                // Mensagem de sucesso
                if (_showSuccessMessage)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 0.0),
                    child: Container(
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
                  ),

                SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
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
                InkWell(
                  onTap: () => GoRouter.of(context).goNamed('servicos'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description, color: FlutterFlowTheme.of(context).secondaryText, size: 24),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Serviços',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.message_outlined, color: FlutterFlowTheme.of(context).primary, size: 24),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        'Fale conosco',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => GoRouter.of(context).goNamed('Profile'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outlined, color: FlutterFlowTheme.of(context).secondaryText, size: 24),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Perfil',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontWeight: FontWeight.w500,
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