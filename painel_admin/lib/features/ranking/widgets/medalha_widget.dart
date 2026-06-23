import 'package:flutter/material.dart';

class MedalhaWidget extends StatelessWidget {
  const MedalhaWidget({
    super.key,
    required this.medalha,
  });

  final String medalha;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Text(_emoji),
      label: Text(_label),
    );
  }

  String get _emoji {
    switch (medalha.toLowerCase()) {
      case 'diamante':
        return '💎';
      case 'ouro':
        return '🥇';
      case 'prata':
        return '🥈';
      default:
        return '🥉';
    }
  }

  String get _label {
    if (medalha.isEmpty) return 'Bronze';
    return '${medalha[0].toUpperCase()}${medalha.substring(1)}';
  }
}
