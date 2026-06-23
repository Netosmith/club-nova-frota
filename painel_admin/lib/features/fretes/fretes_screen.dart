import 'package:flutter/material.dart';

import '../../shared/widgets/admin_layout.dart';

class FretesScreen extends StatelessWidget {
  const FretesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminLayout(
      title: 'Fretes',
      child: Center(
        child: Text('Cadastro e gestão de fretes'),
      ),
    );
  }
}
