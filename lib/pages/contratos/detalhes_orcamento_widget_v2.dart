import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../models/orcamento.dart';
import '../../services/orcamento_service.dart';

class DetalhesOrcamentoWidgetV2 extends StatefulWidget {
  final Orcamento orcamento;
  
  const DetalhesOrcamentoWidgetV2({Key? key, required this.orcamento}) : super(key: key);

  @override
  State<DetalhesOrcamentoWidgetV2> createState() => _DetalhesOrcamentoWidgetV2State();
}

class _DetalhesOrcamentoWidgetV2State extends State<DetalhesOrcamentoWidgetV2> {
  late Orcamento _orcamento;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _orcamento = widget.orcamento;
  }

  Future<void> _atualizarOrcamento() async {
    if (_orcamento.id == null) return;
    
    try {
      setState(() => _isLoading = true);
      final orcamentoAtualizado = await OrcamentoService.getOrcamentoPorId(_orcamento.id!);
      setState(() {
        _orcamento = orcamentoAtualizado;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Color _getStatusColor(StatusEnum? status) {
    switch (status) {
      case StatusEnum.PENDENTE: return Colors.orange;
      case StatusEnum.ACEITO: return Colors.green;
      case StatusEnum.RECUSADO: return Colors.red;
      case StatusEnum.EM_ANDAMENTO: return Color(0xFF204060);
      case StatusEnum.FINALIZADO: return Colors.grey;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Botão de voltar
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context, false),
                      icon: Icon(Icons.arrow_back, size: 22),
                    ),
                  ),
                  
                  // Header com imagem e status
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/images/orcamento_default.png',
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Icon(
                                  Icons.description,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: _getStatusColor(_orcamento.statusOrcamento),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            _orcamento.statusTexto,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 24.0),
                  
                  // Detalhes
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8.0,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0.0, 4.0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow('Serviço:', _orcamento.servico?.nomeServico ?? 'Não informado'),
                        SizedBox(height: 8.0),
                        _buildDetailRow('Empresa:', _orcamento.empresa?.nomeEmpresa ?? 'Não atribuída'),
                        SizedBox(height: 8.0),
                        _buildDetailRow('Localização:', _orcamento.enderecoOrcamento ?? 'Não informado'),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Valor Total', style: FlutterFlowTheme.of(context).bodySmall),
                                Text(
                                  _orcamento.valorServico != null 
                                      ? 'R\$ ${_orcamento.valorServico!.toStringAsFixed(2)}'
                                      : 'A definir',
                                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                                    fontFamily: 'Montserrat',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('Prazo', style: FlutterFlowTheme.of(context).bodySmall),
                                Text(
                                  _orcamento.prazoOrcamento != null
                                      ? '${_orcamento.prazoOrcamento!.day.toString().padLeft(2, '0')}/${_orcamento.prazoOrcamento!.month.toString().padLeft(2, '0')}/${_orcamento.prazoOrcamento!.year}'
                                      : 'A definir',
                                  style: FlutterFlowTheme.of(context).titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: FlutterFlowTheme.of(context).bodyMedium.override(
          fontFamily: 'Montserrat', 
          fontWeight: FontWeight.w500
        )),
        Expanded(
          child: Text(
            value,
            style: FlutterFlowTheme.of(context).bodyMedium,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}