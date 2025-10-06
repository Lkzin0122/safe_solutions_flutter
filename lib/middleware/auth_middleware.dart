import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/auth_service.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class AuthMiddleware {
  static Future<Widget> protectRoute(
    BuildContext context,
    Widget child, {
    bool redirectToLogin = true,
  }) async {
    final isLoggedIn = await AuthService.isLoggedIn();
    
    if (!isLoggedIn) {
      if (redirectToLogin) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GoRouter.of(context).goNamed('Login');
        });
      }
      return _buildUnauthorizedScreen(context);
    }
    
    return child;
  }

  static Widget _buildUnauthorizedScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline,
                  size: 64.0,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Acesso Negado',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Montserrat',
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Você precisa fazer login para acessar esta página.',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Montserrat',
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).goNamed('Login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Fazer Login',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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