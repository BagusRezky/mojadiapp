// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mojadiapp/providers/auth_provider.dart';
import 'package:mojadiapp/widgets/my_button.dart';
import 'package:mojadiapp/widgets/my_textfield.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future<void> _selectedDate() async {
    // Remove focus from the TextField
    FocusScope.of(context).requestFocus(FocusNode());

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        birthDateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                Image.asset('assets/logo.png', width: 200.w, height: 200.h),
                15.verticalSpace,
                TextInputField(
                  hintText: 'Email',
                  labelText: 'Email',
                  minLines: 1,
                  maxLines: 1,
                  controller: emailController,
                ),
                12.verticalSpace,
                TextInputField(
                  hintText: 'Password',
                  labelText: 'Password',
                  minLines: 1,
                  maxLines: 1,
                  controller: passwordController,
                  obscure: true,
                ),
                12.verticalSpace,
                TextField(
                  controller: birthDateController,
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_today),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'DD/MM/YYYY',
                    labelText: 'Birth Date',
                    hintStyle: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                    labelStyle: GoogleFonts.roboto(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Color(0xFF1564C0),
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  onTap: () {
                    _selectedDate();
                  },
                ),
                12.verticalSpace,
                TextInputField(
                  hintText: 'Address',
                  labelText: 'Address',
                  minLines: 1,
                  maxLines: 1,
                  controller: addressController,
                ),
                12.verticalSpace,
                MyButton(
                  text: 'Register',
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false).register(
                      emailController.text,
                      passwordController.text,
                      birthDateController.text,
                      addressController.text,
                      context,
                    );
                  },
                ),
                10.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text(
                    'Sudah punya akun? Login',
                    style: GoogleFonts.roboto(
                      color: const Color(0xFF1564C0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
