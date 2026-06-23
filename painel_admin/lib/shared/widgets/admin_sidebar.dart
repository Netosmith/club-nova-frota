import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/admin_auth_provider.dart';
import '../../core/routes/admin_routes.dart';
import '../../core/theme/admin_colors.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  Future<void> _sair(BuildContext context) async {
    await context.read<AdminAuthProvider>().sair();

    if (!context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AdminRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<AdminAuthProvider>().usuario;

    return Container(
      width: 260,
      color: AdminColors.azulPrincipal,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CLUB NOVA FROTA',
                    style: TextStyle(
                      color: AdminColors.branco,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Painel Administrativo',
                    style: TextStyle(color: Colors.white70),
                  ),
                  if (usuario?.email != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      usuario!.email!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
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
            _MenuItem(
              icon: Icons.settings,
              label: 'Configurações',
              route: AdminRoutes.configuracoes,
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: AdminColors.branco),
              title: const Text(
                'Sair',
                style: TextStyle(color: AdminColors.branco),
              ),
              onTap: () => _sair(context),
            ),
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
