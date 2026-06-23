import 'package:flutter/material.dart';

import 'admin_auth_guard.dart';
import 'admin_sidebar.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AdminAuthGuard(
      child: Scaffold(
        body: Row(
          children: [
            const AdminSidebar(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppBar(title: Text(title)),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
