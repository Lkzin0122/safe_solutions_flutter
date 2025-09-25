import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension BuildContextExtensions on BuildContext {
  void pushNamed(String routeName, {Object? extra, Map<String, String>? pathParameters}) {
    GoRouter.of(this).pushNamed(routeName, extra: extra, pathParameters: pathParameters ?? {});
  }
  
  void goNamed(String routeName, {Object? extra, Map<String, String>? pathParameters}) {
    GoRouter.of(this).goNamed(routeName, extra: extra, pathParameters: pathParameters ?? {});
  }
  
  void pop() {
    GoRouter.of(this).pop();
  }

  void safePop() {
    if (canPop()) {
      pop();
    }
  }
}

T createModel<T>(BuildContext context, T Function() create) {
  return create();
}



Future<void> launchURL(String url) async {
  // URL launcher implementation
}

// Responsive visibility helper
bool responsiveVisibility({
  required BuildContext context,
  bool phone = true,
  bool tablet = true,
  bool tabletLandscape = true,
  bool desktop = true,
}) {
  final width = MediaQuery.of(context).size.width;
  if (width < 479 && !phone) return false;
  if (width >= 479 && width < 767 && !tablet) return false;
  if (width >= 767 && width < 991 && !tabletLandscape) return false;
  if (width >= 991 && !desktop) return false;
  return true;
}

// State management helper
mixin SafeStateMixin<T extends StatefulWidget> on State<T> {
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}

// Extension para adicionar safeSetState a State
extension StateExtensions<T extends StatefulWidget> on State<T> {
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      setState(fn);
    }
  }
}

// Função responsiveVisibility global
bool Function({required BuildContext context, bool phone, bool tablet, bool tabletLandscape, bool desktop}) get responsiveVisibilityGlobal => responsiveVisibility;

// Extension para adicionar responsiveVisibility ao State
extension ResponsiveVisibilityExtension<T extends StatefulWidget> on State<T> {
  bool responsiveVisibility({
    bool phone = true,
    bool tablet = true,
    bool tabletLandscape = true,
    bool desktop = true,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < 479 && !phone) return false;
    if (width >= 479 && width < 767 && !tablet) return false;
    if (width >= 767 && width < 991 && !tabletLandscape) return false;
    if (width >= 991 && !desktop) return false;
    return true;
  }
}

// Validator extension
extension ValidatorExtension on String? Function(String?)? {
  String? Function(String?)? get asValidator => this;
}



String? Function(String?)? createRequiredValidator(String fieldName) {
  return (val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }
    return null;
  };
}

String? Function(String?)? createEmailValidator() {
  return (val) {
    if (val == null || val.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
      return 'Please enter a valid email';
    }
    return null;
  };
}