import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mojadiapp/providers/auth_provider.dart';
import 'package:mojadiapp/screens/auth/login.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Form(
          key: registerFormKey, // Use a unique GlobalKey for this form
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/logo.png', width: 200.w, height: 200.h),
                buildTextField(
                    'Email', emailController, 'Please enter a valid email'),
                SizedBox(height: 10.h),
                buildTextField('Password', passwordController,
                    'Password must be at least 6 characters',
                    obscureText: true),
                SizedBox(height: 20.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (registerFormKey.currentState!.validate()) {
                      authProvider.submit(context, emailController.text,
                          passwordController.text, false);
                    }
                  },
                  child: const Text('Register'),
                ),
                SizedBox(height: 10.h),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: const Text(
                    'Sudah punya akun? Login',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String hint, TextEditingController controller, String? validatorMsg,
      {bool obscureText = false}) {
    return Container(
      width: 300.w,
      height: 50.h,
      padding: EdgeInsets.only(left: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
        obscureText: obscureText,
        validator: (value) =>
            value == null || value.isEmpty ? validatorMsg : null,
      ),
    );
  }
}
