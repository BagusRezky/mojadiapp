import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mojadiapp/providers/auth_provider.dart';
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
      body: Center(
        child: Column(
          children: [
            Image(
              image: const AssetImage('assets/logo.png'),
              width: 200.w,
              height: 200.h,
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Email'),
              // onSaved: (value) => authProvider.enteredEmail = value ?? '',
              // validator: (value) =>
              //     value!.isEmpty ? 'Please enter an email' : null,
            ),
            10.verticalSpace,
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
              // onSaved: (value) => authProvider.enteredPassword = value ?? '',
              // validator: (value) =>
              //     value!.isEmpty ? 'Please enter a password' : null,
            ),
            20.verticalSpace,
            GestureDetector(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).signIn(
                  emailController.text,
                  passwordController.text,
                );
                // Navigator.pushNamed(context, '/home');
              },
              child: Container(
                width: 300.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const SizedBox(
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
