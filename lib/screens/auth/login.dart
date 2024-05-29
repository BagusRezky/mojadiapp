import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mojadiapp/providers/auth_provider.dart';
import 'package:mojadiapp/widgets/my_button.dart';
import 'package:mojadiapp/widgets/my_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    // final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
          child: Column(
            children: [
              Image(
                image: const AssetImage('assets/logo.png'),
                width: 257.w,
                height: 262.h,
              ),
              20.verticalSpace,
              TextInputField(
                hintText: 'Email',
                labelText: 'Email',
                minLines: 1,
                maxLines: 1,
                controller: emailController,
                obscure: false,
              ),
              15.verticalSpace,
              TextInputField(
                hintText: 'Password',
                labelText: 'Password',
                minLines: 1,
                maxLines: 1,
                controller: passwordController,
                obscure: true,
              ),
              20.verticalSpace,
              GestureDetector(
                onTap: () {
                  Provider.of<AuthProvider>(context, listen: false).signIn(
                    emailController.text,
                    passwordController.text,
                    context,
                  );
                },
                child: const MyButton(
                  text: 'Login',
                ),
              ),
              10.verticalSpace,
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: SizedBox(
                  child: Text(
                    'Register',
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF1564C0),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
