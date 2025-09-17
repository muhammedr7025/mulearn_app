import 'package:flutter/material.dart';
import 'package:mu/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  final Widget authenticatedWidget;
  final Widget unauthenticatedWidget;
  final Widget? loadingWidget;

  const AuthWrapper({
    Key? key,
    required this.authenticatedWidget,
    required this.unauthenticatedWidget,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        switch (authProvider.state) {
          case AuthState.initial:
          case AuthState.loading:
            return loadingWidget ??
                const Center(child: CircularProgressIndicator());
          case AuthState.authenticated:
            return authenticatedWidget;
          case AuthState.unauthenticated:
          case AuthState.error:
            return unauthenticatedWidget;
        }
      },
    );
  }
}
