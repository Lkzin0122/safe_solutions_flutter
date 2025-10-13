import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'termos_uso_model.dart';
export 'termos_uso_model.dart';

class TermosUsoWidget extends StatefulWidget {
  const TermosUsoWidget({super.key});

  static String routeName = 'termosUso';
  static String routePath = '/termosUso';

  @override
  State<TermosUsoWidget> createState() => _TermosUsoWidgetState();
}

class _TermosUsoWidgetState extends State<TermosUsoWidget> with TickerProviderStateMixin {
  late TermosUsoModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermosUsoModel());
    
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: FlutterFlowTheme.of(context).primaryText),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Termos de Uso',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF2196F3).withOpacity(0.05),
                          Colors.white
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Color(0xFF2196F3).withOpacity(0.2),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF2196F3).withOpacity(0.1),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 4.0),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header com ícone
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF2196F3).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Icon(
                                Icons.description,
                                color: Color(0xFF2196F3),
                                size: 24.0,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Text(
                                'Termos de Uso — Safe Solutions',
                                style: FlutterFlowTheme.of(context).titleLarge.override(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2196F3),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.0),
                        
                        Text(
                          'Safe Solutions, pessoa jurídica de direito privado descreve, através deste documento, as regras de uso do site www.safesolutions.com e qualquer outro site, loja ou aplicativo operado pelo proprietário. Ao navegar neste website, consideramos que você está de acordo com os Termos de Uso abaixo.',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Montserrat',
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 24.0),
                        
                        _buildSection(
                          context,
                          'Seção 1 - Usuário',
                          'A utilização deste website atribui de forma automática a condição de Usuário e implica a plena aceitação de todas as diretrizes e condições incluídas nestes Termos.',
                        ),
                        
                        _buildSection(
                          context,
                          'Seção 2 - Adesão em conjunto com a Política de Privacidade',
                          'A utilização deste website acarreta a adesão aos presentes Termos de Uso e a versão mais atualizada da Política de Privacidade de Safe Solutions.',
                        ),
                        
                        _buildSection(
                          context,
                          'Seção 3 - Condições de acesso',
                          'Em geral, o acesso ao website da Safe Solutions possui caráter gratuito e não exige prévia inscrição ou registro.\n\nContudo, para usufruir de algumas funcionalidades, o usuário poderá precisar efetuar um cadastro, criando uma conta de usuário com login e senha próprios para acesso.\n\nÉ de total responsabilidade do usuário fornecer apenas informações corretas, autênticas, válidas, completas e atualizadas, bem como não divulgar o seu login e senha para terceiros.',
                        ),
                        
                        _buildSection(
                          context,
                          'Seção 4 - Cookies',
                          'Informações sobre o seu uso neste website podem ser coletadas a partir de cookies. Cookies são informações armazenadas diretamente no computador que você está utilizando. Os cookies permitem a coleta de informações tais como o tipo de navegador, o tempo despendido no website, as páginas visitadas, as preferências de idioma, e outros dados de tráfego anônimos.',
                        ),
                        
                        _buildSection(
                          context,
                          'Seção 5 - Propriedade Intelectual',
                          'Todos os elementos de Safe Solutions são de propriedade intelectual da mesma ou de seus licenciados. Estes Termos ou a utilização do website não concede a você qualquer licença ou direito de uso dos direitos de propriedade intelectual da Safe Solutions ou de terceiros.',
                        ),
                        
                        _buildSection(
                          context,
                          'Seção 6 - Links para sites de terceiros',
                          'Este website poderá, de tempos a tempos, conter links de hipertexto que redirecionará você para sites das redes dos nossos parceiros, anunciantes, fornecedores etc. Se você clicar em um desses links para qualquer um desses sites, lembre-se que cada site possui as suas próprias práticas de privacidade.',
                        ),
                        
                        _buildSection(
                          context,
                          'Seção 7 - Prazos e alterações',
                          'O funcionamento deste website se dá por prazo indeterminado.\n\nO website no todo ou em cada uma das suas seções, pode ser encerrado, suspenso ou interrompido unilateralmente por Safe Solutions, a qualquer momento e sem necessidade de prévio aviso.',
                        ),
                        
                        _buildSection(
                          context,
                          'Seção 8 - Dados pessoais',
                          'Durante a utilização deste website, certos dados pessoais serão coletados e tratados por Safe Solutions e/ou pelos Parceiros. As regras relacionadas ao tratamento de dados pessoais de Safe Solutions estão estipuladas na Política de Privacidade.',
                        ),
                        
                        _buildSection(
                          context,
                          'Seção 9 - Contato',
                          'Caso você tenha qualquer dúvida sobre os Termos de Uso, por favor, entre em contato pelo e-mail safesolutionsempresa@gmail.com.',
                        ),
                        
                        SizedBox(height: 24.0),
                        
                        // Footer
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF2196F3).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Color(0xFF2196F3),
                                size: 20.0,
                              ),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: Text(
                                  'Última atualização: Janeiro 2025',
                                  style: FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF2196F3),
                                    fontWeight: FontWeight.w500,
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: FlutterFlowTheme.of(context).titleMedium.override(
              fontFamily: 'Montserrat',
              color: Color(0xFF2196F3),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            content,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Montserrat',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}