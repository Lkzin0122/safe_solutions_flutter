import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF204060),
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