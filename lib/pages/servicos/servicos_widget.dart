import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'servicos_model.dart';
export 'servicos_model.dart';
import '/models/servico.dart';
import '/services/servico_service.dart';
import '../test_servicos.dart';

class ServicosWidget extends StatefulWidget {
  const ServicosWidget({super.key});

  static String routeName = 'servicos';
  static String routePath = '/servicospage';

  @override
  State<ServicosWidget> createState() => _ServicosWidgetState();
}

class _ServicosWidgetState extends State<ServicosWidget> {
  late ServicosModel _model;
  List<Servico> _servicos = [];
  bool _isLoading = true;
  String? _error;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ServicosModel());
    _carregarServicos();
  }

  Future<void> _carregarServicos() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      // Buscar CNPJ da empresa logada
      final prefs = await SharedPreferences.getInstance();
      final userCnpj = prefs.getString('user_cnpj');
      
      List<Servico> servicos;
      if (userCnpj != null) {
        // Se há empresa logada, buscar serviços da empresa
        print('Buscando serviços para CNPJ: $userCnpj');
        servicos = await ServicoService.getServicosByEmpresa(userCnpj);
      } else {
        // Se não há empresa logada, buscar todos os serviços ativos
        servicos = await ServicoService.getServicosAtivos();
      }
      
      if (mounted) {
        setState(() {
          _servicos = servicos;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Erro ao carregar serviços: $e');
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget _buildServicoCard(Servico servico) {
    return GestureDetector(
      onTap: () {
        context.pushNamed('DetalhesServico', extra: servico);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              color: Color(0x0F000000),
              offset: Offset(0.0, 4.0),
            )
          ],
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary.withOpacity( 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  _getIconForCategory(servico.categoriaServico),
                  size: 24.0,
                  color: FlutterFlowTheme.of(context).primary,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servico.nomeServico,
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (servico.categoriaServico != null)
                      Text(
                        servico.categoriaServico!,
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                  ],
                ),
              ),
              if (servico.valorEstimadoServico != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary.withOpacity( 0.1),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'R\$ ${servico.valorEstimadoServico!.toStringAsFixed(2)}',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Montserrat',
                      color: FlutterFlowTheme.of(context).primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          if (servico.descricaoServico != null) ...[
            SizedBox(height: 12.0),
            Text(
              servico.descricaoServico!,
              style: FlutterFlowTheme.of(context).bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (servico.localServico != null) ...[
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16.0,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                SizedBox(width: 4.0),
                Text(
                  servico.localServico!,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
                ),
              ],
            ),
          ],
          if (servico.empresa != null) ...[
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(
                  Icons.business,
                  size: 16.0,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                SizedBox(width: 4.0),
                Text(
                  servico.empresa!.nomeEmpresa,
                  style: FlutterFlowTheme.of(context).bodySmall.override(
                    fontFamily: 'Montserrat',
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(String? categoria) {
    switch (categoria?.toLowerCase()) {
      case 'limpeza':
        return Icons.cleaning_services;
      case 'montagem':
        return Icons.build;
      case 'manutenção':
        return Icons.build_circle;
      case 'jardinagem':
        return Icons.grass;
      case 'pintura':
        return Icons.format_paint;
      default:
        return Icons.home_repair_service;
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO: Navegar para página de cadastro de serviço
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Funcionalidade de cadastro de serviços em desenvolvimento'),
                backgroundColor: FlutterFlowTheme.of(context).primary,
              ),
            );
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          child: Icon(Icons.add, color: Colors.white),
          tooltip: 'Adicionar Serviço',
        ),

        body: SafeArea(
          child: Column(
            children: [
              // Botão de voltar
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                  child: IconButton(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.arrow_back, size: 22),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Header
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              FlutterFlowTheme.of(context).primary,
                              FlutterFlowTheme.of(context).secondary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.home_repair_service,
                              size: 48.0,
                              color: Colors.white,
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Meus Serviços',
                              style: FlutterFlowTheme.of(context).headlineMedium.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Serviços cadastrados pela sua empresa',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white.withOpacity( 0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 24.0),
                      
                      // Botão de Recarregar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Serviços da Empresa',
                            style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [

                              IconButton(
                                onPressed: _carregarServicos,
                                icon: Icon(Icons.refresh),
                                tooltip: 'Recarregar serviços',
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 16.0),
                      
                      // Conteúdo dos Serviços
                      if (_isLoading)
                        Center(
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                        )
                      else if (_error != null)
                        Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity( 0.1),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Colors.red.withOpacity( 0.3)),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red, size: 48),
                              SizedBox(height: 16),
                              Text(
                                'Erro ao carregar serviços',
                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Verifique sua conexão e tente novamente',
                                style: FlutterFlowTheme.of(context).bodySmall,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _carregarServicos,
                                child: Text('Tentar Novamente'),
                              ),
                            ],
                          ),
                        )
                      else if (_servicos.isEmpty)
                        Container(
                          padding: EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 48,
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Nenhum serviço cadastrado',
                                style: FlutterFlowTheme.of(context).titleMedium,
                              ),
                              Text(
                                'Sua empresa ainda não possui serviços cadastrados',
                                style: FlutterFlowTheme.of(context).bodySmall,
                              ),
                              SizedBox(height: 16),
                              ElevatedButton.icon(
                                onPressed: () {
                                  // TODO: Navegar para página de cadastro de serviço
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Funcionalidade de cadastro de serviços em desenvolvimento'),
                                      backgroundColor: FlutterFlowTheme.of(context).primary,
                                    ),
                                  );
                                },
                                icon: Icon(Icons.add),
                                label: Text('Cadastrar Primeiro Serviço'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: FlutterFlowTheme.of(context).primary,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        // Lista de Serviços da API
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _servicos.length,
                          itemBuilder: (context, index) {
                            final servico = _servicos[index];
                            return _buildServicoCard(servico);
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
