import 'package:flutter/material.dart';

import '../../shared/widgets/admin_layout.dart';

class MotoristasScreen extends StatelessWidget {
  const MotoristasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminLayout(
      title: 'Motoristas',
      child: Center(
        child: Text('Cadastro e gestão de motoristas'),
      ),
    );
  }
}
