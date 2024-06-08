import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mojadiapp/providers/auth_provider.dart';
import 'package:mojadiapp/widgets/my_button.dart';
import 'package:mojadiapp/widgets/my_textfield.dart';
import 'package:provider/provider.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({super.key});

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  final TextEditingController emailController = TextEditingController();

  Future<void> resetPassword() async {
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .resetPassword(emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email reset password telah dikirim'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0x00ffffff),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: Text(
          "Lupa Password",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20.sp,
            color: const Color(0xff000000),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: const Color(0xff212435),
            size: 20.h,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.h),
                child: Image(
                  image: const AssetImage('assets/lupapas.png'),
                  width: 200.w,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "LUPA PASSWORD",
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 14.sp,
                  color: const Color(0xff000000),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.h, 16.h, 15.h, 4.h),
                child: Text(
                  "Silakan tulis email anda untuk menerima kode konfirmasi untuk mengatur password baru.",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.sp,
                    color: const Color(0xff000000),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(3.h, 30.h, 3.h, 20.h),
                child: TextInputField(
                  hintText: 'Masukkan Email',
                  labelText: 'Email',
                  minLines: 1,
                  maxLines: 1,
                  controller: emailController,
                  obscure: false,
                ),
              ),
              MyButton(
                text: 'Kirim',
                onPressed: resetPassword,
              )
            ],
          ),
        ),
      ),
    );
  }
}
