import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final String lokasi;
  final VoidCallback onTap;

  const ReportItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.lokasi,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        color: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.5),
        child: Column(
          children: [
            imageUrl.isNotEmpty
                ? Ink.image(
                    image: NetworkImage(imageUrl),
                    height: 126.h,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 126.h,
                    color: Colors.grey,
                  ),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 50.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          date,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: const Color(0xFF103374),
                          ),
                        ),
                      ],
                    ),
                  ),
                  15.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                          lokasi,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
