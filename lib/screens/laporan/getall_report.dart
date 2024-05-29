import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LaporanScreen extends StatefulWidget {
  const LaporanScreen({super.key});

  @override
  State<LaporanScreen> createState() => _LaporanScreenState();
}

class _LaporanScreenState extends State<LaporanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Semua Laporan',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, fontSize: 24.sp, height: 36.sp),
          ),
          backgroundColor: Colors.white, // Warna solid untuk AppBar
          elevation: 0, // Menghapus bayangan pada AppBar
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
                width: 369.w,
                height: 115.h,
                decoration: BoxDecoration(
                    color: Color.fromARGB(101, 206, 234, 255),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                        width: 1.5.sp,
                        color: Color.fromARGB(255, 144, 201, 248))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: textLaporan()),
                    Container(
                      // margin: EdgeInsets.only(right: 2.w, left: 5.w),
                      width: 108.w,
                      height: 85.h,
                      // child: Image(image: image),
                      child: Text('image'),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(11),
                        // border: Border.all(
                        //     width: 1.5.sp,
                        //     color: Color.fromARGB(255, 144, 201, 248))
                      ),
                    )
                  ],
                ),
              );
            }));
  }

  Widget textLaporan() {
    return Container(
      margin: EdgeInsets.only(right: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Halte Bus di Jalan Pemuda Rusak Parah ',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'lokasi',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: Color.fromARGB(155, 0, 0, 0)),
              ),
              Text(
                'Tanggal',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: Color.fromARGB(155, 0, 0, 0)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
