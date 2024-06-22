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
      backgroundColor: const Color(0xFF1564C0),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 70.h, horizontal: 20.h),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.h),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(25.h, 5.h, 25.h, 15.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: const AssetImage('assets/1.png'),
                  width: 150.w,
                  height: 150.h,
                  fit: BoxFit.cover,
                ),
                Text(
                  'CitiCare',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: const Color(0xFF4D8ACC),
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 24.sp,
                  ),
                ),
                20.verticalSpace,
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0.h, 2.h, 0.h, 0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.h, 0.h, 4.h, 0.h),
                        child: Text(
                          'Sudah punya akun?',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF1564C0),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: Text(
                          'Login',
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.roboto(
                            color: const Color(0xFF1564C0),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
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
