import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'editar_conta_model.dart';
export 'editar_conta_model.dart';

class EditarContaWidget extends StatefulWidget {
  const EditarContaWidget({super.key});

  static String routeName = 'editarConta';
  static String routePath = '/editarConta';

  @override
  State<EditarContaWidget> createState() => _EditarContaWidgetState();
}

class _EditarContaWidgetState extends State<EditarContaWidget> {
  late EditarContaModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showSuccessMessage = false;
  bool _isLoading = false;
  bool _photoChanged = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditarContaModel());
    
    // Initialize controllers
    _model.nomeCompletoController ??= TextEditingController();
    _model.nomeCompletoFocusNode ??= FocusNode();
    
    _model.emailController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();
    
    _model.telefoneController ??= TextEditingController();
    _model.telefoneFocusNode ??= FocusNode();
    
    _model.cpfController ??= TextEditingController();
    _model.cpfFocusNode ??= FocusNode();
    
    _model.biografiaController ??= TextEditingController();
    _model.biografiaFocusNode ??= FocusNode();
    
    // Load user data (example with email)
    _loadUserData();
  }
  
  void _loadUserData() async {
    setState(() {
      _isLoading = true;
    });
    
    // Example: load user by email or CPF
    const String userIdentifier = 'safesolutionsempresa@gmail.com'; // or CPF
    await _model.loadUserData(userIdentifier);
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _salvarDados() async {
    if (_model.formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      try {
        bool success = await _model.saveUserData();
        
        if (success) {
          setState(() {
            _showSuccessMessage = true;
          });
          
          HapticFeedback.lightImpact();
          
          await Future.delayed(Duration(seconds: 2));
          if (mounted) {
            Navigator.of(context).pop();
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao salvar dados. Tente novamente.'),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro de conexão. Verifique sua internet.'),
            backgroundColor: FlutterFlowTheme.of(context).error,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
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
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).tertiary,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          title: Text(
            'Editar Conta',
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
          child: Form(
            key: _model.formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Foto de perfil
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).tertiary,
                              width: 3.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8.0,
                                color: FlutterFlowTheme.of(context).tertiary.withOpacity(0.2),
                                offset: Offset(0.0, 4.0),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: _photoChanged
                                ? Container(
                                    color: FlutterFlowTheme.of(context).tertiary,
                                    child: Icon(
                                      Icons.person,
                                      size: 60.0,
                                      color: Colors.white,
                                    ),
                                  )
                                : Container(
                                    color: FlutterFlowTheme.of(context).tertiary,
                                    child: Icon(
                                      Icons.account_circle,
                                      size: 80.0,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                _photoChanged = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Foto alterada com sucesso!'),
                                  backgroundColor: FlutterFlowTheme.of(context).success,
                                ),
                              );
                            },
                            child: Container(
                              width: 35.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tertiary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0.0, 2.0),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.folder_open,
                                color: Colors.white,
                                size: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.0),
                  
                  // Campo Nome Completo
                  Text(
                    'Nome Completo',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _model.nomeCompletoController,
                    focusNode: _model.nomeCompletoFocusNode,
                    validator: _model.nomeCompletoValidator?.asValidator(context),
                    decoration: InputDecoration(
                      hintText: 'Digite seu nome completo',
                      hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiary,
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    textCapitalization: TextCapitalization.words,
                  ),
                  SizedBox(height: 20.0),
                  
                  // Campo Email
                  Text(
                    'Email',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _model.emailController,
                    focusNode: _model.emailFocusNode,
                    validator: _model.emailValidator?.asValidator(context),
                    decoration: InputDecoration(
                      hintText: 'Digite seu email',
                      hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiary,
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.0),
                  
                  // Campo Telefone
                  Text(
                    'Telefone',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _model.telefoneController,
                    focusNode: _model.telefoneFocusNode,
                    validator: _model.telefoneValidator?.asValidator(context),
                    decoration: InputDecoration(
                      hintText: '(11) 99999-9999',
                      hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiary,
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 20.0),
                  
                  // Campo CPF
                  Text(
                    'CPF',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _model.cpfController,
                    focusNode: _model.cpfFocusNode,
                    validator: _model.cpfValidator?.asValidator(context),
                    decoration: InputDecoration(
                      hintText: '000.000.000-00',
                      hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiary,
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                      prefixIcon: Icon(
                        Icons.badge_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20.0),
                  
                  // Campo Sobre a Empresa
                  Text(
                    'Sobre a Empresa',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: _model.biografiaController,
                    focusNode: _model.biografiaFocusNode,
                    validator: _model.biografiaValidator?.asValidator(context),
                    decoration: InputDecoration(
                      hintText: 'Conte um pouco sobre você ou sua empresa...',
                      hintStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiary,
                          width: 2.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                      alignLabelWithHint: true,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    maxLines: 4,
                    maxLength: 500,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  SizedBox(height: 32.0),
                  
                  // Botões
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Botão Cancelar
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          text: 'Cancelar',
                          options: FFButtonOptions(
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontWeight: FontWeight.w600,
                            ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      
                      // Botão Salvar
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: _isLoading ? null : _salvarDados,
                          text: _isLoading ? 'Salvando...' : 'Salvar',
                          icon: _isLoading 
                            ? SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 2.0,
                                ),
                              )
                            : null,
                          options: FFButtonOptions(
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).tertiary,
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
                  
                  // Mensagem de sucesso
                  if (_showSuccessMessage)
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).success,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: FlutterFlowTheme.of(context).success.withOpacity(0.3),
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          SizedBox(width: 12.0),
                          Text(
                            'Dados salvos com sucesso!',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
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

      ),
    );
  }
}