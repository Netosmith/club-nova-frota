import 'package:flutter/material.dart';

import '../../shared/widgets/admin_layout.dart';

class ComprovantesScreen extends StatelessWidget {
  const ComprovantesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminLayout(
      title: 'Comprovantes',
      child: Center(
        child: Text('Análise e aprovação de comprovantes'),
      ),
    );
  }
}
