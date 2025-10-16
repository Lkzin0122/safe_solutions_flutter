import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/auth/custom_auth/custom_auth_user_provider.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/models/servico.dart';
import '/pages/profile/profile_widget.dart';
import '/pages/contratos/contratos_widget.dart';
import '/pages/inicial/inicial_widget.dart';
import '/pages/login1/login1_widget.dart';
import '/pages/esqueci_senha/esqueci_senha_widget.dart';
import '/pages/validar_codigo/validar_codigo_widget.dart';

import '/pages/servicos/servicos_widget.dart';
import '/pages/montador/montador_widget.dart';
import '/pages/super_clean/super_clean_widget.dart';
import '/pages/super_clean_copy/super_clean_copy_widget.dart';
import '/pages/verificar_codigo/verificar_codigo_widget.dart';
import '/pages/fale_conosco/fale_conosco_widget.dart';
import '/pages/editar_conta/editar_conta_widget.dart';
import '/pages/configuracoes/configuracoes_widget.dart';
import '/pages/suporte/suporte_widget.dart';
import '/pages/privacidade/privacidade_widget.dart';
import '/pages/confirmar_senha/confirmar_senha_widget.dart';
import '/pages/nova_senha_pos_validacao/nova_senha_pos_validacao_widget.dart';
import '/pages/nova_senha/nova_senha_widget.dart';
import '/pages/termos_uso/termos_uso_widget.dart';
import '/pages/status_servico/status_servico_widget.dart';
import '/pages/detalhes_servico/detalhes_servico_widget.dart';
import '/pages/orcamentos/detalhes_orcamento_widget.dart';

import '/pages/test_api.dart';

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
      errorBuilder: (context, state) => appStateNotifier.loggedIn
          ? const ContratosWidget()
          : const Login1Widget(),
      routes: [
        GoRoute(
          name: '_initialize',
          path: '/',
          builder: (context, state) {
            if (appStateNotifier.loading) {
              return const InicialWidget();
            }
            return appStateNotifier.loggedIn
                ? const ContratosWidget()
                : const Login1Widget();
          },
        ),
        GoRoute(
          name: 'Login',
          path: '/login',
          builder: (context, state) => const Login1Widget(),
        ),
        GoRoute(
          name: 'EsqueciSenha',
          path: '/esqueciSenha',
          builder: (context, state) => const EsqueciSenhaWidget(),
        ),
        GoRoute(
          name: 'ValidarCodigo',
          path: '/validar-codigo',
          builder: (context, state) {
            final email = state.extra as String? ?? '';
            return ValidarCodigoWidget(email: email);
          },
        ),

        GoRoute(
          name: 'Inicial',
          path: '/inicial',
          builder: (context, state) => const ProfileWidget(),
        ),
        GoRoute(
          name: 'servicos',
          path: '/servicos',
          builder: (context, state) => const ContratosWidget(),
        ),
        GoRoute(
          name: 'Profile',
          path: '/profile',
          builder: (context, state) => const ProfileWidget(),
        ),
        GoRoute(
          name: 'Servicos',
          path: '/servicospage',
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
          name: 'ConfirmarSenha',
          path: '/confirmarSenha',
          builder: (context, state) => const ConfirmarSenhaWidget(),
        ),
        GoRoute(
          name: 'StatusServico',
          path: '/statusServico',
          builder: (context, state) => const StatusServicoWidget(),
        ),
        GoRoute(
          name: 'NovaSenhaPosValidacao',
          path: '/novaSenhaPosValidacao',
          builder: (context, state) {
            final email = state.extra as String? ?? '';
            return NovaSenhaPosValidacaoWidget(email: email);
          },
        ),
        GoRoute(
          name: 'NovaSenha',
          path: '/nova-senha',
          builder: (context, state) {
            final email = state.extra as String? ?? '';
            return NovaSenhaWidget(email: email);
          },
        ),
        GoRoute(
          name: 'TermosUso',
          path: '/termosUso',
          builder: (context, state) => const TermosUsoWidget(),
        ),
        GoRoute(
          name: 'DetalhesServico',
          path: '/detalhes-servico',
          builder: (context, state) {
            final servico = state.extra as Servico?;
            if (servico == null) {
              return const ServicosWidget();
            }
            return DetalhesServicoWidget(servico: servico);
          },
        ),
        GoRoute(
          name: 'DetalhesOrcamento',
          path: '/detalhes-orcamento',
          builder: (context, state) {
            final orcamentoId = state.extra as int?;
            if (orcamentoId == null) {
              return const ContratosWidget();
            }
            return DetalhesOrcamentoWidget(orcamentoId: orcamentoId);
          },
        ),

        GoRoute(
          name: 'TestApi',
          path: '/testapi',
          builder: (context, state) => TestApiPage(),
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
      GoRouter.of(this).goNamed(
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
      GoRouter.of(this).pushNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    }
  }

  void safePop() {
    if (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop();
    } else {
      GoRouter.of(this).go('/');
    }
  }
}
