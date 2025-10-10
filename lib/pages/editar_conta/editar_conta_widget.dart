import '/flutter_flow/flutter_flow_model.dart' as ffm;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
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
            color: FlutterFlowTheme.of(context).secondaryText,
            fontSize: 14.0,
          ),
        ),
        SizedBox(height: 8.0),
        _model.isEditing && controller != null
            ? TextFormField(
                controller: controller,
                focusNode: focusNode,
                maxLines: maxLines,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: FlutterFlowTheme.of(context).primary),
                  ),
                ),
                validator: validator,
              )
            : Container(
                width: double.infinity,
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                decoration: BoxDecoration(
                  color: Color(0xFFE8F0F0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  value ?? 'N/A',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).primaryText,
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
          backgroundColor: FlutterFlowTheme.of(context).tertiary,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30.0),
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
        body: isLoading
            ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(FlutterFlowTheme.of(context).primary)))
            : SafeArea(
                child: hasLoginError
                    ? _buildErrorScreen()
                    : Form(
                        key: _model.formKey,
                        child: SingleChildScrollView(
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                        Text(
                          'Dados da Empresa',
                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                            fontFamily: 'Montserrat',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                        
                        Text(
                          'Endereço',
                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                            fontFamily: 'Montserrat',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        
                        Row(
                          children: [
                            Expanded(child: _buildField('CEP', userProfile?.companyCep, _model.cepController, _model.cepFocusNode, _model.cepValidator)),
                            SizedBox(width: 16.0),
                            Expanded(child: _buildField('Endereço', userProfile?.companyAddress, _model.enderecoController, _model.enderecoFocusNode, _model.enderecoValidator)),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        
                        Text(
                          'Dados Pessoais',
                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                            fontFamily: 'Montserrat',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
                        
                        Row(
                          children: [
                            if (_model.isEditing) ...[
                              Expanded(
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
                                            SnackBar(content: Text('Dados salvos com sucesso!'), backgroundColor: Colors.green),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Por favor, corrija os erros no formulário'), backgroundColor: Colors.orange),
                                        );
                                      }
                                    } catch (e) {
                                      print('Erro ao salvar: $e');
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Erro ao salvar dados: ${e.toString()}'), backgroundColor: Colors.red),
                                        );
                                      }
                                    }
                                  },
                                  text: 'Salvar',
                                  options: FFButtonOptions(
                                    height: 50.0,
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
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
                                  options: FFButtonOptions(
                                    height: 50.0,
                                    color: Colors.transparent,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ] else
                              Expanded(
                                child: FFButtonWidget(
                                  onPressed: () => setState(() => _model.toggleEditMode()),
                                  text: 'Editar Dados',
                                  options: FFButtonOptions(
                                    height: 50.0,
                                    color: Colors.transparent,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).secondaryText,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                          ],
                        ),
                            ],
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
                color: Colors.red.withOpacity( 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline, size: 64.0, color: Colors.red),
            ),
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
            ElevatedButton(
              onPressed: () => GoRouter.of(context).goNamed('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
              child: Text(
                'Fazer Login',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
