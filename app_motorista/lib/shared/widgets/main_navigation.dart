import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../features/comprovantes/comprovantes_screen.dart';
import '../../features/fretes/fretes_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/ordens/ordens_screen.dart';
import '../../features/perfil/perfil_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    FretesScreen(),
    OrdensScreen(),
    ComprovantesScreen(),
    PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        backgroundColor: AppColors.branco,
        indicatorColor: AppColors.verdeClaro.withValues(alpha: 0.18),
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: AppColors.azulPrincipal),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_shipping_outlined),
            selectedIcon: Icon(Icons.local_shipping, color: AppColors.azulPrincipal),
            label: 'Fretes',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment, color: AppColors.azulPrincipal),
            label: 'Ordens',
          ),
          NavigationDestination(
            icon: Icon(Icons.upload_file_outlined),
            selectedIcon: Icon(Icons.upload_file, color: AppColors.azulPrincipal),
            label: 'Comprov.',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: AppColors.azulPrincipal),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
