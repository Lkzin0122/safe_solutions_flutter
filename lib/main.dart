import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_storage/get_storage.dart';
import 'flutter_flow/nav/nav.dart';
import '/auth/custom_auth/custom_auth_user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setUrlStrategy(PathUrlStrategy());
  
  // Inicializar o estado de autenticação
  _initializeAuth();
  
  runApp(const MyApp());
}

void _initializeAuth() {
  // Simular verificação de autenticação
  Future.delayed(const Duration(milliseconds: 1000), () {
    // Por enquanto, definir como não logado
    // Aqui você pode verificar se há um token salvo, etc.
    final authUser = SafeSolutionsAuthUser(loggedIn: false);
    AppStateNotifier.instance.update(authUser);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SafeSolutions',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      routerConfig: createRouter(AppStateNotifier.instance),
    );
  }
}