import '/flutter_flow/flutter_flow_icon_button.dart';
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
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,

      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.0,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                      'Política de Privacidade',
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF204060),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'A Safe Solutions valoriza a sua privacidade e está comprometida em proteger suas informações pessoais. Esta Política de Privacidade descreve como coletamos, usamos, divulgamos e protegemos as informações de nossos usuários e parceiros.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '1. Introdução',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF204060),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'A Safe Solutions valoriza a sua privacidade e está comprometida em proteger suas informações pessoais. Esta Política de Privacidade descreve como coletamos, usamos, divulgamos e protegemos as informações de nossos usuários e parceiros.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '2. Informações Que Coletamos',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF204060),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '• Informações de Contato: Nome da empresa, endereço, e-mail, número de telefone e outras informações de contato.\n• Informações de Negócios: Dados sobre suas operações comerciais, serviços oferecidos e contratos.\n• Informações de Uso: Dados sobre como você interage com nossos serviços, incluindo registros de acesso, dados de navegação e preferências.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '3. Como Usamos Suas Informações',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF204060),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '• Prestação de Serviços: Para fornecer e gerenciar nossos serviços e soluções, incluindo a manutenção de sua conta e a execução de contratos.\n• Comunicação: Para entrar em contato com você sobre atualizações, ofertas e informações importantes relacionadas aos nossos serviços.\n• Análise e Melhoria: Para analisar o uso dos nossos serviços e melhorar nossa plataforma e processos.\n• Segurança: Para proteger a segurança e integridade de nossos serviços e prevenir fraudes ou abusos.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '4. Compartilhamento de Informações',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF204060),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      '• Com Parceiros e Prestadores de Serviços: Podemos compartilhar suas informações com parceiros e prestadores de serviços que atuam em nosso nome, como empresas de análise e suporte técnico.\n• Com Autoridades Legais: Podemos divulgar informações quando exigido por lei, regulamentação ou para proteger nossos direitos e interesses legais.\n• Transferências de Negócios: Em caso de fusão, aquisição ou venda de ativos, suas informações podem ser transferidas como parte do negócio.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '5. Segurança das Informações',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF204060),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Implementamos medidas de segurança apropriadas para proteger suas informações contra acesso não autorizado, alteração, divulgação ou destruição. No entanto, nenhuma medida de segurança é totalmente infalível, e não podemos garantir a segurança absoluta de seus dados.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '6. Seus Direitos',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF204060),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Você tem o direito de acessar, corrigir ou excluir suas informações pessoais.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '7. Cookies e Tecnologias Similares',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF204060),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Utilizamos cookies e tecnologias semelhantes para melhorar sua experiência em nossa plataforma e analisar o uso. Você pode configurar seu navegador para recusar cookies, mas isso pode afetar sua capacidade de usar nossos serviços de forma eficaz.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '8. Alterações na Política de Privacidade',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF204060),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Podemos atualizar esta Política de Privacidade ocasionalmente para refletir mudanças em nossos serviços ou requisitos legais. Notificaremos sobre qualquer alteração substancial por meio de nossos canais de comunicação habituais.',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      '10. Contato',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                        fontFamily: 'Montserrat',
                        color: Color(0xFF204060),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Se você tiver dúvidas ou preocupações sobre esta Política de Privacidade, entre em contato conosco em: safesolutionsempresa@gmail.com',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Montserrat',
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
    );
  }
}