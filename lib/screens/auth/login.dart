import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mojadiapp/providers/auth_provider.dart';
import 'package:mojadiapp/widgets/my_button.dart';
import 'package:mojadiapp/widgets/my_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);
    // final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xFF1564C0),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 70.h, horizontal: 20.h),
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.h),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(25.h, 5.h, 25.h, 15.h),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image(
                  image: const AssetImage('assets/logo.png'),
                  width: 150.w,
                  height: 150.h,
                  fit: BoxFit.cover,
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
                Padding(
                  padding: EdgeInsets.fromLTRB(0.h, 10.h, 0.h, 30.h),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/lupapassword');
                      },
                      child: Text(
                        "Lupa Password?",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.sp,
                          color: const Color(0xFF1564C0),
                        ),
                      ),
                    ),
                  ),
                ),
                MyButton(
                  text: 'Login',
                  onPressed: () {
                    Provider.of<AuthProvider>(context, listen: false).signIn(
                      emailController.text,
                      passwordController.text,
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
                          'Tidak punya akun?',
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
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Register',
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
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        height: 10.h,
                        thickness: 1.h,
                        color: const Color(0xFF1564C0),
                      ),
                    ),
                    Text(
                      'Atau',
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF1564C0),
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14.sp,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        height: 10.h,
                        thickness: 1.h,
                        color: const Color(0xFF1564C0),
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                SizedBox(
                  width: 215.w,
                  child: OutlinedButton(
                    onPressed: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signInWithGoogle(context);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xff000000),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.g_mobiledata_rounded,
                          color: Colors.red,
                        ),
                        5.horizontalSpace,
                        Text(
                          'Login dengan Google',
                          style: GoogleFonts.roboto(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
