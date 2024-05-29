import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mojadiapp/providers/auth_provider.dart';
import 'package:mojadiapp/screens/auth/login.dart';
import 'package:mojadiapp/screens/home.dart';
import 'package:mojadiapp/screens/laporan/create_report.dart';
import 'package:mojadiapp/screens/laporan/getall_report.dart';
import 'package:provider/provider.dart';
import 'services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: LoginScreen(),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
