import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyMenu extends StatelessWidget {
  final String title;
  final Color boxColor;
  final Color iconColor;
  final IconData icon;
  final Function onTap;

  const MyMenu({
    super.key,
    required this.title,
    required this.boxColor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => onTap(), // Use the variable here
          child: Container(
            width: 50.w,
            height: 44.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.w),
              color: boxColor, // Use the variable here
            ),
            child: Center(
              child: Icon(
                icon,
                color: iconColor, // Use the variable here
              ),
            ),
          ),
        ),
        10.verticalSpace,
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}
