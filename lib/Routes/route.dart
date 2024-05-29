import 'package:flutter/material.dart';
import 'package:mojadiapp/screens/auth/login.dart';
import 'package:mojadiapp/screens/auth/register.dart';
import 'package:mojadiapp/screens/home.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const Register());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
