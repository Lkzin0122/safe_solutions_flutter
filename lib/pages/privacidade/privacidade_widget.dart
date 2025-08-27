import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'privacidade_model.dart';
export 'privacidade_model.dart';

class PrivacidadeWidget extends StatefulWidget {
  const PrivacidadeWidget({super.key});

  static String routeName = 'privacidade';
  static String routePath = '/privacidade';

  @override
  State<PrivacidadeWidget> createState() => _PrivacidadeWidgetState();
}

class _PrivacidadeWidgetState extends State<PrivacidadeWidget> {
  late PrivacidadeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrivacidadeModel());
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
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30.0,
          ),
        ),
        title: Text(
          'Privacidade',
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
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.privacy_tip,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 28.0,
                            ),
                            SizedBox(width: 12.0),
                            Text(
                              'Política de Privacidade',
                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Última atualização: Janeiro de 2024',
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).secondaryText,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                SizedBox(height: 20.0),
                
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: FlutterFlowTheme.of(context).alternate,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1. Introdução',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'A Safe Solutions valoriza a sua privacidade e está comprometida em proteger suas informações pessoais. Esta Política de Privacidade descreve como coletamos, usamos, divulgamos e protegemos as informações de nossos usuários e parceiros.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                lineHeight: 1.5,
                              ),
                        ),
                        
                        SizedBox(height: 20.0),
                        
                        Text(
                          '2. Informações Que Coletamos',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          '• Informações de Contato: Nome da empresa, endereço, e-mail, número de telefone\n• Informações de Negócios: Dados sobre operações comerciais, serviços oferecidos, contratos\n• Informações de Uso: Dados sobre interação com nossos serviços\n• Informações de Pagamento: Dados bancários e cartões para processar pagamentos',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                lineHeight: 1.5,
                              ),
                        ),
                        
                        SizedBox(height: 20.0),
                        
                        Text(
                          '3. Como Usamos Suas Informações',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          '• Prestação de Serviços: Fornecer e gerenciar nossos serviços e soluções\n• Comunicação: Contato sobre atualizações, ofertas e informações importantes\n• Análise e Melhoria: Analisar uso dos serviços e melhorar nossa plataforma\n• Segurança: Proteger a segurança e integridade dos serviços',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                lineHeight: 1.5,
                              ),
                        ),
                        
                        SizedBox(height: 20.0),
                        
                        Text(
                          '4. Compartilhamento de Informações',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          '• Com Parceiros: Compartilhamento com prestadores de serviços que atuam em nosso nome\n• Com Autoridades: Divulgação quando exigido por lei ou para proteger direitos legais\n• Transferências de Negócios: Em caso de fusão, aquisição ou venda de ativos',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                lineHeight: 1.5,
                              ),
                        ),
                        
                        SizedBox(height: 20.0),
                        
                        Text(
                          '5. Segurança das Informações',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'Implementamos medidas de segurança apropriadas para proteger suas informações contra acesso não autorizado, alteração, divulgação ou destruição. No entanto, nenhuma medida de segurança é totalmente infalível.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                lineHeight: 1.5,
                              ),
                        ),
                        
                        SizedBox(height: 20.0),
                        
                        Text(
                          '6. Seus Direitos',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'Você tem o direito de acessar, corrigir ou excluir suas informações pessoais.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                lineHeight: 1.5,
                              ),
                        ),
                        
                        SizedBox(height: 20.0),
                        
                        Text(
                          '7. Cookies e Tecnologias Similares',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'Utilizamos cookies e tecnologias semelhantes para melhorar sua experiência em nossa plataforma e analisar o uso. Você pode configurar seu navegador para recusar cookies.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                lineHeight: 1.5,
                              ),
                        ),
                        
                        SizedBox(height: 20.0),
                        
                        Text(
                          '8. Alterações na Política',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'Podemos atualizar esta Política ocasionalmente para refletir mudanças em nossos serviços ou requisitos legais. Notificaremos sobre alterações substanciais.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                lineHeight: 1.5,
                              ),
                        ),
                        
                        SizedBox(height: 20.0),
                        
                        Text(
                          '9. Contato',
                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'Para dúvidas sobre esta Política de Privacidade, entre em contato: safesolutionsempresa@gmail.com',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).primary,
                                lineHeight: 1.5,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}