import 'package:flutter/material.dart';
import 'package:mojadiapp/pages/home/article/article_create.dart';
import 'package:mojadiapp/pages/home/article/article_list.dart';
import 'package:mojadiapp/pages/auth/login.dart';
import 'package:mojadiapp/pages/auth/lupa_password.dart';
import 'package:mojadiapp/pages/auth/register.dart';
import 'package:mojadiapp/pages/home/home_page.dart';
import 'package:mojadiapp/pages/home/info/info_list.dart';
import 'package:mojadiapp/pages/onboarding/onboard.dart';
import 'package:mojadiapp/pages/profile/profile_page.dart';
import 'package:mojadiapp/pages/profile/profile_update_page.dart';
import 'package:mojadiapp/pages/home/report/report_create.dart';
import 'package:mojadiapp/pages/home/report/report_list.dart';
import 'package:mojadiapp/pages/home/statistik/statistik.dart';

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
      case '/statistik':
        return MaterialPageRoute(builder: (_) => const Statistik());
      case '/info':
        return MaterialPageRoute(builder: (_) => const InfoListScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/updateProfile':
        return MaterialPageRoute(builder: (_) => UpdateProfileScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
