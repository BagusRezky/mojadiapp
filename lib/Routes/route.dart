import 'package:flutter/material.dart';
import 'package:mojadiapp/screens/artikel/create_article.dart';
import 'package:mojadiapp/screens/artikel/list_article.dart';
import 'package:mojadiapp/screens/auth/login.dart';
import 'package:mojadiapp/screens/auth/lupa_password.dart';
import 'package:mojadiapp/screens/auth/register.dart';
import 'package:mojadiapp/screens/home.dart';
import 'package:mojadiapp/screens/onboarding/onboard.dart';
import 'package:mojadiapp/screens/report/create_report.dart';
import 'package:mojadiapp/screens/report/list_report.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case '/lupapassword':
        return MaterialPageRoute(builder: (_) => const LupaPassword());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const Register());
      case '/report':
        return MaterialPageRoute(builder: (_) => const ListReportScreen());
      case '/report/create':
        return MaterialPageRoute(builder: (_) => const CreateReportScreen());
      case '/article':
        return MaterialPageRoute(builder: (_) => const ListArticleScreen());
      case '/article/create':
        return MaterialPageRoute(builder: (_) => const CreateArticleScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
