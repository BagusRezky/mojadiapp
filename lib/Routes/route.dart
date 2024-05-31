import 'package:flutter/material.dart';
import 'package:mojadiapp/screens/auth/login.dart';
import 'package:mojadiapp/screens/auth/register.dart';
import 'package:mojadiapp/screens/home.dart';
import 'package:mojadiapp/screens/report/create_report.dart';
import 'package:mojadiapp/screens/report/list_report.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const Register());
      case '/report':
        return MaterialPageRoute(builder: (_) => const ListReportScreen());
      case '/report/create':
        return MaterialPageRoute(builder: (_) => const CreateReportScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
