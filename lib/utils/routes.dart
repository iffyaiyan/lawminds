import 'package:flutter/material.dart';

import '../presentations/auth/login.dart';
import '../presentations/auth/register.dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';

  static Map<String, WidgetBuilder> routes = {
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen()
  };
}
