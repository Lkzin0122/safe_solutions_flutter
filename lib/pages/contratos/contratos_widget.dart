import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:convert';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'contratos_model.dart';
import 'detalhes_servico_concluido_widget.dart';
import '../../services/auth_service.dart';
export 'contratos_model.dart';



class ServicoModel {
  final String id;
  final String nome;
  final String descricao;
  final String categoria;
  final String local;
  final double valor;
  final bool status;
  final String? disponibilidade;
  final String? criterios;

  ServicoModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.categoria,
    required this.local,
    required this.valor,
    required this.status,
    this.disponibilidade,
    this.criterios,
  });

  factory ServicoModel.fromJson(Map<String, dynamic> json) {
    return ServicoModel(
      id: json['id']?.toString() ?? '',
      nome: json['nome_servico']?.toString() ?? '',
      descricao: json['descricao_servico']?.toString() ?? '',
      categoria: json['categoria_servico']?.toString() ?? '',
      local: json['local_servico']?.toString() ?? '',
      valor: (json['valor_estimado_servico'] ?? 0.0).toDouble(),
      status: json['status_servico'] ?? false,
      disponibilidade: json['disponibilidade_servico']?.toString(),
      criterios: json['criterios_servico']?.toString(),
    );
  }
}

// Removed CompletedService class - using the one from contratos_model.dart instead

class ContratosWidget extends StatefulWidget {
  const ContratosWidget({
    super.key,
    this.initialTab,
  });

  final int? initialTab;

  static String routeName = 'servicos';
  static String routePath = '/servicos';

  @override
  State<ContratosWidget> createState() => _ContratosWidgetState();
}

