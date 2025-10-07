import '/flutter_flow/flutter_flow_model.dart' as ffm;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'editar_conta_model.dart';
import '../../models/user_profile.dart';
import '../../services/profile_service.dart';
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
      print('Error loading profile: $e');
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
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                )
              : hasLoginError
              ? _buildErrorScreen()
              : Form(
                  key: _model.formKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                // Seção Dados da Empresa
                Text(
                  'Dados de sua empresa',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.0),
                
                // Linha 1: Nome da empresa e Email
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome da empresa:',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          _model.isEditing
                              ? TextFormField(
                                  controller: _model.nomeEmpresaController,
                                  focusNode: _model.nomeEmpresaFocusNode,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                  validator: _model.nomeEmpresaValidator,
                                )
                              : Container(
                                  width: double.infinity,
                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE8F0F0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    userProfile?.companyName ?? 'N/A',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primaryText,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email da empresa',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8F0F0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              userProfile?.companyEmail ?? 'N/A',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                
                // Descrição da empresa
                Text(
                  'Descrição da empresa',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 8.0),
                _model.isEditing
                    ? TextFormField(
                        controller: _model.biografiaController,
                        focusNode: _model.biografiaFocusNode,
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        ),
                        validator: _model.biografiaValidator,
                      )
                    : Container(
                        width: double.infinity,
                        padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F0F0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          userProfile?.companyDescription ?? 'N/A',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                      ),
                SizedBox(height: 16.0),
                
                // Linha 2: Telefone e CNPJ
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Telefone da empresa',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8F0F0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              userProfile?.companyPhone ?? 'N/A',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CNPJ',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8F0F0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              userProfile?.companyCnpj ?? 'N/A',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
                
                // Seção Endereço
                Text(
                  'Endereço',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.0),
                
                // Linha 3: CEP e Cidade
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CEP',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          _model.isEditing
                              ? TextFormField(
                                  controller: _model.cepController,
                                  focusNode: _model.cepFocusNode,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                  validator: _model.cepValidator,
                                )
                              : Container(
                                  width: double.infinity,
                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE8F0F0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    userProfile?.companyCep ?? 'N/A',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primaryText,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cidade',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8F0F0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              userProfile?.companyAddress?.split(',').first ?? 'N/A',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                
                // Linha 4: Bairro e Rua
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bairro',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8F0F0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'N/A',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rua',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8F0F0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'N/A',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                
                // Número
                Text(
                  'Número',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F0F0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'N/A',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                
                // Seção Dados Pessoais
                Text(
                  'Dados Pessoais',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.0),
                
                // Linha 5: Nome do usuário e CPF
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nome do usuário',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          _model.isEditing
                              ? TextFormField(
                                  controller: _model.nomeCompletoController,
                                  focusNode: _model.nomeCompletoFocusNode,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).alternate,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context).primary,
                                      ),
                                    ),
                                  ),
                                  validator: _model.nomeCompletoValidator,
                                )
                              : Container(
                                  width: double.infinity,
                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE8F0F0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    userProfile?.personalName ?? 'N/A',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).primaryText,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CPF',
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFE8F0F0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              userProfile?.personalCpf ?? 'N/A',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                
                // Data de nascimento
                Text(
                  'Data de nascimento',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F0F0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'N/A',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
                
                // Botões de ação
                Row(
                  children: [
                    if (_model.isEditing) ..[
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            try {
                              final success = await _model.saveUserProfile();
                              if (success && mounted) {
                                setState(() {
                                  _model.toggleEditMode();
                                  userProfile = _model.userProfile;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Dados salvos com sucesso!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erro ao salvar dados: $e'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          text: 'Salvar',
                          options: FFButtonOptions(
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            elevation: 2.0,
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
                              _model.initializeControllers(); // Reset controllers
                            });
                          },
                          text: 'Cancelar',
                          options: FFButtonOptions(
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontWeight: FontWeight.w500,
                            ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ] else
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () {
                            setState(() {
                              _model.toggleEditMode();
                            });
                          },
                          text: 'Editar Dados',
                          options: FFButtonOptions(
                            height: 50.0,
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                            color: Colors.transparent,
                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontWeight: FontWeight.w500,
                            ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
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
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 64.0,
                color: Colors.red,
              ),
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
              onPressed: () {
                GoRouter.of(context).goNamed('Login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
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