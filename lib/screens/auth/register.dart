import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image(
              image: const AssetImage('assets/logo.png'),
              width: 350.w,
              height: 350.h,
            ),
            Container(
              width: 300.w,
              height: 50.h,
              padding: EdgeInsets.only(left: 5.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
              ),
            ),
            10.verticalSpace,
            Container(
              width: 300.w,
              height: 50.h,
              padding: EdgeInsets.only(left: 5.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
            ),
            10.verticalSpace,
            Container(
              width: 300.w,
              height: 50.h,
              padding: EdgeInsets.only(left: 5.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Tanggal Lahir',
                ),
              ),
            ),
            10.verticalSpace,
            Container(
              width: 300.w,
              height: 50.h,
              padding: EdgeInsets.only(left: 5.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Alamat Domisili',
                ),
              ),
            ),
            20.verticalSpace,
            Container(
              width: 300.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            10.verticalSpace,
            const Text(
              'Sudah punya akun?',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
