import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_auth_provider.dart';
import '../../core/routes/admin_routes.dart';

class AdminAuthGuard extends StatelessWidget {
  const AdminAuthGuard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AdminAuthProvider>();

    if (authProvider.autenticado) {
      return child;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AdminRoutes.login,
          (route) => false,
        );
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
