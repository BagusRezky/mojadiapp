import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mojadiapp/providers/auth_provider.dart';
import 'package:mojadiapp/screens/auth/login.dart';
import 'package:provider/provider.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController birthDateController = TextEditingController();
    final TextEditingController addressController = TextEditingController();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/logo.png', width: 200.w, height: 200.h),
              buildTextField(
                  'Email', emailController, 
                  // 'Please enter a valid email'
                  ),
              10.verticalSpace,
              buildTextField('Password', passwordController,
                  // 'Password must be at least 6 characters',
                  obscureText: true),
             10.verticalSpace,
             buildTextField(
                'Tanggal lahir', birthDateController,
                // 'Please enter a valid email'
              ),
              10.verticalSpace,
              buildTextField(
                'Alamat', addressController,
                // 'Please enter a valid email'
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  textStyle: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).register(
                    emailController.text,
                    passwordController.text,
                    birthDateController.text,
                    addressController.text,
                    context,
                  );
                },
                child: const Text('Register'),
              ),
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
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
    );
  }

  Widget buildTextField(
      String hint, TextEditingController controller, 
      // String? validatorMsg,
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
        // validator: (value) =>
        //     value == null || value.isEmpty ? validatorMsg : null,
      ),
    );
  }
}
