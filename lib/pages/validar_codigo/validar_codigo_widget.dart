import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/services/recuperacao_senha_service.dart';
import 'package:flutter/material.dart';
import 'validar_codigo_model.dart';
export 'validar_codigo_model.dart';

class ValidarCodigoWidget extends StatefulWidget {
  const ValidarCodigoWidget({super.key, required this.email});

  final String email;
  static String routeName = 'ValidarCodigo';
  static String routePath = '/validar-codigo';

  @override
  State<ValidarCodigoWidget> createState() => _ValidarCodigoWidgetState();
}

class _ValidarCodigoWidgetState extends State<ValidarCodigoWidget> {
  late ValidarCodigoModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;

  void _validarCodigo(String codigo) async {
    setState(() => _loading = true);
    
    final result = await RecuperacaoSenhaService.validarToken(codigo);
    
    setState(() => _loading = false);
    
    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Código validado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      context.pushNamed('novaSenhaPosValidacao', extra: widget.email);
    } else {
      _showErrorDialog(result['message']);
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text('Erro'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _model = ValidarCodigoModel();
    _model.codigoController ??= TextEditingController();
    _model.codigoFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Validar Código',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22.0,
            ),
          ),
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Digite o Código',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Digite o código de 9 dígitos enviado para ${widget.email}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: 370.0,
                    child: TextFormField(
                      controller: _model.codigoController,
                      focusNode: _model.codigoFocusNode,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Código',
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
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  FFButtonWidget(
                    onPressed: _loading ? null : () {
                      final codigo = _model.codigoController?.text ?? '';
                      if (codigo.isNotEmpty) {
                        _validarCodigo(codigo);
                      }
                    },
                    text: _loading ? 'Validando...' : 'Validar Código',
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
          ),
        ),
      ),
    );
  }
}