class _ContratosWidgetState extends State<ContratosWidget> {
  late ContratosModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<ServicoModel> _servicos = [];
  bool _isLoading = true;
  String? _error;
  String? _userCnpj;
  String _searchQuery = '';
  bool hasLoginError = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContratosModel());

    if (widget.initialTab == 1) {
      _model.isCompletedExpanded = true;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkLoginAndLoadData();
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> _checkLoginAndLoadData() async {
    try {
      final isLoggedIn = await AuthService.isLoggedIn();
      
      if (!isLoggedIn) {
        if (mounted) {
          setState(() {
            hasLoginError = true;
            _isLoading = false;
          });
        }
        return;
      }
      
      await _loadUserCnpj();
      if (_userCnpj != null) {
        _loadServicos();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          hasLoginError = true;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadUserCnpj() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userCnpj = prefs.getString('user_cnpj');
    });
  }

  Future<void> _loadServicos() async {
    if (_userCnpj == null) return;
    
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final servicos = await fetchServicosEmpresa(_userCnpj!);

      setState(() {
        _servicos = servicos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<List<ServicoModel>> fetchServicosEmpresa(String cnpj) async {
    final url = Uri.parse('http://localhost:8080/servico/empresa/$cnpj');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => ServicoModel.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao buscar serviços: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  List<ServicoModel> get _servicosAtivos {
    var servicos = _servicos.where((servico) => servico.status == true).toList();

    if (_searchQuery.isNotEmpty) {
      servicos = servicos
          .where((servico) =>
              servico.nome.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              servico.descricao
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return servicos;
  }

  List<ServicoModel> get _servicosConcluidos {
    var servicos = _servicos.where((servico) => servico.status == false).toList();

    if (_searchQuery.isNotEmpty) {
      servicos = servicos
          .where((servico) =>
              servico.nome.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              servico.descricao
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return servicos;
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  Widget _buildServicoFromBackend(ServicoModel servico,
      {bool isCompleted = false}) {
    String imageUrl = _getDefaultImageForService(servico.nome);
    String description = '${servico.descricao}\nLocal: ${servico.local}\nValor: R\$ ${servico.valor.toStringAsFixed(2)}';

    if (isCompleted) {
      final completedService = CompletedService(
        id: servico.id,
        title: servico.nome,
        description: servico.descricao,
        completedDate: servico.disponibilidade ?? 'Data não informada',
        rating: 5.0,
        icon: Icons.check_circle,
      );
      return _buildCompletedServiceCard(service: completedService);
    }

    return _buildServiceCard(
      title: servico.nome,
      description: description,
      imageUrl: imageUrl,
      onTap: () {
        // Navegar para detalhes do serviço
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Detalhes do serviço: ${servico.nome}'),
            backgroundColor: FlutterFlowTheme.of(context).primary,
          ),
        );
      },
    );
  }

  String _getDefaultImageForService(String serviceName) {
    final name = serviceName.toLowerCase();
    if (name.contains('montador') || name.contains('montagem')) {
      return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/zqwlt240p7sd/image_17.png';
    } else if (name.contains('clean') || name.contains('limpeza')) {
      return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/dfq8wa491iyv/image_17_(1).png';
    } else if (name.contains('tecno') || name.contains('hardware')) {
      return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/42x886euiaf7/image_20_1.png';
    }
    return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/zqwlt240p7sd/image_17.png';
  }

  Widget _buildLoadingWidget() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 40.0, 24.0, 40.0),
      child: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16.0),
            Text(
              'Carregando serviços...',
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 40.0, 24.0, 40.0),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Erro ao carregar serviços',
              style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'Montserrat',
                    color: Colors.red,
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              _error ?? 'Erro desconhecido',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodySmall,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _loadServicos,
              style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary,
              ),
              child: const Text('Tentar Novamente',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 40.0, 24.0, 40.0),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.description_outlined,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 48.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Nenhum serviço encontrado',
              style: FlutterFlowTheme.of(context).titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              _searchQuery.isNotEmpty
                  ? 'Não encontramos serviços com o termo "$_searchQuery"'
                  : 'Você ainda não possui serviços contratados.',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String description,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 8.0),
      child: Material(
        color: Colors.transparent,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: double.infinity,
            height: 120.0,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 16.0, 16.0, 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      imageUrl,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Icon(Icons.image, color: Colors.grey[600]),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 16.0, 16.0, 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style:
                              FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Montserrat',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style:
                              FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[600],
                    size: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedServiceCard({
    required CompletedService service,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 8.0),
      child: Material(
        color: Colors.transparent,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetalhesServicoConcluidoWidget(service: service),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: FlutterFlowTheme.of(context).alternate,
                width: 1.0,
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
              child: Row(
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondary
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(
                      service.icon,
                      color: FlutterFlowTheme.of(context).secondary,
                      size: 30.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.title,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          service.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'Montserrat',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: FlutterFlowTheme.of(context).success,
                              size: 16.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              'Concluído em ${service.completedDate}',
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).success,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        8.0, 0.0, 0.0, 0.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 16.0,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: hasLoginError
              ? _buildErrorScreen()
              : RefreshIndicator(
                  onRefresh: _loadServicos,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                children: [
                  // Logo padronizada
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        24.0, 20.0, 24.0, 20.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 4.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: Image.network(
                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/mor10gnszw4j/WhatsApp_Image_2025-05-31_at_12.34.51.jpeg',
                          width: 250.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  // Campo de busca e botão calendário
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        24.0, 20.0, 24.0, 0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                  color:
                                      FlutterFlowTheme.of(context).alternate),
                            ),
                            child: TextField(
                              onChanged: _updateSearchQuery,
                              decoration: InputDecoration(
                                hintText: 'Buscar serviços...',
                                prefixIcon: Icon(Icons.search,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(12.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: IconButton(
                            onPressed: () => GoRouter.of(context).goNamed('Calendario'),
                            icon: const Icon(Icons.calendar_month,
                                color: Colors.white),
                            tooltip: 'Ver Calendário',
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_isLoading)
                    _buildLoadingWidget()
                  else if (_error != null)
                    _buildErrorWidget()
                  else if (_servicos.isEmpty)
                    _buildEmptyWidget()
                  else ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 20.0, 24.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Serviços em Andamento',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8.0),
                          Container(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12.0, 6.0, 12.0, 6.0),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).success,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(
                              _searchQuery.isEmpty
                                  ? '${_servicosAtivos.length} Ativos'
                                  : '${_servicosAtivos.length} Encontrados',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    if (_servicosAtivos.isEmpty && _searchQuery.isNotEmpty)
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 20.0, 24.0, 20.0),
                        child: Text(
                          'Nenhum serviço ativo encontrado com "$_searchQuery"',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      )
                    else
                      ..._servicosAtivos
                          .map((servico) => _buildServicoFromBackend(servico)),
                    const SizedBox(height: 30.0),
                    if (_servicosConcluidos.isNotEmpty ||
                        _searchQuery.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _model.isCompletedExpanded =
                                  !_model.isCompletedExpanded;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Serviços Concluídos',
                                      style: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily: 'Montserrat',
                                            color: FlutterFlowTheme.of(context)
                                                .tertiary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Container(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              8.0, 4.0, 8.0, 4.0),
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Text(
                                        _searchQuery.isEmpty
                                            ? '${_servicosConcluidos.length} Concluídos'
                                            : '${_servicosConcluidos.length} Encontrados',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  _model.isCompletedExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedCrossFade(
                        firstChild: const SizedBox.shrink(),
                        secondChild: Column(
                          children: [
                            const SizedBox(height: 10.0),
                            if (_servicosConcluidos.isEmpty &&
                                _searchQuery.isNotEmpty)
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 20.0, 24.0, 20.0),
                                child: Text(
                                  'Nenhum serviço concluído encontrado com "$_searchQuery"',
                                  style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            else
                              ..._servicosConcluidos.map((servico) =>
                                  _buildServicoFromBackend(servico,
                                      isCompleted: true)),
                          ],
                        ),
                        crossFadeState: _model.isCompletedExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ],
                  ],
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
                offset: const Offset(0.0, -2.0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .primary
                            .withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.description,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        'Serviços',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodySmallFamily,
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: !FlutterFlowTheme.of(context)
                                  .bodySmallIsCustom,
                            ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    GoRouter.of(context).goNamed('FaleConosco');
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.message_outlined,
                        color: Color(0xFF888888),
                        size: 24,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Fale conosco',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodySmallFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodySmallIsCustom,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    GoRouter.of(context).goNamed('Profile');
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_outlined,
                        color: Color(0xFF888888),
                        size: 24,
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Perfil',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodySmallFamily,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                useGoogleFonts: !FlutterFlowTheme.of(context)
                                    .bodySmallIsCustom,
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
