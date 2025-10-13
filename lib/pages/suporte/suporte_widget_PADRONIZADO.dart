import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'suporte_model.dart';
export 'suporte_model.dart';

class SuporteWidget extends StatefulWidget {
  const SuporteWidget({super.key});

  static String routeName = 'suporte';
  static String routePath = '/suporte';

  @override
  State<SuporteWidget> createState() => _SuporteWidgetState();
}

class _SuporteWidgetState extends State<SuporteWidget> with TickerProviderStateMixin {
  late SuporteModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SuporteModel());
    
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
          'Suporte',
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
                  child: Column(
                    children: [
                      // Header Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(24.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF2196F3).withOpacity(0.1),
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
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF2196F3).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.support_agent,
                                size: 48.0,
                                color: Color(0xFF2196F3),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Como podemos ajudar?',
                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2196F3),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Nossa equipe de suporte está disponível para ajudá-lo com qualquer dúvida ou problema relacionado aos nossos serviços.',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 24.0),
                      
                      // Horário de Atendimento
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Color(0xFF2196F3).withOpacity(0.2),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8.0,
                              offset: Offset(0.0, 2.0),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Color(0xFF2196F3),
                                  size: 24.0,
                                ),
                                SizedBox(width: 12.0),
                                Text(
                                  'Horário de Atendimento',
                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2196F3),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Segunda a Sexta: 8h às 18h',
                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 20.0),
                      
                      // Canais de Contato
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Color(0xFF2196F3).withOpacity(0.2),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8.0,
                              offset: Offset(0.0, 2.0),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.contact_support,
                                  color: Color(0xFF2196F3),
                                  size: 24.0,
                                ),
                                SizedBox(width: 12.0),
                                Text(
                                  'Canais de Contato',
                                  style: FlutterFlowTheme.of(context).titleMedium.override(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF2196F3),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            
                            // Email
                            _buildContactItem(
                              context,
                              Icons.email_outlined,
                              'safesolutionsempresa@gmail.com',
                              () {},
                            ),
                            
                            SizedBox(height: 16.0),
                            
                            // WhatsApp
                            _buildContactItem(
                              context,
                              Icons.chat,
                              'WhatsApp: (11) 97880-3756',
                              () async {
                                await launchUrl(Uri.parse('https://wa.me/5511978803756'));
                              },
                              isWhatsApp: true,
                            ),
                            
                            SizedBox(height: 16.0),
                            
                            // Chat online
                            _buildContactItem(
                              context,
                              Icons.chat_outlined,
                              'Chat online disponível no app',
                              () {},
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 20.0),
                      
                      // Informações adicionais
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF2196F3).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Color(0xFF2196F3).withOpacity(0.2),
                            width: 1.0,
                          ),
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
                                'Tempo médio de resposta: 2 horas durante horário comercial. Para emergências, utilize nosso WhatsApp.',
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
          );
        },
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String text,
    VoidCallback onTap, {
    bool isWhatsApp = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isWhatsApp ? Color(0xFF25D366).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: isWhatsApp ? Border.all(
            color: Color(0xFF25D366).withOpacity(0.3),
            width: 1.0,
          ) : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isWhatsApp ? Color(0xFF25D366) : Color(0xFF2196F3),
              size: 24.0,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                text,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  color: isWhatsApp ? Color(0xFF25D366) : FlutterFlowTheme.of(context).primaryText,
                ),
              ),
            ),
            if (isWhatsApp)
              Icon(
                Icons.open_in_new,
                color: Color(0xFF25D366),
                size: 16.0,
              ),
          ],
        ),
      ),
    );
  }
}