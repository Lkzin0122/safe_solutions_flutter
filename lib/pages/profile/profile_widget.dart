import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'profile_model.dart';
import '../../services/empresa_service.dart';
export 'profile_model.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  static String routeName = 'profile';
  static String routePath = '/profile';

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget>
    with TickerProviderStateMixin {
  late ProfileModel _model;
  Map<String, dynamic>? empresaData;
  bool isLoading = true;
  bool hasLoginError = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());
    _checkLoginAndLoadProfile();

    animationsMap.addAll({
      'cardOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.6, 0.6),
            end: const Offset(1.0, 1.0),
          ),
        ],
      ),
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 60.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 200.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 200.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 30.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  Future<void> _checkLoginAndLoadProfile() async {
    try {
      final data = await EmpresaService.getEmpresaData();
      final isLoggedIn = await EmpresaService.isLoggedIn();
      
      if (!isLoggedIn || data == null) {
        if (mounted) {
          setState(() {
            hasLoginError = true;
            isLoading = false;
          });
        }
        return;
      }
      
      if (mounted) {
        setState(() {
          empresaData = data;
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

  String _formatCnpj(String cnpj) {
    if (cnpj.isEmpty) return '';
    final numbers = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    if (numbers.length != 14) return cnpj;
    return '${numbers.substring(0, 2)}.${numbers.substring(2, 5)}.${numbers.substring(5, 8)}/${numbers.substring(8, 12)}-${numbers.substring(12, 14)}';
  }

  String _getFullAddress() {
    if (empresaData == null) return 'São Paulo, SP';
    
    final rua = empresaData!['rua'] ?? '';
    final numero = empresaData!['numero'] ?? '';
    final bairro = empresaData!['bairro'] ?? '';
    final cidade = empresaData!['cidade'] ?? '';
    final cep = empresaData!['cep'] ?? '';
    
    List<String> addressParts = [];
    if (rua.isNotEmpty) {
      if (numero.isNotEmpty) {
        addressParts.add('$rua, $numero');
      } else {
        addressParts.add(rua);
      }
    }
    if (bairro.isNotEmpty) addressParts.add(bairro);
    if (cidade.isNotEmpty) addressParts.add(cidade);
    if (cep.isNotEmpty) addressParts.add('CEP: $cep');
    
    return addressParts.isNotEmpty ? addressParts.join(', ') : 'São Paulo, SP';
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
          top: true,
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
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24.0, 80.0, 24.0, 30.0),
                        child: Stack(
                          children: [
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
                            Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: InkWell(
                                onTap: () => GoRouter.of(context).pushNamed('Configuracoes'),
                                child: Container(
                                  width: 24.0,
                                  height: 24.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    borderRadius: BorderRadius.circular(12.0),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0.0, 2.0),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.settings,
                                    color: FlutterFlowTheme.of(context).primaryText,
                                    size: 12.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: FlutterFlowTheme.of(context).primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Container(
                          width: 95.0,
                          height: 95.0,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.account_circle,
                            size: 95.0,
                            color: Colors.white,
                          ),
                        ),
                      ).animateOnPageLoad(animationsMap['cardOnPageLoadAnimation']!),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                        child: Text(
                          empresaData?['nome_empresa'] ?? 'Tech Solutions',
                          style: FlutterFlowTheme.of(context).headlineSmall.override(
                                fontFamily: FlutterFlowTheme.of(context).headlineSmallFamily,
                                color: FlutterFlowTheme.of(context).primary,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: !FlutterFlowTheme.of(context).headlineSmallIsCustom,
                              ),
                        ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                        child: Text(
                          _formatCnpj(empresaData?['cnpj'] ?? ''),
                          style: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                color: FlutterFlowTheme.of(context).tertiary,
                                letterSpacing: 0.0,
                                useGoogleFonts: !FlutterFlowTheme.of(context).titleSmallIsCustom,
                              ),
                        ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
                      ),
                      Divider(
                        height: 44.0,
                        thickness: 1.0,
                        indent: 24.0,
                        endIndent: 24.0,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                                  width: 1.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 8.0,
                                    color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                    offset: Offset(0.0, 4.0),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Icon(
                                          Icons.info_outline,
                                          color: FlutterFlowTheme.of(context).primary,
                                          size: 20.0,
                                        ),
                                      ),
                                      SizedBox(width: 12.0),
                                      Text(
                                        'Sobre a Empresa',
                                        style: FlutterFlowTheme.of(context).titleMedium.override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterFlowTheme.of(context).primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    empresaData?['descricao_empresa'] ?? 'Empresa especializada em soluções tecnológicas.',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Montserrat',
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ],
                              ),
                            ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
                            SizedBox(height: 20.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                                        width: 1.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 8.0,
                                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                          offset: Offset(0.0, 4.0),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Icon(
                                            Icons.phone_outlined,
                                            color: FlutterFlowTheme.of(context).primary,
                                            size: 24.0,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'Telefone',
                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          empresaData?['telefone_empresa'] ?? '(11) 99999-9999',
                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.0),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      borderRadius: BorderRadius.circular(16.0),
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                                        width: 1.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 8.0,
                                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                          offset: Offset(0.0, 4.0),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Icon(
                                            Icons.business_outlined,
                                            color: FlutterFlowTheme.of(context).primary,
                                            size: 24.0,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          'CNPJ',
                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          _formatCnpj(empresaData?['cnpj'] ?? ''),
                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context).primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
                            SizedBox(height: 16.0),
                            InkWell(
                              onTap: () async {
                                final address = _getFullAddress();
                                final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}');
                                await launchUrl(url);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                                    width: 1.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 8.0,
                                      color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                      offset: Offset(0.0, 4.0),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12.0),
                                      ),
                                      child: Icon(
                                        Icons.location_on_outlined,
                                        color: FlutterFlowTheme.of(context).primary,
                                        size: 28.0,
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Localização',
                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).secondaryText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            _getFullAddress(),
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            'Toque para abrir no Google Maps',
                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                              fontFamily: 'Montserrat',
                                              color: FlutterFlowTheme.of(context).tertiary,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.open_in_new,
                                      color: FlutterFlowTheme.of(context).primary,
                                      size: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
                            SizedBox(height: 24.0),
                          ],
                        ),
                      ),
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
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            border: Border(
              top: BorderSide(
                color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                width: 1.0,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                blurRadius: 16.0,
                offset: Offset(0.0, -4.0),
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
                          'Serviços',
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
                InkWell(
                  onTap: () => GoRouter.of(context).pushNamed('FaleConosco'),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.message_outlined,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Fale conosco',
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
                InkWell(
                  onTap: () => GoRouter.of(context).pushNamed('Profile'),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_outlined,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Perfil',
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
                ),
              ],
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