import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportCard extends StatelessWidget {
  final BuildContext context;

  const ReportCard({
    super.key,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Image(
              image: const AssetImage('assets/cover-card.png'),
              height: 140.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 140.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  const Color(0xFF1564C0).withOpacity(0.8),
                  const Color(0xFF90CAF8).withOpacity(0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16.h,
            right: 50.w,
            left: 16.w,
            child: Text(
              'Yuk, laporkan temuaan pelanggaran & kerusakan fasilitas sosial',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 15.sp,
              ),
            ),
          ),
          Positioned(
            top: 55.h,
            right: 30.w,
            left: 16.w,
            child: Text(
              'di Lingkungan Sekitarmu!',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
          Positioned(
            bottom: 12.h,
            right: 16.w,
            width: 140.w,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/report/create');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Buat Laporan',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0E47A1),
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
