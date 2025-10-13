import 'package:flutter/material.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_widgets.dart';
import '../../models/orcamento.dart';
import '../../models/servico.dart';
import '../../services/orcamento_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/usuario.dart';

class SolicitarOrcamentoWidget extends StatefulWidget {
  final Servico servico;
  final VoidCallback? onSuccess;

  const SolicitarOrcamentoWidget({
    Key? key,
    required this.servico,
    this.onSuccess,
  }) : super(key: key);

  @override
  State<SolicitarOrcamentoWidget> createState() => _SolicitarOrcamentoWidgetState();
}

class _SolicitarOrcamentoWidgetState extends State<SolicitarOrcamentoWidget> {
  final _formKey = GlobalKey<FormState>();
  final _detalhesController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _observacaoController = TextEditingController();
  DateTime? _prazoSelecionado;
  bool _isLoading = false;

  @override
  void dispose() {
    _detalhesController.dispose();
    _enderecoController.dispose();
    _observacaoController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          _prazoSelecionado = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _solicitarOrcamento() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      final userCpf = prefs.getString('user_cpf');
      final userName = prefs.getString('user_name');
      
      if (userId == null || userCpf == null) {
        throw Exception('Usuário não encontrado. Faça login novamente.');
      }

      final usuario = Usuario(
        id: userId.toString(),
        cpf: userCpf,
        nomeUsuario: userName ?? 'Usuário',
        email: 'user@example.com',
        senhaUsuario: '',
      );

      final orcamento = Orcamento(
        servico: widget.servico,
        usuario: usuario,
        detalhesOrcamento: _detalhesController.text.trim(),
        enderecoOrcamento: _enderecoController.text.trim(),
        observacao: _observacaoController.text.trim(),
        prazoOrcamento: _prazoSelecionado,
        statusOrcamento: StatusEnum.PENDENTE,
        dataSolicitacao: DateTime.now(),
      );

      await OrcamentoService.criarSolicitacao(orcamento);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Orçamento solicitado com sucesso!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.of(context).pop();
        widget.onSuccess?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao solicitar orçamento: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: Text(
          'Solicitar Orçamento',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize: 20,
              ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Serviço Selecionado',
                        style: FlutterFlowTheme.of(context).titleMedium.override(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.servico.nomeServico ?? 'Nome não informado',
                        style: FlutterFlowTheme.of(context).bodyLarge,
                      ),
                      if (widget.servico.descricaoServico != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.servico.descricaoServico!,
                          style: FlutterFlowTheme.of(context).bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Detalhes da Solicitação',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _detalhesController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Detalhes do serviço *',
                  hintText: 'Descreva detalhadamente o que você precisa...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, descreva os detalhes do serviço';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _enderecoController,
                decoration: InputDecoration(
                  labelText: 'Endereço para execução *',
                  hintText: 'Rua, número, bairro, cidade...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  prefixIcon: const Icon(Icons.location_on_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, informe o endereço';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _selecionarData,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _prazoSelecionado != null
                              ? 'Prazo: ${_prazoSelecionado!.day.toString().padLeft(2, '0')}/${_prazoSelecionado!.month.toString().padLeft(2, '0')}/${_prazoSelecionado!.year} às ${_prazoSelecionado!.hour.toString().padLeft(2, '0')}:${_prazoSelecionado!.minute.toString().padLeft(2, '0')}'
                              : 'Selecionar prazo desejado',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: _prazoSelecionado != null
                                    ? FlutterFlowTheme.of(context).primaryText
                                    : FlutterFlowTheme.of(context).secondaryText,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _observacaoController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Observações (opcional)',
                  hintText: 'Informações adicionais...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                      text: 'Cancelar',
                      options: FFButtonOptions(
                        height: 50,
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).alternate,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FFButtonWidget(
                      onPressed: _isLoading ? null : _solicitarOrcamento,
                      text: _isLoading ? 'Enviando...' : 'Solicitar Orçamento',
                      options: FFButtonOptions(
                        height: 50,
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Montserrat',
                              color: Colors.white,
                            ),
                        borderRadius: BorderRadius.circular(8),
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