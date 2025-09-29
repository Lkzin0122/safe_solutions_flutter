import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../pages/profile/profile_widget.dart';

// Simple navigation helper
extension NavigationHelper on BuildContext {
  void goToProfile() {
    go('/profile');
  }
  
  void pushToProfile() {
    push('/profile');
  }
}

// Route configuration
final appRouter = GoRouter(
  initialLocation: '/profile',
  routes: [
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileWidget(),
    ),
  ],
);