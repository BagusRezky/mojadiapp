import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});
  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Login',
      onFinish: () {
        Navigator.pushNamed(context, '/');
      },
      
      finishButtonStyle: FinishButtonStyle(
        
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      skipTextButton: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      controllerColor: Colors.black26,
      totalPage: 3,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Image.asset(
          'assets/slide_1.png',
          height: 270.h,
          
        ),
        Image.asset(
          'assets/slide_1.png',
          height: 270.h,
        ),
        Image.asset(
          'assets/slide_1.png',
          height: 270.h,
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              450.verticalSpace,
              Text(
                'On your way...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.verticalSpace,
              Text(
                'to find the perfect looking Onboarding for your app?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              450.verticalSpace,
              Text(
                'You’ve reached your destination.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.verticalSpace,
              Text(
                'Sliding with animation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              450.verticalSpace,
              Text(
                'Start now!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              10.verticalSpace,
              Text(
                'Where everything is possible and customize your onboarding.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
