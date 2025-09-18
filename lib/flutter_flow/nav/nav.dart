import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/auth/custom_auth/custom_auth_user_provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';

export 'package:go_router/go_router.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  SafeSolutionsAuthUser? initialUser;
  SafeSolutionsAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(SafeSolutionsAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? const ContratosWidget() : const InicialWidget(),
      routes: [
        GoRoute(
          name: '_initialize',
          path: '/',
          builder: (context, state) =>
              appStateNotifier.loggedIn ? const ContratosWidget() : const InicialWidget(),
        ),
        GoRoute(
          name: 'Login1',
          path: '/login',
          builder: (context, state) => const Login1Widget(),
        ),
        GoRoute(
          name: 'EsqueciSenha',
          path: '/esqueciSenha',
          builder: (context, state) => const EsqueciSenhaWidget(),
        ),
        GoRoute(
          name: 'NovaSenha',
          path: '/novaSenha',
          builder: (context, state) => const NovaSenhaWidget(),
        ),
        GoRoute(
          name: 'Inicial',
          path: '/inicial',
          builder: (context, state) => const InicialWidget(),
        ),
        GoRoute(
          name: 'Contratos',
          path: '/contratos',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return ContratosWidget(
              initialTab: extra?['initialTab'],
            );
          },
        ),
        GoRoute(
          name: 'Profile',
          path: '/profile',
          builder: (context, state) => const ProfileWidget(),
        ),
        GoRoute(
          name: 'Servicos',
          path: '/servicos',
          builder: (context, state) => const ServicosWidget(),
        ),
        GoRoute(
          name: 'Montador',
          path: '/montador',
          builder: (context, state) => const MontadorWidget(),
        ),
        GoRoute(
          name: 'SuperClean',
          path: '/superClean',
          builder: (context, state) => const SuperCleanWidget(),
        ),
        GoRoute(
          name: 'Bratecno',
          path: '/bratecno',
          builder: (context, state) => const BratecnoWidget(),
        ),
        GoRoute(
          name: 'SuperCleanCopy',
          path: '/superCleanCopy',
          builder: (context, state) => const SuperCleanCopyWidget(),
        ),
        GoRoute(
          name: 'VerificarCodigo',
          path: '/verificarCodigo',
          builder: (context, state) => const VerificarCodigoWidget(),
        ),
        GoRoute(
          name: 'FaleConosco',
          path: '/faleConosco',
          builder: (context, state) => const FaleConoscoWidget(),
        ),
        GoRoute(
          name: 'EditarConta',
          path: '/editarConta',
          builder: (context, state) => const EditarContaWidget(),
        ),
        GoRoute(
          name: 'Configuracoes',
          path: '/configuracoes',
          builder: (context, state) => const ConfiguracoesWidget(),
        ),
        GoRoute(
          name: 'Suporte',
          path: '/suporte',
          builder: (context, state) => const SuporteWidget(),
        ),
        GoRoute(
          name: 'Privacidade',
          path: '/privacidade',
          builder: (context, state) => const PrivacidadeWidget(),
        ),
        GoRoute(
          name: 'Calendario',
          path: '/calendario',
          builder: (context, state) => const CalendarioWidget(),
        ),
        GoRoute(
          name: 'ConfirmarSenha',
          path: '/confirmarSenha',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return ConfirmarSenhaWidget(
              serviceId: extra?['serviceId'] ?? state.uri.queryParameters['serviceId'],
            );
          },
        ),
        GoRoute(
          name: 'NovaSenhaPosValidacao',
          path: '/novaSenhaPosValidacao',
          builder: (context, state) => const NovaSenhaPosValidacaoWidget(),
        ),
        GoRoute(
          name: 'TermosUso',
          path: '/termosUso',
          builder: (context, state) => const TermosUsoWidget(),
        ),
      ],
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) {
    if (mounted) {
      goNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    }
  }

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) {
    if (mounted) {
      pushNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    }
  }

  void safePop() {
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}