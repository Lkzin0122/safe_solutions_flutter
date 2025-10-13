import '/flutter_flow/flutter_flow_model.dart' as ffm;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'editar_conta_model.dart';
import '../../models/user_profile.dart';
export 'editar_conta_model.dart';

class EditarContaWidget extends StatefulWidget {
  const EditarContaWidget({super.key});

  @override
  State<EditarContaWidget> createState() => _EditarContaWidgetState();
}

class _EditarContaWidgetState extends State<EditarContaWidget> {
  late EditarContaModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  UserProfile? userProfile;
  bool isLoading = true;
  bool hasLoginError = false;

  @override
  void initState() {
    super.initState();
    _model = ffm.createModel(context, () => EditarContaModel());
    _checkLoginAndLoadProfile();
  }

  Future<void> _checkLoginAndLoadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userCnpj = prefs.getString('user_cnpj');
      final empresaData = prefs.getString('empresa_data');
      
      if (userCnpj == null || empresaData == null) {
        if (mounted) {
          setState(() {
            hasLoginError = true;
            isLoading = false;
          });
        }
        return;
      }
      
      await _loadUserProfile();
    } catch (e) {
      if (mounted) {
        setState(() {
          hasLoginError = true;
          isLoading = false;
        });
      }
    }
  }

  Future<void> _loadUserProfile() async {
    try {
      await _model.loadUserProfile();
      if (mounted) {
        setState(() {
          userProfile = _model.userProfile;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          hasLoginError = true;
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget _buildField(String label, String? value, TextEditingController? controller, FocusNode? focusNode, FormFieldValidator<String>? validator, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
            fontFamily: 'Montserrat',
            color: Colors.blue,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.0),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _model.isEditing && controller != null
              ? TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  maxLines: maxLines,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                    ),
                  ),
                  validator: validator,
                )
              : Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 14.0, 16.0, 14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        FlutterFlowTheme.of(context).primaryBackground,
                        FlutterFlowTheme.of(context).secondaryBackground,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate.withOpacity(0.5),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    value ?? 'N/A',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 15.0,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: isLoading ? null : AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.blue.shade700,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 28.0),
          ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.3),
          title: Text(
            'Editar Conta',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.3),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: isLoading
            ? Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      FlutterFlowTheme.of(context).primaryBackground,
                      FlutterFlowTheme.of(context).secondaryBackground,
                    ],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        strokeWidth: 3.0,
                      ).animate().scale(duration: 1000.ms, curve: Curves.easeInOut),
                      SizedBox(height: 24),
                      Text(
                        'Carregando dados...',
                        style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ).animate().fadeIn(duration: 800.ms),
                    ],
                  ),
                ),
              )
            : SafeArea(
                child: hasLoginError
                    ? _buildErrorScreen()
                    : Form(
                        key: _model.formKey,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                FlutterFlowTheme.of(context).primaryBackground,
                                FlutterFlowTheme.of(context).secondaryBackground.withOpacity(0.3),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: SingleChildScrollView(
                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 32.0, 24.0, 32.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue.withOpacity(0.1),
                                        Colors.blue.withOpacity(0.05),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: Colors.blue.withOpacity(0.2),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Icon(
                                          Icons.business,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                      ),
                                      SizedBox(width: 16.0),
                                      Text(
                                        'Dados da Empresa',
                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3),
                        SizedBox(height: 20.0),
                        
                        Row(
                          children: [
                            Expanded(child: _buildField('Nome da empresa', userProfile?.companyName, _model.nomeEmpresaController, _model.nomeEmpresaFocusNode, _model.nomeEmpresaValidator)),
                            SizedBox(width: 16.0),
                            Expanded(child: _buildField('Email da empresa', userProfile?.companyEmail, null, null, null)),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        
                        _buildField('Descrição da empresa', userProfile?.companyDescription, _model.biografiaController, _model.biografiaFocusNode, _model.biografiaValidator, maxLines: 3),
                        SizedBox(height: 16.0),
                        
                        Row(
                          children: [
                            Expanded(child: _buildField('Telefone da empresa', userProfile?.companyPhone, null, null, null)),
                            SizedBox(width: 16.0),
                            Expanded(child: _buildField('CNPJ', userProfile?.companyCnpj, null, null, null)),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        
                                Container(
                                  padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue.withOpacity(0.1),
                                        Colors.blue.withOpacity(0.05),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: Colors.blue.withOpacity(0.2),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                      ),
                                      SizedBox(width: 16.0),
                                      Text(
                                        'Endereço',
                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3),
                        SizedBox(height: 20.0),
                        
                        Row(
                          children: [
                            Expanded(child: _buildField('CEP', userProfile?.companyCep, _model.cepController, _model.cepFocusNode, _model.cepValidator)),
                            SizedBox(width: 16.0),
                            Expanded(child: _buildField('Endereço', userProfile?.companyAddress, _model.enderecoController, _model.enderecoFocusNode, _model.enderecoValidator)),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        
                                Container(
                                  padding: EdgeInsets.all(20.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue.withOpacity(0.1),
                                        Colors.blue.withOpacity(0.05),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: Colors.blue.withOpacity(0.2),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(12.0),
                                        ),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 24.0,
                                        ),
                                      ),
                                      SizedBox(width: 16.0),
                                      Text(
                                        'Dados Pessoais',
                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                          fontFamily: 'Montserrat',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ).animate().fadeIn(duration: 1000.ms).slideY(begin: 0.3),
                        SizedBox(height: 20.0),
                        
                        Row(
                          children: [
                            Expanded(child: _buildField('Nome do usuário', userProfile?.personalName, _model.nomeCompletoController, _model.nomeCompletoFocusNode, _model.nomeCompletoValidator)),
                            SizedBox(width: 16.0),
                            Expanded(child: _buildField('CPF', userProfile?.personalCpf, null, null, null)),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        
                        _buildField('Telefone pessoal', userProfile?.personalPhone, _model.telefoneController, _model.telefoneFocusNode, _model.telefoneValidator),
                        SizedBox(height: 32.0),
                        
                                Container(
                                  padding: EdgeInsets.all(24.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        FlutterFlowTheme.of(context).primaryBackground,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10.0,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      if (_model.isEditing) ...[
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.blue,
                                                  Colors.blue.shade700,
                                                ],
                                              ),
                                              borderRadius: BorderRadius.circular(12.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.blue.withOpacity(0.3),
                                                  blurRadius: 8.0,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                try {
                                                  if (_model.formKey.currentState?.validate() ?? false) {
                                                    final success = await _model.saveUserProfile();
                                                    if (success && mounted) {
                                                      setState(() {
                                                        _model.toggleEditMode();
                                                        userProfile = _model.userProfile;
                                                      });
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Row(
                                                            children: [
                                                              Icon(Icons.check_circle, color: Colors.white),
                                                              SizedBox(width: 8),
                                                              Text('Dados salvos com sucesso!'),
                                                            ],
                                                          ),
                                                          backgroundColor: Colors.green,
                                                          behavior: SnackBarBehavior.floating,
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                        ),
                                                      );
                                                    }
                                                  } else {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Row(
                                                          children: [
                                                            Icon(Icons.warning, color: Colors.white),
                                                            SizedBox(width: 8),
                                                            Text('Por favor, corrija os erros'),
                                                          ],
                                                        ),
                                                        backgroundColor: Colors.orange,
                                                        behavior: SnackBarBehavior.floating,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                      ),
                                                    );
                                                  }
                                                } catch (e) {
                                                  if (mounted) {
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Row(
                                                          children: [
                                                            Icon(Icons.error, color: Colors.white),
                                                            SizedBox(width: 8),
                                                            Expanded(child: Text('Erro ao salvar: ${e.toString()}')),
                                                          ],
                                                        ),
                                                        backgroundColor: Colors.red,
                                                        behavior: SnackBarBehavior.floating,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              text: 'Salvar Alterações',
                                              icon: Icon(Icons.save, color: Colors.white, size: 20),
                                              options: FFButtonOptions(
                                                height: 56.0,
                                                color: Colors.transparent,
                                                textStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                            ),
                                          ).animate().scale(duration: 200.ms).then().shimmer(duration: 1000.ms),
                                        ),
                                        SizedBox(width: 16.0),
                                        Expanded(
                                          child: FFButtonWidget(
                                            onPressed: () {
                                              setState(() {
                                                _model.toggleEditMode();
                                                _model.initializeControllers();
                                              });
                                            },
                                            text: 'Cancelar',
                                            icon: Icon(Icons.close, color: FlutterFlowTheme.of(context).secondaryText, size: 20),
                                            options: FFButtonOptions(
                                              height: 56.0,
                                              color: Colors.transparent,
                                              textStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                                fontFamily: 'Montserrat',
                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.0,
                                              ),
                                              borderSide: BorderSide(
                                                color: FlutterFlowTheme.of(context).alternate,
                                                width: 2.0,
                                              ),
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                          ).animate().fadeIn(duration: 300.ms),
                                        ),
                                      ] else
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.blue,
                                                  Colors.blue.shade700,
                                                ],
                                              ),
                                              borderRadius: BorderRadius.circular(12.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.blue.withOpacity(0.3),
                                                  blurRadius: 8.0,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: FFButtonWidget(
                                              onPressed: () => setState(() => _model.toggleEditMode()),
                                              text: 'Editar Dados',
                                              icon: Icon(Icons.edit, color: Colors.white, size: 20),
                                              options: FFButtonOptions(
                                                height: 56.0,
                                                color: Colors.transparent,
                                                textStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                                borderRadius: BorderRadius.circular(12.0),
                                              ),
                                            ),
                                          ).animate().scale(duration: 200.ms).then().shimmer(duration: 1500.ms),
                                        ),
                                    ],
                                  ),
                                ).animate().fadeIn(duration: 1200.ms).slideY(begin: 0.3),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.red.withOpacity(0.2),
                    Colors.red.withOpacity(0.05),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline, size: 64.0, color: Colors.red),
            ).animate().scale(duration: 500.ms).then().shake(),
            const SizedBox(height: 24.0),
            Text(
              'Acesso Negado',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Montserrat',
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Você precisa fazer login para acessar esta página.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Montserrat',
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
            ),
            const SizedBox(height: 32.0),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.blue.shade700,
                  ],
                ),
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () => GoRouter.of(context).goNamed('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.login, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Fazer Login',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().scale(duration: 300.ms).then().shimmer(duration: 1000.ms),
          ],
        ),
      ),
    );
  }
}