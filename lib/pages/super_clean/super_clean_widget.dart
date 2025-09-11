import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import '/pages/contratos/contratos_model.dart';
import 'package:flutter/material.dart';
import 'super_clean_model.dart';
export 'super_clean_model.dart';

class SuperCleanWidget extends StatefulWidget {
  const SuperCleanWidget({super.key});

  static String routeName = 'SuperClean';
  static String routePath = '/superClean';

  @override
  State<SuperCleanWidget> createState() => _SuperCleanWidgetState();
}

class _SuperCleanWidgetState extends State<SuperCleanWidget> {
  late SuperCleanModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SuperCleanModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _showStatusPopup(BuildContext context) {
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
                        child: Icon(Icons.cleaning_services, color: Colors.white, size: 24),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status da Limpeza',
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
                _buildStatusStep('Materiais preparados', true, Colors.green, Icons.inventory, '✓ Produtos de limpeza prontos'),
                _buildStatusConnector(true),
                _buildStatusStep('Limpeza em andamento', true, Colors.orange, Icons.cleaning_services, '🧹 Equipe trabalhando'),
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

  void _showFinishConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Finalizar Serviço'),
          content: Text('Tem certeza que deseja finalizar este serviço?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _finishService(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text('Confirmar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _finishService(BuildContext context) {
    final now = DateTime.now();
    final dateStr = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
    
    // Usar o novo método que remove da lista de em andamento e adiciona aos concluídos
    ContratosModel.completeService('super_clean', dateStr);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Serviço finalizado com sucesso!'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
    
    Future.delayed(Duration(milliseconds: 1500), () {
      context.goNamed(ContratosWidget.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        elevation: 0,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30.0,
          ),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Text(
          'Super Clean',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
            fontFamily: 'Montserrat',
            color: FlutterFlowTheme.of(context).tertiary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
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
                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/safe-solutions-1bblqz/assets/dfq8wa491iyv/image_17_(1).png',
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Em Andamento',
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
                    'Orçamento solicitado para a realização de serviços de limpeza em um espaço comercial. O serviço incluirá a limpeza de várias áreas, com foco na sala de reuniões e banheiros. A limpeza da sala de reuniões incluirá a remoção de poeira, limpeza das superfícies das mesas e desinfecção de equipamentos.',
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
                      Text('Tipo de Serviço:', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat', fontWeight: FontWeight.w500)),
                      Text('Limpeza comercial', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat')),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Áreas:', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat', fontWeight: FontWeight.w500)),
                      Text('Sala de reuniões e banheiros', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat')),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Frequência:', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat', fontWeight: FontWeight.w500)),
                      Text('Serviço único', style: FlutterFlowTheme.of(context).bodyMedium.override(fontFamily: 'Montserrat')),
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
                            'R\$ 1.000,00',
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
                            '20/11/2024',
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
                SizedBox(width: 12.0),
                Expanded(
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () => _showFinishConfirmation(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Finalizar Serviço',
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
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => context.pushNamed(ContratosWidget.routeName),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.description, color: FlutterFlowTheme.of(context).secondaryText, size: 24),
                    Text('Contratos', style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Montserrat', color: FlutterFlowTheme.of(context).secondaryText, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              InkWell(
                onTap: () => context.pushNamed(FaleConoscoWidget.routeName),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.message_outlined, color: FlutterFlowTheme.of(context).secondaryText, size: 24),
                    Text('Fale conosco', style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Montserrat', color: FlutterFlowTheme.of(context).secondaryText, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              InkWell(
                onTap: () => context.pushNamed(ProfileWidget.routeName),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_outlined, color: FlutterFlowTheme.of(context).secondaryText, size: 24),
                    Text('Perfil', style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Montserrat', color: FlutterFlowTheme.of(context).secondaryText, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}