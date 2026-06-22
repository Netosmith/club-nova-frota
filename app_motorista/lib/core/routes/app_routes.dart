import 'package:flutter/material.dart';

import '../../features/auth/login_screen.dart';
import '../../features/home/home_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes {
    return {
      login: (_) => const LoginScreen(),
      home: (_) => const HomeScreen(),
    };
  }
}
