import 'package:flutter/material.dart';

import '../../core/routes/admin_routes.dart';
import '../../core/theme/admin_colors.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: AdminColors.azulPrincipal,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CLUB NOVA FROTA',
                    style: TextStyle(
                      color: AdminColors.branco,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Painel Administrativo',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            _MenuItem(
              icon: Icons.dashboard,
              label: 'Dashboard',
              route: AdminRoutes.dashboard,
            ),
            _MenuItem(
              icon: Icons.people,
              label: 'Motoristas',
              route: AdminRoutes.motoristas,
            ),
            _MenuItem(
              icon: Icons.local_shipping,
              label: 'Fretes',
              route: AdminRoutes.fretes,
            ),
            _MenuItem(
              icon: Icons.assignment,
              label: 'Ordens',
              route: AdminRoutes.ordens,
            ),
            _MenuItem(
              icon: Icons.upload_file,
              label: 'Comprovantes',
              route: AdminRoutes.comprovantes,
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Nova Frota Logística',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AdminColors.branco),
      title: Text(
        label,
        style: const TextStyle(color: AdminColors.branco),
      ),
      onTap: () => Navigator.pushReplacementNamed(context, route),
    );
  }
}
