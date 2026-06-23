import 'package:flutter/material.dart';

import '../../shared/widgets/admin_layout.dart';

class OrdensScreen extends StatelessWidget {
  const OrdensScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminLayout(
      title: 'Ordens',
      child: Center(
        child: Text('Gestão de solicitações e ordens'),
      ),
    );
  }
}
