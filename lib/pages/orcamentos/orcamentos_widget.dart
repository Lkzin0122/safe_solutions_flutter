import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../models/orcamento.dart';
import '../../services/orcamento_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'detalhes_orcamento_widget.dart';

class OrcamentosWidget extends StatefulWidget {
  const OrcamentosWidget({Key? key}) : super(key: key);

  @override
  State<OrcamentosWidget> createState() => _OrcamentosWidgetState();
}

class _OrcamentosWidgetState extends State<OrcamentosWidget> {
  List<Orcamento> _orcamentos = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _carregarOrcamentos();
  }

  Future<void> _carregarOrcamentos() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final prefs = await SharedPreferences.getInstance();
      final cpf = prefs.getString('user_cpf');
      
      if (cpf != null && cpf.isNotEmpty) {
        final orcamentos = await OrcamentoService.getOrcamentosPorCpf(cpf);
        final orcamentosFiltrados = orcamentos.where((orcamento) => 
          orcamento.statusOrcamento != StatusEnum.FINALIZADO
        ).toList();
        setState(() {
          _orcamentos = orcamentosFiltrados;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'CPF do usuário não encontrado nas preferências';
          _isLoading = false;
        });
      }
    } catch (e) {
      String errorMessage;
      if (e.toString().contains('Erro de conexão com o servidor')) {
        errorMessage = 'Não foi possível conectar ao servidor. Verifique sua conexão.';
      } else if (e.toString().contains('404')) {
        errorMessage = 'Serviço não encontrado. Verifique se o servidor está rodando.';
      } else {
        errorMessage = 'Erro inesperado: ${e.toString().replaceAll('Exception: ', '')}';
      }
      
      setState(() {
        _error = errorMessage;
        _isLoading = false;
      });
    }
  }

  Color _getStatusColor(StatusEnum? status) {
    switch (status) {
      case StatusEnum.PENDENTE:
        return Colors.orange;
      case StatusEnum.ACEITO:
        return Colors.green;
      case StatusEnum.RECUSADO:
        return Colors.red;
      case StatusEnum.EM_ANDAMENTO:
        return Colors.blue;
      case StatusEnum.FINALIZADO:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: Text(
          'Meus Orçamentos',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: FlutterFlowTheme.of(context).error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _error!,
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FFButtonWidget(
                        onPressed: _carregarOrcamentos,
                        text: 'Tentar Novamente',
                        options: FFButtonOptions(
                          width: 200,
                          height: 40,
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                              ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                )
              : _orcamentos.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 64,
                            color: FlutterFlowTheme.of(context).secondaryText,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhum orçamento encontrado',
                            style: FlutterFlowTheme.of(context).bodyLarge,
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _carregarOrcamentos,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _orcamentos.length,
                        itemBuilder: (context, index) {
                          final orcamento = _orcamentos[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () {
                                if (orcamento.id != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetalhesOrcamentoWidget(
                                        orcamentoId: orcamento.id!,
                                      ),
                                    ),
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          orcamento.servico?.nomeServico ?? 'Serviço não informado',
                                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(orcamento.statusOrcamento),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Text(
                                          orcamento.statusTexto,
                                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                                fontFamily: 'Montserrat',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                    ),
                                    const SizedBox(height: 12),
                                    if (orcamento.detalhesOrcamento != null) ...[
                                      Text(
                                        'Detalhes:',
                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        orcamento.detalhesOrcamento!,
                                        style: FlutterFlowTheme.of(context).bodySmall,
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                    if (orcamento.enderecoOrcamento != null) ...[
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 16,
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              orcamento.enderecoOrcamento!,
                                              style: FlutterFlowTheme.of(context).bodySmall,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                    if (orcamento.valorServico != null) ...[
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.attach_money,
                                            size: 16,
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'R\$ ${orcamento.valorServico!.toStringAsFixed(2)}',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                  color: FlutterFlowTheme.of(context).primary,
                                                ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                    if (orcamento.dataSolicitacao != null) ...[
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today_outlined,
                                            size: 16,
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Solicitado em: ${orcamento.dataSolicitacao!.day.toString().padLeft(2, '0')}/${orcamento.dataSolicitacao!.month.toString().padLeft(2, '0')}/${orcamento.dataSolicitacao!.year}',
                                            style: FlutterFlowTheme.of(context).bodySmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                    if (orcamento.empresa != null) ...[
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.business_outlined,
                                            size: 16,
                                            color: FlutterFlowTheme.of(context).secondaryText,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            orcamento.empresa!.nomeEmpresa ?? 'Empresa não informada',
                                            style: FlutterFlowTheme.of(context).bodySmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                    if (orcamento.motivoRecusa != null) ...[
                                      const SizedBox(height: 8),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.red.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.red.withOpacity(0.3),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Motivo da recusa:',
                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.red[700],
                                                  ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              orcamento.motivoRecusa!,
                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                    fontFamily: 'Montserrat',
                                                    color: Colors.red[600],
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
                InkWell(
                  onTap: () => GoRouter.of(context).goNamed('servicos'),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.description,
                        color: Color(0xFF888888),
                        size: 24,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Serviços',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => GoRouter.of(context).goNamed('FaleConosco'),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.chat_outlined,
                        color: Color(0xFF888888),
                        size: 24,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Fale Conosco',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).secondaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.receipt_long,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        'Orçamentos',
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).primary,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}