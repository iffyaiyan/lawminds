import 'package:flutter/material.dart';

import '../presentations/auth/login.dart';
import '../presentations/auth/register.dart';
import '../presentations/dashboard/dashboard.dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';

  static Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    dashboard: (_) => const DashboardScreen()
  };
}
