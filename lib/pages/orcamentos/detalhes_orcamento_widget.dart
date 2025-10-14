import 'package:flutter/material.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../models/orcamento.dart';
import '../../services/orcamento_service.dart';

class DetalhesOrcamentoWidget extends StatefulWidget {
  final int orcamentoId;
  
  const DetalhesOrcamentoWidget({Key? key, required this.orcamentoId}) : super(key: key);

  @override
  State<DetalhesOrcamentoWidget> createState() => _DetalhesOrcamentoWidgetState();
}

class _DetalhesOrcamentoWidgetState extends State<DetalhesOrcamentoWidget> {
  Orcamento? _orcamento;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _carregarDetalhes();
  }

  Future<void> _carregarDetalhes() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final orcamento = await OrcamentoService.getOrcamentoPorId(widget.orcamentoId);

      setState(() {
        _orcamento = orcamento;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao carregar detalhes: $e';
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

  void _showStatusPopup(BuildContext context) {
    if (_orcamento?.statusOrcamento != StatusEnum.EM_ANDAMENTO) return;
    
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 16,
          child: Container(
            padding: EdgeInsets.all(28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.grey[50]!],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.timeline, color: Colors.white, size: 24),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status do Serviço',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                            Text(
                              'Acompanhe o progresso',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28),
                _buildStatusStep('Orçamento aprovado', true, Colors.green, Icons.check_circle, '✓ Aprovado pelo cliente'),
                _buildStatusConnector(true),
                _buildStatusStep('Materiais adquiridos', true, Colors.green, Icons.shopping_cart, '✓ Todos os materiais prontos'),
                _buildStatusConnector(true),
                _buildStatusStep('Em execução', true, Colors.orange, Icons.build, '🔧 Montagem em andamento'),
                _buildStatusConnector(false),
                _buildStatusStep('Finalizado', false, Colors.grey, Icons.done_all, 'Aguardando conclusão'),
                SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                    ),
                    child: Text(
                      'Fechar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusStep(String text, bool completed, Color color, IconData icon, String subtitle) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: completed ? color.withOpacity(0.1) : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: completed ? color.withOpacity(0.3) : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: completed ? color : Colors.grey[300],
              shape: BoxShape.circle,
              boxShadow: completed ? [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ] : null,
            ),
            child: Icon(
              completed ? Icons.check : icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: completed ? FontWeight.bold : FontWeight.w500,
                    color: completed ? Colors.black : Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: completed ? color : Colors.grey[500],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusConnector(bool active) {
    return Container(
      margin: EdgeInsets.only(left: 19.5, top: 8, bottom: 8),
      width: 2,
      height: 24,
      decoration: BoxDecoration(
        color: active ? Colors.green : Colors.grey[300],
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
                        onPressed: _carregarDetalhes,
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
              : SingleChildScrollView(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Botão de voltar
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.arrow_back, size: 22),
                          ),
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
                              child: Image.network(
                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/zqwlt240p7sd/image_17.png',
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: _getStatusColor(_orcamento?.statusOrcamento),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                _orcamento?.statusTexto ?? 'Desconhecido',
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
                      
                      // Descrição
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Descrição do Orçamento',
                              style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).tertiary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              _orcamento?.detalhesOrcamento ?? 'Sem detalhes disponíveis',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 16.0),
                      
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Serviço:', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat', fontWeight: FontWeight.w500)),
                                Text(_orcamento?.servico?.nomeServico ?? 'Não informado', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat')),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Empresa:', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat', fontWeight: FontWeight.w500)),
                                Text(_orcamento?.empresa?.nomeEmpresa ?? 'Não atribuída', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat')),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Localização:', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat', fontWeight: FontWeight.w500)),
                                Expanded(
                                  child: Text(
                                    _orcamento?.enderecoOrcamento ?? 'Não informado',
                                    style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat'),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Valor Total',
                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                      ),
                                    ),
                                    Text(
                                      _orcamento?.valorServico != null 
                                          ? 'R\$ ${_orcamento!.valorServico!.toStringAsFixed(2)}'
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
                                    Text(
                                      'Prazo',
                                      style: FlutterFlowTheme.of(context).bodySmall.override(
                                        fontFamily: 'Montserrat',
                                        color: FlutterFlowTheme.of(context).secondaryText,
                                      ),
                                    ),
                                    Text(
                                      _orcamento?.prazoOrcamento != null
                                          ? '${_orcamento!.prazoOrcamento!.day.toString().padLeft(2, '0')}/${_orcamento!.prazoOrcamento!.month.toString().padLeft(2, '0')}/${_orcamento!.prazoOrcamento!.year}'
                                          : 'A definir',
                                      style: FlutterFlowTheme.of(context).titleMedium.override(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 24.0),
                      
                      // Botões
                      if (_orcamento?.statusOrcamento == StatusEnum.EM_ANDAMENTO) ...[
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 50.0,
                                child: ElevatedButton(
                                  onPressed: () => _showStatusPopup(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF204060),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Ver Status do Serviço',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
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
}